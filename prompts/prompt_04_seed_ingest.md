# Prompt 04 · Cargar los datos

**Antes de pegarlo:** comprueba que `benchmark-wk/.env.local` tiene las tres claves rellenas.

**Para lanzar el script**, desde la carpeta `benchmark-wk`:

    node --env-file=.env.local scripts/ingest.mjs

```
## Propuesta
Quiero cargar en Supabase los datos ficticios del caso, que están en assets/seed/.

## Qué debe hacer
- Instalar csv-parse dentro de benchmark-wk.
- Crear benchmark-wk/scripts/ingest.mjs, que lea los cuatro CSV de ../assets/seed/
  (la carpeta está un nivel por encima de benchmark-wk).
- Conectarse con NEXT_PUBLIC_SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY: las reglas de
  seguridad bloquean las escrituras con la clave pública.
- Cargar en este orden: empresas, despacho_clientes, facturas, lineas_factura.
- Convertir a número las columnas numéricas (importe_total, cantidad, precio_unitario, importe).
- Poder lanzarse más de una vez sin duplicar filas.
- Mostrar el progreso y, al final, cuántas filas hay en cada tabla.
- Pararse con un mensaje claro si algo falla.

## Qué NO debe hacer
- No modificar los CSV ni crear o alterar tablas.
- No tocar la tabla despachos: ya la rellenó la migration.
- No imprimir las claves en pantalla.

## Cómo sabemos que salió bien
- El script termina sin errores.
- Los totales son: 48 empresas, 48 despacho_clientes, 397 facturas, 1226 lineas_factura.
- En Supabase → Table Editor → facturas se ven las filas.
```
