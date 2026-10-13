---
name: viventa-reactivacion-lead
description: >-
  Redacta mensajes 1-a-1 para reabrir la conversación con un lead de Viventa que se cayó del
  proceso —formulario a medias, DM sin respuesta, comentario "info", no-show, asesor sin cierre o
  frío— con calendario de intentos y check legal; en modo lista arma la tanda del día de registros
  incompletos con el dato que falta y variantes que no se repiten. Redacta, no envía. USA cuando:
  "reactivar leads que quedaron colgados", "hay interesados que no terminaron de mandar sus datos",
  "DMs sin responder hace semanas". Es 1-a-1: viventa-comunicaciones-campana convoca a un segmento.
metadata:
  version: "1.2.0"
  domain: "convert"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# Reactivación de lead — Viventa

Escribe el mensaje que reabre una conversación caída. No vende un apartamento: baja el costo de
responder y demuestra que del otro lado hay una persona. En toda corrida preserva cuatro cosas:
**redacta y no envía**, **no pasa del tope de intentos**, **no nombra ninguna cifra financiera** y
**no afirma nada del lead que no esté en los datos que le dieron**.

Lo opera la persona más junior del equipo de Growth, así que el output se copia y se pega sin
criterio experto: nada de "ajustar según contexto". Lo que haya que decidir, lo decide el skill o
lo pregunta. Una sola pasada: sin research, sin loops, sin búsqueda web.

## Cuándo usar

- Explícito: "necesito reactivar leads que quedaron colgados", "hay gente que llenó el formulario
  a medias, ¿qué les escribo?", "quedaron DMs sin responder hace semanas", "se registraron al
  evento y no fueron, ¿les mando algo?", "escribime un WhatsApp para un lead frío que no se sienta
  automático", "tengo comentarios de 'info' en el post y nadie les respondió", "el asesor habló con
  ella y no volvió, ¿cómo la retomo?".
- Implícito: aparece en el CRM o en la bandeja de Instagram alguien que levantó la mano y quedó
  sin siguiente paso.
- **Modo lista** (tipos 1 y 2 en lote): "hay interesados que no terminaron de mandar sus datos",
  "manda el recordatorio a los clientes potenciales de Meta", "no están entrando leads nuevos",
  "reactivemos las conversaciones viejas". Ver Paso 9.
- Cadencia: por lead y por punto de abandono. El formulario a medias rinde en las primeras 1–2 h;
  revisar abandonos una vez al día pierde esa ventana: en modo lista, dos cortes al día.

## Cuándo NO usar

- **Convocar un segmento a un evento** (secuencia de 21 días) → `viventa-comunicaciones-campana`.
- **Recomendar proyectos del inventario a un lead** → `viventa-match-proyecto-lead`. Este no vende
  proyecto: reabre la conversación.
