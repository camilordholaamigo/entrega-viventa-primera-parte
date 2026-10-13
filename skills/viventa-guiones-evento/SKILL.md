---
name: viventa-guiones-evento
description: >-
  Escribe los 5 guiones de video de un evento Viventa en una pasada: matriz de ángulos asignada
  antes de escribir, hook de 3 segundos, guion con tiempos, shot list grabable, variantes USD/EUR,
  bloque de voz en off por ciudad y validación de palabras prohibidas con lo que necesita visto
  bueno de Crédito. USA cuando: "escribí los 5 guiones del evento de Tampa", "necesito los guiones
  para grabar esta semana", "plan de tomas para la grabación", "guiones nuevos, que no queden todos
  iguales". Es preproducción de video: viventa-pack-evento redacta el copy de cada archivo y
  viventa-qa-marca audita piezas ya hechas.
metadata:
  version: "1.1.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-guiones-evento

Produce los **5 guiones de video** de un evento, listos para que la productora de video los grabe
en una sola sesión y el aprobador de marca los revise. Invariantes de toda corrida: sin dirección
exacta no se escribe nada, los 5 ángulos se asignan antes de escribir y son 5 hipótesis distintas,
ninguna línea con tasa, cuota o plazo se graba sin visto bueno de Crédito, y el skill no aprueba ni
publica.

## Cuándo usar

- Explícito: "escribir los 5 guiones del evento de {ciudad}", "necesito los guiones para grabar
  esta semana", "preproducción del evento de {ciudad}", "plan de tomas para la grabación", "hazme
  los videos del evento de Tampa", "guiones nuevos, que no queden todos iguales", "guiones de
  optimización del evento de {ciudad}".
- Implícito: ya existe el brief del evento (`viventa-brief-evento`) y la grabación se está por
  agendar; o el monitor marcó caída y piden más videos.
- Cadencia: una tanda de lanzamiento por evento; una tanda de optimización por cada caída que
  marque el monitor.

## Cuándo NO usar

- Revisar un guion o una pieza que ya existe contra el manual de marca → `viventa-qa-marca`.
- Redactar el copy de cada archivo (primary text, carruseles, flyers por consultora) →
  `viventa-pack-evento`.
- Buscar el insight y los hooks de una campaña antes de tener brief → `viventa-inteligencia-campana`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Ciudad, país, venue, **dirección completa**, fecha(s), horario local | El brief del evento | **Bloquea** (Paso 1). *"Pasame la dirección completa del venue: calle, número, ciudad."* Se pide a quien armó el brief |
| Modalidad (Open House · ExpoColombia · Expo Casa · Viventa Más Cerca de Ti) | El brief | *"¿Qué modalidad es?"* Define el registro del headline |
| Tanda: lanzamiento u optimización | El usuario | No se pregunta: si nadie lo dice, es **lanzamiento** |
| Rendimiento por ángulo (qué rindió, qué se quemó) | Salida de `viventa-monitor-evento` | Solo en optimización: *"¿Qué ángulo rindió y cuál no, según el monitor?"* Sin esto no hay tanda de optimización (Paso 2) |
| Recursos de grabación: locaciones, cámaras, personas a cuadro | El usuario o el brief | Se asume el mínimo 1/1/1 y se declara en la cabecera |
| Montos del brief (`{MONTO_USD}` / `{MONTO_EUR}`) | El brief | No se pregunta: se usa la línea agnóstica de moneda. Nunca se estima un monto |
| Lista oficial de palabras prohibidas | `Documentación Viventa/Marca/` | No se pregunta: se corre con `references/palabras-prohibidas.md` y la cabecera lo declara |
| Voice of Customer | `references/voice-of-customer-90d.md` | No se pregunta: si no está accesible, se usan solo los verbatims de `references/matriz-angulos.md` y la cabecera lo declara |
| Cifras de marca | `references/cifras-canonicas.md` | Si no está, toda cifra fuera de las del brief va marcada `[⚠ verificar antes de grabar]` |
| Días hasta el evento | Se calcula con la fecha del brief y hoy | — Si son < 45, advertencia en la cabecera. No bloquea |

