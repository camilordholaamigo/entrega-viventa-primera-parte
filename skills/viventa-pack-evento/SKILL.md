---
name: viventa-pack-evento
description: >-
  Convierte los guiones y el brief de un evento Viventa en la matriz de producción: una fila por
  archivo con el copy final escrito, el nombre de archivo normalizado, el árbol de carpetas con su
  índice y el CSV para las plantillas maestras de Figma. USA
  cuando: "arma el pack de piezas del evento de Tampa", "necesito la matriz de producción", "qué
  copy va en cada pieza del evento", "el CSV para el data merge de los flyers". Es postproducción: viventa-guiones-evento escribe los videos antes y
  viventa-brief-evento estima el tamaño del pack al recibir la solicitud.
metadata:
  version: "1.1.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-pack-evento

Produce la matriz de producción de **un** evento: una fila por cada archivo que va a existir, con el
copy final adentro, el nombre normalizado y el bloque CSV de consultoras listo para el data merge de
las plantillas maestras que diseño ya tiene en Figma. El problema no son los 57 archivos de un
evento grande, son sus ~15 unidades de copy: se deciden una vez acá y no se re-deciden en la mesa de
edición. Invariantes de toda corrida: sin dirección exacta no hay matriz, ninguna celda de copy
lleva un placeholder, ninguna cifra sale de fuera del input, y el skill no aprueba ni publica.

## Cuándo usar

- Explícito: "arma el pack de piezas del evento de {ciudad}", "necesito la matriz de producción de
  {ciudad}", "qué copy va en cada pieza del evento", "hazme los flyers por consultora de {ciudad}",
  "el CSV para el data merge de los flyers", "cuántos archivos salen de este evento",
  "adaptaciones del evento de {ciudad} para Meta y para impresos".
- Implícito: los guiones del evento ya existen y producción está por abrir Figma o CapCut.
- Cadencia: una corrida por evento y por tanda (lanzamiento; optimización aparte). Nunca "todos los
  eventos del mes" en una corrida.

## Cuándo NO usar

- Recién llega la solicitud del evento y se quiere saber cuánto trabajo es → `viventa-brief-evento`
  (estima entregables; este skill cuenta archivos exactos).
- Faltan los guiones de video → `viventa-guiones-evento` primero.
- Auditar piezas ya producidas contra el manual → `viventa-qa-marca`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Ciudad, país, venue + dirección completa (calle, número, CP, ciudad, estado) | Brief del evento | **Bloquea** (Paso 1). *"Pasame venue y dirección completa con código postal."* Se pide a quien armó el brief |
| Fecha(s) y horario **local** del evento | Brief del evento | **Bloquea.** *"¿Fecha y horario en hora local del evento?"* Nunca hora Colombia |
| Modalidad | Brief del evento | **Bloquea.** *"¿Es ExpoColombia, Open House, Expo Casa o Más Cerca de Ti?"* Define headline y arquitectura del flyer |
| Conceptos de video | Salida de `viventa-guiones-evento` | *"Pasame los guiones del evento."* Si hay menos de 5, se corre con los que haya y se declara. No se inventan conceptos |
| Tanda: lanzamiento u optimización | Brief o usuario | No se pregunta: sin indicación, lanzamiento |
| Escala: conceptos de carrusel y estática, formatos | Brief del evento | No se pregunta: defaults (3 carruseles, 2 estáticas, 9:16 + 1:1 + A3 + A4 + redes 1:1), declarados en la cabecera |
| Consultoras: nombre, email, teléfono, foto | Brief o líder comercial de la plaza | **Bloquea solo las filas de esa consultora**: van con `⛔ INPUT REQUERIDO` y se pide a la líder comercial |
| Monto de reserva y % de financiamiento | Brief o máster aprobado | Bloquea solo el beneficio que lo usa: `⛔ INPUT REQUERIDO`. Nunca se estima |
| Bancos aliados que van en pieza | `references/cifras-canonicas.md` y máster aprobado | No se pregunta: 5 bancos canónicos; otro conteo solo si lo trae el input (Paso 3) |
| Testimonio o prueba social de la ciudad | Brief o VOC | No se pregunta: se usa el genérico y se marca como oportunidad |
| Días hasta el evento | Se calcula con la fecha y hoy | — Si son < 45, advertencia en cabecera. No bloquea |

