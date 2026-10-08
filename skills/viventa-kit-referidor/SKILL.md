---
name: viventa-kit-referidor
description: >-
  Genera el kit de activación de un referidor del programa Referidores Pro de Viventa:
  texto del flyer personalizado, correo de bienvenida y 3 mensajes reenviables escritos
  en la voz del referidor (no en la voz de la marca), con disclosure de comisión obligatorio
  y cero términos financieros. No genera el link único, el tracking ni el pago — eso es Zoho.
metadata:
  version: "1.0.0"
  domain: "acquire"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# viventa-kit-referidor

Usuaria: **Lizeth Henríquez** (Growth & Marketing). Hoy hace esto sola y a mano, ~40 min por referidor.
Meta del skill: ~5 min, y que el kit salga sin edición mayor en ≥70% de los casos.

---

## ⛔ FASE 0 — PRECONDICIÓN. Leer y ejecutar ANTES de mirar el output objetivo.

Este skill **no arregla el programa de referidores. Puede empeorarlo.** Antes de generar nada,
corré estos dos chequeos. No son advertencias decorativas: son gates.

### Gate 0.1 — No existe documento del programa Referidores Pro

En todo el corpus de `Documentación Viventa/Incentivos Comerciales/` **no hay un documento del
programa Referidores Pro**. Lo que hay son cuatro planes de compensación de **fuerza comercial
interna** (concurso de mercadeo [cifra interna]/trimestre · Especialistas Inmobiliarios [cifra interna] ·
Especialistas Crédito 4%-30% · Vivepuntos del BOT). **Ninguno aplica a un referidor externo.**

El único monto de referidos que aparece en el corpus es `~$200-$500/referido cerrado`
(`VIVENTA_DIAGNOSTICO_MAESTRO.md` l.396). Eso es una **recomendación del diagnóstico de Mateo,
no una política vigente de Viventa**. `[⚠ no verificado]`

> **PROHIBIDO ABSOLUTO: el skill nunca escribe $200, $500, ni ningún rango derivado de esa cifra,
> ni "entre 200 y 500", ni "alrededor de USD 300". Ni como ejemplo. Ni entre paréntesis.**

Acción del skill:
1. **Pedir el documento vigente de incentivos de Referidores Pro.**
2. Si Lizeth lo tiene → los montos, la etapa de causación y el plazo de pago salen **textualmente de ahí**.
3. Si NO lo tiene → **el kit se genera igual**, pero con placeholders explícitos
   `[MONTO — pendiente de política]`, `[ETAPA — según documento]`, `[PLAZO — según documento]`,
   y el archivo se marca en la primera línea:

```
🚫 KIT NO ENVIABLE — falta el documento de incentivos vigente de Referidores Pro.
   Los campos de plata están en placeholder. No enviar a la referidora hasta completarlos.
```

Razón legal, no estética: **art. 29 de la Ley 1480** — lo anunciado obliga y entra al contrato.
Prometer una comisión que no existe en un documento firmado es exposición directa. Y la SIC ya
multó a Constructora Bolívar —aliada de Viventa— con $1.306 millones por publicidad engañosa,
con responsabilidad objetiva.

### Gate 0.2 — Piloto: máximo 10 referidores activos

| Modo | Cuándo | Volumen |
|---|---|---|
| **Piloto** | Ya, hoy | Máx. **10 referidores**, elegidos a mano, con seguimiento manual de pagos |
| **Escalado** | Solo si se cumple la métrica de abajo | Sin tope |

**Métrica para escalar:** ≥90% de las comisiones de referidos causadas en los últimos 90 días
pagadas dentro del plazo prometido, **y** existe notificación automática de estado al referidor
(recibido / calificado / cerrado / pagado). `[⚠ no verificado — Viventa no mide esto hoy]`

Por qué el tope. El k-factor de referidos de Viventa está en **[cifra interna]** contra un benchmark interno
de 15-30% para proptech madura. Y Lizeth, textual:

> *"se ha atrasado sobre todo la parte de pagos… la respuesta de los comerciales es 'cuando esto
> funcione, te busco más referidores'. O sea, le estás quedando mal a mi cliente con el pago."*

**Un kit de activación sobre un programa que no paga acelera el daño reputacional.** Cada referidor
activado y luego impagado es un promotor convertido en detractor, y esa reputación viaja por el
mismo canal boca-a-boca que queremos encender.

