---
name: viventa-comunicaciones-campana
description: >-
  Redacta la secuencia completa de email + WhatsApp para convocar a un evento presencial de Viventa:
  7 correos y 5 mensajes en 21 días, con un tramo de onboarding que se dispara por registro, las
  4 P repartidas una por correo y la segmentación en 3 capas que protege el dominio. Entrega un
  markdown listo para pegar en Zoho Campaigns y Wati. Redacta, no envía.
metadata:
  version: "1.0.0"
  domain: "campaign"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# Comunicaciones de campaña de evento — Viventa

**Qué produce:** un solo documento markdown, copiable a **Zoho Campaigns** y a **Wati** sin
retocar, con la secuencia completa de convocatoria y post-evento de un evento presencial.

**Quién lo usa:** Juan Camilo Usuga (email marketing) y el equipo de eventos.

**La regla que gobierna todo:** **este skill redacta, no envía.** Ni email ni WhatsApp. Termina en
un documento que un humano revisa y programa. Regla durable #1 del cliente, textual (Lizeth):
*"no debería salir al aire sin una revisión."*

**Una sola pasada.** Las cuentas de Claude del cliente son compartidas y se quedan sin créditos
hasta 4 horas. Nada de loops, nada de research. Todo lo que hace falta está acá y en `references/`.

---

## Por qué este skill existe

Email tiene un CAC de **[cifra interna]** contra **[cifra interna]** de Meta y **[cifra interna]** de un evento — es el canal más
barato de la compañía y era el único que no estaba en el flujo documentado. Con 250K registros y
~3.000 leads/mes entrando, la palanca no es más tráfico: es **hablarle bien al que ya está adentro**.