- **Reactivar a un negocio aliado que dejó de referir** → `viventa-ciclo-referidor`.
- **El lead ya contestó y hay que responderle** → `reply-handler`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Canal | El usuario | *"¿Por dónde le escribimos: WhatsApp, DM de Instagram o email?"* **Bloqueante**: sin canal no hay registro ni límite de palabras |
| Punto de abandono | El usuario o el CRM (tabla del Paso 1 en `references/mapa-abandono.md`) | *"¿Dónde se cayó? 1 formulario a medias · 2 DM o comentario que no le respondimos · 3 comentó 'info' · 4 se registró al evento y no fue · 5 habló con asesor y no volvió · 6 frío de 3+ meses."* **Bloqueante**; "genérico" no es respuesta válida |
| Intento número | El usuario o el historial del CRM | *"¿Es el primer mensaje que le mandamos por esto, el segundo o el tercero?"* Si no sabe: se asume 1 y se dice |
| País de residencia | CRM o formulario | *"¿Dónde vive: Estados Unidos, España, Colombia u otro?"* Obligatoria si el canal es email o WhatsApp. Si no se sabe → Paso 3, caso "desconocido" |
| Consentimiento registrado | CRM | Solo si reside en España o el país es desconocido: *"¿Hay consentimiento registrado para escribirle por este canal?"* Si no sabe → se trata como **no** |
| Estado y respuestas | CRM | *"¿Respondió algo, pidió baja, se quejó, o está hoy con un asesor?"* Si no sabe → se asume que no, y queda como casilla del check previo |
| Datos del contacto | CRM, formulario, hilo del DM | No bloqueante. Nombre · qué preguntó o hizo · proyecto o ciudad de interés · fecha del último contacto · para tipo 4, ciudad y fecha del evento · para tipo 5, nombre del asesor y la objeción anotada. Si falta uno: variante honesta sin ese dato y aviso *"Sin <dato>, la variante 1 pierde fuerza; si lo conseguís en el CRM se reescribe en 2 minutos."* |
| Sub-segmento | CRM o nota del asesor | No se pregunta. Si viene: sin cuota inicial ahorrada · vivienda usada / segunda compra · Puerto Rico · veterano con VA loan |
| Quién firma | `[nombre de quien firma]` y `[cargo de quien firma]` | Si la config no está resuelta: *"¿Con qué nombre y cargo firma el mensaje?"* Nunca "el equipo de Viventa" |
| Dirección física (pie de email) | `references/cifras-canonicas.md` | Solo para email: *"¿Qué dirección física va en el pie del correo?"* Sin dirección el email no se entrega (CAN-SPAM) |
| Modo lista: export de interesados incompletos | Meta Business Suite (clientes potenciales y bandeja), formulario de registro o CRM | *"Exporta los interesados que empezaron y no terminaron, con nombre de pila, canal, país, fecha y los campos que sí dejaron."* **Bloquea** el modo lista |
| Modo lista: campos obligatorios del registro | El formulario de registro | Solo la primera vez: *"¿Qué campos son obligatorios para que el registro cuente como lead?"* Se guarda junto al historial |

Nunca se pide ni se guarda el teléfono o el email del lead: el mensaje se pega en la herramienta que
ya los tiene.

## Workflow

### Paso 1 — Recogé los inputs e identificá el punto de abandono

Preguntá en una sola tanda lo que falte de la tabla. Si el usuario no sabe el tipo, usá la tabla
"Cómo identificar el punto de abandono en el CRM" de `references/mapa-abandono.md`.

### Paso 2 — Chequeá parada y tope antes de escribir

**Señales de parada** (anulan el conteo; no se redacta mensaje comercial y se le dice al usuario
por qué): cualquier "no", incluso ambiguo ("ahora no", "después miro"); pedido de baja, bloqueo,
marca de spam o pulgar abajo en WhatsApp; visto sostenido después de dos mensajes; queja pública o en DM; lead activo hoy con un asesor
(manda el CRM, no se duplica contacto).

**Tope por tipo** — decisión de diseño de Viventa, deliberadamente por debajo de los 5–7 toques
que recomiendan los benchmarks de B2B:

| Tipo | Tope | Qué se hace con el intento pedido |
|---|---|---|
| 1, 4, 5 | 3 intentos en 12 días | 1 → Pain · 2 → Plan o Proof · 3 → salida digna. Intento 4+ → negarse y explicar el tope |
| 2 | La respuesta pendiente **no cuenta** como intento | Responder siempre, sin importar cuánto pasó. El conteo de 3 arranca en el primer mensaje que Viventa inicia después |
| 3 | 2 intentos | 1 → ubicar (Plan) · 2 → prueba + salida digna, sin pregunta. Intento 3+ → negarse |
| 6 | 1 mensaje por trimestre | Solo permission reset. Si ya hubo uno en los últimos 3 meses → negarse |