La moneda **se deriva del país** con la tabla única de `references/naming-y-datamerge.md` §3: se
pregunta el país, nunca la moneda. País fuera de la tabla → se pregunta la moneda.

## Workflow

### Paso 1 — Gate de inputs

1. Chequeá la tabla. Si falta dirección completa, fecha/horario o modalidad, detenete y emití solo:
   ```
   ⛔ NO SE PUEDE GENERAR LA MATRIZ — {MODALIDAD} · {CIUDAD}
   INPUTS REQUERIDOS
   - Dirección completa del venue en {ciudad} → pedir a: {quien armó el brief}
   - {otros faltantes, con a quién}
   Motivo: sin dirección concreta ninguna pieza pública puede salir (fricción #1 del Voice of Customer).
   ```
2. Faltantes que no bloquean la matriz entera: datos de una consultora (bloquean sus 3 filas),
   testimonio local, monto de reserva (bloquea su beneficio).

### Paso 2 — Resolver la capa local una sola vez

1. Separá las capas: **máster** (conceptos, promesa, hook, bancos, constructoras: no cambia por
   ciudad) · **local** (ciudad, país, fecha, venue, dirección, horario, moneda, modalidad: una vez por
   evento) · **persona** (nombre, cargo, email, teléfono, foto) · **composición** (9:16 vs 1:1, A3 vs
   A4: no multiplica copy).
2. Redactá tres piezas reutilizables y usalas literales en toda la matriz:
   - Bloque logístico largo: `{venue}, {calle y número}, {ciudad}, {estado} {CP}. {fecha(s)} · {hora inicio} – {hora fin}. Entrada libre.`
   - Bloque logístico corto (≤ 1 línea legible a 300 px): `{Ciudad} · {fechas} · {venue} · {calle y número} · {hora inicio} – {hora fin}`
   - Línea de VO localizada: la dirección hablada, sin CP, con el número como se dice.
3. **Gate de localización**: además de los campos locales, al menos 1 elemento de prioridad 2 de
   `references/localizacion.md` (prueba social de la ciudad · ciudad colombiana de origen de la
   colonia dominante · sub-segmento no atendido, como pregunta y nunca como cobertura). Sin ninguno:
   `⚠ LOCALIZACIÓN SUPERFICIAL — revisar` en cabecera. Cambiar "Miami" por "Tampa" no es localizar.

### Paso 3 — Redactar las unidades de copy, no los archivos

1. Escribí solo las unidades únicas, cada una con su `COPY_ID`: `V01…V05` (primary text + VO
   localizada por video) · `C1…C3` (carrusel slide por slide, ~5 slides) · `E01…E02` (estáticas) ·
   `F01` (flyer general, las 10 ranuras de `references/specs-formato.md`) · `P01…P0N` (contacto por
   consultora).
2. El hook va en los primeros 125 caracteres del primary text; la dirección, después del corte "ver
   más". Cada celda de copy Meta lleva su conteo de caracteres.
3. El último slide de todo carrusel es el bloque logístico corto.
4. Texto congelado, copiado literal:

| Elemento | Texto exacto |
|---|---|
| Promesa | **Con Viventa todo saldrá bien.** |
| Cargo | **Experta en crédito y compra de vivienda** (Experto si es hombre: única variación) |
| Constructoras | **+20 constructoras en todo el país** |
| CTA | **¡Reserva tu cita!** |
| Exclusividad | **Evento exclusivo para colombianos en {país}** |
| Bancos | **5 bancos aliados**, según `references/cifras-canonicas.md` (el nombre de cada banco, del máster aprobado). Solo si el input trae otro conteo se usa el del input, marcado `[⚠ difiere de CIFRAS_CANONICAS]` |

### Paso 4 — Expandir a filas de archivo

1. Una fila por archivo. Las filas 9:16 y 1:1 del mismo concepto **referencian** el mismo `COPY_ID`
   (`↳ V01`); solo cambia la columna de notas de composición.
2. Calculá con la escala del brief (`V` ≤ 5 videos, `C` ≤ 3 carruseles, `E` ≤ 2 estáticas son topes
   de **conceptos**; formatos `F` y consultoras `N` no tienen tope):
   ```
   ARCHIVOS = (V × 2 formatos) + (C × ~5 slides × 2 formatos) + (E × 2 formatos)
            + 1 flyer general A3 + (3 superficies × N consultoras)
   COPY     = V + C + E + 1 + N
   ```
