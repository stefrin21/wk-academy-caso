-- =============================================================================
-- AI Product Building Academy — Edición España
-- migration.sql  ·  Esquema + Row Level Security + funciones de benchmark
-- Caso: plataforma de benchmark para asesorías/gestorías sobre facturas
-- Se aplica desde Supabase → SQL Editor → pegar y Run (Módulo 3 / Tech Stack).
-- =============================================================================

-- ---------------------------------------------------------------- TABLAS
create table if not exists despachos (
  id    uuid primary key,
  nombre text not null,
  cif    text
);

create table if not exists empresas (
  empresa_id          text primary key,   -- código interno (E0001…)
  nif_cif             text unique not null,
  denominacion        text not null,
  cnae                text not null,       -- código de actividad (equivalente a ATECO)
  sector              text,
  comunidad_autonoma  text,
  provincia           text,
  tramo               text                 -- micro / pequeña / mediana
);

-- Relación empresa cliente ↔ despacho que la gestiona
create table if not exists despacho_clientes (
  despacho_id uuid references despachos(id),
  empresa_id  text references empresas(empresa_id),
  nif_cif     text,
  primary key (despacho_id, empresa_id)
);

-- Miembros (usuarios) de cada despacho — enlaza auth.users con el despacho
create table if not exists despacho_miembros (
  despacho_id uuid references despachos(id),
  user_id     uuid references auth.users(id),
  rol         text default 'miembro',
  primary key (despacho_id, user_id)
);

create table if not exists facturas (
  factura_id    text primary key,
  numero        text,
  fecha         date not null,
  emisor_nif    text not null,             -- NIF de la empresa cliente que emite (ventas)
  emisor_empresa text references empresas(empresa_id),
  importe_total numeric(12,2) not null,
  metodo_pago   text,
  despacho_id   uuid references despachos(id)
);

create table if not exists lineas_factura (
  id             bigserial primary key,
  factura_id     text references facturas(factura_id),
  descripcion    text,
  cantidad       integer,
  precio_unitario numeric(12,2),
  importe        numeric(12,2)
);

create index if not exists idx_facturas_despacho on facturas(despacho_id);
create index if not exists idx_facturas_emisor    on facturas(emisor_nif);
create index if not exists idx_empresas_cluster   on empresas(cnae, comunidad_autonoma);

-- ---------------------------------------------------------------- DESPACHOS DE PRUEBA
insert into despachos (id, nombre, cif) values
  ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Despacho Alfa', 'B00000001'),
  ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'Despacho Beta', 'B00000002')
on conflict (id) do nothing;

-- ---------------------------------------------------------------- ROW LEVEL SECURITY
-- La seguridad vive en la base de datos, no en el código: cada despacho ve solo lo suyo.
alter table facturas          enable row level security;
alter table lineas_factura    enable row level security;
alter table despacho_clientes enable row level security;

-- Facturas: visibles solo si el usuario pertenece al despacho dueño de la factura
drop policy if exists p_facturas_por_despacho on facturas;
create policy p_facturas_por_despacho on facturas
  for select using (
    despacho_id in (select despacho_id from despacho_miembros where user_id = auth.uid())
  );

-- Clientes: idem
drop policy if exists p_clientes_por_despacho on despacho_clientes;
create policy p_clientes_por_despacho on despacho_clientes
  for select using (
    despacho_id in (select despacho_id from despacho_miembros where user_id = auth.uid())
  );

-- Líneas: visibles si su factura es visible
drop policy if exists p_lineas_por_factura on lineas_factura;
create policy p_lineas_por_factura on lineas_factura
  for select using (
    factura_id in (
      select factura_id from facturas
      where despacho_id in (select despacho_id from despacho_miembros where user_id = auth.uid())
    )
  );

-- empresas es catálogo compartido (necesario para el clúster): lectura para autenticados
alter table empresas enable row level security;
drop policy if exists p_empresas_lectura on empresas;
create policy p_empresas_lectura on empresas for select using (auth.role() = 'authenticated');

