---
name: viventa-inteligencia-campana
description: >-
  Produce el insight de entrada de una campaña de Viventa: target, 5-7 dolores anclados a
  verbatims reales, 3 ángulos distintos y 5 hooks redactados listos para probar en Meta.
  Se usa antes de pedirle copies a la agencia de pauta o guiones a producción, cuando hay que
  decidir de qué va a hablar la campaña y no solo que "necesitamos leads".
metadata:
  version: "1.0.0"
  domain: "campaign"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# Inteligencia de campaña — Viventa

## Para qué existe

Hoy las campañas de Viventa arrancan sin insumo. Quedó sobre el registro en la reunión del
29-jul-2026: Mateo preguntó de dónde sale el ángulo de cada campaña, Alejandra respondió
*"No, no tenemos nada de eso"*, y Johana lo cerró: *"siempre la necesidad es: necesitamos leads,
necesitamos que la gente vaya a los eventos"*.

Este skill es **el paso faltante**, no una mejora incremental. Produce el documento que hoy no
existe y que debería anteceder a todo lo demás: al brief de la agencia, a los guiones de video,
a los flyers.

**Dónde encaja políticamente:** la agencia externa de pauta define hoy keywords, copies y hooks.
Este skill **no la reemplaza** — produce el insumo que Viventa le entrega. El entregable se
presenta como "esto es lo que sabemos de este público y de este territorio", y la agencia decide
cómo lo ejecuta. Escribirlo o presentarlo como sustituto de la agencia genera fricción y hace
que no se use.

**Lo que este skill NO hace:** no aprueba, no lanza, no compra pauta, no publica, no toca la
cuenta de Meta, no mueve datos personales de leads. Termina en un entregable para aprobación de
Daniel Vélez.

---

## Principio rector: el ángulo ES el targeting

Desde el **14 de enero de 2025** los anuncios de crédito de Viventa caen obligatoriamente en la
Special Ad Category **"Financial Products and Services"** de Meta. Eso **elimina la segmentación
por edad, género y código postal**. No hay forma compliant de recuperarla. El creativo pasó a ser
la capa de targeting.

Consecuencias operativas, y todas son verificables en el entregable:

1. **El callout va en las primeras 8 palabras.** Si el sub-segmento no se nombra ahí, no se
   nombró.
2. **Un buen callout describe una situación, no una demografía.**
   Torpe: *"¿Eres colombiano de 35 a 50 años en Florida?"*
   Bueno: *"Vives en Broward y todos los eventos son en Miami."*
   La persona se reconoce en el hecho, no en la etiqueta.
3. **La landing hace el filtro que el targeting ya no hace.** Por eso el skill entrega, además
   del ángulo, la **pregunta calificadora** que debería ir arriba en el formulario. Sin eso el
   ángulo trae volumen sucio, y Meta ya es el canal de [cifra interna] de CAC fully-loaded.
4. **Nunca prometer aprobación ni tasa.** Además de regla de marca, es el terreno exacto donde
   Meta rechaza creativos de servicios financieros.

---

## Reglas duras

Estas no se negocian y se verifican en la Fase 6.

| # | Regla |
|---|---|
| R1 | **Todo dolor va anclado a un verbatim o a una objeción documentada.** Sin fuente → el renglón dice `[sin evidencia]`. Nunca se inventa el dolor. |
| R2 | **Los verbatims se citan literales**, con typos y sin corregir mayúsculas. La frase rara es el activo. |
| R3 | **Cero menciones de tasa, cuota o plazo con cifra.** Son triggering terms de Reg Z y un disclaimer no lo cura. El marketing entrega precio de vivienda; tasa, cuota y plazo los da el asesor en llamada. |
| R4 | **Cero promesas de aprobación**, "garantizado", "sin requisitos", ni proyecciones de valorización. |
| R5 | **De los 3 ángulos, al menos 1 nace de una objeción del playbook**, no de un deseo. |
| R6 | **Al menos 2 de los dolores son miedos**, no fricciones funcionales. En esta categoría el miedo pesa más que el dolor. |
| R7 | **El ángulo "raíces" no entra.** Está saturado: los ~8 brokers autorizados por Bancolombia lo usan todos, se ve hasta en sus nombres. |
| R8 | **Máximo 2 páginas, 6 bloques, cero secciones de contexto.** Si sobra espacio, se deja en blanco. |
| R9 | **Una sola pasada.** Máximo 2 consultas web, y son opcionales. Si no hay créditos, se entrega igual con las fuentes internas. |
| R10 | **El skill no aprueba, no lanza, no compra pauta.** Termina en entregable para Daniel. |

