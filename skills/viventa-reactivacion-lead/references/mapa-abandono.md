# Mapa de puntos de abandono — detalle

Referencia de consulta para `viventa-reactivacion-lead`. El resumen operativo está en la Fase 2 del
SKILL.md; acá va el detalle que no cabe ahí.

---

## Cómo identificar el punto de abandono en el CRM

| Tipo | Dónde se ve en Zoho / Meta / IG | Señal inequívoca |
|---|---|---|
| 1 · Formulario a medias | Meta lead form incompleto · Zoho Forms con sesión abierta sin submit | Hay email **o** teléfono, pero no ambos, y ningún campo de intención |
| 2 · DM / comentario sin responder | Bandeja de IG con hilo sin respuesta de Viventa | El último mensaje del hilo es de la persona |
| 3 · Comentario "info" | Comentarios del post de campaña | Solo el usuario de IG, sin DM abierto |
| 4 · No-show de evento | Lista de registrados vs. lista de asistentes del evento | Registrado sin check-in |
| 5 · Asesor sin cierre | Historial de actividad del CRM | Última llamada/nota > 7 días, sin siguiente paso agendado |
| 6 · Frío 3–6+ meses | Antigüedad del registro en la base de 250K | Sin interacción registrada en 90+ días |

---

## Tipo 1 — Formulario a medias

**Por qué se cae la gente.** Tres causas dominantes, en orden: se cayó la señal o cambió de app; lo
interrumpieron; **dudó al ver el campo de teléfono**. La tercera es la que importa: la persona
asocia dar el teléfono con "me van a saturar" (fricción declarada del VOC).

**Lo que el mensaje NO debe hacer:** re-vender el proyecto o el evento. La persona ya estaba
convencida — se rompió la mecánica, no la intención. Re-vender la devuelve al principio del embudo.

**La ventana de 1–2 h es el activo más grande del skill.** Es donde se concentra la gran mayoría de
las recuperaciones; a las 72 h la efectividad cae a una fracción. Operativamente: si Manuela revisa
formularios abandonados una vez al día, está perdiendo la ventana. Vale la pena revisar dos o tres
veces al día aunque el mensaje sea el mismo.

**Riesgo legal específico:** si el lead reside en **España**, un formulario abandonado significa
casi siempre **sin consentimiento registrado** → no se puede reactivar por correo. Ver
`piso-legal.md`.

---

## Tipo 2 — DM o comentario sin responder de Viventa

**Este es el más delicado emocionalmente y el más fácil de ganar.** La persona ya hizo el esfuerzo
de escribir. La falla es de Viventa.

**Orden obligatorio del mensaje:**
1. Reconocer la demora — una frase, sin excusas largas. *"Me quedé debiéndote la respuesta y no está
   bien."* No: *"debido al alto volumen de mensajes…"*.
2. Responder o retomar **lo que preguntó**, si se sabe.
3. Recién ahí, la pregunta de avance.

**Si no se sabe qué preguntó** (hilo perdido, cuenta migrada): se dice. *"No quiero responderte
cualquier cosa. ¿Sobre qué era?"* Con tres opciones concretas para que responda con una palabra.

**No cuenta como intento** para el tope de 3. Responder tarde a alguien que escribió no es acoso, es
lo mínimo. El conteo arranca desde el primer mensaje que Viventa inicia por su cuenta.

---

## Tipo 3 — Comentario "info" / "me interesa"

Contexto cero: solo el usuario de IG y la palabra que dejó. Es la etapa más temprana del embudo que
este skill toca.

**El mensaje califica, no vende.** Una pregunta de opción múltiple (máximo 3 opciones) que en una
sola respuesta ubique a la persona: país donde vive · si busca para vivir o invertir · si ya tiene
proyecto en mente. Elegir **una** de las tres, nunca las tres.

**Trampa:** es tentador mandar el catálogo o el link del proyecto. En DM frío, IG penaliza los links
y la persona no pidió información — pidió atención. Un link acá reduce respuesta y entregabilidad.

**Máximo 2 intentos, no 3.** Con contexto tan pobre, el tercer toque a alguien que solo escribió
"info" es desproporcionado. Excepción explícita a la regla general.

---

## Tipo 4 — No-show de evento