Pero el dominio **ya cae en spam** (Juan Camilo: *"la cantidad de mensajes que envío están llegando
a spam"*). Por eso la deliverability acá no es un apéndice de buenas prácticas: **es una restricción
de arquitectura que decide a cuánta gente se le escribe y qué se le escribe.**
El problema no son los 250K registros: **es enviarles a los 250K.**

---

## Fase 0 — Inputs y bloqueantes

Recogé estos datos. **Si falta uno de los bloqueantes, el skill NO genera el paquete**: devuelve la
lista de lo que falta y para. No es purismo — es la fricción #1 del Voice of Customer, textual:
*"no entiendo por qué no pueden decir la ubicación donde van a atender en Miami, solo colocan 28 y 1
pero sin dirección"* (@cliente).

| Input | ¿Bloqueante? | Si falta |
|---|---|---|
| Nombre del evento | ✅ Sí | Pedir. Sin nombre no hay asunto ni ficha |
| **Fecha completa con día de la semana** | ✅ Sí | **PARAR** y pedir |
| **Hora de inicio Y de cierre, con zona horaria** | ✅ Sí | **PARAR** y pedir |
| **Dirección exacta**: calle, número, código postal, ciudad, país | ✅ Sí | **PARAR** y pedir. Nunca inventar, nunca aproximar |
| Referencia de cómo llegar (transporte público o parking) | ✅ Sí | **PARAR** y pedir |
| País del evento | ✅ Sí | **PARAR**. Determina moneda, prefijo telefónico y si WhatsApp está habilitado |
| Conteo estimado por tier (Tier 1 / Tier 2 / geo) | ✅ Sí | **PARAR** y pedir. Sin criterio de segmento no hay entregable |
| Nombre de la consultora que firma los WhatsApp | ⚠️ No | Usar `[Nombre de la consultora]` y marcarlo arriba como pendiente **antes** de programar |
| Ángulo de la campaña (viene de `viventa-brief-evento`) | ⚠️ No | Usar el ángulo por defecto: alquiler que se evapora + los 3 obstáculos (papeles, familia, vacaciones) |
| Fecha en que arranca la pauta | ⚠️ No | Advertir que no se pudo verificar la regla de 45 días |
| **Post-evento:** lista de asistentes | ✅ Sí, para E5 | **PARAR** el bloque post-evento. Sin split A/B no se genera |
| **Post-evento:** notas de mesa (2-3 datos por persona) | ⚠️ No | Generar E5-A genérico **y advertir explícitamente** que sin notas el correo pierde casi todo su valor. No fingir personalización |
| Testimonios de la geografía del evento | ⚠️ No | Usar los del banco tier A de `references/voice-of-customer-90d.md`; si no hay de esa geografía, decirlo |

**Chequeo de los 45 días.** Calculá los días entre el arranque de la pauta y el evento. Si son
**menos de 45**, entregá el paquete igual, con esta advertencia al inicio:

> ⚠️ La pauta arrancó a **N días** del evento (mínimo sano: 45). No alcanza a pasar aprendizaje: el
> CPL va a salir por encima del histórico y esta secuencia de email va a cargar con más peso del que
> le corresponde.

Los 45 días son requisito de **la pauta**, no de esta secuencia. La secuencia vive **dentro** de esa
ventana, en los últimos 21 días, y le habla a base propia, no a tráfico frío.

---

## Fase 1 — Segmentar (antes de escribir una sola palabra)

Nunca se produce un paquete dirigido a "toda la base". Tres capas que se cruzan
(detalle completo: `references/segmentacion-deliverability.md`):

1. **Geografía** — solo contactos a **≤90 minutos** de la ciudad del evento.
2. **Engagement** — Tier 1 (abrió ≤90 días) recibe todo · Tier 2 (91-180 días) recibe **solo E1 y
   E3** · **Tier 3 (+180 días) recibe NADA** de esta secuencia y se desvía a re-permiso o Meta ·
   Tier 4 (rebote/queja) supresión permanente.
3. **Estado en el funnel** — registrados y no registrados nunca reciben lo mismo.

Escribí en el paquete el conteo estimado por tier. **Una convocatoria de ciudad sale a 2.000-6.000
contactos, no a 250.000** `[⚠ no verificado — estimación de orden de magnitud; confirmar en Zoho]`.
Menos volumen, más apertura, mejor reputación y **más asistentes**, no menos.

---

## Fase 2 — Armar el calendario

Arquitectura fija: **7 emails + 5 WhatsApp en 21 días (D-18 a D+3)**.

| # | Día | Canal | Segmento | P |
|---|---|---|---|---|
| **E0-A** | inmediato al registro | Email | Quien se registra | Plan |
| **E0-B** | +48 h del registro | Email | Registrado que abrió E0-A | Proof |
| **E1** | **D-18** | Email | Tier 1 + Tier 2, geo | **Pain** |
| **W1** | D-16 | WhatsApp | Abrió o clicó E1 | Pain → Plan |
| **E2** | **D-10** | Email | Tier 1, no registrados | **Plan** |
| **E3** | **D-4** | Email | Tier 1 + Tier 2, no registrados | **Proof** |
| **W2** | D-3 | WhatsApp | Abrió E2 o E3 | Proof |
| **E4** | **D-2** | Email | **Solo registrados** | **Philosophy** + logística |
| **W3** | D-1 | WhatsApp | Solo registrados | — |
| **W4** | **D, 08:00** | WhatsApp | Solo registrados | — |
| **E5-A** | **D+2** | Email | **Asistieron** | Plan |
| **E5-B** | **D+2** | Email | **Registrados que NO fueron** | Proof → Plan |
| **W5-A/B** | D+3 | WhatsApp | Idem, split | — |

Ajustá los días para que E1, E2 y E3 caigan **martes, miércoles o jueves**. Convocatoria: **1 correo
cada 6-8 días**, no cada 2-3.

### El tramo de onboarding (E0-A y E0-B)

**Corre en paralelo al calendario, no dentro de él.** Los dos se disparan por el registro de la
persona, no por la fecha del evento: alguien que se registra en D-14 recibe E0-A ese día y E0-B dos
días después, y recién ahí entra al flujo de recordatorios. Alguien que se registra en D-3 recibe
E0-A y **ya no recibe E0-B** — se salta al recordatorio.

| | Cuándo | Qué hace |
|---|---|---|
| **E0-A** | Inmediato | Confirma. Dirección exacta, fecha, hora, qué llevar, a quién escribir. Nada de venta. Es el correo que evita la fricción #1 del VOC: *"no entiendo por qué no pueden decir la ubicación donde van a atender"* |
| **E0-B** | +48 h, solo si abrió E0-A y faltan ≥5 días | Qué va a pasar en el evento y quién lo va a atender. Una prueba dura (20 años, oficinas físicas, un testimonio literal). Baja la tasa de no-show, que es el agujero real del canal |

**Regla de corte:** si faltan menos de 5 días para el evento, E0-B no sale. Se solapa con E3/E4 y
satura — y la queja del VOC es saturación, no silencio.

**Frontera con `viventa-parrilla-base`:** este tramo es el onboarding **de quien ya se registró a
este evento**. El onboarding del lead nuevo que entra a la base y todavía no se registró a nada
**no es de este skill** — es de la parrilla de la base. Si te piden "la bienvenida para los leads
nuevos", ese pedido va allá.

**Por qué el Proof va en D-4, justo antes del cierre de registro, y no enterrado en el medio:**
en esta categoría **el miedo pesa más que el dolor** (Mateo: *"creo que aquí no hay tanto dolor,
pero sí hay un miedo…"* — a ser estafado, a perder la plata, a comprar un inmueble que no es). El
Proof no es el correo débil de la secuencia: es el más importante. **Y el miedo no se nombra, se
desactiva** con prueba dura: testimonios literales, 20 años, oficinas físicas, 5 bancos.
Escribir *"no te vamos a estafar"* activa la sospecha en vez de calmarla.

**Por qué no se copia la cadencia de webinar:** es un evento presencial. El costo de asistir no son
dos clics — es un sábado, un desplazamiento y a veces una guardería. El recordatorio de "1 hora
antes" no aplica: quien no salió de la casa a las 9 no sale a las 9:50. Por eso el último toque es
**W4 a las 08:00**.

### Si el evento es en USA

- Moneda **USD** (nunca "USA"), prefijo **+1**, testimonios de clientes de USA.
- **Las 5 piezas de WhatsApp se entregan redactadas, encabezadas con**
  **`🚫 NO ENVIABLE HOY — canal WhatsApp USA bloqueado (Meta rechazó la verificación; en gestión vía
  10DLC/Twilio)`**. Se entregan igual porque: (a) sirven de guion para las llamadas de Aircall, que
  sí operan; (b) el día que se desbloquee, el activo ya está escrito; (c) documenta el costo real del
  bloqueo — cada evento sin WhatsApp deja plata sobre la mesa en el canal de **[cifra interna] de CAC**.
- **Se agrega E4-bis**: recordatorio de 24 h por email, **menos de 80 palabras**, solo dirección,
  hora y mapa. Compensa el hueco de W3. Es el único caso donde la secuencia lleva **8 emails**.

---

## Fase 3 — Redactar los emails

Uno por P, cada uno con **argumento propio**:

- **E1 · Pain** — no es "no tenés casa". Es la **cuenta del alquiler que se evapora** + los tres
  obstáculos concretos: papeles que no se gestionan por teléfono, la familia que no tiene por qué
  hacer la vuelta, las vacaciones que cuestan más que la cuota inicial. Dolor específico y
  verificable, no adjetivos.
- **E2 · Plan** — el **desglose del proceso minuto a minuto** de lo que pasa en la mesa. Las frases
  que compran credibilidad: *"aunque no nos convenga"* y *"si no querés seguir, no te llamamos"* —
  responden la fricción #2 del VOC: *"siempre hay que colocar correo y luego te saturan 😮‍💨"*.
- **E3 · Proof** — testimonios **literales** del Voice of Customer, con la geografía del segmento
  (España habla a España, USA a USA). Después del testimonio, la prueba dura: 20 años, oficinas
  propias en 3 países, 5 bancos, ~20 constructoras. Nunca tasa, cuota ni rentabilidad.
- **E4 · Philosophy + logística** — lo único que ningún competidor puede copiar. Los ~8 brokers
  autorizados usan **el mismo ángulo de "raíces"**; la diferenciación de Viventa es que **se mueve
  físicamente**. Va pegado a la logística, para que el correo que la gente abre por la dirección le
  entregue también el porqué.
- **E0-A** — transaccional, la mejor entregabilidad de la secuencia y el único que se abre con
  seguridad. Es el lugar correcto para la dirección completa. No lo desperdicies con un "gracias por
  registrarte" vacío.
- **E5-A / E5-B** — dos mensajes distintos, nunca uno con condicional.

**El Deseo no ocupa correo propio.** Dolor · Miedo · Deseo es la escala emocional; las 4 P son la
estructura. El Deseo se cuela como cierre en todos ("que quede algo a tu nombre en Colombia"). Un
correo entero de Deseo puro suena a folleto de constructora.

**Formato de cada email:**

```
De:        Viventa <eventos@viventa.co>
Asunto:    {4-8 palabras, minúscula natural, suena a persona}
Preheader: {una línea, complementa el asunto, no lo repite}
```

Cuerpo de **150-280 palabras** · fecha, hora y dirección completas en bloque destacado · **un** CTA
en botón · pie legal con razón social, dirección postal física y baja en un clic.

---

## Fase 4 — Redactar los WhatsApp

**Máximo 40 palabras, con el conteo impreso al lado de la pieza.** Registro distinto al email:
primera persona con nombre ("soy Johana de Viventa"), saludo de mensajería, **una sola pregunta al
final**. No repite el argumento del correo — lo asume y va al cierre. Emojis funcionales (📍🕙🚇),
nunca decorativos.

**Las 4 reglas mecánicas de orquestación** (no negociables, se verifican en la Fase 6):

1. **48 h mínimo** entre un correo y el WhatsApp que lo sigue. Nunca el mismo día.
2. **WhatsApp es escalada, no difusión.** W1 y W2 solo a quien **abrió o clicó**. En frío quema el
   canal. W3 y W4 solo a registrados — ahí ya es servicio, no marketing.
3. **Supresión inmediata al registrarse.** Quien se inscribe sale de convocatoria en ese momento y
   pasa al carril de registrados (E0-A → E0-B → E4 → W3 → W4). Seguir invitando a quien ya se inscribió es
   exactamente lo que produce *"me saturan"*.
4. **Tope global:** máximo **4 emails + 3 WhatsApp por persona en 21 días**, contando todo lo que
   Viventa le mande, incluidas otras campañas. Se aplica sobre el contacto, no sobre la campaña.

---

## Fase 5 — Formato del entregable

Un solo markdown, en este orden exacto:

```markdown
# Comunicaciones · {Evento} · {Ciudad}

> ⚠️ ESTE PAQUETE REQUIERE REVISIÓN HUMANA ANTES DE PROGRAMAR. Nada acá se envía solo.
> {si aplica: advertencia de los 45 días}

## Ficha del evento (verificar antes de programar cualquier envío)
| Campo | Valor |
| Evento · Fecha con día · Horario con zona · Dirección exacta · Cómo llegar ·
  Moneda · Anticipación de pauta · Ventana de la secuencia · Canal WhatsApp · Meta del evento |

## Segmentación — a quién SÍ y a quién NO
| Capa | Criterio | Conteo estimado |
| Geo ≤90 min · Tier 1 · Tier 2 · Tier 3 (EXCLUIDO → re-permiso/Meta) · Tier 4 (suprimido) |

## Calendario de la secuencia
| # | Fecha | Día | Canal | Segmento | P | Función |
Total: N emails · N WhatsApp. Máximo real por persona: 4 emails + 3 WhatsApp en 21 días.

## Las piezas
### E0-A · {fecha} — confirmación
### E0-B · {fecha +48 h} — qué va a pasar (omitir si faltan <5 días)
   De / Asunto / Preheader en bloque de código, luego el cuerpo íntegro
### E1 · {fecha} — PAIN
...
### W1 · {fecha} — WhatsApp ({N} palabras)
   {si USA: 🚫 NO ENVIABLE HOY — ...}
...

## Checklist de deliverability (tachar antes de programar)
- [ ] ...

## ⚠ Alcance — lo que este paquete no arregla
{el bloque textual de references/segmentacion-deliverability.md §5}
```

**Cero placeholders.** Ni `[Ciudad]`, ni `[fecha]`, ni `[dirección]`. Los únicos corchetes
permitidos son los datos de sistema que Zoho resuelve (`[Darme de baja]`, `[Dirección postal]`,
`[enlace de Google Maps]`) y los marcados como pendiente explícito en la ficha.

---

## Fase 6 — Autovalidación (20 casillas binarias)

No entregues hasta que las 20 den ✅.

**Bloqueantes de datos** — si falla una, **parar y pedir el dato**:

- [ ] Fecha completa con día de la semana
- [ ] Hora de inicio **y** de cierre, con zona horaria
- [ ] **Dirección exacta**: calle, número, código postal, ciudad, país
- [ ] Referencia de cómo llegar (transporte público o parking)
- [ ] País declarado → moneda, prefijo y estado de WhatsApp resueltos
- [ ] Segmento y conteo estimado por tier
- [ ] Post-evento: lista de asistentes y notas de mesa (o advertencia explícita de que no las hay)

**Estructura:**

- [ ] 7 emails y 5 WhatsApp (8 emails si es USA, con E4-bis)
- [ ] E0-A y E0-B se disparan por registro, no por fecha del evento
- [ ] Si faltan <5 días para el evento, E0-B NO está en el entregable
- [ ] E0-A trae dirección exacta, fecha, hora y a quién escribir. Sin venta
- [ ] Cada pieza tiene fecha exacta, canal y segmento
- [ ] Cada correo de convocatoria declara su P (Pain / Plan / Proof / Philosophy)
- [ ] Ningún contacto recibe más de 4 emails + 3 WhatsApp en 21 días
- [ ] Mínimo 48 h entre un correo y el WhatsApp que lo sigue
- [ ] Split post-evento A/B presente y diferenciado

**Copy:**

- [ ] Los primeros párrafos de E1-E4 **no comparten más de 5 palabras significativas** entre sí
- [ ] Ningún WhatsApp supera **40 palabras** (conteo impreso)
- [ ] Ningún asunto tiene mayúscula sostenida, emoji, signo repetido ni palabra de la lista negra
- [ ] Ninguna pieza promete aprobación, tasa, cuota ni cupo no verificado
- [ ] Cero placeholders sin resolver
- [ ] Español de Colombia con tuteo — test: *¿esta frase la diría una asesora por teléfono?*

**Cumplimiento:**

- [ ] Todos los correos llevan razón social, dirección postal física y baja en un clic
- [ ] Máximo 3 enlaces por correo, todos al dominio propio, sin acortadores
- [ ] Advertencia de alcance impresa al final del paquete
- [ ] El documento dice: **"este paquete requiere revisión humana antes de programar"**

**Coherencia operativa** (errores reales de mayo, codificados):

- [ ] Moneda coincide con el país del evento y se escribe **`USD`, nunca "USA"** — el flyer de Tampa
      decía *"Reserva desde 280 USA"*
- [ ] Prefijo telefónico coincide con el país — Carolina Ronderos apareció en el evento de **España**
      con teléfono **+1**
- [ ] Si el evento es en USA, las piezas de WhatsApp están marcadas `🚫 NO ENVIABLE HOY`
- [ ] Se calculó la anticipación contra los 45 días y se advirtió si es menor

---

## Reglas duras (violarlas invalida el entregable)

1. **El skill redacta, no envía.** Nunca. Ni email ni WhatsApp.
2. **Cero placeholders.** Sin dirección exacta, fecha, ciudad y hora, **no hay paquete**: hay lista
   de bloqueantes.
3. **Nunca tasa, cuota ni plazo** (Reg Z). Nunca prometer aprobación. Formulación permitida:
   *"revisás si calificás"*, *"qué figura aplica a tu caso"*. **"Mi Casa en Colombia" se nombra como
   programa existente, jamás como aprobación.**
4. **Nunca cupos falsos ni urgencia inventada.** "Última oportunidad" en un evento que se repite
   todos los meses la gente lo nota, y erosiona justo la confianza que se está construyendo.
5. **Nunca escribirle a los 250K.** Sin las 3 capas de segmentación explícitas no hay entregable.
6. **El miedo se desactiva con prueba, no se nombra.**
7. **Español de Colombia, tuteo, cálido, sin sonar a banco.** Nada de "Estimado cliente", "nos
   complace invitarle", "aliado estratégico", "solución integral", "no dude en contactarnos".
8. **Los `[⚠ no verificado]` sobreviven.** No se limpian para que el documento se vea prolijo. La
   dirección del ejemplo de Valencia es ilustrativa y así está marcada.

---

## Ejemplo (recortado — el íntegro está en `references/ejemplo-valencia.md`)

**E1 · 1 de septiembre — PAIN**

```
De:        Viventa <eventos@viventa.co>
Asunto:    Comprar en Colombia sin tener que volver a viajar
Preheader: El sábado 19 estamos en Valencia. Te cuento qué vamos a resolver ahí.
```

Hola, Marcela:

Hay una cuenta que muchos colombianos en España hacen en silencio: cada mes se va el alquiler, y en
Colombia no queda nada a nombre de uno.

Y cuando por fin uno se decide, aparece el otro problema: los bancos colombianos piden papeles que
no se pueden gestionar por teléfono, la familia allá no tiene por qué hacer esa vuelta, y pedir
vacaciones para ir a firmar cuesta más que la cuota inicial.

Por eso vamos a Valencia. **El sábado 19 de septiembre** te sentás con una asesora de Viventa, en
persona, y salís sabiendo tres cosas: si hoy calificás para crédito de vivienda en Colombia, qué
proyectos entran en tu presupuesto y qué papeles te faltan.

**Sábado 19 de septiembre · de 10:00 a 18:00**
**Hotel Barceló Valencia — Av. de Francia 11, 46023 Valencia** `[⚠ no verificado — dirección ilustrativa]`
Metro Ayora, líneas 5 y 7.

Entrada libre. Registrate para que te reservemos un espacio con una asesora:

**[ Quiero mi espacio el 19 de septiembre ]**

Un abrazo,
El equipo de Viventa

---
Viventa · 20 años · 5 bancos aliados · Oficinas en Colombia, España y Estados Unidos
[Dirección postal] · [Darme de baja]

**W1 · 3 de septiembre — WhatsApp (37 palabras)**

```
Hola Marcela, soy Johana de Viventa 👋
El sábado 19 estamos en Valencia, Av. de Francia 11, de 10 a 18h.
Te sentás con una asesora y salís sabiendo si calificás para crédito en Colombia.
¿Te aparto un espacio?
```

---

## Referencias

- `references/segmentacion-deliverability.md` — las 3 capas, tiers, lista negra de asuntos, reglas
  de cuerpo, cumplimiento legal, ficha email vs. WhatsApp, CAC por canal, bloque de alcance.
- `references/anti-patterns.md` — las 14 fallas típicas con antídoto mecánico, por qué el miedo
  manda, frontera con los skills vecinos.
- `references/ejemplo-valencia.md` — la secuencia íntegra de 11 piezas, la tabla del post-evento y
  la variante USA con E4-bis.
- Contexto del cliente: `references/contexto-viventa.md` · verbatims:
  `references/voice-of-customer-90d.md`
