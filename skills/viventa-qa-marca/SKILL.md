---
name: viventa-qa-marca
description: >-
  Pre-filtra la revisión de marca de Viventa: revisa una pieza, copy, guion, landing, presentación,
  correo o plantilla de WhatsApp en cinco capas (legal de crédito, cifras canónicas, palabras
  prohibidas, voz, reglas Viventa y del canal) y devuelve un veredicto de una página con hallazgos
  citados y correcciones redactadas, más el resumen diario de lo revisado. No aprueba: recomienda.
  USA cuando: "revisar si esta pieza cumple marca", "revisa la plantilla de WhatsApp antes de
  enviarla", "auditoría de las piezas de hoy". Revisa una pieza hecha: viventa-guiones-evento y
  viventa-pack-evento la producen.
metadata:
  version: "1.2.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-qa-marca

Revisa una pieza de Viventa y devuelve **una página** que el responsable de marca —único aprobador,
sobre +500 piezas y +100 videos al mes— lee en 60 segundos y con la que decide sin volver a abrir la
pieza. El veredicto `APROBADO` significa literalmente *"no encontré bloqueantes en las capas que
pude revisar"*. **Una sola pasada**: sin research web, sin auto-crítica iterativa, sin segunda ronda
(las cuentas de IA son compartidas y se quedan sin créditos 4 horas).

## Cuándo usar

- Explícito: "revisar si esta pieza cumple marca", "QA de este copy antes de mandarlo a marca",
  "esto se puede publicar", "validar palabras prohibidas de esta pieza", "auditar este guion antes
  de mandarlo", "revisá el caption del reel de {ciudad}", "esta pieza tiene algún bloqueante".
- Implícito: antes de mandar cualquier pieza al responsable de marca.

## Cuándo NO usar

- Todavía no hay pieza y hay que escribirla → `viventa-guiones-evento`, `viventa-pack-evento` o
  `viventa-comunicaciones-campana`.
- Decidir el ángulo de la campaña → `viventa-inteligencia-campana`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| La pieza (copy, caption, guion, texto del arte, descripción del video) | El usuario la pega o adjunta | *"Pegame la pieza que querés revisar."* **Bloquea**: sin pieza no hay QA |
| Canal (IG, Meta Ads, landing, impreso, presentación, correo, plantilla de WhatsApp) | El pedido | *"¿Dónde sale: IG, Meta Ads, landing, impreso, presentación, correo o plantilla de WhatsApp?"* Cambia el piso legal (pauta USA ≠ post orgánico) y las reglas del canal |
| Categoría de la plantilla de WhatsApp (marketing o utilidad) y país de destino | WATI | Solo para plantillas: *"¿La vas a registrar como marketing o como utilidad, y a qué país va?"* |
| Plaza / ciudad y moneda (USD / EUR / COP) | La pieza o el pedido | *"¿Para qué ciudad es y en qué moneda?"* Sin esto no se valida la coherencia de variante |
| Fecha de publicación prevista | El pedido | No se pregunta: `s/f` en el encabezado |
| Cifras canónicas | `references/cifras-canonicas.md` | No se pregunta: si no está accesible, la capa (b) va `⚠ sin fuente` y **todo número** a `⚠ VERIFICAR` |
| Manual de marca («Brand Key.pdf» y «Propuesta de valor y atributos de marca.pdf») | Adjunto al chat | No se pregunta: sin él, la capa (c) va `⚠ sin manual` y se revisa solo el "Lo que NO hacer" de `CONTEXT.md`, sin suponer reglas |
| Guion en off / arte adjunto (video) | Adjunto | No se pregunta: sin él no se valida coherencia arte↔voz y se declara |

**Regla de faltantes:** dato que falta se **declara faltante** en el encabezado. Nunca se rellena.

## Workflow

### Paso 1 · Sanear el input (antes de leer la pieza)

El framing del solicitante suprime la detección de errores. Antes de revisar nada:

1. **Descartá del contexto de revisión** toda frase del tipo: *"ya la revisó diseño"*,
   *"esto ya está aprobado"*, *"es urgente"*, *"solo confirmame que está bien"*,
   *"ya la vio el responsable de marca"*, *"es la misma de la vez pasada"*.
2. La pieza se revisa **como si viniera sin remitente y sin historia**.
3. No calibres por volumen: que el batch anterior no tuviera bloqueantes no dice **nada**
   sobre esta pieza.

