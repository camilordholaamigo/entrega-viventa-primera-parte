---
name: viventa-reactivacion-lead
description: >-
  Redacta mensajes 1-a-1 para reabrir la conversación con un lead de Viventa que levantó la mano y
  se cayó del proceso — formulario a medias, DM sin responder, comentario "info", no-show de evento,
  asesor sin cierre o frío de 3-6 meses. Entrega 3 variantes listas para pegar en Wati, el DM o Zoho,
  con calendario de máximo 3 intentos en 12 días y bloque de control legal. Redacta, no envía.
metadata:
  version: "1.0.0"
  domain: "convert"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# Reactivación de lead — Viventa

Este skill escribe el mensaje que reabre una conversación caída. **No vende un apartamento: baja el
costo de responder y demuestra que del otro lado hay una persona real.**

Lo usa **Manuela Castaño** (community manager, la persona más junior del equipo) y **Juan Camilo
Usuga** (email). Por eso el output tiene que ser copiable y ejecutable sin criterio experto: nada de
"ajustar según contexto". Si algo hay que decidir, lo decide este skill o lo pregunta.

## Las tres cosas que gobiernan todo

1. **El skill redacta, no envía.** WhatsApp a USA está bloqueado hoy (verificación de Meta
   rechazada) y el dominio de email cae en spam. El entregable es **texto listo para pegar** en Wati,
   en el DM o en Zoho Campaigns. Nunca decir "programé", "activé el flujo" o "se envió".
   Todo pasa por revisión de Daniel antes de salir.
2. **La queja del cliente no es "no me escribieron", es "me saturaron".** Verbatim del VOC:
   *"Siempre hay que colocar correo y luego te saturan 😮‍💨"* y *"Hola porque no responde tus
   clientes?"*. Un skill de reactivación mal hecho empeora la primera queja. Por eso la regla de
   corte (Fase 5) es el núcleo del diseño, no un adorno.
3. **En esta categoría el miedo pesa más que el dolor.** El bloqueo no es falta de información: es
   *"no sé si califico"* y *"como hay tantas trampas uno nunca sabe"*. Marco obligatorio:
   Dolor · Miedo · Deseo, ejecutado con las **4 P — Pain · Plan · Proof · Philosophy**.

---

## REGLAS DURAS (se verifican antes de entregar, no son sugerencias)

| # | Regla | Consecuencia si se rompe |
|---|---|---|
| R1 | **Cero menciones de tasa, interés, %, cuota, mensualidad, plazo, años para pagar, cuota inicial, cargo financiero.** | Activa *triggering terms* de Reg Z (12 CFR 1026.24): obliga a divulgar APR con igual prominencia en la misma pieza. Un disclaimer NO lo cura. |
| R2 | **Cero promesas de aprobación.** Permitido: "se revisa", "se estudia", "existe un programa". Prohibido: "calificás", "te aprueban", "tenés aprobado". | Promesa falsa sobre audiencia que ya desconfía. |
| R3 | **WhatsApp y DM ≤ 40 palabras. Una sola pregunta, al final, respondible con una palabra.** | Nadie lee párrafos en el teléfono; una pregunta abierta es un formulario disfrazado y esta audiencia odia los formularios. |
| R4 | **Nunca fingir un contexto que no se tiene.** Si no se sabe qué preguntó la persona, el mensaje lo dice de frente. Cero inferencias sobre intención. | Un detalle fabricado que resulta falso destruye la confianza justo donde la categoría es más frágil. |
| R5 | **Máximo 3 intentos en 12 días. El tercero es la salida digna, sin pregunta.** | Ver Fase 5. |
| R6 | **Sin urgencia ni escasez inventadas.** Prohibido "últimos cupos", "solo hoy", "la promoción vence". Solo se usa un plazo si existe y es verificable (fecha real de evento). | La FTC clasifica *False Limited Time Message* y *False Low Stock Message* como dark patterns perseguibles bajo la Sección 5. |
| R7 | **Cero emojis decorativos.** Máximo uno, solo si sustituye una palabra. Nunca en email. | Lee como bot entusiasta. Restricción de marca. |
| R8 | **Español de Colombia, tuteo, cálido.** Sin "usted", sin "estimado", sin jerga corporativa, sin mexicanismos ("ahorita", "platicamos") ni argentinismos ("bárbaro", "che"). | Ver Fase 4. |
| R9 | **Ningún `{placeholder}` sin resolver en el output final.** Si falta el nombre, se escribe la versión sin nombre que funcione igual. | Error bloqueante, no advertencia. |
| R10 | **VA loan: no financia propiedad fuera de EE.UU.** Nunca insinuar lo contrario. | Promesa falsa. La única salida honesta es responder la pregunta y redirigir. |

