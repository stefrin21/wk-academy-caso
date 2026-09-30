# El caso · Benchmarking para asesorías

Este archivo es la base de trabajo de todo el curso. **Adjúntalo con `#file` cada vez que le
pidas algo a la IA sobre el caso**, para que todos partamos de la misma información.

---

## El caso en una frase

Una plataforma que ayuda a las **asesorías** a comparar sus **empresas clientes** con empresas
parecidas, usando los datos de la **factura electrónica** que ya pasan por la plataforma.

## La escena

Reunión periódica entre el asesor y su empresa cliente. El cliente pregunta:

> «¿Cómo voy respecto a empresas parecidas a la mía?»

El asesor tiene delante los datos de facturación —los de este cliente y los de decenas de
empresas más— pero no tiene forma de convertirlos en una respuesta rápida, fiable y que aguante
una pregunta de seguimiento. Hoy responde con su intuición, y la intuición no se puede enseñar
en una pantalla ni defender si el cliente discrepa.

## Quién es quién

- **Usuario principal: el asesor.** Es quien maneja la herramienta y quien tiene el problema.
- **Usuario secundario: la empresa cliente.** Recibe la respuesta en la reunión, no entra en la
  herramienta.

---

## Las cinco familias de insight

El producto completo deduce automáticamente cinco tipos de comparación. **En el curso se
construye la primera**; las familias 4 y 5 quedan para el hackathon del Módulo 6.

1. **Facturación** de la empresa frente a empresas comparables.
   *(Solo facturación emitida: en los datos no hay facturas recibidas, así que los
   costes no se pueden calcular. Es una decisión tomada, no un olvido.)*
2. **Tipos de cliente**: composición de la cartera frente a los competidores del grupo, para ver
   la concentración de riesgo.
3. **Precios de venta** que aplica la empresa frente a los competidores, también segmentados por
   zona geográfica.
4. **Plazos y métodos de pago y cobro** frente a la media del sector.
5. **Concentración de competidores** en el sector y en la zona de la empresa.

## Cómo se forma el grupo de comparación

Empresas con el **mismo CNAE**, **tamaño similar** y **misma comunidad autónoma**.

**Y aquí está el problema que hay que resolver:** con pocas empresas por sector, cruzar CNAE con
comunidad deja a algunas empresas **solas en su grupo**. Cuando eso pasa, la mediana y los
cuartiles coinciden y la comparación no significa nada.

La regla, entonces:

1. Se intenta primero el grupo **local** (CNAE + comunidad autónoma).
2. Si no llega a un mínimo de empresas, se amplía a **CNAE nacional**.
3. **Se dice siempre en pantalla cuál de los dos se está usando.**

*Cuál es ese mínimo es una decisión de negocio, no técnica, y está sin decidir.*

## Las restricciones que no se negocian

- **Solo datos agregados.** Mediana y cuartiles del grupo. Nunca la cifra de una empresa
  concreta, ni nada que permita deducirla.
- **Umbral mínimo de empresas** antes de mostrar nada: con dos empresas en el grupo, un cuartil
  es el dato de una de ellas.
- **Cada asesoría ve solo sus propios clientes.** La agregación ocurre por debajo; a la pantalla
  solo llega el resultado.
- Marco aplicable: **RGPD, AEPD y secreto profesional.**

---

## Los datos disponibles

Están en `assets/seed/`, en cuatro archivos CSV. **Son datos inventados**: las empresas, las
facturas y las asesorías no existen.

**`empresas.csv`** — 48 empresas en 8 sectores
`empresa_id, nif_cif, denominacion, cnae, sector, comunidad_autonoma, provincia, tramo`

**`facturas.csv`** — 397 facturas de 2025
`factura_id, numero, fecha, emisor_nif, emisor_empresa, importe_total, metodo_pago, despacho_id`

**`lineas_factura.csv`** — 1.226 líneas de detalle
`factura_id, descripcion, cantidad, precio_unitario, importe`

**`despacho_clientes.csv`** — qué empresa pertenece a qué asesoría
`despacho_id, empresa_id, nif_cif`

Los ocho sectores, por código CNAE: 1413 confección · 4321 instalaciones eléctricas ·
4711 comercio de alimentación · 4941 transporte de mercancías · 5610 restaurantes ·
6201 programación informática · 6920 contabilidad y asesoría · 8690 otras actividades sanitarias.

---

## El briefing para la IA

Este es el bloque que se pega en la chat al empezar el trabajo de discovery:

```
Caso de uso: benchmark para asesorías a partir de la factura electrónica.
Escena: un cliente que pide compararse con empresas parecidas.
Datos: facturación, costes, clientes, precios, pagos, formación del clúster.
Restricciones: RGPD, secreto fiscal, calidad del dato, explicabilidad.
Método: las skills instaladas en .agents/skills.
Output: hechos, supuestos, lagunas, problema.
```

## Lo que todavía no está decidido

Son las preguntas abiertas del caso. **No se inventan: se escriben como preguntas.**

- ¿Cuál es el número mínimo de empresas para que un grupo de comparación sea válido?
- ¿Qué define «tamaño similar» — facturación, número de empleados, número de facturas?
- ¿El periodo de comparación es el año natural, los últimos doce meses, o lo elige el asesor?
- ¿Se comparan facturación por separado, o también el margen resultante?
