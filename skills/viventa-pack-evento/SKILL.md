---
name: viventa-pack-evento
description: >-
  Convierte los guiones y el brief de un evento en la matriz de producción completa:
  una fila por archivo que existirá, con el copy final ya escrito, el nombre de archivo
  con convención única, el árbol de carpetas con su índice de archivo, y el bloque CSV
  que alimenta las plantillas maestras de Figma. La escala sale del brief, no está fijada.
  Úsalo en postproducción, cuando hay que decidir qué texto va en cada pieza de cada
  ciudad, cada formato y cada consultora — y no volver a decidirlo en la mesa de edición.
metadata:
  version: "1.0.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-pack-evento

Produce **la matriz de producción de UN evento**: una fila por cada archivo que va a existir,
con el copy final adentro, el nombre de archivo ya normalizado y el bloque CSV de consultoras
listo para el data merge.

**El problema que ataca no son los 57 archivos — son las 20 unidades de copy.** ExpoColombia
Tampa produjo 57 archivos, pero solo 20 decisiones de redacción. Los otros 37 son export y
merge. Hoy esas 20 se re-deciden pieza por pieza en la mesa de edición: eso es lo que convierte
8 horas en 3 días.

**Se conecta con lo que Alejandra ya construyó.** Ella tiene plantillas maestras en Figma para
las piezas repetitivas donde solo cambia información. La salida de este skill **alimenta esas
plantillas** (matriz + bloque data merge). No propone un flujo paralelo, no rediseña nada.

**Este skill no aprueba, no publica y no activa pauta.** Termina en un documento para que
Daniel Vélez lo revise.

**Una sola pasada.** Sin research web, sin loops. Un evento por corrida — nunca "todos los
eventos del mes". Las cuentas de IA son compartidas y con límite (4 horas de espera si se
agotan); una matriz de 3 eventos es una matriz que no se termina de generar.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **Sin dirección exacta del evento, el skill bloquea.** Calle, número, código postal, ciudad,
   estado/provincia + nombre del venue. Va en **toda** pieza pública: flyers, cierre de video,
   último slide de cada carrusel, estáticas, pieza de redes. Es la fricción #1 del Voice of
   Customer, mencionada 3 veces: *"No entiendo por qué no pueden decir la ubicación donde van a
   atender en Miami, solo colocan 28 y 1 pero sin direccion"*. Sin dirección, el único output es
   el bloque `INPUTS REQUERIDOS`.
2. **Cero placeholders.** Ningún `[ciudad]`, `[fecha]`, `[dirección]`, `[nombre]`, `TBD` ni `N/A`
   en columnas de copy. Cada celda es texto final, copiable a Figma/CapCut con Cmd+C. Dato que
   falta → `⛔ INPUT REQUERIDO: {qué falta} → pedir a: {quién}`. Nunca se infiere ni se aproxima.
3. **Nunca tasa, cuota, plazo ni cuota inicial.** Son triggering terms regulados (Reg Z). El
   material de marketing entrega precio; tasa, cuota y plazo los da el asesor en llamada.
4. **Cero invención de cifras.** Solo se escriben montos y porcentajes presentes en el input o
   en el máster aprobado (`280 USD`, `hasta el 80 %`). Cualquier otro número → `⛔ INPUT REQUERIDO`.
   **Cero conversión automática de moneda.**
5. **La moneda se deriva del país** (tabla en `references/naming-y-datamerge.md`). Se escribe
   `USD`/`EUR`/`GBP`, **nunca "USA"** — error real en el flyer de Tampa: *"Reserva desde 280 USA."*
6. **Español de Colombia, tuteo, en todos los territorios** — incluidos Londres, París y
   Misisauga. No se traduce al inglés ni al francés.