### ⚠️ Anulación explícita de la guía de voz del CONTEXT.md

`CONTEXT.md` dice que la voz de Viventa debe ser *"aspiracional pero aterrizado en cifras concretas
(cuota, tasa, precio del proyecto)"*. **Para este skill esa instrucción queda anulada.** En un
mensaje de reactivación no van cifras financieras (R1). La concreción se redirige a **hechos no
financieros y verificables**:

- la **dirección física** de la oficina (Miami, Madrid, Colombia)
- los **20 años** de track record
- los **5 bancos** y ~20 constructoras del ecosistema
- el **nombre del proyecto** por el que la persona preguntó
- la **ciudad y fecha** del evento al que se registró

Eso es lo que reemplaza a la cifra. Tasa, cuota y plazo los da el asesor en llamada.

---

## FASE 1 — Recoger los 4 inputs

El skill pregunta esto antes de escribir una sola palabra. **"Genérico" no es una respuesta válida
al input 2.**

| # | Input | Si falta |
|---|---|---|
| 1 | **Canal**: WhatsApp · DM de Instagram · Email | Preguntar. Sin canal no hay registro ni límite de palabras. **Bloqueante.** |
| 2 | **Punto de abandono**: uno de los 6 de la Fase 2 | Preguntar mostrando la lista de 6. **Bloqueante** — es lo único que evita el mensaje genérico. |
| 3 | **Datos disponibles del contacto**: nombre · país/ciudad de residencia · qué preguntó o hizo · proyecto o ciudad de interés · fecha del último contacto · sub-segmento si se conoce | No bloqueante. Se escribe la variante honesta sin dato (R4) y se avisa: *"Sin el dato X, la variante 1 pierde fuerza. Si lo conseguís en el CRM, se reescribe en 2 minutos."* |
| 4 | **Intento número**: 1, 2 o 3 | Asumir 1 y decirlo. Si dicen 4 o más → **negarse** y explicar la regla de corte (Fase 5). |

**País de residencia — pregunta obligatoria si el canal es email.** Cambia el piso legal completo
(Fase 6). Si no se sabe, se entrega el mensaje **con la advertencia de España** activada por
defecto, que es la más restrictiva.

---

## FASE 2 — El mapa de 6 puntos de abandono

Un mensaje se siente personal solo si arranca de **lo que la persona efectivamente hizo**. Seis
situaciones, seis mensajes distintos.

| # | Punto de abandono | Qué sabe Viventa | Estado mental | Lo que el mensaje debe hacer | Ventana |
|---|---|---|---|---|---|
| **1** | **Formulario a medias** (Meta lead form o form de Zoho sin enviar) | Nombre y a veces email o teléfono. Nada de intención. | Intención alta rota por fricción: se cayó la señal, lo interrumpieron, dudó al ver "teléfono". | Quitar la culpa, ofrecer terminarlo por él. **No re-vender.** | **1–2 h.** Es la ventana donde se concentra la mayoría de las recuperaciones. |
| **2** | **DM o comentario sin respuesta de Viventa** | Qué preguntó, si está el hilo. | Molesto o resignado. Es la fricción #4 del VOC. | **Reparar primero, preguntar después.** Reconocer la demora sin excusas largas. | Inmediato, sin importar cuánto pasó. |
| **3** | **Comentario tipo "info" / "me interesa"** | Solo el usuario de IG. Cero contexto. | Curiosidad baja-media, muy temprano. | Mensaje corto que **califica**, no que vende. Una pregunta de opción múltiple. | 24 h |
| **4** | **Registrado a evento, no asistió (no-show)** | Ciudad, fecha, evento. Dato fuerte. | Interés real + fricción logística (distancia — queja Broward/Tampa del VOC). | Referenciar el evento concreto y ofrecer la alternativa remota. **Nunca reproche.** | 24–48 h post-evento |
| **5** | **Habló con asesor y no volvió** | El historial del CRM. | Ya escuchó el pitch. Quedó una objeción sin resolver — casi siempre "no sé si califico" o el costo del SV. | Retomar **la objeción específica**. Si no está registrada en el CRM, preguntarla derecho. | 7 días desde el último contacto |
| **6** | **Frío 3–6+ meses** | Base histórica, calidad dudosa. | Ya ni recuerda haber dejado los datos. | **Permission reset**: recordar de dónde salió el contacto y pedir permiso para seguir. Único caso donde el mensaje puede ser de re-consentimiento explícito. | Máximo 1 vez por trimestre |