**Español de Colombia, tuteo.** Frases cortas. Prueba concreta antes que adjetivo. Nada de
"solución integral", "aliado estratégico", "unlock", "leverage". Nada de jerga financiera sin
traducir (LTV, DTI, amortización). No hablar como banco.

---

### Anti-patterns

| Falla | Cómo se ve | Antídoto |
|---|---|---|
| Dolor de manual | "Buscan seguridad financiera para su familia" | Columna `fuente` obligatoria. Sin fuente → `[sin evidencia]`. Prohibido redactar dolores en tercera persona genérica |
| Tres ángulos que son uno | A: "cumple tu sueño" · B: "haz realidad tu sueño" · C: "tu sueño es posible" | Test de 3 preguntas, con resultado escrito |
| Ignorar que no hay targeting | Ángulo que asume "mostrárselo a hombres 40-55 en Weston" | Cada ángulo declara la frase del creativo que hace el callout |
| Inventar tendencias | "Está en tendencia el formato POV en el nicho inmobiliario latino" | Sin URL y sin fecha no entra. "Sin dato de tendencia esta semana" |
| 4 páginas que nadie lee | Sección "Contexto del mercado inmobiliario colombiano" | Tope duro: 2 páginas, 6 bloques |
| Hooks descritos, no escritos | "Un hook que apele a la nostalgia del migrante" | Los 5 hooks entre comillas, listos para pegar |
| Prometer lo que no puede | "Aprobación garantizada", "tasa desde X%" | Filtro final de palabras prohibidas |
| Copiar el brief de otra ciudad | El mismo doc con Tampa cambiado por Orlando | El territorio es input obligatorio y aparece en el hook 1 |
| Verbatim maquillado | *"colombia todo es robo"* → "existen dudas sobre la seguridad" | Verbatims literales, con typos |
| Re-investigar lo ya sabido | Buscar en web qué es la Special Ad Category | Todo precargado en este SKILL.md y en `references/`. Máximo 2 consultas web opcionales |


## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| **Territorio** — ciudad o condado con nombre propio | **Sí** | **Pará y preguntá.** Sin territorio no hay callout y el brief queda genérico. No inventes uno. |
| **Tipo de campaña** — evento presencial / marca / producto (constructora) | **Sí** | Preguntá. Cambia el bloque 1 y los hooks. |
| **Fecha y dirección del evento** (si es evento) | Sí para eventos | Escribí en el bloque 1: `[⚠ falta dirección concreta — no se puede anunciar el evento sin ella, es la fricción #1 del VOC]`. El brief sigue; la advertencia viaja. |
| **Sub-segmento objetivo** | No | Lo derivás del VOC según territorio. Declaralo explícitamente en el bloque 1. |
| **Constructora / proyecto** (si es campaña de producto) | No | Trabajás a nivel marca y lo anotás en el bloque 6. |
| **Datos de rentabilidad de Lizeth** | No | El ángulo de retorno queda como pregunta abierta en el bloque 6, no como ángulo. |

**Chequeo de fecha:** si es evento y faltan **menos de 45 días**, advertilo en la primera línea
del entregable. Es el tiempo que necesita la pauta para pasar aprendizaje y llegar a un CPL sano.

**Chequeo de elegibilidad:** si el territorio no está en la lista de países elegibles
(ver `references/dolores-y-verbatims.md` §6), avisá antes de proponer nada.

---

## Workflow

Seis fases, una pasada, sin loops.

### Fase 1 — Encuadre (2 min)
Confirmá territorio, tipo de campaña, fecha y dirección. Corré los chequeos de 45 días y de
elegibilidad. Si falta un input obligatorio, pará y preguntá — una sola vez, en un solo mensaje.

### Fase 2 — Minería de dolores (local, obligatoria)
Leé, en este orden:

1. `references/voice-of-customer-90d.md`
2. «Manejo de Objeciones.docx» (adjuntar al chat)
   *(el directorio tiene un espacio final en el nombre — citalo entre comillas)*
3. `references/dolores-y-verbatims.md` de este skill — matriz precargada, los 4 sub-segmentos y
   sus trampas factuales. **No re-investigues esto.**

Filtrá por territorio. Sacá 5-7 dolores, cada uno con su verbatim literal y su fuente.
Marcá cuáles son **miedo** y cuáles son **dolor** (R6).

### Fase 3 — Lectura del banco de ángulos
Leé `angulos-usados.md` (ver `references/banco-angulos.md` §1; si no existe, creálo con el
encabezado y seguí). Descartá lo `quemado` y lo `activo` de menos de 30 días. Lo descartado va
al bloque 4 del entregable, con la razón.

### Fase 4 — Construcción de los 3 ángulos
Cada ángulo se arma sobre las 4 P: **Pain · Plan · Proof · Philosophy**, y declara la **frase
exacta del creativo que hace el callout**. Un ángulo sin esa frase no es un ángulo.

Corré el **test de 3 preguntas** (enemigo distinto · sub-segmento o awareness distinto · prueba
distinta — detalle en `references/banco-angulos.md` §4) y **escribí el resultado**. Si alguna
línea da FALLA, reemplazá el ángulo antes de seguir. No se entrega con un FALLA escrito.

Verificá R5: al menos uno nace de una objeción del playbook.

### Fase 5 — Hooks (opcional: hasta 2 consultas web)
Redactá 5 hooks completos, entre comillas, listos para pegar en Meta. El hook 1 lleva el callout
de territorio y tiene **≤ 12 palabras**.

Las 2 consultas web son **opcionales** y solo para verificar un dato fresco y fechado
(reglamentación del FNA, un competidor nuevo en el territorio). **Tendencia sin URL y sin fecha
no entra**: si no se pudo verificar, escribí *"sin dato de tendencia esta semana"*. Mejor vacío
que inventado. Si no hay créditos, saltate la fase y entregá igual.

### Fase 6 — Autovalidación y cierre
Corré el checklist completo (abajo). Escribí las 3 líneas nuevas en `angulos-usados.md` con
estado `sin probar`. Entregá para aprobación de Daniel.

---

## Formato del output — plantilla exacta

Seis bloques, en este orden. Sin portada, sin "contexto del mercado", sin glosario.
**Máximo 2 páginas.**

```markdown
# Inteligencia de campaña — {TERRITORIO} · {AAAA-MM}
{si aplica: ⚠ Faltan N días para el evento — por debajo de los 45 que necesita la pauta.}

## 1. Target
{Sub-segmento + territorio + nivel de awareness (Schwartz), en UNA línea.}
Sofisticación: {qué ya vio este público de la competencia.}
Pregunta calificadora para la landing: "{pregunta que filtra post-clic}"

## 2. Dolores priorizados
| # | Dolor | Tipo | Evidencia (verbatim / objeción) | Fuente | Uso en copy |
|---|---|---|---|---|---|
| 1 | ... | miedo | *"verbatim literal, con typos"* | VOC 90D, verbatim NN | ... |
| 2 | ... | dolor | Objeción #N | Manejo de Objeciones.docx | ... |
{5 a 7 filas. Mínimo 2 de tipo "miedo". Sin fuente → [sin evidencia].}

## 3. Ángulos
**Ángulo A — "{nombre}"** ({tipo: territorio / objeción-reversal / reencuadre})
· Pain: {el dolor del que sale, con su #}
· Plan: {la promesa}
· Proof: {la prueba dura — nunca tasa, cuota ni plazo}
· Philosophy: {qué hace distinto a Viventa acá}
· Callout: "{frase exacta del creativo que nombra al sub-segmento, primeras 8 palabras}"
· Auto-selecciona a: {quién se reconoce}
· Por qué ahora: {razón fechada}
· Slug para naming: VIV_{TERRITORIO}_{AAAAMM}_{ANGULO-SLUG}

**Ángulo B — ...** {mismo formato}
**Ángulo C — ...** {mismo formato}

**Test de distinción**
· Enemigos: {A} · {B} · {C} → PASA
· Sub-segmentos: {A} · {B} · {C} → PASA
· Pruebas: {A} · {B} · {C} → PASA

## 4. Ángulos a evitar
- {ángulo}: {razón — quemado en el banco / saturado en la categoría / riesgo regulatorio}

## 5. Hooks (listos para probar)
1. "..."   ← callout de territorio, ≤ 12 palabras
2. "..."
3. "..."
4. "..."
5. "..."

## 6. Qué no sabemos
- {hueco}: `[sin evidencia]` — {quién lo valida y antes de qué}
```