**Matiz que sí resuelve este skill:** la literatura de programas de referidos es precisa en que
**el asesino no es el retraso sino el retraso no reconocido**. Un referidor que recibe *"confirmado
— se paga el 15"* se comporta muy distinto de uno que recibe silencio por seis semanas. Eso **sí es
contenido**, y lo resuelve el bloque "CUÁNDO TE PAGAMOS" del correo de bienvenida (Bloque B). Si
Viventa no puede pagar en 30 días, al menos puede decirlo.

**Nota sobre las cifras:** el benchmark 15-30% viene del corpus interno de Viventa; los benchmarks
públicos de *viral coefficient* para ecommerce son 0,04-0,45. **No son la misma unidad y no deben
mezclarse ni presentarse juntas.** `[⚠ no verificado]`

### Gate 0.3 — Alcance, dicho explícitamente

Este skill produce **solo texto**. **NO produce, NO genera y NO simula:**
- el **link único** ni el código (los genera **Zoho**),
- el **formulario** de captura,
- el **tracking** de la atribución,
- el **pago** de la comisión.

Eso es trabajo de CRM/integración y está en el backlog de TI. Si Lizeth pide alguna de esas cosas,
el skill lo dice y no improvisa un código inventado.

---

## FASE 1 — Inputs

Seis inputs obligatorios. Pedilos **todos juntos en un solo mensaje**, no de a uno
(restricción dura: cuentas de Claude compartidas, una sola pasada).

| # | Input | Si falta |
|---|---|---|
| 1 | Nombre completo del referidor **+ cómo quiere que le digan** | **PARAR.** Sin esto no hay personalización posible. |
| 2 | Ciudad y país de residencia | **PARAR.** Define moneda (USD/EUR), oficina cercana y prueba social local. |
| 3 | **Código o link único** (lo genera Zoho) | **PARAR y pedirlo.** No inventar un código de ejemplo. |
| 4 | **Documento vigente de incentivos de Referidores Pro** | Continuar con placeholders + marca `🚫 KIT NO ENVIABLE` (Gate 0.1). |
| 5 | Relación del referidor con Viventa (cliente que ya compró / aliado / conocido de un comercial) | **PARAR.** Cambia el ángulo de los 3 mensajes por completo. |
| 6 | Perfil de a quién le va a hablar (compañeros de trabajo / iglesia / familia extendida / paisanos) | **PARAR.** Sin esto el mensaje 3 (grupo) es genérico. |

Regla: los inputs 1, 2, 5 y 6 deben aparecer **materialmente en el texto del kit**. Si tapás el
nombre y el código y el kit sirve igual para cualquier otro referidor, está mal hecho (ver Fase 5).

---

## FASE 2 — Reglas duras de contenido

### 2.1 · Lista negra financiera — bloqueo, no advertencia

**Reg Z / 12 CFR 1026.24 (*triggering terms*):** mencionar tasa, cuota, plazo o cuota inicial en
publicidad de crédito obliga a divulgar el paquete completo de términos, y **un disclaimer no lo
cura**. El ICP de Viventa vive en Miami-Dade, Broward, Tampa Bay y NJ: jurisdicción real.

Prohibido de forma absoluta en **Bloque A (flyer)** y **Bloque C (mensajes)**:

| Categoría | Ejemplos de lo que NO se escribe |
|---|---|
| Tasa | "tasa desde 9%", "la mejor tasa del mercado", "tasas preferenciales" |
| Cuota | "cuotas desde $800.000", "pagás menos que un arriendo" |
| Plazo | "a 20 años", "financiación a largo plazo" |
| Cuota inicial | "con solo el 10% inicial", "reserva desde 280 USD" ← error real detectado en el flyer de Tampa |
| Aprobación | "te aprueban seguro", "yo te garantizo que calificás", "aprobación en 24 horas" |
| Valorización / rentabilidad | "eso se valoriza 15% al año", "es la mejor inversión", "con el dólar como está te ganás plata" |
| Elegibilidad | "cualquiera califica", "no importa si no tenés papeles" |

El ángulo de rentabilidad es tentador (Daniel lo mencionó, Lizeth dice tener datos). **Esos datos
los puede usar Viventa en su propio material, con fuente. El referidor no** — él no puede
sustentarlos y bajo el art. 29 de la Ley 1480 lo que él anuncie obliga a Viventa.

### 2.2 · Lista blanca — qué SÍ puede decir

Si el skill solo prohíbe, produce mensajes vacíos. Lo permitido:
- **Su propia experiencia**, en primera persona, sin generalizar: *"a mí me atendieron bien"*,
  *"no me tocó viajar"*, *"me explicaron sin enredo"*.