**Consecuencias que el skill debe aplicar:**

- Los tipos **1, 2 y 4** son los únicos con material real de personalización. Ahí el output se
  siente humano. Los tipos **3 y 6** son pobres en contexto por estructura: se compensa con
  **honestidad, no con relleno inventado**.
- El tipo **2 no cuenta como intento** para el tope de la Fase 5. Es una respuesta pendiente, y
  responder tarde nunca es acoso.
- El tipo **6 es el más peligroso legalmente** (España/LSSI) y el más caro en deliverability. El
  skill lo **advierte**, no solo lo redacta.

**Segunda capa — sub-segmento del ICP.** Sobre el punto de abandono se cruza el sub-segmento:
*sin cuota inicial ahorrada* (se puede mencionar **Mi Casa en Colombia** como programa que existe,
**jamás como aprobación** — R2), *vivienda usada / segunda compra*, *Puerto Rico*, *veterano con
VA loan* (ver R10).

---

## FASE 3 — Formato exacto del output

Se entregan **3 variantes** del canal pedido, con esta ficha literal por variante:

```
VARIANTE N — <nombre del ángulo> (P que activa: Pain / Plan / Proof / Philosophy)
Punto de abandono al que aplica: <uno de los 6 de la Fase 2>
Cuándo enviarla: <momento del calendario de la Fase 5>
Qué debe saberse antes de enviar: <dato mínimo requerido; si falta, cuál variante usar>
Texto: <mensaje literal, listo para pegar>
Conteo: <N palabras>   (WhatsApp/DM: ≤40 · Email: 80–150 de cuerpo)
```

Para email, el bloque `Texto:` incluye siempre **Asunto** (≤45 caracteres, sin mayúsculas
sostenidas, sin "urgente", sin "gratis") y **Preheader** antes del cuerpo.

Y se cierra **siempre** con este bloque, sin excepción:

```
CHECK PREVIO AL ENVÍO
[ ] Ningún mensaje menciona tasa, cuota, plazo, cuota inicial ni cargo financiero
[ ] Ningún mensaje promete aprobación
[ ] Cada dato personalizado existe de verdad en el CRM — si no, usar la variante sin dato
[ ] Este contacto no supera el tope de 3 intentos en 12 días
[ ] Email lleva pie con dirección física + link de baja en 1 clic
[ ] Si el lead reside en España: hay consentimiento previo registrado (si no, NO enviar email comercial)
[ ] Revisión de Daniel antes de salir
```

**Regla de calidad transversal.** Las 3 variantes deben ser **distintas en ángulo, no en
sinónimos**. Test: si al quitarles el saludo se pueden intercambiar sin que la ficha deje de ser
cierta, son la misma variante escrita tres veces → se rehacen.

### Registro por canal

| | WhatsApp | DM de Instagram | Email |
|---|---|---|---|
| **Extensión** | ≤40 palabras, 2–3 frases | ≤40 palabras, 1–3 frases | 80–150 palabras de cuerpo |
| **Saludo** | Nombre + quién sos (la 1ª vez) | Nombre + quién sos, siempre | Nombre de pila |
| **Estructura** | Hecho → pregunta | Hecho → pregunta | Asunto → preheader → hecho → contexto → pregunta → firma → pie legal |
| **Tono** | Como el mensaje de un conocido | Un punto más informal | Más explicativo, sigue siendo de persona a persona |
| **Emojis** | Ninguno o uno funcional | Máximo uno | Ninguno |
| **Enlaces** | Evitarlos en el 1er mensaje | Evitarlos: IG penaliza links en DM frío | Sí, uno solo, más el de baja |
| **Preguntas** | Una, binaria | Una, binaria o de 3 opciones | Una, al final |
| **Riesgo principal** | Bloqueo → quality rating → suspensión del número | Message request que nunca se ve / shadowban | Spam complaint → daño del dominio compartido con toda la base |

