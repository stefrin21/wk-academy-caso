# Prompt 02 · Conectar Supabase

**Antes de pegarlo:** ten abierto el panel de Supabase en *Project Settings → API*. Ahí están
los valores que vas a necesitar. Según la versión del panel, la clave pública aparece como
**anon** o **publishable**, y la secreta como **service_role** o **secret**.

**Las claves las pegas tú en el archivo `.env.local`. Nunca en la chat.**

```
## Propuesta
Quiero que el proyecto benchmark-wk pueda hablar con mi base de datos de Supabase.

## Qué debe hacer
- Instalar @supabase/supabase-js dentro de benchmark-wk.
- Crear benchmark-wk/.env.local con las tres variables que aparecen en .env.example
  (está en la raíz del repositorio), dejando los valores vacíos: los relleno yo.
- Crear benchmark-wk/lib/supabase.ts: un único cliente, exportado como supabase, que lea
  NEXT_PUBLIC_SUPABASE_URL y NEXT_PUBLIC_SUPABASE_ANON_KEY.
- Comprobar que .env.local está cubierto por el .gitignore.

## Qué NO debe hacer
- No pedirme las claves ni escribirlas en ningún archivo que no sea .env.local.
- No usar SUPABASE_SERVICE_ROLE_KEY dentro de lib/supabase.ts.
- No crear páginas ni tablas todavía.

## Cómo sabemos que salió bien
- Existen benchmark-wk/.env.local y benchmark-wk/lib/supabase.ts.
- Se puede escribir import { supabase } from '@/lib/supabase' sin errores.
- Al reiniciar npm run dev no aparece ningún error de Supabase.
```