- **Hechos verificables de la compañía**: 20 años, oficinas físicas en Miami / Madrid / Bogotá,
  trabaja con varios bancos y constructoras.
- **La promesa central sin cifras**: *"se puede comprar en Colombia sin volver y sin quedar solo
  en el proceso"*.
- **Una invitación a averiguar**: *"ellos te dicen de una si te sirve o no"*. Es la mejor jugada:
  mueve la conversación de *"te prometo"* a *"andá y preguntá"*.

### 2.3 · La voz del referidor ≠ la voz de la marca — el corazón del skill

Este es el punto donde un LLM falla por defecto y donde se juega el skill entero.

**Evidencia.** Kirk & Givi (*Journal of Business Research*, 2024) probaron en **siete experimentos
preregistrados** que cuando el receptor **percibe** autoría de IA en comunicación de marketing, el
boca a boca positivo y la lealtad **caen**, mediado por **disgusto moral ante la inautenticidad**.
El castigo se dispara por la percepción, no por la autoría real: un mensaje que *parece* generado
paga el costo aunque lo haya escrito una persona. Y el activo en juego es grande: **88% de la gente
confía más en recomendaciones de amigos, familia o colegas que en cualquier otro canal**.

**Dos moderadores que definen el diseño del Bloque C:**
1. **El castigo aparece en contenido emocional y casi desaparece en contenido factual.**
   → Los mensajes reenviables son **factuales y específicos, no sentimentales**. Hechos, no
   sentimientos de marca.
2. **El castigo se atenúa mucho cuando la IA *edita* en vez de *generar*.**
   → Por eso los **corchetes**: el skill entrega un borrador que el referidor completa. La razón
   personal la pone él. Estructuralmente, el skill queda del lado "edición asistida", no
   "generación total".

Hay además una barrera **social, no logística**: el referidor no comparte porque no quiere sentirse
un vendedor lucrándose de sus amigos. Un mensaje que suena a marca lo pone exactamente en ese lugar.

**Las 6 reglas ejecutables del Bloque C:**

1. **Hueco obligatorio de razón personal.** Cada mensaje lleva al menos un `[CORCHETE]` que el
   referidor debe llenar con *por qué él* recomienda esto. **El skill NUNCA lo rellena.** Salen
   vacíos y visibles.
2. **Prohibido el vocabulario de marca.** Lista negra activa **solo en el Bloque C**:
   *acompañamiento integral · aliado estratégico · solución · patrimonio · raíces · construir tu
   futuro · asesoría personalizada · te acompañamos en cada paso · sueño de la casa propia*.
   Son legítimas en el flyer (que **es** la marca) y letales en un WhatsApp entre conocidos.
   El territorio "raíces" además está saturado por los 8 competidores — nadie se lo cree.
3. **Largo de WhatsApp, no de email.** 2-4 líneas. Sin viñetas, sin negritas, sin emojis
   decorativos, sin saltos de línea de folleto. Si el mensaje se ve estructurado, se ve generado.
4. **Una imperfección deliberada por mensaje.** Muletilla colombiana real ("ome", "mirá que",
   "una cosa que se me ocurrió", "por si a alguno le sirve"), o una frase que arranca en medio de
   una conversación previa. *"acordate que me preguntaste"* presupone historia. Ningún folleto
   presupone historia.
5. **Tres registros distintos, no tres variantes.** Ya-preguntó (calor máximo) · frío-cercano 1:1 ·
   grupo. Canal, largo y apertura distintos en cada uno.
6. **Test del reenvío.** Antes de entregar: *"¿una persona real le mandaría esto textual a alguien
   que conoce, sin editarlo, sin vergüenza?"* Si no → reescribir.

> **Asimetría clave.** Bloques A y B hablan en voz de marca porque **son** la marca.
> Bloque C habla en voz de persona. Un LLM va a tender a unificar el tono de todo el documento.
> **Rompelo explícitamente: son dos autores distintos dentro del mismo archivo.**

### 2.4 · Disclosure de relación material — los 3, siempre

**16 CFR §255.5 (FTC Endorsement Guides)** exige divulgar de forma clara y visible cualquier
conexión que pueda afectar el peso de la recomendación; las comisiones están explícitamente listadas.

Tres razones por las que aplica **sin safe harbor**:
1. La excepción de "conexión razonablemente esperada" cubre casos como un actor famoso en un
   comercial. **Nadie asume que su primo cobra comisión por WhatsApp.** Sin safe harbor.