La moneda se deriva del país con la tabla única de `references/naming-y-datamerge.md` §3: se
pregunta el país, nunca la moneda. País fuera de la tabla → se pregunta la moneda. Las consultoras no hacen falta acá: se resuelven en `viventa-pack-evento`.

## Workflow

### Paso 1 — Gate de inputs

1. Chequeá la tabla. Si falta la dirección exacta (barrio o ciudad sola cuentan como faltante),
   detenete y emití solo:
   ```
   ⛔ NO SE PUEDEN ESCRIBIR LOS GUIONES
   INPUTS REQUERIDOS
   - Dirección completa del venue en {ciudad} → pedir a: {quien armó el brief}
   - {otros faltantes, con a quién}
   Motivo: sin dirección concreta ninguna pieza puede salir (fricción #1 del Voice of Customer).
   ```
2. Ese bloque es un output válido. No inventes un venue plausible.

### Paso 2 — Elegir la tanda

| | Lanzamiento (default) | Optimización |
|---|---|---|
| Cuándo | Preproducción, antes de grabar | Evento al aire, el monitor marcó caída |
| Input extra | — | **Obligatorio:** rendimiento por ángulo |
| Qué produce | Los 5 ángulos de la matriz | Guiones sobre lo que rindió + ángulos no probados |
| Prefijo | — | `OPT` en cada ficha |

Reglas de optimización:
1. Sin datos de rendimiento, el output es el pedido de esos datos, no 5 guiones nuevos.
2. Un ángulo quemado (frecuencia alta, CTR cayendo) no se repite aunque haya rendido antes.
3. Un ángulo que rindió se profundiza con otro hook y otra estructura; nunca el mismo guion con
   otras palabras.
4. El tope de 5 conceptos es por tanda. Las dos tandas nunca van en la misma corrida.

### Paso 3 — Asignar los ángulos antes de escribir

1. Cargá `references/matriz-angulos.md` y armá la matriz de 5 filas: `# · ángulo · sub-segmento
   ICP · dolor VOC (verbatim) · tipo de hook (value promise · curiosity · shock) · estructura
   narrativa · promesa · prueba · hipótesis`.
2. Los ángulos 1, 2, 3 y 5 son fijos. El 4 rota entre los 4 sub-segmentos desatendidos: elegí el que
   aplique al territorio y declaralo.
3. Cada fila lleva una estructura narrativa distinta y un verbatim distinto del VOC. Si no hay 5
   verbatims distintos disponibles, el guion sin verbatim se marca `⚠ sin verbatim propio` en lugar
   de repetir uno.
4. La matriz va primero en el entregable.

### Paso 4 — Escribir los 5 guiones

Cada guion lleva 8 bloques, en este orden:

1. **Ficha** — ángulo · sub-segmento · dolor con verbatim · tipo de hook · estructura · duración
   (15-30 s) · hipótesis.
2. **Hook 0:00-0:03** — literal, ≤ 12 palabras. Sin saludo, sin marca, sin logo. La acción ya
   empezó en el frame 1.
3. **Guion hablado** — tabla `Tiempo | Línea | Nota de dirección`, con pattern interrupt marcado
   cada 5-8 s.
4. **Shot list** — columnas fijas de `references/shot-list.md`, sin exceder los recursos declarados.
5. **Texto en pantalla** por segmento, con nota de zona segura 9:16 vs 1:1.
6. **Variantes de cifra USD/EUR** — según la jerarquía de moneda (Paso 5).
7. **Bloque de VO por ciudad y fecha** — las frases que cambian por ciudad, para grabar en tanda.
8. **CTA** — con ciudad, dirección, fecha y hora ya resueltas.

### Paso 5 — Resolver moneda, ciudad y fecha fuera de labios

De mejor a peor:

| # | Solución | Costo |
|---|---|---|
| 1 | **Línea agnóstica** (preferida): *"Hay proyectos para presupuestos muy distintos — en el evento te decimos cuál te sirve."* | 1 toma sirve para los dos mercados |
| 2 | Cifra en toma aislada de ≤ 2 s (insert, texto en pantalla, VO sin cara) | 1 toma extra |
| 3 | Cifra en el bloque de VO | 1 take de audio extra |
| 4 | Cifra en labios a cámara — solo si el brief lo exige y queda declarado | Re-grabación completa |

- Cada mercado usa su cifra del brief; nunca se convierte tipo de cambio.
- Se escribe `USD` / `EUR` / `GBP`; nunca `$` sin mercado ni "USA" (error real: *"Reserva desde
  280 USA."*).
- Si la cifra va en VO, la línea EUR lleva una palabra más para emparejar la duración.
- Ciudad y fecha siguen el mismo principio: van en el bloque de VO, nunca en labios.

### Paso 6 — Validar en la misma pasada

1. **Capa 1, lista negra literal** — categorías A-D de `references/palabras-prohibidas.md`. Match =
   falla: se reemplaza en el guion y la fila va al bloque A con el reemplazo redactado.
2. **Capa 2, lista de disparo** — números seguidos de `%`, `$`, `€`, `COP`, "millones", y las
   palabras `tasa · cuota · inicial · plazo · años · aprobación · califica · garantiza · desde`.
   Match = bloque B con la pregunta exacta para Crédito. "20 años" de trayectoria de Viventa es
   cifra de marca, no plazo: no va a B.
3. **Capa 3, marca** — jerga sin traducir (LTV, DTI, amortización, preaprobado, buró),
   españolismos, "inversión" donde va "patrimonio", "solución integral", "aliado estratégico".
4. Siempre van a B: tasa, cuota mensual, % o monto de cuota inicial, plazo en años, cobertura de un
   producto o país (VA loan, ITIN, vivienda usada, Puerto Rico, Canadá), requisitos de calificación.
5. Corré los 12 tests del Output esperado. Si uno falla, arreglalo; si no se puede sin un dato que
   no tenés, queda como faltante en el bloque de validación.

## Reglas duras

- **Nunca escribe un guion sin dirección exacta**: el output es solo `INPUTS REQUERIDOS`.
- **Nunca deja en un guion para grabar una línea con tasa, cuota, plazo o cuota inicial** sin que
  esté en el bloque B marcada "no se graba hasta el OK de Crédito".
- **Nunca promete aprobación de crédito ni valorización.** Permitido: "te acompañamos en el
  proceso". Prohibido: "te aprobamos".
- **Nunca usa un testimonio que no esté literal** en el VOC o en `references/matriz-angulos.md`, ni
  una cifra sin fuente: se marca `[⚠ verificar antes de grabar]`.
- **Nunca escribe el ángulo de "inversión inmobiliaria"**, rentabilidad o ROI: es patrimonio y
  familia.
- **Nunca usa españolismos** ("vosotros", "vale", "coger", "guay", "tío"):
  español de Colombia, tuteo.
- **Nunca repite estructura narrativa ni verbatim** entre dos guiones de la misma tanda.
- **Nunca borra un `[⚠ no verificado]` heredado** de las referencias.

## Output esperado

No escribe archivos. Devuelve en la conversación un markdown copiable a Google Docs o CapCut:

```markdown
# Guiones — {MODALIDAD} · {CIUDAD}, {PAÍS} {· OPT si es optimización}
**Dirección:** {venue}, {calle y número}, {ciudad} · **Fecha:** {fecha(s)} · **Horario:** {inicio}–{fin} (local)
**Mercado:** {país} → {USD|EUR|GBP} · **Formatos:** 9:16 + 1:1
**Semáforo 45 días:** {N} días — {✅ | ⚠ por debajo de 45, la pauta no alcanza a pasar aprendizaje}
**Palabras prohibidas:** {lista oficial | ⚠ lista base del skill} · **VOC:** {completo | ⚠ solo verbatims de referencia}
**Recursos declarados:** {N} locación · {N} cámara · {N} personas {· supuesto 1/1/1}

## Matriz de ángulos
| # | Ángulo | Sub-segmento | Dolor VOC (verbatim) | Hook | Estructura | Promesa | Prueba | Qué se aprende si gana |

## Guion 1 — {ángulo}   (los 8 bloques del Paso 4)
## Guion 2..5 — idéntica estructura

## BLOQUE DE VALIDACIÓN
### A. Palabras prohibidas detectadas  | Guion | Tiempo | Cita | Regla | Reemplazo |
### B. Requiere visto bueno de Crédito — NO se graba hasta el OK  | Guion | Claim | Categoría | A quién | Pregunta exacta |
### C. Lo que NO se puede decir en anuncios (checklist fijo de references/palabras-prohibidas.md)
### D. Tests  | # | Test | PASA/FALLA |

**APROBACIÓN DE MARCA: pendiente — aprobador de marca**
```

Los 12 tests del bloque D:

| # | Test |
|---|---|
| 1 | Los 5 hooks no comparten verbo inicial ni estructura de apertura |
| 2 | Las 5 estructuras son distintas: ninguna coincide con otra en más de 3 de 5 beats |
| 3 | 5 verbatims distintos (o el guion marcado `⚠ sin verbatim propio`) |
| 4 | Con la ficha tapada, cada hook se asigna a su ángulo |
| 5 | Cero matches de la lista negra A-D |
| 6 | Todo claim de tasa, cuota, inicial, plazo o cobertura está en el bloque B |
| 7 | Cero jerga sin traducción en la misma frase |
| 8 | Toda cifra rastreable a `references/cifras-canonicas.md`, al brief o al VOC, o marcada |
| 9 | Shot list completo y dentro de los recursos declarados |
| 10 | Cada CTA con ciudad, dirección, fecha y hora concretas |
| 11 | Líneas de moneda en USD y EUR, fuera de labios salvo excepción declarada |
| 12 | Bloque de VO por ciudad/fecha aislado y grabable en tanda |

Ejemplo recortado — guion 3, ángulo trust (Más Cerca de Ti, Valencia, sábado 27-sep, 10:00-18:00):

| Tiempo | Línea | Nota de dirección |
|---|---|---|
| 0:00-0:03 | *"«Es que en Colombia todo es robo.» Me lo escribieron ayer."* | Hook shock, 11 palabras. Corte seco desde negro, ya mirando el celular |
| 0:03-0:08 | *"Y lo entiendo. Comprar a 8.000 kilómetros, sin ver, sin estar… da miedo."* | Validación. Bajar el ritmo |
| 0:08-0:13 | *"Por eso Viventa no es una inmobiliaria. Llevamos 20 años, trabajamos con 5 bancos y tenemos oficina en Colombia, Estados Unidos y España."* | ⚡ Pattern interrupt: B-roll de fachada + overlay de los 3 países |
| 0:19-0:24 | **[BLOQUE VO]** *"Este sábado 27 de septiembre estamos en Valencia. Te esperamos en {DIRECCIÓN}, de 10 de la mañana a 6 de la tarde."* | CTA. Card final con dirección grande |

Sin cifra de dinero: decisión del ángulo trust. Validación: prohibidas 0 · Crédito 0 · cifras 20
años / 5 bancos / 3 países de `references/cifras-canonicas.md`.

Al terminar se le dice al usuario: *"5 guiones listos para revisión de marca. {n} líneas esperan
visto bueno de Crédito (bloque B) y no se graban hasta el OK. Sigue `viventa-pack-evento`."*

## Skills relacionados

- **Antes:** `viventa-brief-evento` (dirección, fecha, modalidad) y `viventa-inteligencia-campana`
  (dolores y hooks de entrada).
- **Después:** `viventa-pack-evento` multiplica los conceptos a todas las piezas;
  `viventa-qa-marca` audita contra el manual completo.
- **Optimización:** `viventa-monitor-evento` entrega el rendimiento por ángulo que pide el Paso 2.
- **Referencias:** `references/matriz-angulos.md` · `references/palabras-prohibidas.md` ·
  `references/shot-list.md`.