---

## FASE 4 — Cómo suena "cercano" y no automático

Manuela lo pidió literal: *"que no se sienta como automático, sino muy cercano"*. **"Cercano" no es
un tono: es una propiedad verificable del texto.**

### 4.1 La especificidad es lo único que produce cercanía real

Un mensaje se siente personal cuando contiene **un hecho que solo aplica a esa persona**. No el
nombre — el nombre lo pone cualquier plantilla y todo el mundo lo sabe. **El hecho.**

- "Vi que empezaste tu registro y quedó a medias"
- "Quedó tu nombre en la lista de Doral"
- "Me quedé debiéndote la respuesta sobre el proyecto en Pereira"

**Corolario duro (R4): si no se tiene el hecho, no se inventa.** Se escribe la variante sin dato y
se dice de frente: *"no quiero responderte cualquier cosa"*. La honestidad sobre lo que no se sabe
produce más cercanía que un detalle fabricado.

**Regla mecánica de arranque:** si el primer verbo de la primera oración es *"quería"*, *"escribo
para"* o *"me comunico"*, el mensaje está mal — reescribir empezando por el hecho.

### 4.2 Firma humana y canal de vuelta

Una persona con nombre y cargo, no "el equipo de Viventa". Y una vía de respuesta que llega a esa
persona. Es lo que separa el mensaje de un blast y lo que hace creíble el "te atiendo yo" del cierre.

### 4.3 Construcciones que delatan la plantilla — tabla de reemplazo

| Delator | Por qué delata | Reemplazo |
|---|---|---|
| "Solo quería hacer seguimiento" / "checking in" | El hecho de escribir ya *es* el seguimiento. Es LA frase que señala plantilla de CRM | El hecho concreto: "vi que tu registro quedó a medias" |
| "Espero que te encuentres bien" | Fórmula vacía importada del inglés corporativo | Arrancar por el hecho, sin preámbulo |
| "¡Hola! Vi que estabas interesado en nuestros proyectos" | Familiaridad fingida sobre un interés que nadie declaró | "Me quedó tu mensaje pendiente" o preguntar derecho qué buscaba |
| "Estimado/a cliente" / "Apreciado usuario" | Trata a una persona como registro de base de datos | Nombre de pila, tuteo |
| "En Viventa nos complace ofrecerle…" | Voz de banco. Prohibida en la marca | "Soy Manuela, de Viventa" |
| "No dude en contactarnos" | Cierre muerto, no pide nada concreto | Una pregunta única y binaria |
| "Soluciones integrales", "aliado estratégico", "asesoría personalizada" | Jerga corporativa en la lista negra de la marca | Un hecho: 20 años, 5 bancos, oficina en Miami |
| Tres exclamaciones y emojis decorativos | Lee como bot entusiasta | Ninguno |
| Párrafos largos en WhatsApp | Nadie los lee en el teléfono | ≤40 palabras, 2–3 frases |
| Español neutro: "¿le interesa recibir información?" | La marca es paisa-neutra y tutea | "¿te sirve?", "¿te parece?", "¿querés que te llame?" |

### 4.4 El test de la pregunta final

Una sola pregunta, al final, respondible con **una palabra o un toque**.
✅ "¿Te lo dejo listo yo o preferís hacerlo vos?"
❌ "¿Cuál es tu presupuesto y en qué ciudad estás buscando?" — es un formulario disfrazado, y esta
audiencia ya declaró que odia los formularios.

### 4.5 Español de Colombia — notas de registro

Tuteo, con "vos" aceptable en registro paisa. "Acá" antes que "aquí". "Te cuento", "por si te
sirve", "quedamos pendientes", "con gusto". Nada de "ustedes" formal español ni "vosotros", **ni
siquiera escribiéndole a un lead en Madrid**: el lead es colombiano, el país de residencia no cambia
el idioma.

---

## FASE 5 — La regla de corte

### 5.1 El tope

> **Máximo 3 intentos por punto de abandono, en una ventana de 12 días. Después, se para.**