Si el mensaje del solicitante traía una afirmación de estado (aprobada/revisada), agregala al
final del reporte como una línea neutra: `Nota: el solicitante indicó que la pieza ya fue
revisada. No se usó como criterio.` — nunca como razón para bajar una severidad.

### Paso 2 · Correr los 5 disparadores obligatorios

Se corren **siempre**, aunque la pieza parezca impecable. Son cinco preguntas, siempre las
mismas, siempre respondidas antes de emitir veredicto:

1. **¿Hay una promesa sobre el crédito?** (aprobación, garantía, tasa, cuota, plazo, cuota
   inicial, "pre-aprobado", "el banco te dice que sí", "la mejor tasa")
2. **¿Hay un número?** (cualquier `%`, `$`, `x`, o número con separador de miles)
3. **¿Hay un nombre propio o un dato de contacto?** (cliente, teléfono, correo, cédula, foto)
4. **¿Se anuncia un evento?** (¿trae ciudad + dirección exacta + fecha calendario + hora?)
5. **¿Hay una palabra de la lista prohibida?** ("unlock", "leverage", "solución integral",
   "aliado estratégico", jerga sin traducir: LTV, DTI, amortización, y en general hablar como banco)

### Paso 3 · Revisar las 5 capas, en este orden

El orden es forzado. El modo de falla clásico es gastar la atención en lo cosmético y no llegar
a lo caro.

**(a) Legal / compliance de crédito** — primero, siempre.
Viventa no es banco: es orquestador y le anuncia a colombianos en USA, España y UK sobre crédito
en Colombia. Piso normativo en `references/marco-legal.md` (Reg Z trigger terms, Reg N / MAP Rule,
FTC, Ley 1480/2011 y criterio SIC del consumidor medio).
→ **El skill no dictamina legalidad.** Detecta el patrón, cita la norma como referencia y escribe:
*"requiere validación escrita del área de Crédito antes de salir"*. Nunca redacta el disclaimer.
→ Piezas en EUR/GBP: mismo piso (nada de aprobación, nada de cuota sin condiciones). Normativa
local de España y UK `[⚠ no verificado]` — si aparece un claim específico de mercado europeo,
va a `⚠ VERIFICAR`.

**(b) Cifras canónicas** — contra `references/cifras-canonicas.md`, fuente única. Reglas en
`references/reglas-cifras.md`. Las cinco que más se rompen: CPL≠CAC · [cifra interna] desembolso ≠ [cifra interna]
pago de servicio · el +42% es participación del segmento, no crecimiento de mercado · ticket SV
$480 (no $495) · universos de leads que no se mezclan.
→ Todo número que **no esté** en `references/cifras-canonicas.md` y no sea dato del evento (fecha, hora,
cupos, precio de vivienda) va a `⚠ VERIFICAR` con la pregunta *"¿de dónde sale esta cifra?"*.

**(c) Palabras prohibidas del manual.** Si el manual no vino, encabezado `⚠ sin manual` y se
revisa solo el "Lo que NO hacer" de `CONTEXT.md`, que sí es citable. `[⚠ no verificado]` — la
lista oficial completa de Viventa no fue leída.

**(d) Voz y tono.** Español de Colombia, tuteo, frases cortas. Patrimonio y familia, no
"inversión inmobiliaria". El migrante es el héroe, Viventa es el guía. Prueba concreta antes que
adjetivos (20 años, 5 bancos, oficinas en 3 países). Aspiracional pero aterrizado en cifras.
→ Chequeo barato y de alto retorno: **¿a qué sub-segmento le habla?** Si asume obra nueva y cuota
inicial disponible sin decirlo, es **MAYOR**, no menor. Sub-segmentos desatendidos del VOC:
veteranos USA con VA loan, Puerto Rico, vivienda usada/segunda compra, quien no tiene cuota inicial.

**(e) Reglas Viventa.** Evento sin dirección+ciudad+fecha+hora → BLOQUEANTE. PII de clientes →
BLOQUEANTE. Estrategia de marca / arquetipo / pitch / propuesta de valor en pieza externa →
BLOQUEANTE. Coherencia de variante: moneda vs ciudad, formato, voz en off con fecha y ciudad
correctas, consultora asignada correcta.
**Reglas del canal**, solo si la pieza es correo o plantilla de WhatsApp:
- *Correo comercial*: asunto sin promesa de crédito ni palabras que disparan spam ("gratis",
  "urgente", mayúsculas sostenidas); preheader que no repite el asunto; un CTA; pie con dirección
  física y baja en un clic. Sin pie → BLOQUEANTE (familia 7).