**El punto con mejor material de personalización de los seis:** ciudad, fecha, nombre del evento,
todo verificable.

**Regla de oro: nunca reproche.** Ni un "te esperábamos y no llegaste" con tono. La causa real
suele ser **logística** — la queja de distancia Broward/Tampa del VOC es literal. El mensaje asume
buena fe y ofrece la alternativa remota (llamada de 15 minutos con asesora).

**Elementos que deben aparecer:** la ciudad del evento y algo concreto de lo que se habló ahí — no
"fue muy interesante", sino la pregunta que se resolvió. Eso demuestra que hubo un evento real y no
un pretexto de CRM.

**Cuidado con la fecha del próximo evento.** Solo se menciona si existe, con **dirección concreta**
(regla dura de Viventa: un evento sin dirección no se anuncia — fricción #1 del VOC).

---

## Tipo 5 — Habló con asesor y no volvió

**El material está en el CRM, no en la cabeza de Manuela.** Antes de escribir hay que leer la nota
del asesor y encontrar **la objeción que quedó sin resolver**. Casi siempre una de dos:

1. *"No sé si califico"* — el miedo dominante del ICP. El mensaje ofrece el camino corto de
   verificación, **sin prometer el resultado** (R2).
2. *"$480 USD del Servicio Viventa"* — objeción de costo. El mensaje no descuenta ni justifica:
   remite a la fuente canónica de manejo de objeciones y, si hace falta, ofrece que el asesor lo
   explique de nuevo.

**Si la objeción no está registrada en el CRM**, el mensaje la pregunta derecho: *"quedó algo sin
resolver de la charla con [asesora]. ¿Qué fue lo que te frenó?"* Es más honesto y suele funcionar
mejor que adivinar.

**Verificar antes de escribir:** que el lead **no esté activo con otro asesor**. Duplicar contacto
es una señal de parada (Fase 5.3).

---

## Tipo 6 — Frío 3–6+ meses

**El más peligroso legalmente y el más caro en deliverability.** La persona ya ni recuerda haber
dejado los datos; la probabilidad de que marque spam es la más alta de los seis, y cada marca de
spam daña el dominio compartido con toda la base de 250K.

**Único caso donde el mensaje es de permission reset**, no comercial:
1. Recordar **de dónde salió el contacto** — "dejaste tus datos en [evento/campaña] en [mes]".
2. Preguntar si quiere seguir recibiendo.
3. Enlace de baja visible, no escondido en el pie.

**Frecuencia: máximo 1 vez por trimestre.** No hay secuencia de 3 acá.

**España + tipo 6 = el peor escenario del skill.** Sin consentimiento previo registrado, no se envía
correo comercial y punto. Se propone re-consentimiento o no se contacta.

---

## Segunda capa — sub-segmentos del ICP

Se cruzan sobre el punto de abandono. Cambian el ángulo, nunca la estructura ni las reglas duras.

| Sub-segmento | Qué cambia en el mensaje | Trampa |
|---|---|---|
| **Sin cuota inicial ahorrada** | Se puede mencionar que **existe** el programa *Mi Casa en Colombia* (FNA) | **Jamás** como aprobación ni con cifras. "Existe un programa que se estudia caso a caso." Nada de "hasta 100%" con números en el mensaje |
| **Vivienda usada / segunda compra** | Ya conoce el proceso; el ángulo es la agilidad, no la pedagogía | No tratarlo como primerizo — lo lee como plantilla |
| **Puerto Rico** | Aplica al crédito (residencia elegible) | Mucha gente asume que no aplica; vale la pena decirlo de frente |
| **Veterano con VA loan** | Responder la pregunta con honestidad y redirigir | **El VA loan no financia propiedad fuera de EE.UU. ni de sus territorios.** Nunca insinuar que sí. Lo del *ingreso* VA como ingreso computable ante bancos colombianos está **sin verificar** — no se menciona |

---

## Cruce rápido: punto de abandono × material de personalización

| | Material real | Compensación cuando falta |
|---|---|---|
| Tipos **1, 2, 4** | **Sí** — hay hecho concreto | — |
| Tipos **3, 6** | **No** — pobres por estructura | **Honestidad, no relleno.** Decir lo que no se sabe |
| Tipo **5** | Depende del CRM | Si la nota está vacía, preguntar la objeción derecho |
