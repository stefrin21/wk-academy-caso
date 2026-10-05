# Prompt 06 · Crear una Skill para los prompts OpenSpec

Es el ejercicio final del Módulo 3. Hay **dos maneras** de crear la Skill; el resultado es el
mismo: un archivo `SKILL.md` dentro de `.github/skills/prompt-openspec/`.

**Opción A · con `/create-skill`.** Escriban `/create-skill` en la chat de Copilot y, cuando
pregunte, descríbanla así:

> Una Skill llamada prompt-openspec que convierte lo que pido en un prompt de cuatro partes:
> propuesta, qué debe hacer, qué NO debe hacer y cómo sabemos que salió bien. Que me pregunte
> lo que falte y que no genere código.

Si `/create-skill` no aparece en su versión, usen la opción B.

**Opción B · pidiéndoselo a Copilot.** Copien el bloque de abajo y péguenlo en la chat, en modo
**Agent**. Funciona siempre.

```
## Propuesta
Quiero una Skill que me ayude a escribir prompts OpenSpec, para no olvidarme
ninguna de las cuatro partes cada vez que pido algo.

## Qué debe hacer
- Crear el archivo .github/skills/prompt-openspec/SKILL.md
- Empezar con name (prompt-openspec) y description, como las Skills que ya hay
  en .github/skills/
- Cuando yo describa algo que quiero construir, devolverme el prompt en cuatro
  partes: propuesta, qué debe hacer, qué NO debe hacer, cómo sabemos que salió bien
- Preguntarme lo que falte en vez de inventarlo
- Usar como modelo los archivos de la carpeta prompts/

## Qué NO debe hacer
- No generar código: la Skill solo escribe el prompt
- No modificar las Skills que ya existen
- No ejecutar nada sin que yo lo confirme

## Cómo sabemos que salió bien
- Al escribir / en la chat aparece prompt-openspec
- Si escribo «/prompt-openspec quiero una página de login», me devuelve las cuatro
  partes o me pregunta lo que falta, sin escribir código
```

**Después, con cualquiera de las dos:** recarguen la ventana (`Cmd/Ctrl + Shift + P` →
`Developer: Reload Window`) y pruébenla:

    /prompt-openspec quiero una página de login para la aplicación
