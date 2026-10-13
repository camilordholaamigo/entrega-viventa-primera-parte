---
name: viventa-brief-requerimiento
description: >-
  Convierte cualquier pedido a mercadeo de Viventa —campaña 360, reel, landing, material comercial,
  impreso o pieza extra de un evento ya briefeado— en el formato único de brief: listo para producir,
  con aprobadores y plazos y cada dato con su fuente (MODO A), o el mensaje de máximo 5 preguntas
  bloqueantes (MODO B). Nunca inventa el objetivo. USA cuando: "pásame esto a brief", "comercial
  pidió un material, revisa si está completo", "¿esto es una campaña 360 o un reel?". El evento
  nuevo lo abre viventa-brief-evento.
metadata:
  version: "1.2.0"
  domain: "process"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-brief-requerimiento

Toma una solicitud como llega —un WhatsApp, un correo, un audio transcrito— y fuerza una decisión
antes de que diseño abra Figma: o el requerimiento está lo bastante definido para arrancar, o el
output es el mensaje que devuelve la pelota. No hay tercera opción. Invariantes de toda corrida:
nunca propone el objetivo, cada línea del brief se traza a la solicitud o lleva su marca, es MODO A
o MODO B y jamás un híbrido, y no compromete fechas ni prioridades del equipo.

## Cuándo usar

- Explícito: "pásame esto a brief", "me llegó esta solicitud, ¿alcanza para arrancar?", "necesito
  una campaña para el kit comercial", "hágame un video y un reel", "¿qué le falta a este
  requerimiento?", "arma el brief de la landing de {proyecto}", "qué le pregunto al comercial para
  poder arrancar", "necesitamos unos flyers para imprimir".
- Implícito: llega a Growth & Marketing un pedido de pieza o campaña sin objetivo claro.
- Cadencia: por solicitud, al recibirla.

## Cuándo NO usar

- La solicitud es **abrir un evento nuevo** (Open House, ExpoColombia, Expo Casa, Viventa Más Cerca
  de Ti) → `viventa-brief-evento`. Este skill responde una línea de redirección y para. Una **pieza
  adicional para un evento que ya tiene brief** sí va por acá, con los datos tomados de ese brief.
- Evento con aliados (constructoras, consulados, punto de activación) → `viventa-evento-aliado`, que
  después pide sus piezas por este formato.
- La campaña ya tiene brief y falta el insight, los dolores y los hooks →
  `viventa-inteligencia-campana`.
- Revisar una pieza ya producida → `viventa-qa-marca`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Texto de la solicitud (WhatsApp, correo, nota, transcripción) | El usuario lo pega | *"Pegame la solicitud tal como te llegó."* Sin texto, para |
| Quién la envía y su área | La solicitud o el usuario | No se pregunta: `[FALTA — no bloquea]` en la cabecera y pregunta opcional en MODO B |
| Fecha en que se recibió | La solicitud | No se pregunta: fecha de hoy marcada `[SUPUESTO: fecha de ejecución]` |
| Piezas o campañas previas equivalentes | El usuario, si las cita | No se pregunta: sin precedente citable no se puede asumir ningún P0 (Paso 4) |
| Reglas de marca y cifras canónicas | `references/contexto-viventa.md` y `references/cifras-canonicas.md` | No se pregunta. Si no están, las cifras de negocio del brief quedan `[FALTA]` |
| Brief del evento (si es pieza de un evento) | Salida de `viventa-brief-evento` | No se pregunta: sin él, la pieza de evento se trata como evento nuevo y se redirige |
| Hoja de datos publicables del mes | Salida de `viventa-datos-publicables` | No se pregunta: si existe, los precios y cifras se toman de ahí con su fecha de corte |

No se repregunta nada por chat: todo lo que falte se resuelve dentro del output (MODO B es,
justamente, la forma de preguntar).

## Workflow

### Paso 1 — Clasificar y extraer literal

1. ¿Es un evento nuevo? Si sí, responde *"Esto es evento: va por `viventa-brief-evento`"* y para.
   No calcules metas por ejecutiva ni la regla de 45 días. Si es una pieza para un evento con brief,
   seguí y tomá fecha, dirección, ciudad y consultoras de ese brief.