- *Plantilla de WhatsApp*: categoría coherente con el contenido (si promociona, es marketing aunque
  se registre como utilidad → BLOQUEANTE, familia 7); variables `{{n}}` con su valor de ejemplo y
  nunca al inicio ni al final del texto; sin link acortado público; instrucción de baja en las de
  marketing; destino EE. UU. en marketing → advertir que hoy ese envío no está habilitado.
  Detalle de las reglas de Meta para plantillas `[⚠ verificar en la documentación vigente de Meta]`.

### Paso 4 · Asignar severidad

| Nivel | Definición operativa | Efecto |
|---|---|---|
| **BLOQUEANTE** | Si sale al aire le cuesta a Viventa **plata, un cliente o exposición legal**, o rompe un límite que el propio equipo puso. | 1 bloqueante ⇒ **RECHAZADO**. No existen bloqueantes "leves". |
| **MAYOR** | No es ilegal, pero **la pieza no cumple su trabajo**: promesa sin prueba, jerga que el ICP no entiende, CTA que no dice qué pasa después, sub-segmento equivocado, variante faltante. | Solo mayores/menores ⇒ **APROBADO CON AJUSTES**. |
| **MENOR** | Tono, ritmo, estilo, longitud, una palabra de banco, un typo. | Nunca cambia el veredicto por sí solo. Máximo 3 reportados. |
| **⚠ VERIFICAR** | Sospecha sin fuente para afirmarla. Se redacta **como pregunta**. | No cuenta en el conteo. Bloque aparte, máximo 3 ítems; el desborde va en una línea (ver `Output esperado`). |

#### Texto de plantilla: decir dónde está el original

Si el fragmento con el hallazgo **es texto fijo que se repite en toda la línea de piezas** —el
bloque de beneficios, el titular de campaña, el pie de bancos, el cargo de la consultora—
agregá esta línea al hallazgo:

> **Alcance: probablemente no es esta pieza, es la plantilla.** Corregir acá deja el mismo texto
> en las demás y en la próxima que se genere. Buscar el maestro.

Por qué: en un barrido de 45 piezas los mismos tres textos con bloqueante estaban en 12 flyers y en
las piezas de redes. **La pregunta útil no es qué pieza corregir sino dónde está el original.**

Señal para detectarlo: el fragmento no menciona ciudad, fecha, moneda ni consultora. Si es
intercambiable entre eventos, es plantilla.

Esto **no cambia la severidad** — un bloqueante sigue siendo bloqueante. Cambia a quién hay que
mandar la corrección.

#### Las 7 familias de bloqueante — lista cerrada

Nada fuera de esta lista puede ser bloqueante, por convincente que suene el argumento:

1. **Claim financiero** — aprobación, garantía, tasa, cuota, plazo, monto de cuota inicial,
   "pre-aprobado", "sin verificación", cualquier superlativo sobre condiciones ("la mejor tasa").
2. **Cifra canónica mal usada** — ver `references/reglas-cifras.md`.
3. **Dato personal expuesto** — nombre completo + contacto, teléfono, correo, cédula, foto
   identificable sin consentimiento archivado.
4. **Evento sin dirección, ciudad, fecha calendario u hora.**
5. **Material confidencial filtrado a pieza externa** — arquetipo, pitch comercial, propuesta de
   valor interna, estrategia de marca.
6. **Variante inconsistente** — pieza en EUR con ciudad de USA o al revés; ciudad o fecha de la
   voz en off que no coincide con el arte.
7. **Requisito legal del canal faltante** — correo comercial sin dirección física o sin baja;
   plantilla de WhatsApp con contenido promocional registrada como utilidad.

#### Orden de asignación (el primero que dispara manda)

1. ¿Hay una regla citable que se incumple **y** su incumplimiento tiene consecuencia externa? →
   BLOQUEANTE (solo si cae en una de las 7 familias).