3. Si piden "150 piezas" o "22 videos", preguntá si son archivos o conceptos antes de advertir: 150
   archivos desde 15 unidades de copy no rompe nada; más de 5 conceptos de video sí, y se pide
   priorizar.
4. Declará la escala en la cabecera marcando los defaults: `Escala: V=5 [default], C=3 [default],
   E=2 [default], N=6 [del brief]`.
5. Tanda de optimización: otra corrida, prefijo `OPT` en cada nombre de archivo, nunca mezclada con
   la de lanzamiento.
6. Nombre de archivo según `references/naming-y-datamerge.md` §2, con un solo `CIUDAD3` por ciudad.
   Toda fila 9:16 lleva nota de safe zone 14/35/6 con CTA y dirección fuera del 35 % inferior.

### Paso 5 — CSV de consultoras

1. Emití el CSV con el esquema exacto de `references/naming-y-datamerge.md` §4.
2. Aplicá la capa persona (§5): email derivado del patrón marcado `⚠ verificar`; teléfono siempre del
   input; prefijo telefónico distinto del país del evento → `⚠ verificar prefijo`, sin asumir cuál
   es el correcto. Más de 6 consultoras → advertir antes de generar.

### Paso 6 — Carpetas e índice de archivo

1. Reproducí la convención que ya usan: mes → evento-ciudad → consultora → pieza. No inventes otra:
   remapearía el histórico.
2. **Árbol de carpetas** en texto plano, numerado (`01.VIDEOS`, `02.CARRUSELES`…), listo para
   crear en Drive. Una carpeta por consultora, no una por pieza; si piden carpeta por pieza, se hace
   avisando que se desvía del histórico y rompe el data merge.
3. **Índice**: una fila por archivo con nombre, dimensiones, peso máximo, campaña, asesor y carpeta
   destino. Dimensiones de `references/specs-formato.md`, nunca estimadas. Pieza sin consultora →
   `04.FLYER GENERAL`.

### Paso 7 — Chequeo y cierre

1. Verificá: cero corchetes, `TBD` o `N/A` en copy; toda pieza pública con dirección completa;
   conteo declarado de archivos = filas de la matriz = filas del índice; unidades de copy
   declaradas aparte; moneda `USD`/`EUR`/`GBP`, nunca "USA" ni `$` solo; cero emojis de bandera.
2. Todo hallazgo va al bloque de cierre. Cerrá con `APROBACIÓN DE MARCA: pendiente — aprobador de
   marca`.

## Reglas duras

- **Nunca genera la matriz sin dirección completa, fecha/horario local y modalidad**: el output es
  solo `INPUTS REQUERIDOS`.
- **Nunca deja un placeholder en una celda de copy** (`[ciudad]`, `TBD`, `N/A`). Dato que falta →
  `⛔ INPUT REQUERIDO: {qué} → pedir a: {quién}`.
- **Nunca escribe tasa, cuota, plazo ni cuota inicial**, ni promete aprobación: el material de
  marketing entrega precio; lo demás lo da el asesor en llamada.
- **Nunca escribe un monto o porcentaje que no esté en el input o en el máster aprobado**, ni
  convierte moneda. Permitido: `280 USD` si viene del flyer aprobado. Prohibido: `258 EUR` calculado.
- **Nunca escribe "USA" como moneda** ni `$` sin mercado.
- **Nunca traduce al inglés ni al francés**: español de Colombia, tuteo, también en Londres, París o
  Misisauga.
- **Nunca repite el texto de un `COPY_ID`** en otra fila: la referencia.
- **Nunca inventa un teléfono ni afirma un email derivado**: el teléfono es input duro; el email
  derivado lleva `⚠ verificar`.
- **Nunca toca una base de leads ni emite datos de clientes.** Los contactos de consultoras son
  comerciales y ya se imprimen en pieza.
- **Nunca borra un `[⚠ no verificado]` heredado** de las referencias.

## Output esperado

No escribe archivos ni crea carpetas. Devuelve en la conversación un markdown copiable a Sheets o
Docs:

```markdown
# Matriz de producción — {MODALIDAD} · {CIUDAD}, {PAÍS} {· OPT}
**Venue y dirección:** {venue}, {calle y número}, {ciudad}, {estado} {CP}
**Fecha:** {fecha(s)} · **Horario:** {inicio}–{fin} (hora local)
**Moneda:** {país} → {USD|EUR|GBP} · **Prefijo de archivo:** {CIUDAD3}
**Consultoras:** {N} · **Escala:** V={n} [..] C={n} [..] E={n} [..] N={n} [..]
**Semáforo 45 días:** {N} días — {✅ | ⚠ por debajo de 45}
**Localización:** {✅ {elemento de prioridad 2} | ⚠ LOCALIZACIÓN SUPERFICIAL — revisar}

## Bloque A — Videos Meta
| # | Archivo de salida | COPY_ID | Concepto | Fmt | Primary text (n car.) | VO localizada | Notas de composición |
## Bloque B — Carruseles Meta
| Carrusel | Slide | COPY_ID | Copy final | Archivos de salida (9:16 / 1:1) |
## Bloque C — Estáticas y flyer general
| Archivo de salida | COPY_ID | Ranura | Copy final | Notas |
## Bloque D — Piezas por consultora
| Archivo de salida | Consultora | Superficie | Nombre impreso | Cargo | Contacto | Estado |
## Bloque E — CSV para data merge en Figma
consultora,nombre_impreso,cargo,email,telefono,foto,archivo_A3,archivo_A4,archivo_redes,estado
## Bloque F — Árbol de carpetas e índice
{AÑO}/{NN.MES}/{MODALIDAD} - {CIUDAD}/ 01.VIDEOS · 02.CARRUSELES · 03.ESTATICAS · 04.FLYER GENERAL · 05.CONSULTORAS/{NOMBRE}
| Archivo | Dimensiones | Peso máx. | Campaña | Asesor | Carpeta destino |

## Cierre
EVENTO · TOTAL DE ARCHIVOS ({desglose}) · UNIDADES DE COPY ÚNICAS ({desglose})
TIEMPO ESTIMADO DE EJECUCIÓN: {N} h de Figma/CapCut · BLOQUEOS ({cuáles y a quién})
VERIFICACIONES ({las ⚠}) · ADVERTENCIAS HEREDADAS ({los [⚠ no verificado]})
APROBACIÓN DE MARCA: pendiente — aprobador de marca
```

Ejemplo recortado — ExpoColombia Tampa (Holiday Inn Tampa Westshore Airport Area, 700 North
Westshore Blvd, Tampa, FL 33609 · 30-31 de mayo · 10:00 a.m. – 7:00 p.m.):

| Archivo de salida | COPY_ID | Fmt | Primary text | Notas |
|---|---|---|---|---|
| `TP_video_TrabajasParaEsto_9x16_v01.mov` | V01 | 9:16 | Llevas años trabajando lejos de casa para que a los tuyos no les falte nada. Falta una sola cosa: que ese esfuerzo quede en algo tuyo, en Colombia. Te esperamos en Tampa el 30 y 31 de mayo… *(hook: 122 car.)* | Placa de dirección últimos 4 s · safe zone 14/35/6 |
| `TP_video_TrabajasParaEsto_1x1_v01.mov` | ↳ V01 | 1:1 | ↳ V01 | Reencuadre a centro |
| `TP_flyer_A4_v01_ConsultoraB.pdf` | P02 | A4 | ⛔ INPUT REQUERIDO: email y teléfono → líder comercial de Tampa | bloqueado |

```
TOTAL DE ARCHIVOS: 57  (10 video + 30 carrusel + 4 estáticas + 1 flyer general + 12 por consultora)
UNIDADES DE COPY ÚNICAS: 15  (5 video con su VO + 3 carruseles + 2 estáticas + 1 flyer + 4 contactos)
```

Al terminar se le dice al usuario: *"Matriz lista: {n} archivos desde {n} unidades de copy. Bloqueos:
{n} ({a quién pedirlos}). Pendiente la revisión del aprobador de marca."* La prueba: si diseño abre
la matriz y no tiene que escribirle a nadie ni decidir una palabra, está lista.

## Skills relacionados

- **Antes:** `viventa-brief-evento` (dirección, escala, consultoras) y `viventa-guiones-evento` (los
  conceptos de video).
- **Después:** `viventa-comunicaciones-campana` para la secuencia de email y WhatsApp del evento;
  `viventa-qa-marca` para auditar las piezas producidas.
- **Referencias:** `references/naming-y-datamerge.md` (naming, país→moneda, CSV, capa persona) ·
  `references/specs-formato.md` (safe zones, límites de Meta, impresos, ranuras del flyer) ·
  `references/localizacion.md` (prioridades por territorio y antipatrones).