-- Miembros: cada usuario ve solo su propia pertenencia a un despacho. Las reglas de arriba
-- leen esta tabla; sin sesión no se ve ninguna fila, y por eso no se ve ninguna factura.
alter table despacho_miembros enable row level security;
drop policy if exists p_miembros_propios on despacho_miembros;
create policy p_miembros_propios on despacho_miembros for select using (user_id = auth.uid());

-- ---------------------------------------------------------------- FUNCIONES DE BENCHMARK
-- El benchmark compara al cliente con TODO el clúster (empresas de otros despachos).
-- RLS lo impediría, así que usamos SECURITY DEFINER: la función corre como 'postgres'
-- y devuelve SOLO datos agregados / NIFs del clúster, nunca facturas individuales ajenas.

-- NIFs de las empresas del mismo clúster (mismo CNAE + Comunidad Autónoma)
create or replace function get_cluster_nifs(p_cnae text, p_ccaa text)
returns table(nif_cif text)
language sql security definer set search_path = public as $$
  select nif_cif from empresas where cnae = p_cnae and comunidad_autonoma = p_ccaa;
$$;

-- Facturación mensual de una empresa (para la curva del cliente)
create or replace function get_facturacion_mensual(p_nif text)
returns table(mes text, total numeric)
language sql security definer set search_path = public as $$
  select to_char(fecha, 'YYYY-MM') as mes, sum(importe_total) as total
  from facturas where emisor_nif = p_nif
  group by 1 order by 1;
$$;

-- Percentiles de facturación mensual del clúster (banda de comparación)
create or replace function get_benchmark_cluster(p_cnae text, p_ccaa text)
returns table(mes text, p25 numeric, mediana numeric, p75 numeric)
language sql security definer set search_path = public as $$
  with mensual as (
    select f.emisor_nif, to_char(f.fecha,'YYYY-MM') as mes, sum(f.importe_total) as total
    from facturas f
    join empresas e on e.nif_cif = f.emisor_nif
    where e.cnae = p_cnae and e.comunidad_autonoma = p_ccaa
    group by 1,2
  )
  select mes,
         percentile_cont(0.25) within group (order by total),
         percentile_cont(0.50) within group (order by total),
         percentile_cont(0.75) within group (order by total)
  from mensual group by mes order by mes;
$$;

-- =============================================================================
-- PERMISOS DE LA DATA API (GRANT)
-- Desde octubre de 2026 Supabase ya no da estos permisos automáticamente a las
-- tablas nuevas: sin ellos, supabase-js responde "permission denied".
--   · service_role (la clave secreta): todo. La usan el script de carga y /debug.
--   · authenticated (usuarios con sesión): leer. Lo que ve cada uno lo deciden las
--     reglas RLS de arriba.
--   · anon (clave pública, sin sesión): leer solo las tablas con RLS, que no le dejan
--     ver nada. Por eso /debug enseña 0 en vez de un error. Incluye despacho_miembros
--     porque las reglas de las facturas la consultan. despachos no tiene RLS: anon no
--     recibe nada sobre ella.
-- =============================================================================
grant usage on schema public to anon, authenticated, service_role;

grant select, insert, update, delete on
  despachos, empresas, despacho_clientes, despacho_miembros, facturas, lineas_factura
  to service_role;
grant usage, select on all sequences in schema public to service_role;

grant select on
  despachos, empresas, despacho_clientes, despacho_miembros, facturas, lineas_factura
  to authenticated;

grant select on empresas, despacho_clientes, despacho_miembros, facturas, lineas_factura to anon;

-- =============================================================================
-- DESPUÉS DE APLICAR ESTE ARCHIVO:
--   1) Importar los CSV (script de ingest, Módulo 3): empresas, facturas,
--      lineas_factura, despacho_clientes.
--   2) Crear dos usuarios en Supabase → Auth: alfa@test.wk y beta@test.wk
--   3) Enlazarlos a su despacho:
--        insert into despacho_miembros (despacho_id, user_id, rol)
--        select id, (select id from auth.users where email='alfa@test.wk'), 'miembro'
--        from despachos where nombre='Despacho Alfa';
--        -- (repetir para beta@test.wk / Despacho Beta)
--   4) Probar la RLS: logado como Alfa se ven solo sus clientes; como Beta, los suyos.
-- =============================================================================