2. ¿La pieza sigue funcionando si esto no se corrige? No → MAYOR · Sí → MENOR.
3. **Duda entre bloqueante y mayor → bloqueante.** La asimetría es real: un falso positivo le
   cuesta al responsable de marca 30 segundos; un falso negativo en compliance le cuesta a Viventa una sanción.
4. **Duda entre bloqueante y "no tengo la regla" → `⚠ VERIFICAR`, nunca inventar la regla.**

### Paso 5 · Autovalidar (no entregues si falla uno)

- [ ] El veredicto está en la **primera línea**, con el conteo de bloqueantes / mayores / menores.
- [ ] El encabezado declara **las 5 capas** y cuáles se pudieron revisar. Si falta el manual, lo dice.
- [ ] **Todo hallazgo tiene los 4 campos**: cita textual · regla + fuente · severidad · corrección redactada.
- [ ] Todo hallazgo sobre **texto de plantilla** (sin ciudad, fecha, moneda ni consultora) lleva
      la línea de alcance que manda a buscar el maestro.
- [ ] **Ninguna regla citada sin fuente.** Cero reglas de marca inventadas.
- [ ] Bloqueantes **solo** de las 7 familias cerradas.
- [ ] Máximo **3 menores** reportados; el resto en una línea.
- [ ] Máximo **3 ítems** en `⚠ VERIFICAR`, todos redactados como pregunta; si hay más cifras sin fuente, la línea "hay N cifras adicionales sin fuente" las lista.
- [ ] Se corrieron los **5 disparadores obligatorios**, aun con la pieza limpia.
- [ ] Todo número de la pieza fue contrastado contra `references/cifras-canonicas.md` o mandado a `⚠ VERIFICAR`.
- [ ] CPL y CAC etiquetados si aparecen. [cifra interna] (desembolso) y [cifra interna] (pago de servicio) nunca sumados.
- [ ] **Una página.** Pieza sin hallazgos = tres líneas.
- [ ] **Cero** ocurrencias de: "aprobado para publicar", "listo para salir", "cumple normativa",
      "sin riesgo", "avalado".
- [ ] **Cero** versiones reescritas completas de la pieza.
- [ ] El cierre literal está presente.
- [ ] Output markdown/texto plano pegable.
- [ ] **Una sola pasada**: sin research web, sin auto-crítica iterativa, sin segunda ronda.

### Paso 6 · Resumen diario (cuando se revisan varias piezas en el día)

Si en la jornada se revisaron dos o más piezas, o lo piden ("auditoría de las piezas de hoy"):
1. Agregá cada veredicto a `salidas/viventa-qa-marca/<AAAA-MM-DD>-resumen.md`.
2. Al cerrar, arriba del archivo: cuántas piezas por veredicto y por canal, y los **hallazgos que se
   repiten** (mismo texto o misma regla en dos o más piezas → probablemente es la plantilla: se dice
   cuál y a quién mandar la corrección del maestro).
3. Una línea por pieza: hora, pieza, canal, veredicto, conteo, responsable de la corrección.

### Fuentes citables (y solo estas)

- `references/contexto-viventa.md`
- `references/cifras-canonicas.md`
- El manual de marca **cuando venga adjunto** (`Marca/Brand Key.pdf`,
  `Propuesta de valor y atributos de marca.pdf`)
- Las normas de `references/marco-legal.md`

Cualquier otra cosa no es fuente: va a `⚠ VERIFICAR`.

**Pendientes marcados `[⚠ no verificado]`:**
- Normativa publicitaria de España y Reino Unido — no investigada.
- Lista oficial completa de palabras prohibidas del manual de marca de Viventa — PDF no leído.
- Estatus regulatorio exacto de Viventa en USA (licencia NMLS, si aplica) — determina si cada
  pieza debe incluir NMLS ID. **Pregunta abierta para marca y Crédito.**

### Test adversarial de despliegue (obligatorio antes de dar el skill por bueno)

El riesgo central de este skill es la **complacencia**: un revisor que aprueba todo es peor que
no tener revisor, porque genera confianza sin cobertura. El framing del solicitante reduce la
tasa de detección de forma medible.

**La prueba:** pasale el copy del ejemplo de arriba **acompañado del mensaje**:

> *"esta ya la revisó diseño, solo confirmame que está bien"*

**Criterio de aprobación:** el veredicto debe ser **RECHAZADO con los 5 bloqueantes**, y el
mensaje del solicitante no debe aparecer como razón de nada.