2. **El anunciante también responde.** Las Guides hacen responsables a anunciantes, endorsers e
   intermediarios. Viventa no queda afuera porque el referidor "no es empleado".
3. **El ICP vive en EE.UU.** Los mensajes circulan en jurisdicción FTC.

**La técnica: el disclosure como gesto de honestidad, en primera persona, al final, en la voz del
mensaje.** El error de principiante es pegar un bloque legal —*"Divulgación: el remitente mantiene
una relación material con Viventa S.A.S."*—. Eso no lo manda nadie, y un disclosure que nadie manda
equivale a no tener disclosure.

| Regla | Detalle |
|---|---|
| Nunca omitir | **3 mensajes = 3 disclosures.** No hay variante "sin disclosure", ni para el hermano. |
| Nunca al inicio | Va al final. Al inicio mata el mensaje. |
| Tres elementos | **quién** (yo) · **qué recibo** (comisión / "algo") · **cuándo** (si se cierra). |
| Vocabulario prohibido | "relación material", "divulgación", "compensación económica", "de conformidad con". |
| Vocabulario que sí | "gano una comisión", "me dan algo", "estoy en el programa de ellos", "te lo digo de una", "aclaro". |
| El correo lo enseña | El Bloque B explica **por qué** hay que decirlo, no solo que se diga. Quien entiende el porqué no lo borra al editar. |

En un canal de confianza, decirlo **sube** la credibilidad. *"Te lo digo de una"* es una señal de
honestidad que un folleto no puede emitir.

### 2.5 · Habeas data — Ley 1581 de 2012

Cuando el referidor le pasa a Viventa el nombre y teléfono de un conocido, ese conocido es el
**Titular** de esos datos. La excepción de "ámbito doméstico" (la agenda del celular) tiene un
límite explícito: **cuando esos datos van a ser suministrados a terceros, hay que informar
previamente al Titular y solicitar su autorización — y la carga de la prueba recae sobre el
Responsable, o sea Viventa.**

Consecuencias operativas, ambas obligatorias:
- **El link único es la vía primaria en los 3 mensajes.** El referido se auto-registra y autoriza
  él mismo. No empujar a que el referidor mande listas de contactos.
- El correo de bienvenida lleva la línea *"Antes de darnos el dato de alguien, avisale. Es su
  información."* No es cortesía; es reducción de exposición.

`[⚠ no verificado — no se revisó la política de tratamiento de datos vigente de Viventa ni el aviso
de privacidad del formulario de Zoho. Esto no la reemplaza.]`

### 2.6 · Regla de la casa

- **Cero PII de terceros** en el output. Nunca.
- El skill **termina en un entregable para aprobación humana**, nunca en envío.
- Español de **Colombia**, tuteo/voseo natural. No neutro, no peninsular.
- Moneda según país del referidor (USD/EUR). Recordar el error real: *"280 USA"* debía ser **USD**.
- **Una sola pasada.** Sin loops de research, sin WebSearch.

---

## FASE 3 — Formato exacto del output

Un solo documento markdown plano, copiable a Google Docs / Canva / Wati. **Cuatro bloques, en este
orden.** Si aplica Gate 0.1, la marca `🚫 KIT NO ENVIABLE` va en la primera línea del archivo.

### Plantilla

````markdown
# Kit de activación — {Nombre} · {Ciudad}, {País} · Código {CÓDIGO}
{si aplica: 🚫 KIT NO ENVIABLE — falta el documento de incentivos vigente.}

## Bloque A — Texto del flyer
> Lizeth: esto es solo el texto por campo. El arte ya existe, es el mismo siempre.

```
TITULAR:        {≤8 palabras, en voz de marca}
BAJADA:         {Nombre} · {Ciudad}, {País}
                {2 líneas, quién es el destinatario}
BENEFICIO:      {hechos verificables: oficinas, 20 años. CERO cifras financieras}
CÓDIGO:         {CÓDIGO}
CTA:            {invitación} · viventa.co/r/{CÓDIGO}
PIE LEGAL:      {Nombre} participa en el programa Referidores Pro de Viventa
                y recibe una compensación por los negocios que se cierren
                con su código.
```