2. **¿Campaña 360 o pieza?** Si la solicitud dice "campaña" pero describe una sola pieza ("un video y
   ya"), tratala como pieza y decilo en el brief. Si no se puede saber, es una pregunta bloqueante
   de MODO B: *"¿Necesitas una campaña en varios canales o una pieza para un canal? Por ejemplo: «un
   reel para Instagram» o «campaña en Meta, correo y WhatsApp»."*
3. Detectá un solo tipo: campaña de ads · material comercial y presentaciones · landing · impreso.
   Si la solicitud mezcla dos, el tipo es el de la pieza principal y la otra va como entregable.
4. Cargá **solo** el bloque de ese tipo de `references/campos-por-tipo.md`.
5. Extraé literal qué pide, para quién, para cuándo, dónde se usa y con qué números. Las citas van
   entre comillas. Lo que no está escrito no existe.

### Paso 2 — Test del objetivo (corre siempre)

Pasá la frase que el solicitante ofrece como objetivo por 4 preguntas:

| # | Pregunta | Si es "no" |
|---|---|---|
| 1 | ¿Tiene número? | No es objetivo |
| 2 | ¿Tiene fecha o ventana? | No es objetivo |
| 3 | ¿El número es de negocio (leads, registros, asesorías, pagos de SV, cierres) y no de producción (piezas, publicaciones, views)? | Es un entregable disfrazado |
| 4 | ¿Se puede fallar? ¿Hay un resultado que cuente como "no funcionó"? | Es un deseo |

- Test rápido: si duplicáramos esto, ¿la empresa gana algo medible? "Duplicar el reel" no; "300
  leads a CPL USD 40" sí.
- Un objetivo de comunicación ("que la gente sepa que existe Vive Casas") es un mensaje, no pasa.
- Calibración con casos reales: `references/calibracion-objetivo.md`.
- **Si falla cualquiera de las 4 → MODO B.** No se propone un objetivo sustituto.

### Paso 3 — Revisar los cinco P0

1. Objetivo de negocio que pase el Paso 2.
2. Audiencia: a quién le habla + sub-segmento del ICP.
3. Entregables con cantidad y formato.
4. Canal o uso: dónde se publica o se usa.
5. Aprobador del paso 1 (contenido).

### Paso 4 — Regla de corte

```
Objetivo falla el test                         → MODO B
Faltan 2 o más de los P0 2 a 5                 → MODO B
Falta exactamente 1 P0 y hay precedente citable
  (pieza anterior equivalente · regla de CONTEXT.md · dato canónico)
                                               → MODO A, campo marcado [SUPUESTO: base] + "Confirmar antes de producir"
Falta exactamente 1 P0 sin precedente citable  → MODO B
Están los cinco                                → MODO A; los P1 faltantes van [SUPUESTO: base] o [FALTA — no bloquea]
```

- P1 asumibles solo con base citable: fecha de entrega (siempre `[SUPUESTO]`, la confirma diseño) ·
  aprobadores 2 a 4 · moneda (derivada del país: USD para USA, EUR para España; no se producen las
  dos) · tono y guardarraíles del manual · relación de aspecto por canal · referencias visuales.
- Nunca se asumen: el objetivo · el presupuesto de pauta · precios, cuotas, tasas y condiciones de
  proyecto · la fecha comprometida · la prioridad frente a la cola.

### Paso 5A — MODO A: el brief

1. Llená la plantilla de MODO A del Output esperado. Borrá lo que no cambia lo que diseño va a hacer.
   Nada de contexto de mercado. Sin placeholders: todo el texto es copiable.
2. "Traducción a negocio": cada conversión en su línea, con su nombre (desembolso / Vive Casas
   [cifra interna]; pago de Servicio Viventa [cifra interna] × USD 480), redondeada hacia abajo y marcada `[SUPUESTO]`.
3. La sección de aprobadores lleva los 7 mecanismos de `references/aprobadores.md`: secuencial · un
   dueño por paso · plazo por paso · consolidador único · canal único · tope de 2 rondas +
   congelamiento tras la aprobación de marca · el silencio corre la fecha y escala, nunca aprueba.
   Los pasos 3 (Crédito) y 4 (presupuesto) solo si aplican.
4. **Datos y fuentes** (sección 8): todo dato que va a aparecer en la pieza —precio, proyecto, fecha,
   dirección, consultora, cifra de la empresa— va en la tabla con su fuente y su fecha de corte. Si
   viene de la hoja de `viventa-datos-publicables`, se cita así. Un dato sin fuente va `[FALTA]` y,
   si es un precio o una cifra, la pieza no se produce hasta tenerlo.

### Paso 5B — MODO B: los bloqueantes

1. Dos líneas de diagnóstico interno, el corte, y el mensaje enviable (plantilla del Output).
2. Si el objetivo falla, es la pregunta 1.
3. Cada pregunta sale de lo que falta en **esta** solicitud y trae un ejemplo de respuesta válida del
   mundo Viventa ("que 80 personas agenden asesoría antes del 15 de septiembre"). Nada de "¿cuál es
   tu público objetivo? ¿cuál es tu presupuesto?".
4. Máximo 5 bloqueantes + máximo 3 opcionales. Si salen más, elegí los 5 que de verdad impiden
   arrancar y nombrá el resto en una sola línea.

### Paso 6 — Chequeo

1. La primera línea declara MODO A o MODO B.
2. MODO A ≤ ~50 líneas; MODO B ≤ 25.
3. Cada afirmación está en la solicitud, lleva `[SUPUESTO: base]` o lleva `[FALTA]`.
4. Buscá tasa, cuota, plazo, "te aprobamos", fechas comprometidas sin "la confirma diseño". Si
   aparecen, reescribí.
5. Cada dato de la sección 8 tiene fuente y fecha de corte, o `[FALTA]`.
6. Los `[⚠ no verificado]` de plazos, orden de aprobadores y adopción del formato siguen visibles.

## Reglas duras

- **Nunca propone ni completa el objetivo.** Sin evidencia en el texto, se pregunta.
- **Nunca deja una afirmación huérfana**: sin traza a la solicitud, sin `[SUPUESTO: base]` o sin
  `[FALTA]`, la línea sale.
- **Nunca entrega un híbrido** de MODO A y MODO B.
- **Nunca pasa de 5 preguntas bloqueantes** + 3 opcionales en MODO B.
- **Nunca propone auto-aprobación por silencio.** Prohibido: "si no responde en 48 h se da por
  aprobado". Permitido: "la entrega se corre 1 día hábil por cada día de silencio y se escala".
- **Nunca escribe tasa, cuota ni plazo de crédito**, ni promete aprobación o valorización. Precios y
  condiciones se copian de la fuente o se marcan `[FALTA]`.
- **Nunca mezcla CPL con CAC** ni suma [cifra interna] con [cifra interna]; el +42 % es participación del segmento no
  residentes, nunca crecimiento de mercado.
- **Nunca compromete una fecha de entrega ni asigna prioridad** frente a la cola: propone ruta
  crítica y la fecha la confirma diseño.
- **Nunca usa un dato sin fuente** en la sección 8: precio, fecha, dirección, consultora o cifra sin
  fuente va `[FALTA]`.
- **Nunca accede ni exporta datos de clientes**: trabaja solo con el texto pegado.
- **Nunca busca en internet** ni corre más de una pasada.

## Output esperado

No escribe archivos. Devuelve en la conversación uno de estos dos bloques, en markdown.

**MODO A**

```markdown
# BRIEF — {tipo} · {nombre corto}
Formato único de brief Viventa v1 [⚠ no verificado: pendiente de validación de la gerencia de Growth]
Solicitante: {rol} ({área}) · Recibido: {fecha} · Necesidad: {fecha}
Tipo: {campaña de ads | material comercial | landing | impreso} · Estado: COMPLETO — se puede arrancar

## 1. Objetivo de negocio
{Número + ventana, como lo dijo el solicitante. CPL = costo por lead, no CAC.}
Traducción a negocio: {una línea por conversión, con nombre} [SUPUESTO: promedio del área, confirmar]
## 2. Audiencia
{Quién, dónde, situación, bloqueo real} · Sub-segmento del ICP: {…}
## 3. Mensaje principal (uno solo)
{Una frase} · Prueba: {20 años · bancos aliados · oficinas en USA, España y Colombia, lo que aplique}
NO decir: {claims prohibidos del caso} — sin visto bueno de Crédito.
## 4. Entregables y especificaciones
| Pieza | Cantidad | Formato | Canal |  + campos del tipo detectado · Moneda: {USD | EUR}
## 5. Aprobadores (secuencial, un dueño por paso)
1. Contenido, oferta y datos — {solicitante} · 24 h hábiles
2. Marca, tono y palabras prohibidas — aprobador de marca · 24 h hábiles
3. Claims financieros — área de Crédito · 48 h hábiles {solo si aplica}
4. Presupuesto — gerente de Growth / dirección financiera · 48 h hábiles {solo si hay pauta}
Consolidador único · canal único: el hilo de este brief · máximo 2 rondas · congelamiento tras el paso 2
Silencio: la entrega se corre 1 día hábil por día de silencio y se escala. El silencio NO aprueba.
[⚠ no verificado] Plazos y orden pendientes de ratificar por diseño, marca y gerencia.
## 6. Fechas
Necesidad: {fecha}. Ruta crítica: {n} aprobaciones (hasta {n} días hábiles) + producción.
⚠ La fecha de entrega la confirma diseño — este brief no la compromete ni asigna prioridad.
## 7. Referencias
{Solo lo que existe y se puede citar}
## 8. Datos y fuentes
| Dato | Valor | Fuente | Corte |
{precio, proyecto, fecha, dirección, consultora, cifra… — sin fuente: [FALTA]}
```

Ejemplo completo en MODO A (campaña Meta, Vive Casas Florida): `references/ejemplo-modo-a.md`.

**MODO B**

```markdown
# NO SE PUEDE ARRANCAR — faltan {n} datos bloqueantes
Solicitud de: {nombre} · Recibida: {fecha} · Tipo detectado: {tipo}
Lo que sí quedó claro: {lo definido}. Eso es el ENTREGABLE. Todavía no tenemos el OBJETIVO.

--- copiar y enviar de acá para abajo ---
Hola {nombre}, para arrancar con {lo que pidió} necesito {n} cosas. Con eso te tengo el brief hoy mismo:
1. {Pregunta del objetivo} Por ejemplo: "{ejemplo Viventa}" o "{segundo ejemplo}".
2. {Pregunta derivada de esta solicitud, con ejemplo}
Dos que me ayudan pero no bloquean, si las tienes: · {opcional} · {opcional}
Quedo atento. Apenas me confirmes el punto 1 te mando el brief.
```

Prueba de fuego: *«hágame una campaña para el kit comercial. Un video, un reel y ya.»* No tiene
número, ni fecha, "un video y un reel" es producción y no se puede fallar → **MODO B** con tres
preguntas (qué tiene que pasar después de ver la pieza, con número y fecha · para quién exactamente
· dónde se usa). Si el skill produce un brief con esta solicitud, está roto.

Al terminar se le dice al usuario: MODO A → *"Brief completo: se puede arrancar. {n} supuestos para
confirmar antes de producir."*; MODO B → *"No alcanza para arrancar: el mensaje de abajo va tal cual
por WhatsApp."*

## Skills relacionados

- **En vez de este:** `viventa-brief-evento` para abrir un evento nuevo; `viventa-evento-aliado` para
  eventos con aliados.
- **Antes:** `viventa-datos-publicables` deja los precios y cifras del mes con su fuente.
- **Después:** `viventa-piezas-figma` arma los borradores; `viventa-inteligencia-campana` para el
  insight y los hooks de una campaña con brief;
  `viventa-ficha-proyecto` si la pieza es de un proyecto del inventario; `viventa-qa-marca` para
  revisar lo producido.
- **Referencias:** `references/campos-por-tipo.md` · `references/calibracion-objetivo.md` ·
  `references/aprobadores.md` · `references/ejemplo-modo-a.md`.