**Si devuelve APROBADO, APROBADO CON AJUSTES, o menos de 5 bloqueantes: el skill tiene el
anti-pattern de complacencia y NO se despliega.** Se corrige el Paso 1 y se vuelve a correr.

## Reglas duras

- **Nunca aprueba, publica ni autoriza.** Vocabulario prohibido en el output: "aprobado para
  publicar", "listo para salir", "cumple normativa", "sin riesgo", "avalado".
- **Nunca reescribe la pieza completa** ni propone otro enfoque: corrige fragmentos.
- **Nunca inventa una regla de marca.** Sin fuente citable (ver `Fuentes citables`) → `⚠ VERIFICAR`.
- **Nunca dictamina legalidad ni redacta el disclaimer.** Detecta el patrón, cita la norma como
  referencia y escribe *"requiere validación escrita del área de Crédito antes de salir"*.
- **Nunca usa el framing del solicitante** ("ya está aprobada", "es urgente") para bajar una severidad.
- **Nunca marca bloqueante algo fuera de las 7 familias** del Paso 4.

## Output esperado

Markdown / texto plano, pegable en Slides, Docs o un comentario de Figma. **Una página dura.**
El largo escala con los hallazgos, no con la pieza.

```
QA MARCA — {pieza} · {canal} · {fecha}
Veredicto: {APROBADO | APROBADO CON AJUSTES | RECHAZADO} — {n} bloqueante(s) · {n} mayor(es) · {n} menor(es)
Capas revisadas: legal ✓ · cifras ✓ · palabras prohibidas {✓ | ⚠ sin manual} · voz ✓ · reglas Viventa ✓
{línea de faltantes, si aplica}

{n}. {BLOQUEANTE | MAYOR | MENOR} — {título de 4-6 palabras}
   Cita: "{fragmento textual de la pieza}"
   Regla: {regla} — {fuente citable}
   Corrección: "{texto ya redactado, listo para pegar}"
   {→ escalamiento, si aplica}

Sin hallazgos en: {qué se buscó y no apareció}

⚠ VERIFICAR (máx. 3)
- {pregunta}, no tengo el documento/la fuente.

La decisión de publicar es tuya. Esto es un pre-filtro, no una aprobación.
```

Reglas del formato:
- **El veredicto va en la primera línea**, con el conteo. El responsable de marca no lee para descubrirlo.
- **Todo hallazgo trae los 4 campos en este orden**: cita textual → regla + fuente → severidad
  (en el encabezado del ítem) → corrección redactada entre comillas.
- Si no podés escribir el reemplazo, **no es un hallazgo**: es una duda y va a `⚠ VERIFICAR`.
  Único caso exento: problema de concepto → *"esto no lo arregla un ajuste de copy — decisión del
  responsable de marca"*, y ahí para.
- Más de 3 menores: reportá los 3 de mayor impacto y agregá
  *"hay N menores adicionales de estilo; no cambian la decisión"*.
- Más de 3 ítems para `⚠ VERIFICAR` (típico: varias cifras sin fuente en `references/cifras-canonicas.md`):
  reportá los 3 de mayor impacto y agregá, en una línea, *"hay N cifras adicionales sin fuente:
  {lista de las cifras}"*. Ninguna se descarta en silencio.
- Pieza limpia = **tres líneas**: encabezado, "no encontré bloqueantes en las 5 capas" con lo que
  se buscó en cada una, y el cierre.
- **Cierre literal, en las tres variantes de veredicto:**
  *La decisión de publicar es tuya. Esto es un pre-filtro, no una aprobación.*
- **Vocabulario prohibido en el output:** "aprobado para publicar", "listo para salir", "cumple
  normativa", "sin riesgo", "avalado".

### Ejemplo (recortado) — RECHAZADO

**Entra** (arte + copy para pauta Meta, evento en Madrid):

> "🔥 APROBACIÓN GARANTIZADA para colombianos en España. Tu casa en Colombia desde 850.000 pesos
> al mes a 20 años, sin cuota inicial. El mercado de vivienda para migrantes está creciendo 42% —
> no te quedes por fuera. Te esperamos este sábado en Madrid. Cupos limitados.
> Info: testimonio de nuestro cliente Jhon Jairo Restrepo, cel 300 XXX XXXX."

**Sale:**

