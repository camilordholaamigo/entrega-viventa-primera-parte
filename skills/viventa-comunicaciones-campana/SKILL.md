---
name: viventa-comunicaciones-campana
description: >-
  Redacta la secuencia de email + WhatsApp que convoca a un evento presencial de Viventa: 8 correos
  y 6 WhatsApp en 21 días, onboarding disparado por registro, una P por correo y segmentación en 3
  capas que protege el dominio. Markdown listo para Zoho Campaigns y Wati; redacta, no envía. USA
  cuando: "armame los correos del evento de {ciudad}", "la secuencia de emails y WhatsApp para el
  evento", "el correo de después del evento, para los que fueron y los que no". Es un evento:
  viventa-parrilla-base planifica el mes de toda la base y viventa-reactivacion-lead escribe a un
  lead caído.
metadata:
  version: "1.1.0"
  domain: "campaign"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# Comunicaciones de campaña de evento — Viventa

Un solo markdown, copiable a **Zoho Campaigns** y **Wati** sin retocar, con la convocatoria y el
post-evento de un evento presencial. Invariantes de toda corrida: **redacta, no envía** (regla
durable #1 del cliente: nada sale al aire sin revisión humana); ninguna pieza se dirige a "toda la
base"; ninguna pieza sale sin dirección, fecha y hora reales.

Por qué la segmentación manda: email es el canal más barato de la compañía (CAC fully-loaded [cifra interna]
contra [cifra interna] de Meta y [cifra interna] de un evento, `references/cifras-canonicas.md`) y el dominio **ya cae en spam**. La
deliverability no es un apéndice: decide a cuánta gente se le escribe. El problema no son los 250K
registros; es escribirles a los 250K.

**Una sola pasada**: las cuentas de IA del cliente son compartidas y se quedan sin créditos hasta 4
horas. Sin loops ni research web; todo lo necesario está acá y en `references/`.

## Cuándo usar

- Explícito: "armame los correos del evento de {ciudad}", "la secuencia de emails y WhatsApp para el
  evento", "hacé la campaña de correos del Más Cerca de Ti", "los mensajes de Wati para el evento y
  los correos de Zoho", "el correo de después del evento, para los que fueron y los que no", "a quién
  le mandamos esta convocatoria sin quemar el dominio".
- Implícito: hay un brief de evento cerrado (`viventa-brief-evento`) y faltan las comunicaciones a la
  base propia.
- Cadencia: una vez por evento, idealmente antes de D-18; el bloque post-evento se completa en D+1
  con la lista de asistentes.

## Cuándo NO usar

- El plan del mes para toda la base, o la bienvenida a leads nuevos que no se registraron a ningún
  evento → `viventa-parrilla-base`.
- Reabrir la conversación con un lead que se cayó (incluido un no-show puntual, 1 a 1) →
  `viventa-reactivacion-lead`.
- El copy de flyers y piezas gráficas del evento → `viventa-pack-evento`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Nombre del evento | Brief del evento o el usuario | *"¿Cómo se llama el evento?"* — **bloquea** |
| Fecha con día de la semana | Brief del evento | *"¿Qué día es el evento (fecha completa)?"* — **bloquea** |
| Hora de inicio y de cierre, con zona horaria | Brief del evento | *"¿De qué hora a qué hora, y en qué zona horaria?"* — **bloquea** |
| Dirección exacta (calle, número, código postal, ciudad, país) | Brief del evento | *"Pasame la dirección exacta del lugar."* — **bloquea**. Nunca se aproxima |
| Cómo llegar (transporte público o parking) | Brief del evento | *"¿Qué metro/bus o parking le decimos a la gente?"* — **bloquea** |
| País del evento | Brief del evento | *"¿En qué país es?"* — **bloquea**: define moneda, prefijo y si WhatsApp está habilitado |
| Conteo estimado por tier y geo (Tier 1 / Tier 2 a ≤90 min) | Responsable de email marketing (Zoho) | *"¿Cuántos contactos Tier 1 y Tier 2 hay a ≤90 min de la ciudad?"* — **bloquea** |
| Nombre de la consultora que firma los WhatsApp | Brief del evento | *"¿Quién firma los WhatsApp?"* — no bloquea: va `[Nombre de la consultora]` marcado como pendiente en la ficha |
| Ángulo de la campaña | Output de `viventa-inteligencia-campana` o del brief | No se pregunta: default = el alquiler que se evapora + los 3 obstáculos (papeles, familia, vacaciones), declarado en la ficha |
| Fecha de arranque de la pauta | Brief del evento | *"¿Cuándo arrancó (o arranca) la pauta?"* — no bloquea: sin ella, la ficha dice "regla de 45 días no verificada" |
| Lista de asistentes (post-evento) | Registro del evento, D+1 | *"¿Ya tenés la lista de quién fue y quién no?"* — **bloquea solo el bloque E5/W5**; el resto sale |
| Notas de mesa, 2-3 datos por asistente | Asesoras, D+1 | No bloquea: E5-A sale genérico con la advertencia de que sin notas pierde casi todo su valor |
| Testimonios de la geografía del evento | `references/voice-of-customer-90d.md`, banco tier A | No se pregunta. Si no hay de esa geografía, E3 lo dice y usa solo prueba dura |
| Remitente de los correos | `[correo remitente]` | *"¿Desde qué dirección salen los correos del evento?"* |
| Fecha de hoy | El sistema | — |

Si falta **cualquier bloqueante**, no se genera el paquete: se devuelve la lista de lo que falta
(con la pregunta de cada uno) y se para. Es la fricción #1 del Voice of Customer: *"no entiendo por
qué no pueden decir la ubicación donde van a atender en Miami, solo colocan 28 y 1 pero sin
dirección"* (comentario de una seguidora en Instagram).

## Workflow

### Paso 1 — Chequear la anticipación de 45 días

1. Calculá los días entre el arranque de la pauta y el evento.
2. Si son **menos de 45** (44 incluido), el paquete sale igual, con esta advertencia arriba:
   *"⚠️ La pauta arrancó a N días del evento (mínimo sano: 45). No alcanza a pasar aprendizaje: el
   CPL va a salir por encima del histórico y esta secuencia va a cargar más peso del que le toca."*
   45 exactos o más: sin advertencia. Sin fecha de pauta: "regla de 45 días no verificada".
3. Los 45 días son requisito de la pauta, no de la secuencia: la secuencia vive en los últimos 21.

### Paso 2 — Segmentar antes de escribir

Tres capas que se cruzan (detalle: `references/segmentacion-deliverability.md`):

1. **Geografía**: solo contactos a **≤90 minutos** de la ciudad del evento.
2. **Engagement**: Tier 1 (abrió ≤90 días) recibe todo · Tier 2 (91-180 días) recibe **solo E1 y E3**
   · Tier 3 (+180 días) **no recibe nada** de esta secuencia y se desvía a re-permiso o Meta · Tier 4
   (rebote/queja) supresión permanente. Un contacto en el día 90 es Tier 1; en el 180, Tier 2.
3. **Estado**: registrados y no registrados nunca reciben la misma pieza.

Escribí el conteo por tier. Orden de magnitud esperado de una convocatoria de ciudad: 2.000-6.000
contactos `[⚠ no verificado — estimación; confirmar en Zoho]`. Si el conteo Tier 1 + Tier 2 da 0, no
hay paquete: se dice y se sugiere re-permiso o Meta.

### Paso 3 — Armar el calendario

Arquitectura fija en 21 días (D-18 a D+3). **Regla de conteo única** (tabla, checklist y total del
entregable): se cuenta cada pieza redactada, y las variantes A/B cuentan por separado → **8 emails**
(E0-A, E0-B, E1, E2, E3, E4, E5-A, E5-B) **+ 6 WhatsApp** (W1, W2, W3, W4, W5-A, W5-B). En USA, +E4-bis
= 9 emails. Ningún contacto recibe todas: el tope por persona lo controla el punto 4.

| # | Día | Canal | Segmento | P |
|---|---|---|---|---|
| E0-A | inmediato al registro | Email | Quien se registra | Plan |
| E0-B | +48 h del registro | Email | Registrado que abrió E0-A | Proof |
| E1 | D-18 | Email | Tier 1 + Tier 2, geo | Pain |
| W1 | D-16 | WhatsApp | Abrió o clicó E1 | Pain → Plan |
| E2 | D-10 | Email | Tier 1, no registrados | Plan |
| E3 | D-4 | Email | Tier 1 + Tier 2, no registrados | Proof |
| W2 | D-3 | WhatsApp | Abrió E2 o E3 | Proof |
| E4 | D-2 | Email | Solo registrados | Philosophy + logística |
| W3 | D-1 | WhatsApp | Solo registrados | — |
| W4 | D, 08:00 | WhatsApp | Solo registrados | — |
| E5-A | D+2 | Email | Asistieron | Plan |
| E5-B | D+2 | Email | Registrados que no fueron | Proof → Plan |
| W5-A/B | D+3 | WhatsApp | Idem, split | — |

1. Corré E1, E2 y E3 al martes, miércoles o jueves más cercano, manteniendo 6-8 días entre correos
   de convocatoria.
2. **E0-A y E0-B se disparan por registro, no por fecha.** Quien se registra en D-14 recibe E0-A ese
   día y E0-B a las 48 h. Si faltan **menos de 5 días** al registrarse, E0-B no sale (se solapa con
   E3/E4 y satura); con 5 días exactos, sale.
3. **Supresión al registrarse**: quien se inscribe sale de convocatoria y pasa al carril de
   registrados (E0-A → E0-B → E4 → W3 → W4).
4. **Tope por persona: 4 emails + 3 WhatsApp en 21 días**, contando todo lo que Viventa le mande.
   Se chequea contra el contacto antes de cada envío. Nunca caen E0-A, W4 ni E4-bis (logística). Excepción explícita: en USA, E4-bis no cuenta para el tope, así que un contacto puede recibir 5 emails si el quinto es E4-bis.
   Para que el carril de quien se registra a mitad de convocatoria no lo rompa:
   - Quien recibió E1 antes de registrarse **no recibe E0-B**.
   - Quien recibió E0-A hace 5 días o menos **no recibe E4** (E0-A ya llevó la logística).
   - Quien recibió W1 y W2 **no recibe W3**; quien recibió W1 o W2 **no recibe W5**.
   - Si aun así E5-A/E5-B pasaría el tope, E5 no sale y el contacto queda para
     `viventa-parrilla-base` del mes siguiente.
   Ejemplo: Tier 1 que recibió E1 + W1 y se registra en D-12 → E1, E0-A, E4, E5 (4 emails) y W1, W3,
   W4 (3 WhatsApp).
5. Por qué el Proof va en D-4: en esta categoría el miedo (a ser estafado, a perder la plata) pesa
   más que el dolor, y D-4 es justo antes del cierre de registro.
6. Por qué W4 a las 08:00 y no "1 hora antes": es presencial; quien no salió de la casa a las 9 no
   sale a las 9:50.

**Si el evento es en USA:**
- Moneda `USD` (nunca "USA"), prefijo +1, testimonios de clientes en USA.
- Las 5 piezas de WhatsApp se redactan igual, encabezadas con `🚫 NO ENVIABLE HOY — canal WhatsApp
  USA bloqueado (en gestión vía 10DLC/Twilio)`. Sirven de guion para las llamadas y quedan listas
  para cuando se desbloquee.
- Se agrega **E4-bis**: recordatorio de 24 h por email, menos de 80 palabras, solo dirección, hora y
  mapa. La secuencia queda en **9 emails**.

### Paso 4 — Redactar los emails

Cada uno con argumento propio:

- **E0-A** — transaccional: dirección exacta, fecha, hora, qué llevar, a quién escribir. Sin venta.
  Es el correo que más se abre: no lo gastes en un "gracias por registrarte".
- **E0-B** — qué va a pasar en el evento y quién atiende, más una prueba dura. Baja el no-show.
- **E1 · Pain** — la cuenta del alquiler que se evapora + los tres obstáculos concretos (papeles que
  no se gestionan por teléfono, la familia que no tiene por qué hacer la vuelta, vacaciones que
  cuestan más que la cuota inicial). Dolor verificable, no adjetivos.
- **E2 · Plan** — el proceso minuto a minuto de la mesa, con *"aunque no nos convenga"* y *"si no
  querés seguir, no te llamamos"* (responden la fricción #2 del VOC: *"siempre hay que colocar
  correo y luego te saturan"*).
- **E3 · Proof** — testimonios literales del VOC de la misma geografía, luego prueba dura: 20 años,
  oficinas propias en 3 países, 5 bancos, ~20 constructoras.
- **E4 · Philosophy + logística** — la diferencia de Viventa: se mueve físicamente, mientras los ~8
  brokers autorizados usan el mismo ángulo de "raíces". Pegado a la logística.
- **E5-A / E5-B** — dos correos distintos, nunca uno con condicional. E5-A usa las notas de mesa.

El Deseo no ocupa correo propio: se cuela como cierre ("que quede algo a tu nombre en Colombia").

Formato de cada email: bloque `De: Viventa <[correo remitente]>` · `Asunto:` 4-8 palabras, en
minúscula natural · `Preheader:` una línea que complementa sin repetir. Cuerpo de 150-280 palabras,
fecha/hora/dirección en bloque destacado, **un** CTA en botón, máximo 3 enlaces al dominio propio sin
acortadores, pie con razón social, dirección postal física y baja en un clic. Lista negra de asuntos:
`references/segmentacion-deliverability.md`.

### Paso 5 — Redactar los WhatsApp

1. Máximo **40 palabras**, con el conteo impreso al lado del título de la pieza.
2. Primera persona con el nombre de la consultora ("soy {consultora} de Viventa"), saludo de
   mensajería, **una sola pregunta al final**, emojis funcionales (📍🕙🚇), no decorativos.
3. Reglas de orquestación: **48 h mínimo** entre un correo y el WhatsApp que lo sigue · W1 y W2 solo
   a quien abrió o clicó · W3 y W4 solo a registrados · el tope por persona y sus supresiones son los
   del Paso 3, punto 4.

### Paso 6 — Armar el entregable y autovalidar

1. Armá el documento con la forma de `## Output esperado`.
2. Corré el checklist de abajo. Si una casilla falla, corregí antes de entregar; si falla un dato
   bloqueante, volvé a la lista de faltantes.

Checklist:
- [ ] Ficha con fecha y día, horario con zona, dirección exacta, cómo llegar, moneda, prefijo y
      estado de WhatsApp coherentes con el país (moneda `USD`, nunca "USA"; en España, ningún +1).
- [ ] 8 emails + 6 WhatsApp según la regla de conteo (9 emails en USA); E0-B ausente si faltan <5 días.
- [ ] Cada pieza con fecha exacta, canal, segmento y, en convocatoria, su P.
- [ ] Nadie recibe más de 4 emails + 3 WhatsApp en 21 días (supresiones del Paso 3, punto 4, aplicadas); 48 h
      entre correo y WhatsApp.
- [ ] Los primeros párrafos de E1-E4 no comparten más de 5 palabras significativas.
- [ ] Ningún WhatsApp supera 40 palabras; ningún asunto con mayúscula sostenida, emoji o signo repetido.
- [ ] Cero tasa, cuota, plazo, aprobación, cupos no verificados.
- [ ] Todo correo con razón social, dirección postal física, baja en un clic y máximo 3 enlaces al
      dominio propio, sin acortadores.
- [ ] Split post-evento A/B presente, o el bloque dice que falta la lista de asistentes.
- [ ] Advertencia de revisión humana arriba y bloque de alcance al final.

## Reglas duras

- **Nunca envía ni programa** un correo o un WhatsApp. Termina en un documento para revisión.
- **Nunca deja un placeholder de dato del evento.** Prohibido: `[Ciudad]`, `[fecha]`, `[dirección]`,
  "por confirmar". Permitido: los campos de sistema que Zoho resuelve (`[Darme de baja]`,
  `[Dirección postal]`, `[enlace de Google Maps]`) y `[Nombre de la consultora]` si está listado como
  pendiente en la ficha.
- **Nunca menciona tasa, cuota ni plazo con cifra, ni promete aprobación.** Permitido: *"revisás si
  calificás"*. "Mi Casa en Colombia" se nombra como programa existente, nunca como aprobación.
- **Nunca inventa cupos ni urgencia** ("últimos cupos", "última oportunidad") sin un número
  verificado.
- **Nunca incluye en una pieza a Tier 3 ni a Tier 4**, ni produce un envío sin las 3 capas escritas.
- **Nunca nombra el miedo** ("no te vamos a estafar"): se desactiva con prueba.
- **Nunca usa registro de banco**: "Estimado cliente", "nos complace invitarle", "aliado
  estratégico", "solución integral", "no dude en contactarnos". Español de Colombia, tuteo.
- **Nunca borra un `[⚠ no verificado]`** heredado, incluida la dirección ilustrativa del ejemplo.

## Output esperado

Devuelve en la conversación un markdown; si el usuario lo pide en archivo, se guarda en
`salidas/viventa-comunicaciones-campana/{AAAA-MM-DD}-{evento-slug}.md`.

```markdown
# Comunicaciones · {Evento} · {Ciudad}
> ⚠️ ESTE PAQUETE REQUIERE REVISIÓN HUMANA ANTES DE PROGRAMAR. Nada acá se envía solo.
> {advertencia de 45 días, si aplica} {pendientes: consultora, notas de mesa}

## Ficha del evento
| Evento | Fecha y día | Horario y zona | Dirección | Cómo llegar | Moneda | Anticipación de pauta | Ventana | Canal WhatsApp | Ángulo |

## Segmentación — a quién sí y a quién no
| Capa | Criterio | Conteo estimado |   (Geo · Tier 1 · Tier 2 · Tier 3 excluido · Tier 4 suprimido)

## Calendario
| # | Fecha | Día | Canal | Segmento | P | Función |
Total: N emails · N WhatsApp. Máximo por persona: 4 emails + 3 WhatsApp en 21 días.

## Las piezas
### E0-A · {fecha} — confirmación      (De / Asunto / Preheader en bloque, luego el cuerpo íntegro)
...
### W1 · {fecha} — WhatsApp ({N} palabras)   {🚫 NO ENVIABLE HOY si es USA}
...

## Checklist de deliverability (tachar antes de programar)
## ⚠ Alcance — lo que este paquete no arregla   (bloque de references/segmentacion-deliverability.md §5)
```

Al entregar se dice: *"Paquete listo para revisión: N correos y N WhatsApp para {N} contactos.
Pendientes antes de programar: {lista o 'ninguno'}."* Si faltaban bloqueantes, el output es solo la
lista de faltantes con su pregunta.

Ejemplo íntegro (Valencia, post-evento y variante USA): `references/ejemplo-valencia.md`.

## Skills relacionados

- **Antes:** `viventa-brief-evento` (ficha y bloqueantes del evento) y `viventa-inteligencia-campana`
  (el ángulo y los dolores que usa E1-E3).
- **Después:** `viventa-qa-marca` revisa las piezas antes de programar; `viventa-monitor-evento` mide
  el evento.
- **En vez de este:** `viventa-parrilla-base` para el plan mensual de la base;
  `viventa-reactivacion-lead` para un lead caído 1 a 1.
- **Referencias:** `references/segmentacion-deliverability.md` (capas, tiers, lista negra, legal,
  alcance) · `references/anti-patterns.md` (14 fallas con antídoto) · `references/ejemplo-valencia.md`
  · `references/contexto-viventa.md`.