- **Borde de los 12 días**: si pasaron más de 12 días desde el intento 1 sin respuesta, no se
  reinicia la secuencia: el intento que falte se reemplaza por la salida digna y ahí termina.
  Heurística propia, ajustable solo con aprobación de Growth.
- Después de la salida digna el lead pasa a nurture de baja frecuencia (tipo 6). No se borra, no se
  persigue.
- **Por qué 3 y no 7**: el dominio de email ya cae en spam y la base comparte reputación; WhatsApp
  castiga bloqueos con quality rating y suspensión; y la queja registrada del cliente es *"te
  saturan"*. Si alguien pide subir el número, mostrale este párrafo.

### Paso 3 — Aplicá el piso legal por residencia × canal

Tabla completa y fuentes en `references/piso-legal.md`. Lo que decide el Paso 3:

| Reside en | Canal | Decisión |
|---|---|---|
| USA | Email | Se redacta. Pie obligatorio: dirección física + baja en 1 clic |
| USA | WhatsApp | Se redacta, con la advertencia: *"Requiere opt-in; fuera de la ventana de 24 h solo con plantilla aprobada. Hoy el envío a USA está bloqueado."* Nunca afirmar que se puede enviar ya |
| USA / cualquiera | DM de IG | Se redacta. Sin links en DM frío |
| España | Email o WhatsApp, **con** consentimiento registrado | Se redacta normal |
| España | Email o WhatsApp, **sin** consentimiento (o no se sabe) | **Se detiene.** No hay mensaje comercial. Se entrega la advertencia *"Lead en España sin consentimiento registrado — no se puede enviar comunicación comercial (LSSI art. 21)"* y, si hay trazabilidad del origen del dato, el mensaje de re-consentimiento (6-B de `banco-mensajes.md`); si no la hay, la recomendación de no contactar |
| Desconocido | Email o WhatsApp | Se redacta, y el check previo lleva activada la casilla de España: no se envía hasta confirmar que no reside allá o que hay consentimiento |
| Colombia / otros | Email | Se redacta con el estándar de USA (el más alto que aplica sin consentimiento) |

Tipo 2 por DM (la persona escribió primero) no requiere consentimiento adicional en ningún país.

### Paso 4 — Elegí el ángulo por punto de abandono y sub-segmento

| Tipo | Qué debe hacer el mensaje | Ventana del intento 1 |
|---|---|---|
| 1 · Formulario a medias | Quitar la culpa y ofrecer terminarlo por la persona. No re-vender | 1–2 h |
| 2 · DM sin respuesta | Reparar primero (una frase, sin excusas), responder lo que preguntó, recién ahí la pregunta. Si no se sabe qué preguntó, decirlo y dar 3 opciones | Inmediato |
| 3 · Comentario "info" | Calificar, no vender: una pregunta de opción múltiple (máx. 3 opciones). Sin link | 24 h |
| 4 · No-show | Nombrar la ciudad del evento y algo concreto que se resolvió ahí; ofrecer la alternativa remota. Nunca reproche | 24–48 h post-evento |
| 5 · Asesor sin cierre | Retomar la objeción anotada. Si no hay nota, preguntarla derecho: *"¿qué fue lo que te frenó?"* | 7 días desde el último contacto |
| 6 · Frío | Permission reset: de dónde salió el contacto + si quiere seguir recibiendo + baja visible | 1 por trimestre |

Las ventanas son las del diseño original del skill: heurística, no medida en Viventa.

Los intentos siguientes usan las **4 P** en orden: intento 1 **Pain** (el hecho concreto, en el
mismo canal donde abandonó) · intento 2, día 2–5, **Plan** o **Proof** (ángulo nuevo, puede
cambiar de canal; Proof con testimonio solo si hay un caso 🟢 de `viventa-caso-exito` —los verbatims del VOC no tienen consentimiento—, si no, prueba concreta) · intento 3, día 7–12, **Philosophy** (salida digna, sin pregunta). El
sub-segmento cambia el ángulo, nunca la estructura: ✅/❌ por sub-segmento en
`references/mapa-abandono.md` y `references/banco-mensajes.md`.