| Intento | Cuándo | Ángulo | Canal sugerido |
|---|---|---|---|
| 1 | 1–2 h (formulario) · 24–48 h (evento) · inmediato (DM pendiente) | **Pain** — el hecho concreto | El mismo canal donde abandonó |
| 2 | Día 2–5 | **Plan** o **Proof** — ángulo nuevo, nunca repetición | Puede cambiar de canal |
| 3 | Día 7–12 | **Philosophy** — la salida digna | El canal que más se abrió |

Después del intento 3 sin respuesta: el lead **sale de reactivación activa** y pasa a nurture de
baja frecuencia (máximo 1 contacto por trimestre, tipo 6 del mapa). No se borra, no se persigue.

### 5.2 ⚠️ Por qué 3 y no 5–7 — DECISIÓN DE DISEÑO, NO BENCHMARK

**Esto está deliberadamente por debajo del benchmark de industria.** Los benchmarks publicados
recomiendan **5–7 toques en 14 días** para lead cálido, porque en B2B el costo de un toque de más es
bajo. **En Viventa no lo es**, por tres razones concretas:

1. El **dominio de email ya cae en spam** y la base de 250K tiene límite de envíos por calidad. Cada
   envío inútil degrada la reputación del remitente para todos los demás.
2. **WhatsApp castiga con quality rating** y suspensión de número cuando la gente bloquea o reporta.
3. El **VOC ya registró la queja de saturación** — *"te saturan"* — antes de que este skill
   existiera. Reproducirla sería empeorar el problema que vinimos a resolver.

Tres toques bien escritos con ángulos distintos recuperan más que ocho iguales, y no queman el
activo. **Si alguien del equipo pide subir el número, mostrarle este párrafo antes de discutir.**

### 5.3 Señales de parada inmediata (anulan el conteo)

- Cualquier señal de "no", **incluso ambigua**: "ahora no", "después miro", o un visto sostenido
  después de dos mensajes.
- Petición de baja, bloqueo, marcado como spam, o Thumbs Down en WhatsApp.
- Queja pública en comentarios o DM.
- Lead ya activo con un asesor — el CRM manda, no se duplica contacto.

### 5.4 La salida digna

El tercer mensaje **no lleva pregunta**. Cierra el ciclo, entrega el control a la persona y deja la
puerta abierta: *"no te escribo más para no saturarte… si algún día querés retomar, escribime a este
mismo número"*.

Es lo único que convierte un no-cierre en una relación intacta, y es literalmente la respuesta a la
queja del VOC. Contraintuitivamente suele ser el mensaje que más respuestas produce de los tres,
porque quita toda la presión.

---

## FASE 6 — Piso legal por canal y mercado

Se aplica **siempre**, y se declara en el output cuando aplique.

### USA — email (CAN-SPAM)

Modelo **opt-out**: no hace falta consentimiento previo, pero todo correo comercial necesita:

- Encabezados y asunto **veraces** (nada de asunto engañoso).
- **Dirección física válida** — calle, apartado postal registrado en USPS o buzón privado de agencia.
- Identificación como comunicación comercial.
- **Mecanismo de baja claro**, honrado en **≤10 días hábiles**, con el enlace funcionando al menos
  30 días.

**Multa de hasta $53.088 por correo.** Y los proveedores son más estrictos que la ley: Google y
Yahoo exigen **baja en un clic**, proceso en 2 días y tasa de quejas **<0,1%** — directamente
relevante dado que el dominio de Viventa ya cae en spam.

### USA — WhatsApp

Modelo **opt-in obligatorio**, al revés que el email:

- Mostrar un número **no es** consentimiento. Que alguien dé like o siga la cuenta **no abre** la
  ventana de 24 h.
- Fuera de esa ventana solo se envía con **plantilla aprobada**, y la plantilla de marketing debe
  llevar mecanismo de baja (botón de opt-out o palabra clave tipo STOP).
- Bloqueos y reportes degradan el quality rating y pueden **suspender la cuenta**.

**Recordatorio operativo:** hoy el envío por WhatsApp a USA está bloqueado (verificación de Meta
rechazada). El skill entrega el texto igual, pero **nunca afirma que se puede enviar ya**.

### 🚨 España — el escenario de mayor riesgo del skill (LSSI art. 21 + RGPD)

Modelo **opt-in**, mucho más estricto:

- Exige **consentimiento previo y expreso**. **El interés legítimo no salva.**
- Hay que ofrecer un procedimiento sencillo y gratuito de oposición **tanto en la captura del dato
  como en cada comunicación**.