7. **Los topes son de CONCEPTOS, no de archivos** — y esta distinción es el corazón del skill.
   Tope por evento: **5 conceptos de video · 3 carruseles · 2 estáticas**. Los *archivos* que
   salen de esos conceptos no tienen tope: son adaptaciones por ciudad, formato y consultora, y
   se derivan solos (Fase 4).
   **Cuando alguien pide "150 piezas" o "22 videos", casi siempre está contando archivos.** Antes
   de advertir nada, preguntá cuál de los dos es: 150 archivos desde 20 unidades de copy es
   exactamente lo que este skill produce y no rompe ningún tope. 150 conceptos distintos sí.
   Si de verdad piden más *conceptos*, advertir y pedir priorizar: 12 variantes cosméticas no
   compran 12 creativos: compran 5 conceptos y 7 archivos que además saturan a la única editora.
   `[⚠ no verificado]` Meta trataría creativos estructuralmente similares del mismo ad set como
   el mismo concepto para efectos de fatiga; el umbral del similarity score no está documentado
   públicamente.
8. **Un `COPY_ID` por unidad de copy.** Las filas 9:16 y 1:1 del mismo concepto **referencian**
   el mismo `COPY_ID`; no repiten el texto. Escribirlo dos veces garantiza que las dos versiones
   diverjan con la primera corrección.
9. **Los `[⚠ no verificado]` heredados se mantienen visibles** en el entregable. No se limpian.
10. El skill **no toca ninguna base de leads** y no emite PII de clientes.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| Ciudad, país, **venue + dirección completa** (calle, número, CP, ciudad, estado) | **Sí — bloqueante** | **Bloquea.** Pedir a quien armó el brief del evento (comercial / Johana) |
| Fecha(s) y horario **local del evento** | **Sí — bloqueante** | **Bloquea.** Nunca hora Colombia |
| Modalidad: ExpoColombia · Open House · Expo Casa · Viventa Más Cerca de Ti | **Sí** | Bloquea el headline. Determina la arquitectura del flyer, no la cantidad de piezas |
| Los conceptos de video (salida de `viventa-guiones-evento`) | Sí | Si hay menos de los esperados, correr con los que haya y declararlo. **No inventar conceptos** |
| Consultoras: nombre, email, teléfono, foto | **Bloqueante por consultora** | La fila se genera con el copy fijo resuelto y el campo marcado `⛔ INPUT REQUERIDO`. Pedir a la líder comercial de la plaza |
| Monto de reserva y % de financiamiento | Sí para los beneficios | `⛔ INPUT REQUERIDO`. **Nunca estimar** |
| Moneda | **Derivada** | No preguntarla: preguntar el país |
| Testimonio o prueba social de la ciudad | No | Usar el genérico y marcarlo como **oportunidad** en el bloque de localización |
| Formatos pedidos (9:16 / 1:1 / 4:5 / A3 / A4) | No | Default: **9:16 + 1:1 + A3 + A4 + redes 1:1** |
| Días hasta el evento | Sí | Calcular. Si son < 45, advertencia visible en la cabecera. **No bloquea** |

---

## Workflow

### Fase 1 — Gate de inputs (antes de redactar una sola palabra)

Chequeá la tabla de arriba. Si falta la dirección completa, la fecha/horario o la modalidad,
**detenete acá** y emití solo:

```
⛔ NO SE PUEDE GENERAR LA MATRIZ — {MODALIDAD} · {CIUDAD}

INPUTS REQUERIDOS
- Dirección completa del venue en {ciudad} → pedir a: {quien armó el brief del evento}
- {otros faltantes, con a quién pedírselos}

Motivo: sin dirección concreta ninguna pieza pública puede salir (fricción #1 del Voice of Customer).
```

Ese bloque **es un output válido**. No inventes un venue plausible ni un horario razonable.

Faltantes que **no** bloquean la matriz completa: datos de una consultora (bloquean solo sus 3
filas), testimonio local, monto de reserva (bloquea solo el beneficio que lo usa).

### Fase 2 — Resolver la capa local, una sola vez

Escribí **una vez** el bloque logístico y propagalo. No se re-decide pieza por pieza.

```
CAPA 1 · MÁSTER      5 conceptos · promesa · hook · bancos · +20 constructoras   → no cambia por ciudad
CAPA 2 · LOCAL       ciudad · país · fecha · venue · DIRECCIÓN · horario ·
                     moneda (derivada) · modalidad                                → 1 vez por evento
CAPA 3 · PERSONA     nombre · cargo (fijo) · email · teléfono · foto              → 4 campos, 3 superficies
CAPA 0 · COMPOSICIÓN 9:16 vs 1:1 · A3 vs A4                                       → NO multiplica copy
```

