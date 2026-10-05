# Prompt 01 · Crear el proyecto Next.js

**Cómo se usa:** copien el bloque de abajo y péguenlo en la chat de Copilot, en modo **Agent**.
Copilot les da el comando; **lo ejecutan ustedes** en el terminal.

```
## Propuesta
Quiero crear el proyecto web del caso «Benchmark para asesorías» dentro de esta carpeta.

## Qué debe hacer
- Darme el comando exacto para crear un proyecto Next.js llamado benchmark-wk, con
  TypeScript, Tailwind CSS y App Router:
  npx create-next-app@latest benchmark-wk --yes
- Explicarme en dos líneas qué hace ese comando antes de que yo lo ejecute.
- Decirme después cómo arrancarlo: cd benchmark-wk y npm run dev.

## Qué NO debe hacer
- No crear páginas, componentes ni estilos todavía.
- No instalar ninguna otra librería.
- No tocar, mover ni borrar las carpetas assets/, prompts/ ni .github/.

## Cómo sabemos que salió bien
- Existe la carpeta benchmark-wk/ con app/ y package.json dentro.
- npm run dev arranca sin errores.
- http://localhost:3000 muestra la página de bienvenida de Next.js.
```