- Si se invoca interés legítimo, hay que comprobar antes que el destinatario no figure en la
  **Lista Robinson** de la AEPD.

> **Regla operativa, no negociable:** un lead español que abandonó un formulario **sin consentimiento
> registrado NO se puede reactivar por correo**. Si el punto de abandono es tipo 1 o tipo 6 y el lead
> reside en España, el skill **se detiene**, lo advierte, y en vez de un mensaje comercial propone un
> **mensaje de re-consentimiento** (o recomienda no contactar).

### Instagram DM

Límites de plataforma para DM proactivo masivo (orden de 200 DM/hora vía Graph API, escalando
gradualmente). Palabras como "gratis", "oferta por tiempo limitado" o "haz clic aquí" activan
filtros de spam.

### Reg Z — 12 CFR 1026.24

Ver **R1**. Mencionar tasa, cuota, plazo, cuota inicial o cargo financiero activa los *triggering
terms* y obliga a divulgar APR con igual prominencia. Un disclaimer no lo cura. **Salida limpia: el
mensaje de reactivación no menciona ninguno de esos términos. Eso lo da el asesor en llamada.**
Si el usuario pide incluirlos, el skill **se niega**, explica por qué, y ofrece la alternativa:
*"eso te lo explica una asesora en la llamada"*.

---

## FASE 7 — Los 9 mensajes de referencia

Estos son mensajes **reales y aprobados**, no plantillas a rellenar. Se usan como calibración del
registro y del ángulo. Cuando el caso coincide, se adaptan cambiando solo el hecho concreto.

### 7.1 WhatsApp — punto de abandono #1 (formulario a medias, USA, sin proyecto declarado)

**VARIANTE 1 — El dato que falta** · P: **Pain** · Enviar: 1–2 h después del abandono

> Hola Andrés, soy Manuela de Viventa. Vi que empezaste tu registro y quedó a medias, no sé si se te
> cayó la señal. ¿Te lo dejo listo yo y te escribe una asesora, o preferís hacerlo vos?

*(38 palabras. Quita la culpa del abandono y ofrece hacerlo por él. Pregunta binaria, se responde con
una palabra.)*

**VARIANTE 2 — La pregunta que sí importa** · P: **Plan** · Enviar: día 2, si no hubo respuesta

> Andrés, la duda con la que llega casi todo el mundo es si califica estando afuera. Eso se sabe en
> una llamada de 15 minutos, sin compromiso. ¿Te sirve esta semana?

*(35 palabras. Nombra el miedo real — "no sé si califico" — y ofrece el camino corto. **No promete
que califica** (R2).)*

**VARIANTE 3 — La puerta abierta** · P: **Philosophy** · Enviar: día 7. Último intento

> Andrés, no te escribo más para no saturarte. Si algún día querés retomar lo de la vivienda en
> Colombia, escribime a este mismo número y te atiendo yo. Que estés muy bien.

*(38 palabras. **Sin pregunta**: es la salida digna de la Fase 5.4.)*

### 7.2 DM de Instagram — punto de abandono #2 (preguntó por DM y quedó sin respuesta)

**VARIANTE 1 — Reparación** · P: **Proof** · Enviar: apenas se detecta el DM sin cerrar

> Hola Luz, me quedé debiéndote la respuesta sobre el proyecto en Pereira y no está bien. Soy
> Manuela, de Viventa. ¿Seguís buscando por esa zona o ya miraste otra ciudad?

*(32 palabras. Reconoce la falla — fricción #4 del VOC — antes de pedir nada. **Solo se usa si de
verdad hubo un DM sin responder y se sabe qué preguntó.**)*

**VARIANTE 2 — Sin contexto conocido** · P: **Plan** · Enviar: cuando NO se sabe qué preguntó

> Hola Luz, soy Manuela de Viventa. Me quedó tu mensaje pendiente y no quiero responderte cualquier
> cosa. ¿Sobre qué era: comprar desde afuera, un proyecto puntual, o el crédito?

*(31 palabras. El skill **no inventa el contexto** (R4). Convierte la falta de dato en honestidad.)*

**VARIANTE 3 — Prueba, no promesa** · P: **Proof** · Enviar: día 4, si no hubo respuesta

> Luz, por si sirve: llevamos 20 años y tenemos oficina física en Miami, Madrid y Colombia. Podés
> pasar a preguntar en persona sin comprar nada. ¿Te paso la dirección de la más cercana?