Redactá tres piezas reutilizables y usalas literales en toda la matriz:

- **Bloque logístico largo** (flyers, primary text): `{venue}, {calle y número}, {ciudad}, {estado} {CP}. {fecha(s)} · {hora inicio} – {hora fin}. Entrada libre.`
- **Bloque logístico corto** (último slide, pieza de redes, ≤1 línea legible a 300 px):
  `{Ciudad} · {fechas} · {venue} · {calle y número} · {hora inicio} – {hora fin}`
- **Línea de VO localizada** (cierre de video, la que Johana graba por ciudad): la dirección
  hablada, sin código postal, con el número deletreado como se dice.

**Gate de localización.** La capa local exige los 6 campos obligatorios **y al menos 1 elemento
de prioridad 2**: prueba social de la ciudad · referencia a la ciudad colombiana de origen de la
colonia dominante · o un sub-segmento no atendido (VA loan, ITIN — respondido con honestidad,
nunca prometido). Si no hay ninguno, marcá en la cabecera `⚠ LOCALIZACIÓN SUPERFICIAL — revisar`.
Cambiar "Miami" por "Tampa" no es localizar. Detalle en `references/localizacion.md`.

### Fase 3 — Redactar las unidades de copy (no los archivos)

Escribí **solo las unidades únicas**, cada una con su `COPY_ID`:

| Prefijo | Qué es | Cantidad |
|---|---|---|
| `V01…V05` | Primary text + línea de VO localizada por concepto de video | ≤5 |
| `C1…C3` | Carrusel completo, slide por slide (~5 slides) | ≤3 |
| `E01…E02` | Estáticas | ≤2 |
| `F01` | Flyer general (las 10 ranuras) | 1 |
| `P01…P0N` | Bloque de contacto por consultora (4 campos) | N |

Reglas de redacción:
- El hook va en los **primeros 125 caracteres** del primary text; la dirección, después del corte
  "ver más" — es para quien ya se enganchó.
- **El último slide de todo carrusel es el bloque logístico corto.** Sin excepción.
- Cada celda de copy Meta lleva su **conteo de caracteres**.
- Cero emojis de bandera.
- Texto congelado copiado **literal** de la tabla de abajo. No se reescribe en ninguna ciudad.

### Texto congelado — se copia, no se redacta

| Elemento | Texto exacto |
|---|---|
| Promesa | **Con Viventa todo saldrá bien.** |
| Cargo | **Experta en crédito y compra de vivienda** (flexión a **Experto** si es hombre — única variación permitida) |
| Bancos | Bancolombia · Davivienda · Banco de Occidente · Banco de Bogotá · Banco Unión |
| Constructoras | **+20 constructoras en todo el país** |
| CTA | **¡Reserva tu cita!** |
| Exclusividad | **Evento exclusivo para colombianos en {país}** (solo cambia el país) |
| Estructura del hook | Abre con la vida del migrante, no con el producto. El migrante es el héroe; Viventa es el guía |

### Fase 4 — Expandir a filas de archivo

Ahora sí, una fila por archivo. `COPY_ID` compartido entre formatos; lo único distinto es la
columna *notas de composición*.

**La escala sale del brief, no está fijada acá.** Leé del brief del evento (paso 1 de la cadena)
las cuatro cantidades y usalas como variables:

| Variable | Qué es | Default | Tope (regla #7) |
|---|---|---|---|
| `V` | **Conceptos** de video del pack | 5 | 5 |
| `C` | **Conceptos** de carrusel | 3 | 3 |
| `E` | **Conceptos** de estática | 2 | 2 |
| `F` | Formatos por concepto | 9:16 + 1:1 | sin tope |
| `N` | Consultoras asignadas | del brief, **bloqueante si falta** | sin tope |

Lo que escala es `F` × `N`, no `V`/`C`/`E`. Por eso un evento con 6 consultoras y 3 formatos
produce cientos de archivos sin romper el tope de conceptos.

```
ARCHIVOS = (V videos × 2 formatos) + (C carruseles × ~5 slides × 2 formatos)
         + (E estáticas × 2 formatos) + 1 flyer general A3 + (3 superficies × N consultoras)

COPY     = V + C + E + 1 + N
```

**Si usaste un default, escribilo en la cabecera del entregable** (`Escala: V=5 [default], C=3
[default], E=2 [default], N=6 [del brief]`). Un default silencioso es cómo se produce un pack a
la medida equivocada.

**Tanda de optimización.** Si el brief pide optimización, es **otra corrida de este skill** con
sus propias `V`, `C` y `E` — no se suma a la matriz de lanzamiento. Prefijo `OPT` en el nombre
de archivo para separarla. Mezclar las dos tandas en una matriz hace imposible leer qué se
produjo para qué.

Nombre de archivo según `references/naming-y-datamerge.md` §2. Nota de safe zone 14/35/6 en
**toda** fila 9:16, con CTA y dirección fuera del 35 % inferior.

### Fase 5 — Bloque CSV de consultoras

Emití el CSV con el esquema exacto de `references/naming-y-datamerge.md` §4, listo para pegar en
Google Sheets y conectar al data merge de las plantillas maestras de Figma. Corré los chequeos de
la capa persona (§5 del mismo archivo): email derivado marcado `⚠ verificar`, teléfono siempre
del input, prefijo telefónico contrastado contra el país del evento.

### Fase 5.5 — Estructura de carpetas e índice de archivo

Responde el pedido literal del cliente: *"cada pieza debo crear una carpeta, guardarla con el
nombre, el tamaño de la pieza, la campaña, el nombre del asesor."*

**No inventes una convención nueva.** La que ya usan está en el material real
(`Eventos/05.MAYO/VIVENTA MÁS CERCA DE TI - ALICANTE/CAROLINA RONDEROS/…`): mes → evento-ciudad →
consultora → pieza. El skill la reproduce y la completa; cambiarla obligaría a remapear el
histórico.

Dos salidas, ambas en el Bloque F:

1. **Árbol de carpetas** — la ruta completa a crear, en texto plano, lista para reproducir en
   Drive. Numerada (`01.VIDEOS`, `02.CARRUSELES`…) para que ordene sola.
2. **Índice de archivo** — una fila por archivo con: nombre, dimensiones, peso máximo, campaña,
   asesor y carpeta destino. Es el mismo universo de filas de la Fase 4, proyectado sobre dónde
   vive cada archivo en vez de qué dice.

Reglas:
- **Una carpeta por consultora, no una por pieza.** El pedido dice "una carpeta por pieza", pero
  la estructura real que ya usan agrupa por consultora y la respetamos: crear 150 carpetas sueltas
  rompe el data merge de Figma y no es lo que hacen hoy. Si insisten en carpeta por pieza, se
  hace — pero avisando que se desvía del histórico.
- **El asesor sale del brief.** Una pieza sin consultora asignada va a `04.FLYER GENERAL`, nunca a
  una carpeta de consultora vacía.
- **Las dimensiones salen de `references/specs-formato.md`**, no se estiman.
- El índice **no crea archivos ni carpetas**: es el mapa para que alguien lo haga. Este skill
  escribe texto.

### Fase 6 — Autovalidación y cierre

Corré el checklist de abajo entero. Todo hallazgo va en el bloque de cierre, no en un archivo
aparte. Cerrá siempre con `APROBACIÓN DE MARCA: pendiente — Daniel Vélez`.

---

## Qué multiplica y qué no

| Dimensión | ¿Multiplica copy? | ¿Multiplica archivos? | Veredicto |
|---|---|---|---|
| **Ciudad / evento** | **Sí** — dirección, fecha, horario, prueba social local | Sí | **Real. Es el eje principal** |
| **Modalidad** | **Sí** — headline y arquitectura del flyer | No | **Real.** Determina la plantilla, no la cantidad |
| **Consultora** | **No** — solo 4 campos | Sí (×3 superficies) | **Real pero barata. Es data merge, no redacción** |
| Moneda USD/EUR | Derivada del país | No | **Nunca es un eje independiente** |
| Formato 9:16 / 1:1 | **No** | Sí (×2) | **Cosmética a nivel copy, real a nivel export.** Mismo `COPY_ID` |
| Fecha | Sí, dentro del bloque logístico | No | Parte de la capa local |

**Regla:** si una dimensión no cambia ninguna palabra, es una **columna de export**, no una fila
nueva de decisión.

---

## Formato exacto del entregable

Markdown copiable a Google Sheets / Docs. Plantilla:

```markdown
# Matriz de producción — {MODALIDAD} · {CIUDAD}, {PAÍS}

**Venue y dirección:** {venue}, {calle y número}, {ciudad}, {estado} {CP}
**Fecha:** {fecha(s)} · **Horario:** {inicio}–{fin} (hora local)
**Moneda:** {país} → {USD|EUR|GBP} · **Prefijo de archivo:** {CIUDAD3}
**Consultoras:** {N} — {lista}
**Semáforo 45 días:** {N} días — {✅ / ⚠ por debajo de 45, la pauta no alcanza a pasar aprendizaje}
**Localización:** {✅ {elemento de prioridad 2 usado} / ⚠ LOCALIZACIÓN SUPERFICIAL — revisar}

## Bloque A — Videos Meta
| # | Archivo de salida | COPY_ID | Concepto | Fmt | Primary text (n car.) | VO — línea de cierre localizada | Notas de composición |

## Bloque B — Carruseles Meta
| Carrusel | Slide | COPY_ID | Copy final | Archivos de salida (9:16 / 1:1) |

## Bloque C — Estáticas y flyer general
| Archivo de salida | COPY_ID | Ranura | Copy final | Notas |

## Bloque D — Piezas por consultora
| Archivo de salida | Consultora | Superficie | Nombre impreso | Cargo | Contacto | Estado |

## Bloque E — CSV para data merge en Figma
```csv
consultora,nombre_impreso,cargo,email,telefono,foto,archivo_A3,archivo_A4,archivo_redes,estado
```

## Bloque F — Estructura de carpetas e índice de archivo

### Árbol a crear
```
{AÑO}/{NN.MES}/{MODALIDAD} - {CIUDAD}/
├── 01.VIDEOS/{9x16, 1x1}
├── 02.CARRUSELES/{carrusel-1, carrusel-2, ...}
├── 03.ESTATICAS/
├── 04.FLYER GENERAL/{A3, A4}
└── 05.CONSULTORAS/{NOMBRE CONSULTORA}/{A3, A4, REDES}
```

### Índice
| Archivo | Dimensiones | Peso máx. | Campaña | Asesor | Carpeta destino |

## Cierre
EVENTO: {modalidad} {ciudad} · {fechas} · {moneda}
TOTAL DE ARCHIVOS: {N}  ({desglose})
UNIDADES DE COPY ÚNICAS: {N}  ({desglose})
TIEMPO ESTIMADO DE EJECUCIÓN: {N} h de Figma/CapCut
BLOQUEOS: {N} ({cuáles y a quién pedírselos})
VERIFICACIONES: {las marcadas ⚠}
ADVERTENCIAS HEREDADAS: {los [⚠ no verificado] que aplican}
APROBACIÓN DE MARCA: pendiente — Daniel Vélez
```

---

## Ejemplo real recortado — ExpoColombia Tampa

Datos tomados de las piezas reales de mayo 2026. Holiday Inn Tampa Westshore Airport Area,
700 North Westshore Blvd, Tampa, FL 33609 · 30-31 de mayo · 10:00 a.m. – 7:00 p.m.

**Bloque A (recorte, 2 de 10 filas)**

| # | Archivo de salida | COPY_ID | Concepto | Fmt | Primary text | VO localizada | Notas de composición |
|---|---|---|---|---|---|---|---|
| 1 | `TP_video_TrabajasParaEsto_9x16_v01.mov` | V01 | Trabajas para esto | 9:16 | Llevas años trabajando lejos de casa para que a los tuyos no les falte nada. Falta una sola cosa: que ese esfuerzo quede en algo tuyo, en Colombia. Te esperamos en Tampa el 30 y 31 de mayo, en el Holiday Inn Westshore Airport Area, 700 North Westshore Blvd. Entrada libre, de 10:00 a.m. a 7:00 p.m. Con Viventa todo saldrá bien. *(hook: 122 car. antes del corte)* | "Te esperamos en Tampa, el 30 y 31 de mayo, en el Holiday Inn Westshore, sobre la 700 North Westshore Boulevard." | Placa fija de dirección, últimos 4 s. Safe zone 14/35/6 — CTA a altura 45-55 % |
| 2 | `TP_video_TrabajasParaEsto_1x1_v01.mov` | **V01** *(mismo copy, misma locución)* | Trabajas para esto | 1:1 | ↳ V01 | ↳ V01 | Reencuadre a centro; la placa pasa a tercio inferior, sin restricción de UI |

**Bloque B (recorte, 1 carrusel)**

| Carrusel | Slide | Copy final |
|---|---|---|
| C3 · "Reserva desde 280 USD" | 1 | Reservar tu apartamento en Colombia empieza desde 280 USD. |
| C3 | 2 | No es el precio de la vivienda. Es lo que necesitas para separarla mientras se estructura tu crédito. |
| C3 | 3 | El análisis inicial de crédito lo haces ahí mismo, el día del evento. |
| C3 | 4 | Con el respaldo de Bancolombia, Davivienda, Banco de Occidente, Banco de Bogotá y Banco Unión. |
| C3 | 5 | Tampa · 30 y 31 de mayo · Holiday Inn Westshore Airport Area · 700 North Westshore Blvd, Tampa, FL 33609 · 10:00 a.m. – 7:00 p.m. · Entrada libre |

> `280 USD` y `hasta el 80 %` salen del flyer real. **Ningún otro monto, tasa o condición se
> escribe sin que venga en el input.** Nótese `USD`, no `USA`.

**Bloque D (recorte, 2 de 12 filas)**

| Archivo de salida | Consultora | Superficie | Contacto | Estado |
|---|---|---|---|---|
| `TP_flyer_A4_v01_DianaBarcenas.pdf` | Diana Bárcenas | A4 | db.consultor@viventa.co · +1 786 4722511 | ✅ verificado en pieza de mayo |
| `TP_flyer_A4_v01_MarcelaEstrada.pdf` | Marcela Estrada | A4 | ⛔ INPUT REQUERIDO: email y teléfono → líder comercial de Tampa | bloqueado |

**Cierre**

```
EVENTO: ExpoColombia Tampa · 30-31 mayo · USD
TOTAL DE ARCHIVOS: 57  (10 video + 32 carrusel + 4 estáticas + 1 flyer general + 12 por consultora)
UNIDADES DE COPY ÚNICAS: 20  (5 video + 3 carruseles + 2 estáticas + 1 flyer + 4 contactos + 5 locuciones)
TIEMPO ESTIMADO DE EJECUCIÓN: 8-10 h de Figma/CapCut (vs. 2-3 días con la decisión de copy incluida)
BLOQUEOS: 3 (contacto de Marcela Estrada, Olga Díaz, Teresa Abello)
APROBACIÓN DE MARCA: pendiente — Daniel Vélez
```

---

## Checklist de autovalidación (Fase 6 — se corre entero, en la misma pasada)

**A · Completitud**
- [ ] Ciudad, país, moneda derivada, modalidad resueltos
- [ ] Fecha(s) y horario **local**
- [ ] Venue + dirección completa ← bloqueante
- [ ] Consultoras con nombre, email, teléfono, foto ← bloqueante por consultora
- [ ] Monto de reserva y % de financiamiento vienen del input
- [ ] Días hasta el evento ≥ 45, o advertencia visible

**B · Integridad de la matriz**
- [ ] Cero corchetes, cero `TBD`, cero `N/A` en columnas de copy
- [ ] Toda fila tiene nombre de archivo con la convención de `references/naming-y-datamerge.md`
- [ ] **Toda pieza pública contiene la dirección completa** — video, último slide de cada carrusel, estáticas, los 3 flyers, pieza de redes
- [ ] Filas 9:16 y 1:1 del mismo concepto comparten `COPY_ID` y la segunda referencia, no repite
- [ ] Conteo declarado de archivos = número de filas
- [ ] Unidades de copy declaradas por separado de los archivos
- [ ] **La escala (V, C, E, N) está declarada en la cabecera, marcando cuáles son default**
- [ ] Si es tanda de optimización, las filas llevan prefijo `OPT` y no se mezclan con lanzamiento

**B2 · Carpetas e índice (Bloque F)**
- [ ] El árbol de carpetas respeta la convención existente: mes → evento-ciudad → consultora
- [ ] El índice tiene una fila por archivo, y ese conteo coincide con el de la matriz
- [ ] Dimensiones tomadas de `references/specs-formato.md`, ninguna estimada
- [ ] Ninguna pieza sin consultora quedó colgando de una carpeta de consultora

**C · Marca y verdad**
- [ ] "Con Viventa todo saldrá bien." en al menos el flyer y un carrusel
- [ ] Cargo exacto: "Experta/o en crédito y compra de vivienda"
- [ ] Conteo de bancos y "+20 constructoras en todo el país" correctos.
      ⚠️ **Discrepancia abierta (29-ago-2026):** las piezas de mayo muestran **4 logos**
      (Bancolombia · Davivienda · Banco de Occidente · Banco Unión) y el material del
      engagement dice **5 bancos**. Hasta que Lizeth confirme cuál es el número real, usar
      el que venga en el input y marcarlo `[⚠ verificar conteo de bancos]`. **No escribir "5"
      por defecto.**
- [ ] Cero cifras fuera de la lista blanca del input
- [ ] Cero tasa, cuota, plazo, cuota inicial · cero promesa de aprobación
- [ ] Cero jerga sin traducir (LTV, DTI, amortización) · cero "solución integral", "aliado estratégico", "unlock", "leverage"
- [ ] Moneda escrita `USD`/`EUR`/`GBP` — **nunca "USA"**, nunca `$` a secas
- [ ] Todo en español de Colombia, incluidos Londres, París y Misisauga

**D · Ejecutabilidad**
- [ ] Hook dentro de los primeros 125 caracteres del primary text
- [ ] Toda fila 9:16 con nota de safe zone 14/35/6 y CTA fuera del 35 % inferior
- [ ] Bloque CSV listo para data merge, columnas en el orden del esquema
- [ ] Cero emojis de bandera
- [ ] Prefijo telefónico de cada consultora coherente con el país del evento, o marcado `⚠ verificar prefijo`
- [ ] Un solo `CIUDAD3` por ciudad en toda la matriz (nada de `MISSISAUGA` y `MISSISAGUA II`)

**E · Gobernanza**
- [ ] Cierre con `APROBACIÓN DE MARCA: pendiente — Daniel Vélez`
- [ ] Cero PII de clientes
- [ ] El skill no publicó, subió ni activó nada
- [ ] Un solo evento, una sola pasada, sin research

> **Prueba definitiva:** si Alejandra abre la matriz y no tiene que escribirle a nadie ni decidir
> una sola palabra para producir los 57 archivos, la matriz está lista.

---

## Frontera con otros skills

| Skill | Qué hace | Frontera |
|---|---|---|
| `viventa-brief-evento` | Arma el brief y los datos del evento | Es el **input** de este skill |
| `viventa-guiones-evento` | Escribe los 5 guiones y las variantes USD/EUR | Entrega los conceptos; este skill los adapta a piezas y territorio |
| `viventa-qa-marca` | Audita cualquier pieza contra el manual completo | Este skill valida su propia matriz (pre-filtro barato); el QA profundo es del otro |

## Referencias

- `references/specs-formato.md` — safe zones 9:16 / 1:1 / 4:5, límites de caracteres de Meta, formatos impresos, las 10 ranuras del flyer
- `references/naming-y-datamerge.md` — **fuente canónica** de la convención de naming, la tabla país→moneda, el esquema del CSV de data merge y las reglas de la capa persona
- `references/localizacion.md` — qué cambia de verdad por territorio (prioridad 1 y 2), antipatrones con antídoto y la aritmética de archivos vs. unidades de copy