Hechos que sí dan concreción (fuente: `references/contexto-viventa.md`): 20 años, 5 bancos y ~20
constructoras, oficinas físicas en EE. UU., España y Colombia, el nombre del proyecto por el que
preguntó, la ciudad y fecha del evento. Tasa, cuota y plazo los da el asesor en llamada.

### Paso 5 — Decidí qué 3 variantes van

- **Intento 1 (tipos 1, 4, 5)**: las 3 son la secuencia completa — intento 1, 2 y 3.
- **Intento 2**: dos variantes del intento 2 (una Plan, una Proof) + la salida digna.
- **Intento 3**: una sola variante, la salida digna. Se dice que es una.
- **Tipo 2**: la reparación con contexto, la versión sin contexto, y el primer intento que Viventa
  inicia si no responde (día 4).
- **Tipo 3**: intento 1, una alternativa del intento 1 y el intento 2.
- **Tipo 6**: un solo mensaje de permission reset (más el de re-consentimiento si aplica España).

Test de distinción: si al quitarles el saludo dos variantes se pueden intercambiar sin que su ficha
deje de ser cierta, son la misma → se rehace una.

### Paso 6 — Redactá con el registro del canal

| | WhatsApp | DM de Instagram | Email |
|---|---|---|---|
| Extensión | ≤40 palabras, 2–3 frases | ≤40 palabras, 1–3 frases | 80–150 palabras de cuerpo |
| Saludo | Nombre + quién sos (la 1ª vez) | Nombre + quién sos, siempre | Nombre de pila |
| Estructura | Hecho → pregunta | Hecho → pregunta | Asunto (≤45 caracteres, sin "urgente" ni "gratis") → preheader → hecho → contexto → pregunta → firma → pie legal |
| Emojis | Ninguno o uno que sustituya una palabra | Máximo uno | Ninguno |
| Enlaces | Ninguno en el 1er mensaje | Ninguno | Uno solo, más el de baja |
| Pregunta | Una, binaria | Una, binaria o de 3 opciones | Una, al final |

Cercanía es una propiedad chequeable, no un tono:

1. **Arrancá por el hecho** que solo aplica a esa persona ("vi que empezaste tu registro y quedó a
   medias"). Si el primer verbo es *"quería"*, *"escribo para"* o *"me comunico"*, reescribí.
2. **Si no tenés el hecho, decilo**: *"no quiero responderte cualquier cosa"*.
3. **Firma humana**: nombre y cargo de la fila "Quién firma", y una vía de respuesta que llega a
   esa persona.
4. **Sacá los delatores de plantilla**: "solo quería hacer seguimiento", "espero que te encuentres
   bien", "estimado/a", "no dude en contactarnos", "en Viventa nos complace…", "soluciones
   integrales", "aliado estratégico", "asesoría personalizada". Reemplazo: el hecho, el nombre de
   pila, una pregunta binaria.
5. **Pregunta final respondible con una palabra**: ✅ "¿Te lo dejo listo yo o preferís hacerlo
   vos?" ❌ "¿Cuál es tu presupuesto y en qué ciudad buscás?" (formulario disfrazado).
6. **Español de Colombia**: tuteo, "vos" aceptable en registro paisa, "acá", "te cuento", "con
   gusto". Tampoco "vosotros" para un lead en Madrid: el lead es colombiano.

Calibrá contra los mensajes aprobados de `references/banco-mensajes.md`: cuando el caso coincide,
se cambia solo el hecho concreto. En esos ejemplos la firmante y los leads son nombres ficticios;
en el output va el nombre de la fila "Quién firma" y el del lead si existe.

### Paso 7 — Armá la ficha y el check previo

Ficha literal por variante:

```
VARIANTE N — <ángulo> (P: Pain / Plan / Proof / Philosophy)
Punto de abandono: <tipo 1-6>
Intento y cuándo enviarla: <intento N · momento del Paso 4>
Qué debe saberse antes de enviar: <dato mínimo; si falta, qué variante usar>
Texto: <mensaje literal; en email con Asunto y Preheader primero>
Conteo: <N palabras>
```

Y siempre, al final:

```
CHECK PREVIO AL ENVÍO
[ ] Ningún mensaje menciona tasa, cuota, plazo, cuota inicial ni cargo financiero
[ ] Ningún mensaje promete aprobación
[ ] Cada dato personalizado existe en el CRM — si no, usar la variante sin dato
[ ] El lead no respondió "no", no pidió baja y no está activo con un asesor
[ ] Este contacto no supera el tope de su tipo
[ ] Email: pie con dirección física + baja en 1 clic
[ ] Si reside en España o no se sabe: hay consentimiento registrado (si no, NO enviar)
[ ] WhatsApp a USA: el envío está habilitado hoy
[ ] Revisión humana del aprobador de Growth antes de salir
```

### Paso 8 — Autovalidá y entregá

Antes de mostrar, pasá cada variante por las Reglas duras (conteo de palabras declarado, una sola
pregunta salvo en la salida digna, cero placeholders de lead, variantes distintas, punto de
abandono declarado). Prueba final: leela en voz alta; si suena a empresa, reescribila.

Guardá el entregable (Output esperado) y cerrá con la frase de entrega.

### Paso 9 — Modo lista: la tanda del día de registros incompletos

Se usa para los tipos 1 y 2 cuando son muchos a la vez. Todo lo anterior sigue valiendo por persona
(parada, tope, piso legal, registro del canal); esto agrega lo de volumen:

1. **Leé el historial** de `salidas/viventa-reactivacion-lead/historial.csv`
   (ID, fecha, intento, variante usada). Sin historial, todos son intento 1.
2. **Detectá el dato que falta** de cada interesado contra los campos obligatorios del registro
   (por ejemplo país, ciudad de interés, propósito, forma de contacto). Si falta más de uno, se pide
   **solo el más importante**: un mensaje, un dato.
3. **Filtrá**: fuera los que tienen señal de parada, los que superan el tope, los que están con un
   asesor y los de España sin consentimiento (van a la sección "no contactar" con el motivo).
4. **Armá o actualizá el banco de variantes** en `banco-variantes.md`: de 10 a 15 variantes por
   situación (dato que falta × canal × país), todas dentro del registro del Paso 6. El banco es
   interno: sus `{campos}` nunca se pegan sin resolver.
5. **Asigná a cada persona una variante resuelta** (con su nombre de pila y su dato concreto), sin
   repetir variante dentro de la misma tanda para la misma situación y sin repetirle a nadie una
   variante que ya recibió.
6. **Ordená la lista** por ventana: primero los de menos de 2 horas, después los del día, al final
   los de días anteriores dentro del tope.
7. **Actualizá el historial** con lo que se propuso enviar (marcado `propuesto`; la persona que
   envía lo pasa a `enviado`).

## Reglas duras

| # | Nunca | Ejemplo |
|---|---|---|
| R1 | Menciona tasa, interés, %, cuota, mensualidad, plazo, años para pagar, cuota inicial, pago inicial o cargo financiero. Activa los *triggering terms* de Reg Z (12 CFR 1026.24), que obligan a divulgar APR con igual prominencia; un disclaimer no lo cura. Si el usuario pide incluirlos, el skill se niega y ofrece *"eso te lo explica una asesora en la llamada"* | ✅ "20 años, oficina en Miami" · ❌ "cuotas desde 800.000 al mes" |
| R2 | Promete aprobación | ✅ "se revisa", "existe un programa que se estudia caso a caso" · ❌ "calificás", "te aprueban" |
| R3 | Pasa de 40 palabras en WhatsApp o DM, ni hace más de una pregunta (al final, respondible con una palabra). Heurística propia de lectura en teléfono | — |
| R4 | Afirma un dato del lead que no vino en los inputs, ni infiere intención | ✅ "me quedó tu mensaje pendiente" · ❌ "vi que estabas muy interesado en invertir en Medellín" con solo un email a medias |
| R5 | Supera el tope de intentos de su tipo (Paso 2) ni escribe tras una señal de parada | — |
| R6 | Inventa urgencia o escasez ("últimos cupos", "solo hoy"). Solo plazos reales y verificables. La FTC persigue *False Limited Time* y *False Low Stock Message* bajo la Sección 5 | ✅ "el evento es el sábado 14 en <dirección>" · ❌ "quedan pocos cupos" |
| R7 | Usa emojis decorativos. Máximo uno si sustituye una palabra; ninguno en email | — |
| R8 | Escribe con "usted", "estimado", jerga corporativa, mexicanismos ("ahorita", "platicamos") o argentinismos ("bárbaro", "che") | — |
| R9 | Deja un `{placeholder}` de datos del lead sin resolver. Sin nombre, va la versión que funciona igual. Única excepción: la etiqueta de baja que inserta la herramienta de email, escrita como `ENLACE DE BAJA (lo inserta la herramienta de email)` | ✅ "Hola, soy Laura de Viventa" · ❌ "Hola {nombre}", "Hola, estimado" |
| R10 | Insinúa que el VA loan financia propiedad fuera de EE.UU., ni menciona el ingreso VA como computable ante bancos colombianos (sin verificar) | ✅ "El VA loan no se puede usar para comprar fuera de Estados Unidos" |
| R11 | Envía, programa o dice "se envió", "programé", "activé el flujo". El entregable es texto + cuándo pegarlo | — |
| R12 | Redacta un mensaje comercial por email o WhatsApp a un lead en España sin consentimiento registrado | — |
| R13 | En modo lista, repite la misma variante a la misma persona, o pide más de un dato por mensaje | — |

## Output esperado

Archivo `salidas/viventa-reactivacion-lead/<AAAA-MM-DD>-tipo<N>-<canal>.md`
con:

1. **Resumen**: canal · punto de abandono · intento · país · decisiones del Paso 2 y 3 (tope,
   advertencias legales, datos que faltaron).
2. **Variantes**: 1 a 3 fichas del Paso 7, según el Paso 5.
3. **CHECK PREVIO AL ENVÍO**.

**Modo lista**: `salidas/viventa-reactivacion-lead/<AAAA-MM-DD>-lista.md` con
el resumen (cuántos, por dato faltante, por canal y país), la lista ordenada por ventana —una fila
por persona con ID, nombre de pila, canal, dato que falta, intento y el mensaje resuelto— y la
sección "no contactar" con el motivo de cada uno; más `banco-variantes.md` e `historial.csv`
actualizados.

El archivo no lleva teléfono ni email del lead. Si el Paso 2 o el 3 detuvieron la corrida, el
archivo trae solo el resumen con el motivo (y el mensaje de re-consentimiento si aplica).

El mismo contenido se muestra en la conversación. Frase de entrega: *"Listo: <N> variantes para
<canal>, punto de abandono <tipo>, intento <N>. Quedó en <ruta>. Nada se envió: pasalo por el
check y por revisión antes de pegarlo en <Wati / el DM / Zoho Campaigns>."*

## Skills relacionados

- **Antes:** `viventa-comunicaciones-campana`, que convoca al evento; sus registrados que no
  fueron son el tipo 4 de este skill.
- **Después:** `reply-handler` cuando el lead contesta; `viventa-match-proyecto-lead` cuando la
  conversación se reabrió y hay que recomendarle proyectos.
- **En vez de este:** `viventa-ciclo-referidor` si quien se enfrió es un negocio aliado, no un lead.
