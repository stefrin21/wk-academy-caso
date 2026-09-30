---
name: historia-usuario
description: Convierte una petición de funcionalidad en una historia de usuario con criterios de aceptación en formato Given/When/Then. Úsala cuando haya que pasar de una idea escrita en prosa a algo que un equipo pueda estimar y verificar.
---

# Historia de usuario

Convierte una petición de funcionalidad en una historia que negocio y tecnología entiendan igual.

## Cómo trabajar

1. Escribe **una sola** historia. Si la petición contiene varias, dilo y propón cómo partirla.
2. No conviertas una tarea técnica en historia. Si la petición es «crear una tabla en la base de
   datos», señálalo: eso es una tarea, no una historia.
3. Si falta información para escribir un criterio, **no la inventes**: ponla en «preguntas».

## Formato de salida

### Historia

> Como **[rol concreto]**, quiero **[objetivo]**, para **[beneficio]**.

El rol no es «usuario»: es «el asesor», «la empresa cliente», «el administrador».

### Criterios de aceptación

Entre **2 y 4**, en Given/When/Then:

```
Given  [contexto de partida]
When   [acción o evento]
Then   [resultado observable en pantalla o en los datos]
```

Incluye al menos **un caso límite** — qué pasa cuando no hay datos suficientes, cuando el valor
es cero, o cuando el usuario no tiene permiso.

### Preguntas

Lo que hace falta decidir antes de construirla. Nunca está vacío.

## Qué no hacer

- No propongas diseño de pantalla ni solución técnica.
- No escribas criterios que no se puedan observar («el sistema es rápido» no vale).
- No superes media página.
