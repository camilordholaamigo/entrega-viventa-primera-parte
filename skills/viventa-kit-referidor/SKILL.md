---
name: viventa-kit-referidor
description: >-
  Da de alta a un Referidor Pro de Viventa: texto del flyer, correo de bienvenida, 3 mensajes
  reenviables en su voz (con disclosure de comisión y cero términos financieros) y el alta operativa:
  código propuesto, link con seguimiento, pedido de regla de asignación a comercial y tarea de
  seguimiento en el CRM. USA cuando: "se registró un nuevo Referidor Pro", "hazme el kit del
  referidor", "crea el link del referidor", "mensajes para que el referidor reenvíe por WhatsApp". Es
  el alta: viventa-ciclo-referidor lo mantiene activo y advocate arma embajadores sin comisión.
metadata:
  version: "1.2.0"
  domain: "acquire"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-kit-referidor

Arma, en una sola pasada, el kit con que se activa un referidor externo del programa Referidores
Pro. Tres invariantes en toda corrida: **ningún monto de comisión que no salga textual del
documento de incentivos vigente**, **ningún término financiero en lo que dice el referidor**, y
**los 3 mensajes reenviables suenan a una persona, no a la marca, y declaran la comisión**.
Además deja lista el **alta operativa** para que no dependa de la practicante: el código que se
propone crear, el link con seguimiento, el pedido de la regla de asignación a comercial y la tarea de
seguimiento de cierres. El skill **redacta y arma**; crear el código, el formulario y la tarea en Zoho
lo hace quien tiene permiso, y el kit no sale enviable hasta que el código exista.

## Cuándo usar

- Explícito: "necesito activar un referidor nuevo", "hazme el kit del referidor", "arma el flyer y
  los mensajes para un Referidor Pro", "ya tengo el código del referidor, qué le mando", "el correo
  de bienvenida de Referidores Pro", "mensajes para que el referidor reenvíe por WhatsApp".
- Implícito: Zoho acaba de generar el código de un referidor nuevo y todavía no recibió nada.
- Cadencia: una vez por referidor, al darlo de alta.

## Cuándo NO usar

- **El referidor ya está activo** y hay que mantenerlo, reactivarlo o contarle resultados →
  `viventa-ciclo-referidor`.
- **Un programa de embajadores sin comisión** para clientes que ya recomiendan → `advocate`.
- **Crear de verdad el código, el formulario o la tarea en Zoho, o pagar** → lo hace quien tiene
  permiso en Zoho (este skill deja el pedido redactado en el Bloque E). Conciliar pagos atrasados →
  `viventa-conciliacion-referidos`.

## Input del usuario

Pedí todo lo que falte **en un solo mensaje**, no de a uno.

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Nombre del referidor y cómo quiere que le digan | El usuario | *"¿Cómo se llama el referidor y cómo le gusta que le digan?"* — **para** sin esto |
| Ciudad y país donde vive | El usuario | *"¿En qué ciudad y país vive?"* — **para** sin esto |
| Código y link único | Zoho, lo pega el usuario | *"¿Zoho ya generó el código y el link? Pásamelos."* — si **todavía no existen**, el skill propone el código (Bloque E), el kit sale NO ENVIABLE con `[falta: código creado en Zoho]` y sigue |
| URL base del formulario de registro de referidos | Zoho Forms / landing | *"¿Cuál es la URL del formulario de registro de referidos?"* Sin ella, el link con seguimiento queda como estructura con `[URL del formulario]` |
| Consultor o equipo que recibirá los referidos | Comercial | *"¿Qué consultor o equipo atiende los referidos de esta ciudad?"* Sin esto, el pedido de regla de asignación sale con la pregunta para comercial |
| Documento vigente de incentivos de Referidores Pro | El usuario lo adjunta o pega | *"¿Tenés el documento vigente de incentivos de Referidores Pro? Pegalo o adjuntalo."* — si no lo tiene, sigue con placeholders y el kit sale NO ENVIABLE (paso 1) |
| Relación del referidor con Viventa | El usuario | *"¿Es cliente que ya compró, aliado, o conocido de un comercial?"* — **para** sin esto |
| A quién le va a hablar | El usuario | *"¿A quién le va a mandar esto: compañeros de trabajo, iglesia, familia, paisanos…?"* — **para** sin esto |
| Quién firma el correo | `[nombre de quien firma]` y `[cargo de quien firma]` | Solo si el config trae `YOUR_*` o vacío: *"¿Quién firma el correo de bienvenida y con qué cargo?"* |

