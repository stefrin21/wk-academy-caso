# Prompt 03 · Entender y aplicar la migration

**Cómo se usa:** este prompt no ejecuta nada. Copilot les explica el archivo; **lo aplican ustedes**
en Supabase: *SQL Editor* → **+** → *Create a new snippet* → pegan el contenido de
`assets/migration.sql` → **Run**. Supabase avisa de que la operación es destructiva: es normal, se confirma.

```
## Propuesta
Quiero entender qué hace assets/migration.sql antes de aplicarlo en Supabase.

## Qué debe hacer
- Leer assets/migration.sql y explicarme, en lenguaje sencillo, qué tablas crea y para qué
  sirve cada una.
- Explicarme qué hacen las políticas RLS: quién puede ver qué.
- Decirme qué tengo que comprobar en Supabase después de ejecutarlo.

## Qué NO debe hacer
- No modificar assets/migration.sql.
- No intentar ejecutarlo: lo pego yo en el SQL Editor.
- No inventar tablas o columnas que no estén en el archivo.

## Cómo sabemos que salió bien
- El SQL Editor termina sin errores.
- En Table Editor aparecen seis tablas: despachos, empresas, despacho_clientes,
  despacho_miembros, facturas y lineas_factura.
- despachos tiene 2 filas (Alfa y Beta). facturas está vacía: los datos llegan en el paso 4.
```