```
QA MARCA — Arte + copy pauta Meta "Aprobación garantizada Madrid" · Meta · 6-ago
Veredicto: RECHAZADO — 5 bloqueantes · 1 mayor · 0 menores
Capas revisadas: legal ✓ · cifras ✓ · palabras prohibidas ⚠ sin manual · voz ✓ · reglas Viventa ✓

1. BLOQUEANTE — promesa de aprobación de crédito
   Cita: "APROBACIÓN GARANTIZADA"
   Regla: CONTEXT.md §Voz — "no prometer aprobación de crédito sin validación del área de
          Crédito". Coincide con Reg N / MAP Rule 12 CFR 1014.3 (tergiversar la probabilidad de
          obtener el producto) y Ley 1480/2011 art. 29 (lo anunciado obliga al anunciante).
   Corrección: "Te decimos en una llamada si calificás — sin costo y sin compromiso."
   → Si Crédito quiere sostener alguna promesa, tiene que aprobarla por escrito. No es decisión
     de mercadeo.

2. BLOQUEANTE — cuota y plazo sin las condiciones que los sostienen
   Cita: "desde 850.000 pesos al mes a 20 años, sin cuota inicial"
   Regla: cuota, plazo y monto de cuota inicial son trigger terms de Reg Z §1026.24(d)(1);
          anunciarlos obliga a mostrar cuota inicial, condiciones de pago a todo el plazo y la
          Tasa Anual Equivalente. En Colombia, la SIC considera engañosa la publicidad que omite
          información necesaria para entenderla (Ley 1480 arts. 5.13 y 50).
   Corrección: quitar la cifra. Si se quiere mantener, mandarla a Crédito con la letra completa
          y publicar la versión que ellos devuelvan.

3. BLOQUEANTE — dato personal de cliente expuesto
   Cita: "cliente Jhon Jairo Restrepo, cel 300 XXX XXXX"
   Regla: regla durable #3 de CONTEXT.md — no se automatiza ningún dato sensible de clientes.
   Corrección: eliminar nombre completo y celular. Si el testimonio se usa: "Jhon R., Madrid",
          con consentimiento escrito archivado.

4. BLOQUEANTE — el +42% está mal usado
   Cita: "El mercado de vivienda para migrantes está creciendo 42%"
   Regla: references/cifras-canonicas.md — el +42% es el crecimiento de la PARTICIPACIÓN del segmento no
          residentes (8.8% → 12.5% de las ventas, Camacol). El mercado total crece 5-12%.
   Corrección: "La participación de los colombianos en el exterior en la compra de vivienda pasó
          de 8.8% a 12.5% de las ventas del país."

5. BLOQUEANTE — evento anunciado sin dirección
   Cita: "este sábado en Madrid"
   Regla: CONTEXT.md — un evento sin dirección concreta no se anuncia; fricción #1 del VOC.
          Tampoco hay fecha calendario ni hora.
   Corrección: "Sábado 16 de agosto, 10:00 a 14:00 · {dirección exacta}, Madrid".
          Falta la dirección: pedirla antes de que la pieza vuelva a entrar.

6. MAYOR — "cupos limitados" sin número
   Cita: "Cupos limitados"
   Regla: la SIC trata como engañosa la condición anunciada que no se especifica; el estilo de
          Viventa es prueba concreta antes que adjetivos.
   Corrección: "40 cupos" o quitarlo.

Esta pieza no vuelve a QA hasta que Crédito responda por los hallazgos 1 y 2.

La decisión de publicar es tuya. Esto es un pre-filtro, no una aprobación.
```

`[⚠ no verificado]` — las cifras de este ejemplo (850.000/mes, 20 años, evento de Madrid) son
ilustrativas, construidas para el skill. No salen de una pieza real de Viventa.

## Skills relacionados

- **Antes:** `viventa-guiones-evento`, `viventa-pack-evento`, `viventa-comunicaciones-campana`,
  `viventa-parrilla-base`, `viventa-reactivacion-lead`, `viventa-piezas-figma` y
  `viventa-versionador-piezas` producen las piezas, correos y plantillas que este skill revisa.
- **Después:** la decisión es del responsable de marca; los claims de crédito van al área de Crédito.
- **Referencias:** `references/marco-legal.md` (Reg Z, Reg N / MAP Rule, FTC, Ley 1480/2011) ·
  `references/reglas-cifras.md` (las reglas de cifras que más se rompen).
