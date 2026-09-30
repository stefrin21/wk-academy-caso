-- =============================================================================
-- Funciones de comparación · se aplica en el Módulo 5
--
-- Sustituye las funciones de comparación que vinieron en migration.sql.
-- Se pega en Supabase → SQL Editor → Run (elegir «Run without RLS»).
-- =============================================================================

-- Si applica da Supabase → SQL Editor → incolla e Run.
-- =============================================================================

-- Le versioni a un solo parametro vanno rimosse, altrimenti Postgres non sa
-- quale delle due chiamare.
drop function if exists get_cluster_size(text);
drop function if exists get_benchmark_cluster(text);
drop function if exists get_posicion_cliente(text, text);

-- Quante aziende compongono il gruppo di confronto
create or replace function get_cluster_size(p_cnae text, p_ccaa text default null)
returns integer
language sql security definer set search_path = public as $$
  select count(*)::integer
  from empresas
  where cnae = p_cnae
    and (p_ccaa is null or comunidad_autonoma = p_ccaa);
$$;

-- La banda di confronto: metà centrale del gruppo, mese per mese
create or replace function get_benchmark_cluster(p_cnae text, p_ccaa text default null)
returns table(mes text, p25 numeric, mediana numeric, p75 numeric)
language sql security definer set search_path = public as $$
  with mensual as (
    select f.emisor_nif, to_char(f.fecha,'YYYY-MM') as mes, sum(f.importe_total) as total
    from facturas f
    join empresas e on e.nif_cif = f.emisor_nif
    where e.cnae = p_cnae
      and (p_ccaa is null or e.comunidad_autonoma = p_ccaa)
    group by 1,2
  )
  select mes,
         percentile_cont(0.25) within group (order by total),
         percentile_cont(0.50) within group (order by total),
         percentile_cont(0.75) within group (order by total)
  from mensual group by mes order by mes;
$$;

-- La posizione del cliente dentro il gruppo: "Puesto 3 de 6"
create or replace function get_posicion_cliente(p_nif text, p_cnae text, p_ccaa text default null)
returns table(puesto integer, total integer)
language sql security definer set search_path = public as $$
  with por_empresa as (
    select f.emisor_nif,
           sum(f.importe_total) / count(distinct to_char(f.fecha, 'YYYY-MM')) as media_mensual
    from facturas f
    join empresas e on e.nif_cif = f.emisor_nif
    where e.cnae = p_cnae
      and (p_ccaa is null or e.comunidad_autonoma = p_ccaa)
    group by f.emisor_nif
  ),
  clasificacion as (
    select emisor_nif,
           rank() over (order by media_mensual desc) as puesto,
           count(*) over ()                          as total
    from por_empresa
  )
  select puesto::integer, total::integer
  from clasificacion
  where emisor_nif = p_nif;
$$;