---

## Ejemplo real (recortado) — Broward County, FL, evento presencial

**1. Target**
Colombiano no residente en Broward, ingresos en USD, **Solution Aware**: sabe que existen
brokers, no sabe si son confiables ni si él califica. Sofisticación alta — ya vio a Bolívar,
Casa en Casa y a la propia Viventa anunciar ferias.
Pregunta calificadora: *"¿Eres colombiano o tienes familiar colombiano en primer grado?"*

**2. Dolores** (3 de 7, recortado)

| # | Dolor | Tipo | Evidencia | Fuente | Uso en copy |
|---|---|---|---|---|---|
| 1 | Los eventos siempre son en Miami-Dade y no maneja hasta allá | dolor | *"…van a Miami y nunca he visto uno acá en Broward, como que si todos los Colombianos viviéramos en Miami-Dade… mi no se me ha perdido nada por allá abajo para hacer ese viaje"* — @cliente | VOC 90D, verbatim 24 | El hook nombra Broward y la dirección exacta |
| 2 | "Desde tan lejos uno nunca sabe" | **miedo** | *"Eso realmente es algo de confianza? Porque es que colombia todo es robo."* | VOC 90D, verbatim 19 | Prueba dura antes que adjetivo: 20 años, 5 bancos, oficinas en 3 países |
| 3 | "No sé si califico y no quiero que me digan que no" | **miedo** | Objeción #4 — miedo a presentar taxes por el estatus migratorio | Manejo de Objeciones.docx #4 | "Primero saber, después decidir". Nunca prometer aprobación |

**3. Ángulos** (uno de tres, completo)

> **Ángulo B — "Saber si calificas no te compromete a nada"** (objeción-reversal)
> · Pain: dolor #3, el miedo al "no".
> · Plan: sales de la reunión sabiendo tu situación real, compres o no.
> · Proof: revisión de perfil crediticio con 5 bancos aliados + garantía de devolución si no hay
>   aprobación.
> · Philosophy: Viventa acompaña, no vende un producto suelto.
> · Callout: *"Antes de soñar con el apartamento, hay una pregunta más aburrida."*
> · Auto-selecciona a: el que lleva años posponiendo por miedo al "no".
> · Por qué ahora: la objeción #4 está sin atender en el copy actual.
> · Slug: `VIV_BROWARD_202608_CALIFICAS`

**Test de distinción**
· Enemigos: la distancia · la desconfianza · la aritmética → PASA
· Sub-segmentos: quien vive en Broward / quien pospone por miedo / quien piensa en cifras → PASA
· Pruebas: dirección concreta / 5 bancos + garantía / testimonios de recompra → PASA

**4. Ángulos a evitar**
- *"Cumple tu sueño"*: saturado, sin enemigo, no auto-selecciona a nadie.
- Cualquier promesa de aprobación o de tasa: regla de marca + riesgo con Meta Financial Services.
- Anunciar el evento sin dirección: reactiva la fricción #1 del VOC.

**5. Hooks**
1. *"Vives en Broward y todos los eventos son en Miami. Este no."*
2. *"Antes de soñar con el apartamento, hay una pregunta más aburrida: ¿calificas? Te la respondemos en 20 minutos."*
3. *"Llevas 8 años mandando plata a Colombia. ¿Cuánto de eso es tuyo?"*
4. *"No, no necesitas venir a Colombia. Sí necesitas saber cómo te ven los bancos."*
5. *"'Es que en Colombia todo es robo.' Lo escuchamos todos los días. Por eso trabajamos con 5 bancos y no con promesas."*

