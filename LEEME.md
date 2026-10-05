# AI Product Building Academy · El caso

Esta carpeta contiene los datos del caso sobre el que vamos a construir.
**No hay que abrir ni entender nada de aquí dentro**: son los materiales que usaremos en
clase. Lo único importante hoy es tenerla descargada en el computadora.

---

## Qué hay que instalar antes del curso

| Programa | Para qué sirve | Quién lo necesita |
|---|---|---|
| **VS Code** | El programa donde se trabaja | Todos |
| **Node.js** (versión LTS) | El motor que hace funcionar el proyecto en el computadora | Todos |
| **GitHub Copilot** | El asistente de IA dentro de VS Code | Todos · licencia de WK |
| **Cuenta de Supabase** (gratuita) | Donde vivirán los datos | **Solo ruta PM** |

**Importante sobre Supabase:** registrarse con **correo electrónico**, no con GitHub.

---

## Qué hay en esta carpeta

| Archivo | Para qué sirve | Cuándo se usa |
|---|---|---|
| `CASO.md` | **El caso escrito por extenso.** Adjúntalo con `#file` siempre que le pidas algo a la IA sobre el caso | Todos los módulos |
| `package.json` | La lista de librerías del proyecto. `npm install` la lee para saber qué descargar | Módulo 1 · deberes |
| `.github/skills/feature-onepager/` | Una **Skill** ya preparada. No hay que crearla: ya está | Módulo 1 |
| `.github/skills/historia-usuario/` | Otra Skill de ejemplo, la que el docente enseña en clase | Módulo 1 |
| `assets/seed/` (4 archivos) | Los datos inventados del caso: empresas, facturas y sus líneas | Módulo 3 · ruta PM |
| `assets/migration.sql` | El texto que crea las tablas y las reglas de seguridad | Módulo 3 · ruta PM |
| `assets/migration-comparacion.sql` | Las funciones que comparan una empresa con su sector | Módulo 5 · ruta PM |
| `assets/datos-ejemplo.ts` | Los mismos datos, en un archivo, sin base de datos | Módulo 3 · ruta PO |
| `prompts/` (6 archivos) | Los cinco prompts para montar el proyecto y el del ejercicio de Skills, listos para copiar y pegar en Copilot | Módulo 3 |
| `.env.example` | El modelo del archivo de claves. Las claves de verdad van en `.env.local`, que es privado | Módulo 3 · ruta PM |

---

## Los datos son inventados

Las 48 empresas, las 397 facturas y los 2 despachos de esta carpeta **no existen**: están
generados para el curso.

En ningún momento del curso se conecta ningún dato ni ningún sistema real de la empresa.

---

## Cómo conseguir esta carpeta

Se clona desde GitHub, no se descarga a mano:

```
https://github.com/stefrin21/wk-academy-caso.git
```

En VS Code: `Cmd/Ctrl + Shift + P` → `Git: Clone` → pegar esa dirección → elegir dónde
guardarla. Al abrirse, VS Code pregunta si confía en la carpeta: hay que decir que sí.

---

## Dónde guardar esta carpeta

**No dentro de OneDrive ni de ninguna carpeta sincronizada con la nube.**

Durante el curso el proyecto genera miles de archivos. Si la carpeta está sincronizada, la nube
intenta subirlos todos mientras se trabaja: va lentísimo, a veces bloquea archivos en uso y crea
copias en conflicto.

⚠️ **Cuidado:** en muchas computadoras de empresa, **el Escritorio y Documentos ya están dentro
de OneDrive** sin que se note.

**Dónde ponerla entonces:**

| Sistema | Dónde |
|---|---|
| Windows | Crear una carpeta directamente en el disco: `C:\wk-academy` |
| Mac | En la carpeta personal (la que lleva su nombre de usuario), junto a Escritorio y Documentos |

**Cómo comprobar que no está sincronizada:** si junto a los archivos aparecen iconos de nube o
palomitas verdes, está dentro de OneDrive y hay que moverla.

---

## El día del curso

1. Abrir VS Code
2. **File → Open Folder…** (el menú de VS Code está en inglés) y elegir esta carpeta
3. Esperar instrucciones

*También funciona arrastrar la carpeta encima del icono de VS Code.*

No hay que preparar nada más. El proyecto se construye en clase, paso a paso.