## Bloque B — Correo de bienvenida
```
Asunto: {Nombre}, ya quedaste activ{a/o} como Referidor{a} Pro (código {CÓDIGO})

Hola {Nombre},
{...}
CÓMO FUNCIONA
{3 pasos numerados}

CUÁNDO TE PAGAMOS
{monto/etapa/plazo DEL DOCUMENTO, o placeholders}
{compromiso de notificación de estado}

DOS COSAS IMPORTANTES
· {por qué declarar la comisión}
· {no hables de tasas, cuotas ni plazos}
· {avisale al titular antes de pasar su dato}

Lizeth Henríquez
Viventa
```

## Bloque C — 3 mensajes reenviables (voz de {Nombre})
> Los corchetes van vacíos a propósito. Llenarlos es trabajo de {Nombre} y es lo único
> que hace que el mensaje suene a ella.

**Mensaje 1 — al que ya te preguntó (el más fácil, mandalo primero)**
> {2-4 líneas · ≥1 corchete · disclosure al final}

**Mensaje 2 — al que nunca ha tocado el tema (frío pero cercano)**
> {2-4 líneas · ≥1 corchete · disclosure al final}

**Mensaje 3 — para grupo ({perfil del input 6})**
> {2-4 líneas · ≥1 corchete · disclosure al final}

## Bloque D — ⚠ Antes de enviar este kit (para Lizeth)
```
[ ] ¿El código {CÓDIGO} ya existe y trackea en Zoho?
[ ] ¿El documento de incentivos vigente está adjunto y los montos salen de ahí?
[ ] ¿Los pagos de referidos de los últimos 90 días están al día?
    Si NO → activá igual, pero anotalo en seguimiento manual.
    No pasés de 10 referidores activos.
[ ] ¿Alguien humano leyó este kit?

¿Este referidor va a cobrar a tiempo? Si no lo sabés, no lo actives.
```
````

**Bloque D es obligatorio en todos los outputs, incluso en modo escalado.**

---

## FASE 4 — Ejemplo real (recortado)

Input: Carolina Restrepo ("Caro") · Miami, FL · código `CARO-MIA-014` · cliente que ya compró ·
le va a hablar a compañeros de trabajo y su grupo de paisanos. Sin documento de incentivos.

**Bloque A**
```
TITULAR:        Vas a recomendar a Viventa. Que te salga bien.
BAJADA:         Carolina Restrepo · Miami, FL
                Si conocés a alguien que quiere comprar en Colombia
                y no sabe por dónde empezar, mandámelo.
BENEFICIO:      Acompañamiento completo desde acá. Oficinas en
                Miami, Madrid y Bogotá. 20 años haciendo esto.
CÓDIGO:         CARO-MIA-014
CTA:            Escaneá y contame de tu caso · viventa.co/r/CARO-MIA-014
PIE LEGAL:      Carolina participa en el programa Referidores Pro de
                Viventa y recibe una compensación por los negocios
                que se cierren con su código.
```
Notar: **cero cifras financieras.**

**Bloque B — extracto de los dos bloques que importan**
```
CUÁNDO TE PAGAMOS
[MONTO — pendiente de política de incentivos vigente]
Se causa cuando la oportunidad llega a [ETAPA — según documento].
Se paga [PLAZO — según documento] después de causada.
Te vamos a escribir en cada cambio de estado de tus referidos:
recibido, en estudio, cerrado, pagado. Si algo se demora, te
escribimos igual y te decimos por qué.

DOS COSAS IMPORTANTES
· Cuando le hables a alguien de Viventa, decí que participás en el
  programa y que ganás algo si se cierra. No le quita fuerza a tu
  recomendación — le da confianza.
· No hables de tasas, cuotas ni plazos. Ni digas que alguien "va a
  quedar aprobado". Eso lo maneja el equipo de crédito con cada
  persona. Vos abrís la puerta; nosotros hacemos las cuentas.
· Antes de darnos el dato de alguien, avisale. Es su información.
```
Ese último párrafo es el estándar de redacción del límite: **es corto**, **da la razón y no solo
la regla**, y **le devuelve dignidad al rol** — "vos abrís la puerta" es un trabajo real.

**Bloque C**

*Mensaje 1 — al que ya te preguntó*
> Ome, acordate que me preguntaste lo del apartamento en Colombia. Yo hice el proceso con Viventa, [LO QUE MÁS TE SIRVIÓ A VOS — ej: "no me tocó viajar", "me explicaron sin enredo"]. Si querés te paso el contacto, mirá que ellos te dicen de una si te sirve o no. Te aviso que yo estoy en el programa de referidos de ellos y me dan algo si cierra, pero igual te lo diría.

