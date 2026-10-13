---
name: viventa-radar-competencia
description: >-
  Produce el radar mensual de mercado de Viventa en 2 páginas: qué publicaron y pautaron los
  competidores, benchmark comparable y menciones de marca contra el baseline del Voice of
  Customer, y qué cambió desde la corrida anterior. Lo no verificado va a "no observado". USA
  cuando: "qué está haciendo la competencia", "radar competitivo del mes", "qué ángulos están
  corriendo los otros brokers", "qué dicen de nosotros", "benchmark del sector". Es el mercado
  como proceso: viventa-inteligencia-campana saca el insight de una campaña y radar-competitivo
  corre el scraping con dashboard.
metadata:
  version: "1.1.0"
  domain: "analyze"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-radar-competencia

Produce **el radar de mercado del mes**: competencia, benchmark y menciones de marca, en un solo
documento de máximo 2 páginas. **Observa y reporta**: no recomienda campañas, no escribe copy y no
decide presupuesto. Su salida la consumen `viventa-parrilla-base` y `viventa-inteligencia-campana`.

**Una sola pasada.** Cuentas compartidas, créditos limitados: si el material no está en el input
o en una búsqueda por competidor, va a "no observado". Eso es un resultado válido.

Dos hechos que ordenan la lectura (detalle en `references/panorama-competitivo.md`):

- **Meta Special Ad Category** (desde el 14-ene-2025): los anuncios financieros perdieron
  segmentación por edad, género y código postal. **El hook sustituye al targeting**, así que este
  radar mira hooks y ángulos, no audiencias.
- **El ángulo "raíces" está saturado**: lo usan todos los brokers. Reportarlo no es un hallazgo.

## Cuándo usar

- Explícito: "qué está haciendo la competencia", "radar competitivo del mes", "qué ángulos están
  corriendo los otros brokers", "qué dicen de nosotros", "benchmark del sector".
- Implícito: antes de armar la parrilla del mes, o cuando alguien afirma que "la competencia está
  haciendo X" y nadie tiene la pieza que lo pruebe.
- Cadencia: mensual, sobre el mes cerrado.

## Cuándo NO usar

- **El insight de entrada de una campaña puntual** (dolores, ángulos, hooks) →
  `viventa-inteligencia-campana`.
- **El desempeño propio** (CRM, Meta, Google, email) → `viventa-reporte-campanas`.
- **Scraping masivo de varias marcas con dashboard** → `radar-competitivo`.

## Conexiones

| Conexión | Para qué | Si falta |
|---|---|---|
| Búsqueda web (incluye Meta Ad Library pública) | Ver publicaciones, anuncios activos y menciones de marca que el usuario no trajo | Degrada: se trabaja solo con lo pegado; lo no traído va a "no observado" y la cobertura lo declara |

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Periodo | El usuario | *"¿Qué mes cubro?"* — sin respuesta, el mes cerrado anterior, declarado en la cobertura |
| Competidores a mirar | El usuario, o la lista del radar anterior | *"¿Qué competidores miro este mes?"* — sin respuesta, los brokers autorizados por Bancolombia (`references/panorama-competitivo.md`), declarado en la cobertura. Si no se puede confirmar quiénes son, se dice; no se inventan nombres |
| Piezas o anuncios recolectados | El usuario pega capturas, links o texto | No se pregunta: se hace la búsqueda del Paso 2 |
| Métricas propias del periodo | La salida de `viventa-reporte-campanas` | *"¿Tenés el reporte de campañas del mes?"* — sin él, el benchmark sale incompleto y lo dice |
| Métricas de referencia del sector | El usuario, con su fuente publicada | *"¿Tenés algún benchmark del sector con fuente?"* — sin fuente, la fila va a "métricas no emitidas" |
| Menciones de marca recolectadas | El usuario | No se pregunta: se hace la búsqueda del Paso 4 |
| Radar del mes anterior | `salidas/viventa-radar-competencia/` | Se busca ahí; si no está, el Paso 5 lo trata como primera corrida |

Baseline de social listening y cifras propias: `references/voice-of-customer-90d.md` y
`references/cifras-canonicas.md` (los inyecta el build del plugin del cliente). No se preguntan.

## Workflow

1. **Encuadrá.** Fijá periodo, competidores y fuentes que de verdad se pudieron mirar. Escribí la
   línea de cobertura con lo que **no** se cubrió: evita que el lector asuma cobertura total.
