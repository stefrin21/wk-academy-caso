# Prompt 05 · La página de verificación

**Cómo se usa:** péguenlo en modo **Agent** y abran después `http://localhost:3000/debug`.

```
## Propuesta
Quiero una página de diagnóstico que demuestre que la aplicación lee de la base de datos.

## Qué debe hacer
- Crear benchmark-wk/app/debug/page.tsx como Server Component.
- Mostrar «Facturas totales» y los datos de una factura: emisor, fecha e importe.
- Tener en cuenta la RLS: sin haber iniciado sesión, la clave pública no ve ninguna factura.
  Para esta página de diagnóstico, leer el total en el servidor con SUPABASE_SERVICE_ROLE_KEY.
- Mostrar también, al lado, cuántas facturas ve la clave pública sin sesión, para que se
  vea la diferencia.
- Hacer las consultas una después de otra (un await por consulta), no en paralelo con
  Promise.all: lanzadas a la vez, los dos recuentos se mezclan y sale 0.

## Qué NO debe hacer
- No usar 'use client': la clave secreta no puede llegar nunca al navegador.
- No crear login ni otras páginas todavía.
- No enlazar esta página desde ninguna otra: es una herramienta, no una funcionalidad.

## Cómo sabemos que salió bien
- http://localhost:3000/debug muestra «Facturas totales: 397».
- Se ven los datos de una factura.
- La clave pública sin sesión ve 0: es la seguridad funcionando, no un error.
```