**6. Qué no sabemos**
- Cuál de los 3 ángulos ya se corrió en Broward: `[sin evidencia]` — el histórico de creativos no
  está documentado. Lo valida la agencia de pauta antes de comprar.

---

## Advertencias que no se borran

Sobreviven a cualquier reescritura del entregable.

- ⚠️ **VA loan.** El VA loan **no financia propiedad fuera de EE.UU. ni de sus territorios**. El
  ángulo veteranos **no puede ser** "usá tu VA loan en Colombia" — es promesa falsa. El ángulo
  honesto es *"tu ingreso estable de veterano te sirve acá, aunque el VA no cruce la frontera"*,
  y aun ese está `[⚠ no verificado — pendiente de validar con el área de Crédito si el ingreso VA
  computa ante bancos colombianos]`. Mientras no esté validado, va al bloque 6, no al bloque 3.
- ⚠️ **"Raíces" está saturado.** Es el ángulo de los ~8 brokers autorizados por Bancolombia
  (Colombia Raíz, Colraíces, Casa Propia Colombia, Casa en Casa, Unión Andina, Interimage,
  Suvivienda). Se ve hasta en los nombres de marca. No diferencia.
- ⚠️ **Terreno de la agencia.** Hooks, copies y keywords los define hoy la agencia externa. Este
  entregable es el **insumo que Viventa le pasa**, no su reemplazo. Presentarlo así.
- ⚠️ **Puerto Rico:** el callout se escribe "colombiano en Puerto Rico", nunca "puertorriqueño" —
  los bancos exigen ser colombiano o tener parentesco en primer grado.
- ⚠️ **"Mi Casa en Colombia"** (FNA, aprobado 17-jun-2026) se enuncia como programa existente,
  nunca como aprobación garantizada. Verificar estado de reglamentación en cada campaña.

---

## Checklist de autovalidación

Antes de entregar, todas deben dar sí.

- [ ] Cabe en 2 páginas. 6 bloques, en orden, sin secciones extra.
- [ ] Cada dolor tiene verbatim/objeción + fuente, o dice `[sin evidencia]`. **Cero dolores sin ancla.**
- [ ] Los verbatims están literales, con typos, sin maquillar.
- [ ] Al menos 2 de los dolores están marcados como **miedo**.
- [ ] Al menos 1 de los 3 ángulos nace de una objeción del `Manejo de Objeciones.docx`.
- [ ] Los 3 ángulos pasan el test de 3 preguntas y el resultado está escrito. Ningún FALLA.
- [ ] Cada ángulo declara la frase del creativo que hace el callout del sub-segmento.
- [ ] Cada ángulo trae sus 4 P completas.
- [ ] 5 hooks entre comillas, español de Colombia, tuteo. El hook 1 lleva territorio y tiene ≤ 12 palabras.
- [ ] **Filtro de palabras prohibidas**, búsqueda literal en todo el texto: `aprobación`, `aprobado`, `tasa` + cifra, `cuota` + cifra, `plazo` + cifra, `garantizado`, `sin requisitos`, `valorización`, `raíces`. Cero coincidencias.
- [ ] Si hay evento: dirección y ciudad concretas, o advertencia explícita de que faltan.
- [ ] Si faltan menos de 45 días para el evento, lo advierte en la primera línea.
- [ ] `angulos-usados.md` leído antes de proponer y actualizado con 3 líneas nuevas al entregar.
- [ ] Termina en entregable para aprobación de Daniel. **No publica, no lanza, no activa pauta.**
- [ ] **Una sola pasada.** Máximo 2 consultas web opcionales; sin créditos, se entrega igual con fuentes internas.

---

## Referencias

- `references/dolores-y-verbatims.md` — matriz de dolores, escala Dolor·Miedo·Deseo, las 4 P,
  los 4 sub-segmentos con sus trampas factuales, países elegibles, fuentes vivas.
- `references/banco-angulos.md` — formato del registro persistente, test de distinción, tipos de
  callout, ángulos vetados, ángulos semilla.
- `angulos-usados.md` — el registro. Se crea en la primera corrida.
- `references/contexto-viventa.md` — voz, marca,
  reglas durables del cliente.

**Alimenta a:** `viventa-guiones-evento`, `viventa-pack-evento` y el brief que Viventa le entrega
a la agencia externa de pauta.