2. **Mirá la competencia.** Por competidor, una pasada: lo pegado y, si hay búsqueda web, sus
   publicaciones del periodo y sus anuncios activos en Meta Ad Library. Anotá solo lo observado:
   formato y tema publicado, ángulo o hook con **la pieza como evidencia** (qué, dónde, cuándo), y
   si pauta, qué anuncio se vio. Es señal: un ángulo nuevo en dos o más competidores a la vez, un
   formato nuevo, un sub-segmento que alguien empezó a atender, un competidor que dejó de pautar.
   Clasificá cada ángulo por el miedo que ataca (estafa, perder la plata, inmueble que no es).
3. **Armá el benchmark.** Una fila por métrica que tenga **fuente, ventana y universo**, y que
   esté medida igual del lado propio y del ajeno. Si falta cualquiera de las tres o la medición
   difiere, la fila va a "Métricas no emitidas y por qué". CPL y CAC se nombran completos y
   nunca se mezclan.
4. **Medí las menciones.** Volumen del periodo, separando **espontáneas** de **respondidas**, y
   saldo de sentimiento. Compará **siempre contra dos referencias a la vez**: el baseline propio
   del VOC (6 % de comentarios, 1,7 % de negativos) y el sector (0-0,3 % de comentarios en
   competidores, 10-15 % de negativos). Ej.: 3 % de negativos = "casi el doble del baseline
   propio, muy por debajo del sector". Igual al baseline → "en línea con el baseline". Sin
   menciones halladas → "no observado", no "cero menciones". Marcá si un competidor está
   atendiendo un sub-segmento desatendido (veteranos con VA loan, Puerto Rico, vivienda usada,
   compra sin cuota inicial): es el hallazgo más valioso del mes.
5. **Anotá qué cambió.** Solo si hay radar anterior: hasta 3 cambios contra él, cada uno con su
   implicación para la parrilla en una línea. Sin cambios relevantes → "sin cambios relevantes".
   Sin radar anterior → *"primera corrida — no hay comparación posible"*, y este radar queda de
   baseline.
6. **Autovalidá y guardá.** Recorré las reglas duras contra el borrador; si alguna falla,
   corregí antes de emitir. Guardá en la ruta de `Output esperado`.

## Reglas duras

- **Nunca estima** gasto, volumen de leads ni resultados de un competidor, ni desde la Ad
  Library ni desde la frecuencia de posteo. Si no se vio, no se dice.
- **Ninguna observación de competencia sin su evidencia** (pieza, dónde, cuándo). Una sola pieza
  no se lee como estrategia.
- **Ninguna fila de benchmark sin fuente, ventana y universo**, y ninguna comparación entre
  métricas medidas distinto.
- **Nunca compara menciones contra cero**: siempre contra el baseline del VOC y el sector.
- **Cero PII**: menciones por volumen y sentimiento; un verbatim público se cita sin identificar
  a la persona más allá de su handle público.
- **Ninguna cifra propia fuera de `references/cifras-canonicas.md`.** El +42 % es participación
  del segmento de no residentes, nunca "crecimiento del mercado" (el mercado total crece 5-12 %).
- **Nunca escribe copy ni propone campañas.** Permitido: *"el ángulo de entrega garantizada ya lo
  corren 3 competidores; la parrilla debería evaluar si sigue diferenciando"*. Prohibido:
  *"lanzar una campaña para veteranos con este copy: …"*.
- **Nunca reporta "raíces" ni audiencias como hallazgo.**
- **La sección "No observado" siempre existe**, aunque diga "nada relevante".

## Output esperado

Archivo `salidas/viventa-radar-competencia/radar-{AAAA-MM}.md`, español de
Colombia con tuteo, máximo 2 páginas:

```
# Radar de mercado — {periodo}

Cobertura: {qué se miró} · No cubierto: {qué no}

## 1. Competencia
{por competidor: qué publicó, qué ángulo, miedo que ataca, evidencia}

## 2. Benchmark
{tabla comparable, con fuente / ventana / universo}
### Métricas no emitidas y por qué

## 3. Menciones de marca
{volumen, espontáneas vs respondidas, sentimiento vs baseline y vs sector}

## 4. Qué cambió desde la corrida anterior
{máx. 3, con implicación para la parrilla — o "primera corrida"}

## 5. No observado
{lo que no se pudo verificar}
```

Al terminar se le dice al usuario la ruta, la cobertura en una línea y el hallazgo principal (o
"sin hallazgos nuevos este mes").

## Skills relacionados

- **Antes:** `viventa-reporte-campanas`, que da las métricas propias del benchmark.
- **Después:** `viventa-parrilla-base` planifica el mes con esta salida;
  `viventa-inteligencia-campana` la usa como insumo de una campaña.
- **En vez de este:** `radar-competitivo` para un scraping completo de varias marcas con
  dashboard; `viventa-caso-exito` cuando lo que hay que hacer es convertir la prueba social propia
  en piezas.