No usa conexiones ni búsqueda web: todo entra pegado.

## Workflow

1. **Resolvé el documento de incentivos.**
   - Está y trae monto, etapa de causación y plazo de pago → esos tres datos se copian **textuales**,
     con la moneda que diga el documento. No se redondean ni se convierten.
   - Está pero le falta alguno de los tres → ese campo va en placeholder y el kit sale NO ENVIABLE.
   - No está → `[falta: monto — documento del programa]`, `[falta: etapa — documento del programa]`,
     `[falta: plazo — documento del programa]`, y la primera línea del archivo es:
     `🚫 KIT NO ENVIABLE — falta el documento de incentivos vigente de Referidores Pro. No enviar hasta completar los campos de plata.`
   - Ningún otro documento sirve de reemplazo: los planes de compensación de la fuerza comercial
     interna (concurso de mercadeo, especialistas, puntos del bot) **no aplican** a un referidor externo,
     y el rango por referido que aparece en el diagnóstico interno es una recomendación, no política.
2. **Armá el alta operativa (Bloque E)** antes del texto, porque el kit depende de ella:
   - **Código propuesto**: `RP-{CIUDAD3}-{APELLIDO}` (mayúsculas, sin tildes ni espacios; CIUDAD3 de
     la convención de nombres de `viventa-pack-evento`). Si ya existe en el listado de referidores, se
     agrega un dígito. Queda marcado `propuesto — no existe hasta que Zoho lo cree`.
   - **Link con seguimiento**: URL base del formulario + `?ref={CÓDIGO}&utm_source=referidor-pro&utm_medium=referido&utm_campaign={CÓDIGO}`.
     El campo oculto del formulario que guarda `ref` tiene que existir; si no, va en el pedido a Zoho.
   - **Pedido a quien administra Zoho**: crear el referidor con código, datos de contacto y datos de
     pago (que el referidor envía por canal seguro, nunca en el kit), el campo oculto `ref` en el
     formulario y la prueba de un registro de punta a punta.
   - **Pedido a comercial**: regla de asignación (los registros con este código van a {consultor o
     equipo}) y quién confirma que quedó.
   - **Tarea de seguimiento en el CRM**: a los 30 días del alta, revisar registros y cierres del
     código; si causó pago, verificar la tarea de pago (→ `viventa-conciliacion-referidos`).
   Nunca escribas un código como si ya existiera ni una URL de ejemplo como si fuera la real.