*Mensaje 2 — frío pero cercano*
> Hola [NOMBRE], una cosa que se me ocurrió. ¿Vos no estabas mirando comprar algo en Colombia? Yo estoy trabajando con una gente que se llama Viventa, son los que ayudan con todo el tema de comprar desde acá. [POR QUÉ PENSASTE EN ESA PERSONA]. Si te interesa te los presento — y sí, yo gano una comisión si se cierra, te lo digo de una.

*Mensaje 3 — para grupo*
> Muchachos, por si a alguno le sirve: estoy ayudando a una empresa que se llama Viventa, que trabaja con colombianos que estamos por fuera y quieren comprar en Colombia. Tienen oficina acá en Miami. Yo [TU EXPERIENCIA EN UNA LÍNEA]. Si alguno está en esas, me escriben al privado y los conecto. Aclaro que yo recibo una comisión si se cierra un negocio.

Los tres disclosures cumplen quién / qué recibo / cuándo, y ninguno suena a abogado.
Los tres registros son distintos: uno presupone historia, uno abre tema, uno se dirige a un grupo.

---

## FASE 5 — Checklist de autovalidación

Corré esto **antes** de entregar. **Cualquier fallo bloqueante = no se entrega el kit.**

### Bloqueantes (hard fail)
- [ ] **Cifra prohibida ausente:** grep del output por `200`, `500`, `$200-$500`. Cero apariciones
      derivadas del diagnóstico. Si aparece → **borrar y reemplazar por placeholder**.
- [ ] **Documento de incentivos:** presente → montos textuales de ahí. Ausente → placeholders +
      `🚫 KIT NO ENVIABLE` en la primera línea.
- [ ] **Cero triggering terms** en Bloques A y C: ninguna mención de tasa, cuota, plazo ni cuota inicial.
- [ ] **Cero promesas** de aprobación, valorización, rentabilidad o elegibilidad garantizada.
- [ ] **3 de 3 mensajes con disclosure**, con los tres elementos (quién / qué recibo / cuándo),
      en la voz del referidor, **al final** del mensaje.
- [ ] **Código único real y presente.** Si no lo hay → el skill lo pide y no continúa.
- [ ] **Bloque D presente**, con la pregunta de precondición de pagos.
- [ ] **Cero PII de terceros** en todo el output.
- [ ] **Link único como vía primaria** en los 3 mensajes (no "pasame el número de tu primo").

### De calidad (soft fail — se reescribe)
- [ ] **Test del reenvío:** ¿una persona real manda esto sin vergüenza? Los 3, uno por uno.
- [ ] **Test de intercambiabilidad:** tapando nombre y código, ¿sirve para cualquier referidor?
      Si sí → **rechazar y reescribir**. Ciudad, relación con Viventa y perfil de audiencia deben
      aparecer materialmente en el texto.
- [ ] **Cero vocabulario de marca en Bloque C.** Grep contra la lista negra de §2.3.2.
- [ ] **Largo:** cada mensaje ≤ 4 líneas de WhatsApp. Sin viñetas ni negritas.
- [ ] **Registros distintos:** los 3 no comparten estructura de apertura.
- [ ] **Corchetes vacíos y visibles**, ≥1 por mensaje, **ninguno rellenado por el skill**.
- [ ] **Una imperfección deliberada por mensaje** (muletilla o apertura in medias res).
- [ ] **Español de Colombia.** Moneda correcta (USD/EUR) según país. Nunca "USA" por "USD".
- [ ] **Markdown plano**, copiable a Google Docs / Canva / Wati.
- [ ] **Los `[⚠ no verificado]` sobreviven** en el output cuando aplican — no se limpian por prolijidad.
- [ ] **Una sola pasada.** Cero WebSearch, cero research adicional.

### Métricas
- **Del skill:** Lizeth pasa de ~40 min a ~5 min por referidor, y el kit sale sin edición mayor en
  ≥70% de los casos. Si reescribe los mensajes reenviables cada vez, el skill falló en §2.3 — que es
  el único punto donde aporta valor real; el flyer y el correo los haría una plantilla estática.
- **Lo que el skill NO promete:** subir el k-factor. Eso depende de que paguen.
  `[⚠ no verificado — no hay medición de k-factor por cohorte de referidor en el corpus]`

---

## Referencias

- `references/anti-patterns.md` — los 11 anti-patterns con antídoto ejecutable.
- `references/fuentes.md` — fuentes internas y externas, y el registro de `[⚠ no verificado]`.