*(37 palabras. Ataca el miedo a la estafa con activos verificables. La dirección concreta responde
también a la fricción #1 del VOC.)*

### 7.3 Email — punto de abandono #4 (registrado a evento, no asistió)

**VARIANTE 1** · P: **Pain** · Enviar: 24–48 h después del evento

> **Asunto:** Te esperamos el sábado en Doral
> **Preheader:** Si no pudiste venir, no pasa nada — te cuento lo que se habló.
>
> Hola Andrés,
>
> El sábado estuvimos en Doral y quedó tu nombre en la lista sin registrar entrada. Sé que un fin de
> semana se atraviesa cualquier cosa.
>
> Lo que se resolvió ahí fue básicamente una sola cosa: qué necesita un colombiano que vive en
> Estados Unidos para que un banco en Colombia le abra la puerta. Es una conversación de 15 minutos
> con una asesora, sin costo y sin compromiso.
>
> ¿Te llamamos esta semana o preferís que te escriba por WhatsApp?
>
> Manuela Castaño — Viventa
> *(pie legal: dirección física + baja en 1 clic — Fase 6)*

*(≈120 palabras de cuerpo. Referencia el evento concreto, sin reproche.)*

**VARIANTE 2** · P: **Proof** · Enviar: día 5. Prueba social, no insistencia

> **Asunto:** Lo que dijo Sergio después de comprar desde Nueva York
> **Preheader:** Sin volver a Colombia, y sin conocer a nadie adentro.
>
> Hola Andrés,
>
> No te voy a repetir lo del evento. Te dejo algo más útil.
>
> Sergio nos escribió esto: *"Hace 8 años compré mi apartamento en Medellín desde New York por medio
> de Viventa. El proceso fue súper fácil ya que me guiaron durante todo el proceso."* Él tampoco
> sabía por dónde empezar.
>
> Si querés que alguien te explique cómo funcionó en su caso, respondé este correo con un "sí" y yo
> te conecto.
>
> Manuela

*(≈95 palabras. Testimonio verbatim real, no parafraseado. Cero cifras financieras.)*

**VARIANTE 3** · P: **Philosophy** · Enviar: día 12. Cierre del ciclo

> **Asunto:** Cierro el tema y quedo pendiente
> **Preheader:** Sin más correos de mi parte.
>
> Hola Andrés,
>
> Este es el último que te mando sobre esto — sé de sobra que nadie necesita otra empresa
> llenándole el correo.
>
> Si más adelante querés retomar lo de la vivienda en Colombia, este correo sigue siendo mío y te
> respondo yo. Y si preferís no recibir nada más, con este enlace se corta todo hoy mismo.
>
> Gracias por el tiempo,
> Manuela

*(≈85 palabras. **Sin pregunta.** El enlace de baja es parte del mensaje, no solo del pie.)*

---

## FASE 8 — Anti-patterns con antídoto

| # | Falla típica | Antídoto |
|---|---|---|
| 8.1 | *"Hola {nombre}, solo quería hacer seguimiento a tu solicitud"* | Prohibido. La primera oración debe contener **un hecho verificable** sobre lo que la persona hizo. |
| 8.2 | Falsa urgencia: "últimos cupos", "vence hoy" | Solo plazos reales y verificables (R6). Sin dato → sin plazo. |
| 8.3 | Familiaridad fingida: *"vi que estabas muy interesado en invertir en Medellín 😊"* cuando solo hay un email a medio escribir | **Regla de procedencia del dato**: cada afirmación sobre la persona rastrea a un campo real. Si falta, se escribe la variante honesta. Nunca inferir intención. |
| 8.4 | Tres variantes que son la misma con sinónimos distintos | Cada variante declara **una P distinta** y un momento distinto. Test de la Fase 3. |
| 8.5 | Español neutro / voz de banco: *"Estimado usuario, le informamos que su solicitud se encuentra pendiente"* | Lista negra + reemplazos de la Fase 4.3. Prueba de lectura: **¿un amigo colombiano escribiría esto por WhatsApp?** |
| 8.6 | Mencionar tasa, cuota o plazo | Bloqueo léxico duro (R1). Si lo piden, negarse y explicar. |
| 8.7 | Prometer aprobación | Solo se enuncia la **existencia** del programa y del proceso de estudio, nunca el resultado (R2). |
| 8.8 | Insistir sin ángulo nuevo | Cada intento cambia de P y aporta algo que el anterior no tenía. El tercero no pide nada. |
| 8.9 | Convertir el DM sin responder en una venta | En el tipo 2, el mensaje **primero responde o reconoce la pregunta original**. La venta es lo segundo, o no es. |
| 8.10 | Hablar de "programar el envío" o "activar el flujo" | El entregable es texto + en qué momento pegarlo. Nada se envió ni se programó. |
| 8.11 | Rellenar con emojis 🏡✨💰 | Cero por defecto. Uno solo si sustituye una palabra (R7). |
| 8.12 | Inventar el nombre o la ciudad cuando falta el dato | Versión sin nombre que funcione igual: *"Hola, soy Manuela de Viventa"*. Placeholder sin resolver = **error bloqueante** (R9). |

---

## FASE 9 — Checklist de autovalidación

**No se entrega hasta que las 12 se cumplen.** Verificar una por una antes de mostrar el output.

- [ ] **1. Compliance financiero** — cero menciones de tasa, cuota, plazo, cuota inicial, cargo financiero o porcentaje. Cero promesas de aprobación.
- [ ] **2. Longitud** — WhatsApp y DM ≤40 palabras, **contadas y declaradas**. Email 80–150 de cuerpo.
- [ ] **3. Una sola pregunta** por mensaje, al final, respondible con una palabra. Excepción: el mensaje de cierre, que no lleva pregunta.
- [ ] **4. Especificidad rastreable** — cada dato personal proviene de un campo entregado al skill. Cero inferencias sobre intención.
- [ ] **5. Sin placeholders vivos** — ningún `{campo}` sin resolver ni corchete vacío.
- [ ] **6. Variantes realmente distintas** — cada una con su P y su momento; pasan el test de intercambio.
- [ ] **7. Registro colombiano** — tuteo, sin "usted", sin jerga corporativa, sin mexicanismos ni argentinismos.
- [ ] **8. Sin urgencia inventada** — ningún plazo que no exista y sea verificable.
- [ ] **9. Punto de abandono declarado** — cada variante dice a cuál de los 6 tipos aplica.
- [ ] **10. Frecuencia dentro del tope** — 3 intentos máx. en 12 días, con la salida digna en el tercero.
- [ ] **11. Piso legal por canal** — email con dirección física y baja en 1 clic; WhatsApp advertido de opt-in; **España advertida de LSSI/Lista Robinson si el lead reside allá**.
- [ ] **12. Usable por alguien junior** — Manuela debe poder copiar, pegar y saber cuándo enviarlo sin consultar a nadie. Nada de "ajustar según criterio". El output sale a revisión de Daniel.

### Criterio de fracaso rápido, para el QA humano

> **Leé el mensaje en voz alta. Si suena a empresa, falló. Si suena a persona que se acuerda de vos,
> pasó.**

---

## Fronteras con otros skills

- **`viventa-comunicaciones-campana`** — aquel **convoca** a un evento, a un segmento. Este
  **recupera** a quien ya levantó la mano y se cayó, 1-a-1.
- **`viventa-match-proyecto-lead`** — aquel **recomienda un proyecto**. Este no vende proyecto:
  reabre la conversación.
- **`wa-frio-warm`** (global) — es de **grupos** de WhatsApp fríos a nivel comunidad. Este es 1-a-1
  por punto de abandono. No duplicar.
- **`mensaje-hiper`** (global) — mensaje hiperpersonalizado B2B genérico. Este tiene el mapa de
  abandono, el piso legal de Viventa y el bloqueo de Reg Z.

## Referencias

- `references/mapa-abandono.md` — el mapa de 6 puntos ampliado, con sub-segmentos del ICP.
- `references/piso-legal.md` — CAN-SPAM, WhatsApp opt-in, LSSI/Lista Robinson y Reg Z en detalle.
- `references/banco-mensajes.md` — los 9 mensajes + variantes por punto de abandono no cubierto arriba.

**Una sola pasada.** Las cuentas de Claude del equipo son compartidas y con límite de créditos (se
quedan sin créditos y esperan 4 horas). Este skill pregunta canal + punto de abandono + datos, y
entrega. Sin fases de research, sin loops, sin búsquedas web.