3. **Escribí el Bloque A — texto del flyer**, campo por campo (el arte ya existe), en voz de marca:
   titular de ≤8 palabras; bajada con nombre y ciudad; beneficio con hechos verificables (20 años,
   5 bancos, oficinas físicas en EE. UU., España y Colombia) o la promesa central sin cifras (*"se puede
   comprar en Colombia sin volver y sin quedar solo en el proceso"*); código; CTA con el link
   tal como lo pegó el usuario; pie legal: *"{Nombre} participa en el programa Referidores Pro de
   Viventa y recibe una compensación por los negocios que se cierren con su código."* Si el
   referidor vive en una ciudad con oficina, nombrá esa oficina; si no, las tres. La moneda, si
   aparece, es la del país del referidor: USD en EE. UU., EUR en España.
4. **Escribí el Bloque B — correo de bienvenida**, en voz de marca, firmado por quien firma:
   asunto con nombre y código; CÓMO FUNCIONA en 3 pasos; CUÁNDO TE PAGAMOS con monto / etapa / plazo
   del paso 1 y el compromiso de avisarle cada cambio de estado (recibido, en estudio, cerrado,
   pagado) y cualquier demora con su motivo; DOS COSAS IMPORTANTES con tres puntos: por qué declarar
   la comisión, no hablar de tasas / cuotas / plazos ni de aprobación, y avisarle al titular antes de
   pasar su dato.
5. **Escribí el Bloque C — 3 mensajes reenviables, en la voz del referidor**, uno por registro:
   - Mensaje 1, al que ya le preguntó: presupone una conversación previa ("acordate que me preguntaste").
   - Mensaje 2, frío pero cercano, 1:1: abre el tema.
   - Mensaje 3, para grupo: dirigido al público del input. Si nombró varios, al primero; no hagas variantes.

   Cada uno cumple las seis reglas:
   1. **≥1 `[CORCHETE]` vacío** donde el referidor pone por qué él lo recomienda. Nunca lo rellenás.
   2. **Cero vocabulario de marca**: *acompañamiento integral, aliado estratégico, solución,
      patrimonio, raíces, construir tu futuro, asesoría personalizada, te acompañamos en cada paso,
      sueño de la casa propia*. En los Bloques A y B sí se permiten.
   3. **2-4 líneas**, sin viñetas, negritas ni emojis decorativos.
   4. **Una imperfección deliberada**: muletilla colombiana ("ome", "mirá que", "por si a alguno le
      sirve") o apertura en medio de una conversación.
   5. **Factual, no sentimental**: hechos y una invitación a averiguar ("ellos te dicen de una si te
      sirve o no"). Solo si es **cliente que ya compró** habla de su propia experiencia en primera
      persona; si es aliado o conocido, el corchete pide por qué confía, no una experiencia que no tuvo.
   6. **El link como vía primaria**: el conocido se registra solo. Nunca "pasame el número de tu primo".

   Y cierra con el **disclosure**, al final, en primera persona y con los tres elementos: quién (yo),
   qué recibo (una comisión / "algo"), cuándo (si se cierra). Permitido: *"te aclaro que yo gano una
   comisión si se cierra"*. Prohibido: *"el remitente mantiene una relación material con Viventa"* —
   ni "divulgación", "compensación económica" ni "de conformidad con".
6. **Escribí el Bloque D — checklist para quien envía**, siempre:
   ```
   [ ] ¿El código {CÓDIGO} ya existe y trackea en Zoho? (prueba de un registro con el link)
   [ ] ¿Comercial confirmó la regla de asignación?
   [ ] ¿Los montos salen del documento de incentivos vigente?
   [ ] ¿Los pagos de referidos de los últimos 90 días están al día?
       Si no → activá igual, en seguimiento manual. Piloto: no más de 10 referidores activos.
   [ ] ¿Una persona leyó este kit completo?
   ¿Este referidor va a cobrar a tiempo? Si no lo sabés, no lo actives.
   ```
   El tope de 10 y el ≥90% de pagos a tiempo en 90 días para escalar son heurística propia del
   diagnóstico, ajustable; Viventa no los mide hoy.
7. **Autovalidá antes de entregar.** Un bloqueante falla → corregí y volvé a chequear; no entregues.
   - Bloqueantes: ningún monto de comisión que no esté textual en el documento; ninguna mención de
     tasa, cuota, plazo, cuota inicial, aprobación, valorización, rentabilidad o elegibilidad en los
     Bloques A y C; 3 de 3 mensajes con disclosure completo al final; código real presente;
     Bloque D presente; cero datos personales de terceros; link como vía primaria en los 3.
   - De calidad (se reescribe): ¿una persona real mandaría cada mensaje textual, sin vergüenza?;
     tapando nombre y código, ¿sirve para cualquier otro referidor? (si sí, reescribí: ciudad,
     relación y público tienen que estar en el texto); corchetes vacíos y visibles; los 3 mensajes no
     comparten apertura; español de Colombia; "USD", nunca "USA"; las marcas `[⚠ no verificado]`
     que apliquen (política de datos no revisada, umbral de pagos propuesto) quedan en el Bloque D,
     no se limpian.
   - Una sola pasada: sin búsqueda web ni research adicional.
8. **Guardá y entregá** (ver Output esperado).

## Reglas duras

- **Nunca escribe un monto de comisión que no esté textual en el documento vigente** — tampoco el
  rango del diagnóstico interno, ni "alrededor de", ni como ejemplo. Sin documento: placeholder.
- **Nunca pone tasa, cuota, plazo, cuota inicial ni promesa de aprobación, valorización,
  rentabilidad o elegibilidad** en el flyer ni en los mensajes. Permitido: *"20 años, oficinas en
  EE. UU., España y Colombia"*. Prohibido: *"reserva desde 280 USD"*, *"te aprueban seguro"*.
- **Nunca entrega un mensaje reenviable sin disclosure**, ni con el disclosure al inicio o en jerga legal.
- **Nunca rellena un corchete** del Bloque C.
- **Nunca presenta un código o un link como existente** hasta que Zoho lo cree: el propuesto va
  marcado y el kit sale NO ENVIABLE. Nunca inventa un dato de pago ni lo pide por el kit.
- **Nunca incluye nombre, teléfono ni correo de un tercero** en el output.
- **Nunca envía nada**: termina en un archivo para aprobación humana.

## Fundamentos

- **Lo anunciado obliga** (Ley 1480, art. 29): prometer una comisión que no está en un documento
  firmado expone a Viventa, y la SIC ya sancionó a una constructora aliada por publicidad engañosa
  con responsabilidad objetiva.
- **Reg Z / 12 CFR 1026.24**: mencionar tasa, cuota, plazo o cuota inicial en publicidad de crédito
  obliga a divulgar todos los términos, y un disclaimer no lo cura. El ICP vive en EE. UU.
- **FTC, 16 CFR §255.5**: la comisión es una conexión material y se declara; el anunciante también
  responde. Nadie asume que un conocido cobra por un WhatsApp, así que no hay safe harbor.
- **Ley 1581 de 2012**: el conocido es titular de sus datos y la carga de la prueba es de Viventa.
  Por eso el link (se registra y autoriza solo) y el aviso previo del correo.
- **Autoría percibida** (Kirk & Givi, *Journal of Business Research*, 2024): cuando un mensaje
  *parece* hecho por IA cae el boca a boca, sobre todo en contenido emocional y mucho menos cuando la
  IA edita en vez de generar. De ahí los mensajes factuales y los corchetes.
- **Pagos**: el programa hoy se atrasa en pagar. Lo que mata a un referidor no es el retraso sino el
  retraso no avisado; el bloque CUÁNDO TE PAGAMOS y el Bloque D existen por eso.

Detalle y enlaces en `references/fuentes.md`; los 13 errores típicos con su antídoto en
`references/anti-patterns.md`.

## Output esperado

Un markdown plano, copiable a Google Docs, Canva o Wati, en
`salidas/viventa-kit-referidor/<AAAA-MM-DD>-<codigo>.md`:

````markdown
{si aplica: 🚫 KIT NO ENVIABLE — …}
# Kit de activación — {Nombre} · {Ciudad}, {País} · Código {CÓDIGO}

## Bloque A — Texto del flyer
TITULAR / BAJADA / BENEFICIO / CÓDIGO / CTA / PIE LEGAL

## Bloque B — Correo de bienvenida
Asunto · saludo · CÓMO FUNCIONA · CUÁNDO TE PAGAMOS · DOS COSAS IMPORTANTES · firma

## Bloque C — 3 mensajes reenviables (voz de {Nombre})
> Los corchetes van vacíos a propósito: llenarlos es trabajo de {Nombre}.
Mensaje 1 — al que ya te preguntó · Mensaje 2 — frío pero cercano · Mensaje 3 — para grupo ({público})

## Bloque D — Antes de enviar este kit
{checklist del paso 6}

## Bloque E — Alta operativa
Código propuesto: {CÓDIGO} (propuesto — no existe hasta que Zoho lo cree)
Link con seguimiento: {URL base}?ref={CÓDIGO}&utm_source=referidor-pro&utm_medium=referido&utm_campaign={CÓDIGO}
Pedido a Zoho: {texto listo para pegar}
Pedido a comercial (regla de asignación): {texto listo para pegar}
Tarea de seguimiento: {fecha alta + 30 días} — revisar registros, cierres y tarea de pago del código
````

Ejemplo de mensaje 1 bien hecho (referidora ficticia, cliente que ya compró):

> Ome, acordate que me preguntaste lo del apartamento en Colombia. Yo hice el proceso con Viventa,
> [LO QUE MÁS TE SIRVIÓ A VOS]. Si querés te paso el link, mirá que ellos te dicen de una si te sirve
> o no. Te aviso que estoy en el programa de referidos de ellos y me dan algo si cierra, pero igual te lo diría.

Al terminar, decí: *"Kit listo en `<ruta>`. {Enviable / NO ENVIABLE: falta X}. Los pedidos a Zoho y
a comercial están en el Bloque E; los corchetes del Bloque C los llena {Nombre}."*

## Skills relacionados

- **Después:** `viventa-ciclo-referidor`, para la parrilla mensual, la reactivación y el correo de
  resultados del referidor ya activo; `viventa-conciliacion-referidos` cuando sus referidos cierran y
  hay que verificar el pago; `viventa-mapa-crm` si la regla o el campo de seguimiento no existen en Zoho.
- **En vez de este:** `advocate` cuando el programa es de embajadores sin comisión;
  `escribir-en-mi-voz` si lo que hace falta es un perfil de voz de una persona y no un kit.
- **Relacionado:** `viventa-caso-exito`, si el referidor es un cliente cuya historia puede volverse
  prueba social con su autorización.
