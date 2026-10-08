---
name: viventa-brief-requerimiento
description: >-
  Convierte cualquier solicitud suelta que NO es evento —campaña de ads, kit comercial,
  landing, presentación, impreso— en una de dos cosas: el brief de 1 página listo para
  producir, o el mensaje de máximo 5 preguntas bloqueantes para reenviarle al solicitante
  tal cual por WhatsApp. Nunca inventa el objetivo: o pasa el test, o devuelve la pelota.
metadata:
  version: "1.0.0"
  domain: "process"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# viventa-brief-requerimiento

Toma una solicitud como llega en la vida real —un mensaje de WhatsApp, un correo, un audio
transcrito— y **fuerza una decisión antes de que Alejandra toque Figma**: o el requerimiento está
lo bastante definido para arrancar, o el output es el mensaje que devuelve la pelota.

**No hay tercera opción. Rellenar el hueco no es una opción.**

Este skill **no aprueba, no prioriza, no compromete fechas del equipo y nunca propone el
objetivo**. Termina en un documento de 1 página para que un humano decida.

**Una sola pasada.** Sin WebSearch, sin research externo, sin loops, sin repreguntar en el chat.
Todo sale del texto de la solicitud + `CONTEXT.md` + `references/cifras-canonicas.md`.

**Alcance:** todo lo que **no es evento**. Si la solicitud es de un evento (Open House,
ExpoColombia, Expo Casa, Viventa Más Cerca de Ti), responde una línea —
*"Esto es evento: va por `viventa-brief-evento`"* — y **para ahí**. No calcules metas por
ejecutiva ni apliques la regla de 45 días: eso vive en el skill hermano.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **El skill nunca propone el objetivo.** Sin evidencia en el texto de la solicitud, se
   pregunta, no se completa. Este es el punto entero del skill.
2. **Trazabilidad total.** Cada línea del brief se traza a la solicitud original, o lleva
   `[SUPUESTO: base]`, o lleva `[FALTA]`. **Cero afirmaciones huérfanas.**
3. **MODO A o MODO B, jamás híbrido.** Se declara en la primera línea del output.
4. **Máximo 1 página** (~50 líneas). MODO B: ≤ 25 líneas.
5. **Máximo 5 preguntas bloqueantes** en MODO B, + máximo 3 "ayudan pero no bloquean".
6. **El silencio no aprueba.** Nunca propongas auto-aprobación por vencimiento de plazo.
7. **Nunca tasa, cuota ni plazo de crédito** en la pieza (Reg Z). Nunca prometer aprobación de
   crédito ni valorización. Precios y condiciones **se copian de la fuente o se marcan
   `[FALTA]`** — jamás se estiman.
8. **CPL = costo por lead. CAC = costo por cierre.** Nunca en el mismo número. Conversión a
   desembolso **[cifra interna]** ≠ conversión a pago de Servicio Viventa **[cifra interna]**; no se suman. El **+42%**
   es participación del segmento no residentes, no crecimiento de mercado. Ticket SV = **USD 480**.
9. **La fecha de entrega la confirma Alejandra.** El skill propone ruta crítica, nunca compromete
   fecha ni asigna prioridad frente a la cola.
10. **Español de Colombia, tuteo.** Frases cortas, cordial sin rodeos, sin jerga. El MODO B se
    pega en WhatsApp sin editar una coma.
11. **Cero PII.** Se trabaja con el texto de la solicitud; no se accede ni se exporta data de
    clientes.
12. Los `[⚠ no verificado]` **sobreviven en el output**: plazos SLA, orden de aprobadores y topes
    numéricos necesitan ratificación de Alejandra, Daniel y Lizeth.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| Texto de la solicitud (WhatsApp, correo, nota, transcripción) | **Sí** | Pide el texto crudo y para. Sin solicitud no hay skill. |
| Quién la envía y su área | No | `[FALTA — no bloquea]` en la cabecera; entra como pregunta opcional en MODO B. |
| Fecha en que se recibió | No | Usa la fecha de hoy y márcala `[SUPUESTO: fecha de ejecución]`. |
| Piezas o campañas previas equivalentes | No | Sin precedente citable no se puede asumir ningún P0 (ver §Regla de corte). |

No pidas nada más por chat. Todo lo que falte se resuelve **dentro del output**.

---

## Fase 1 — Clasificar y extraer literal

1. **¿Es evento?** Si sí → redirige a `viventa-brief-evento` y para.
2. **Detecta el tipo** (uno solo): campaña de ads (40% de la carga) · material comercial y
   presentaciones (25%) · landing (20%) · impreso (15%). Los campos extra por tipo están en
   `references/campos-por-tipo.md` — **carga solo el bloque del tipo detectado**. Preguntar los
   campos de los otros tres es burocracia y mata la adopción.
3. **Extrae literalmente** lo que dice la solicitud: qué pide, para quién, para cuándo, dónde se
   usa, con qué números. Anota entre comillas lo que es cita textual. Lo que no está escrito
   **no existe** — no lo infieras en esta fase.

---

## Fase 2 — Test del objetivo (bloqueante, corre siempre)

Toma la frase que el solicitante ofrece como objetivo y pásale las 4 preguntas:

| # | Pregunta | Si es "no" |
|---|---|---|
| 1 | ¿Tiene **número**? | No es objetivo |
| 2 | ¿Tiene **fecha o ventana**? | No es objetivo |
| 3 | ¿El número es de **negocio** (leads, registros, asesorías, pagos de SV, cierres) y no de **producción** (piezas, publicaciones, views)? | Es un entregable disfrazado |
| 4 | ¿Se puede **fallar**? ¿Existe un resultado que cuente como "no funcionó"? | Es un deseo |

**Test de negación (el más rápido):** si duplicáramos esto, ¿la empresa gana algo medible?
"Duplicar el reel" no gana nada. "Duplicar 300 leads a USD 40 de CPL" sí.

Ojo con los tres niveles que se confunden: objetivo de **negocio** (qué necesita la empresa) →
objetivo de **marketing** (qué tiene que hacer la persona) → objetivo de **comunicación** (qué
tiene que pensar o sentir). Copiar el de comunicación como si fuera el de negocio es el error
clásico. "Que la gente sepa que existe Vive Casas" es un *mensaje*, no un objetivo.

Tabla de calibración con ejemplos reales de Viventa: `references/calibracion-objetivo.md`.

> **Si falla cualquiera de las 4 → MODO B. Sin excepción. No se propone un objetivo sustituto.**

---

## Fase 3 — Regla de corte (algoritmo cerrado, sin interpretación)

**Los cinco P0:**
1. Objetivo de negocio que pase el test de la Fase 2
2. Audiencia: a quién le habla + sub-segmento del ICP
3. Entregables con cantidad y formato
4. Canal o uso: dónde se publica o se usa
5. Aprobador designado del paso 1 (contenido)

```
SI el objetivo falla el test de 4 preguntas
   → MODO B. Sin excepción. No se propone objetivo.

SI faltan 2 o más de los P0 restantes (2 a 5)
   → MODO B.

SI falta exactamente 1 de los P0 restantes
   Y existe precedente documentado y citable
     (pieza anterior equivalente · regla de CONTEXT.md · dato canónico)
   → MODO A, con ese campo marcado [SUPUESTO: base]
     + la línea "Confirmar antes de producir".
   SI NO hay precedente citable → MODO B.

SI los cinco P0 están
   → MODO A. Los P1 faltantes van como [SUPUESTO: base]
     o [FALTA — no bloquea].
```

**Qué se puede asumir (P1), solo con base citable:** fecha de entrega (`[SUPUESTO]` siempre, la
confirma Alejandra) · aprobadores 2 a 4 (Daniel para marca; Crédito si hay claim financiero;
Lizeth si hay pauta) · moneda (se deriva del país: USD para USA, EUR para España — no se producen
las dos) · tono y guardarraíles de marca (están en el manual) · relación de aspecto por canal ·
referencias visuales.

**Qué no se asume jamás:** el objetivo · el presupuesto de pauta · precios, cuotas, tasas y
condiciones de proyecto · la fecha comprometida de entrega · la prioridad frente a la cola.

---

## Fase 4A — MODO A: el brief

Plantilla exacta. Borra las secciones que no cambian lo que Alejandra va a hacer. **Nada de
contexto de mercado.** Sin placeholders tipo `[nombre del producto]`: en MODO A todo el texto es
copiable tal cual.

```markdown
# BRIEF — {tipo} · {nombre corto}
Solicitante: {nombre} ({área}) · Recibido: {fecha} · Necesidad: {fecha}
Tipo: {campaña de ads | material comercial | landing | impreso} · Estado: COMPLETO — se puede arrancar

## 1. Objetivo de negocio
{Número + ventana de fechas, tal como lo dijo el solicitante.}
{Si aplica: etiqueta CPL como costo por lead, no CAC.}
Traducción a negocio: {cálculo con conversión canónica} [SUPUESTO: promedio del área, confirmar]

## 2. Audiencia
{Quién, dónde, ingresos, situación. Bloqueo real que tiene hoy.}
Sub-segmento del ICP: {…}

## 3. Mensaje principal (uno solo)
{Una sola frase. Sin comas que unan ideas, sin listas. Si necesita un "y", no está destilado.}
Prueba: {20 años · 5 bancos · oficinas en USA, España y Colombia · lo que aplique}
NO decir: {claims prohibidos del caso} — sin visto bueno del área de Crédito.

## 4. Entregables y especificaciones
| Pieza | Cantidad | Formato | Canal |
|---|---|---|---|
| … | … | … | … |
{Campos extra del tipo detectado — solo los de ese tipo.}
Moneda de las cifras en pieza: {USD | EUR, derivada del país}.

## 5. Aprobadores (secuencial, un dueño por paso)
1. Contenido, oferta y datos del producto — {solicitante} · 24 h hábiles
2. Marca, tono y palabras prohibidas — Daniel Vélez · 24 h hábiles
3. Claims financieros (cuota, tasa, "calificas") — área de Crédito · 48 h hábiles  {solo si aplica}
4. Presupuesto — Lizeth / dirección financiera · 48 h hábiles  {solo si hay pauta}
Consolidador único de observaciones: {solicitante}. Canal único: el hilo de este brief.
Máximo 2 rondas de revisión.
Congelamiento: aprobado el paso 2, todo cambio de texto, imagen o lineamiento entra como
SOLICITUD NUEVA, no como observación.
Si un aprobador no responde en su plazo: la entrega se corre 1 día hábil por cada día de
silencio y se escala a {gerente del área}. El silencio NO aprueba.
[⚠ no verificado] Plazos y orden pendientes de ratificar por Alejandra, Daniel y Lizeth.

## 6. Fechas
Necesidad declarada: {fecha}. Ruta crítica: {n} aprobaciones (hasta {n} días hábiles) + producción.
⚠ La fecha de entrega la confirma Alejandra — este brief no la compromete ni asigna prioridad.

## 7. Referencias
{Piezas previas citables · playbook · manual de marca. Solo lo que existe.}
```

**Los 7 mecanismos de la sección 5 van completos, siempre:** secuencial (nunca en paralelo) · un
dueño por paso · plazo por paso · consolidador único · canal único · tope de 2 rondas +
congelamiento post-aprobación de marca · consecuencia del silencio que **no es aprobación**.
Detalle y fundamento: `references/aprobadores.md`.

Los pasos 3 y 4 **solo se activan si aplican**. Meterlos siempre es burocracia.

---

## Fase 4B — MODO B: los bloqueantes

Estructura fija: dos líneas de diagnóstico interno, luego el corte, luego el mensaje enviable.

```markdown
# NO SE PUEDE ARRANCAR — faltan {n} datos bloqueantes
Solicitud de: {nombre} · Recibida: {fecha} · Tipo detectado: {tipo}

Lo que sí quedó claro: {lo que el solicitante sí definió}.
Eso es el ENTREGABLE. Todavía no tenemos el OBJETIVO, y sin objetivo la pieza se produce dos veces.

--- copiar y enviar de acá para abajo ---

Hola {nombre}, para arrancar con {lo que pidió} necesito {n} cosas.
Con eso te tengo el brief hoy mismo:

1. {Pregunta del objetivo — siempre primera si el objetivo falla.}
   Por ejemplo: "{ejemplo real del mundo Viventa}" o "{segundo ejemplo}".

2. {Pregunta derivada de lo que falta en ESTA solicitud, con ejemplo concreto.}

3. {…}

Dos que me ayudan pero no bloquean, si las tienes:
· {opcional}
· {opcional}

Quedo atento. Apenas me confirmes el punto 1 te mando el brief.
```

Reglas del MODO B:
- **La primera pregunta siempre es la del objetivo** si el objetivo falla el test.
- Cada pregunta trae **un ejemplo de respuesta válida del mundo Viventa** ("que 80 personas
  agenden asesoría antes del 15 de septiembre", "que las 12 consultoras de Madrid cierren 5
  Servicios Viventa este mes usando la presentación").
- Preguntas **derivadas de esta solicitud**, nunca un checklist genérico. "¿Cuál es tu público
  objetivo? ¿Cuál es tu presupuesto? ¿Cuáles son tus KPIs?" es exactamente lo que el comercial
  ignora.
- Si salen más de 5 bloqueantes, escoge las 5 que de verdad impiden arrancar y menciona el resto
  en **una sola línea**.

---

## Ejemplo real (recortado)

*Solicitud:* «Lizzie, hágame una campaña para el kit comercial. Un video, un reel y ya.»

Objetivo: no hay número, no hay fecha, "un video y un reel" es producción, no se puede fallar.
Falla las 4 → **MODO B**, sin discusión.

```markdown
# NO SE PUEDE ARRANCAR — faltan 3 datos bloqueantes
Solicitud de: Andrés · Recibida: 6-ago · Tipo detectado: material comercial

Lo que sí quedó claro: quieres un video y un reel para el kit comercial.
Eso es el ENTREGABLE. Todavía no tenemos el OBJETIVO, y sin objetivo la pieza se produce dos veces.

--- copiar y enviar de acá para abajo ---

Hola Andrés, para arrancar con el video y el reel necesito tres cosas.
Con eso te tengo el brief hoy mismo:

1. ¿Qué tiene que pasar después de que alguien vea la pieza? Dime el número y la fecha.
   Por ejemplo: "que 80 personas agenden asesoría antes del 15 de septiembre" o
   "que las 12 consultoras de Madrid la usen en visita para cerrar 5 Servicios Viventa este mes".

2. ¿Para quién es exactamente? ¿La ve el cliente final, o la usa la consultora en una reunión?
   Y si es cliente final: ¿de qué país y en qué momento está (apenas averiguando, o ya con
   crédito preaprobado)?

3. ¿Dónde se publica o se usa? WhatsApp, Instagram, correo, o la consultora la muestra en el
   celular. De eso depende el formato y la duración.

Dos que me ayudan pero no bloquean, si las tienes:
· ¿Para cuándo la necesitas y por qué esa fecha?
· ¿Alguien más tiene que dar visto bueno además de Daniel?

Quedo atento. Apenas me confirmes el punto 1 te mando el brief.
```

Contraejemplo completo en MODO A (campaña Meta, Vive Casas Florida):
`references/ejemplo-modo-a.md`.

**Prueba de fuego:** dale al skill esta misma solicitud. Si produce un brief en vez de preguntas,
el skill está roto — sin importar qué tan bien escrito esté el brief.

---

## Fase 5 — Autovalidación (todas, o el output no sale)

**Estructura**
- [ ] Cabe en 1 página (~50 líneas). MODO B ≤ 25 líneas.
- [ ] Es MODO A **o** MODO B, nunca híbrido, y lo declara en la primera línea.
- [ ] Todo el texto es copiable y pegable. Sin placeholders en un MODO A.

**Contenido**
- [ ] **Trazabilidad total:** cada afirmación está en la solicitud, o lleva `[SUPUESTO: base]`, o
      lleva `[FALTA]`. Cero afirmaciones huérfanas. *Este es el criterio que más importa.*
- [ ] El objetivo del MODO A pasa las 4 preguntas. Si no, el output debió ser MODO B.
- [ ] La sección de aprobadores tiene los 7 mecanismos. Los 7, no cinco.
- [ ] Los campos extra corresponden al tipo detectado y no a los otros tres.
- [ ] CPL etiquetado como costo por lead, CAC como costo por cierre, sin mezclar. [cifra interna] separado
      de [cifra interna].
- [ ] Ningún precio, cuota o tasa inventado. Ninguna promesa de aprobación de crédito ni de
      valorización.
- [ ] Ninguna fecha de entrega comprometida sin "confirma Alejandra". Ninguna prioridad asignada.

**MODO B**
- [ ] Máximo 5 bloqueantes + máximo 3 opcionales.
- [ ] Cada pregunta trae un ejemplo de respuesta válida del mundo Viventa.
- [ ] Español de Colombia, tuteo, cordial, sin rodeos. Listo para WhatsApp sin editar.
- [ ] La primera pregunta es la del objetivo, si el objetivo falta.

**Operativo**
- [ ] Una sola pasada. Sin research externo. Sin loops.
- [ ] Cero PII.
- [ ] Si era evento, redirigió a `viventa-brief-evento` y paró.
- [ ] Los `[⚠ no verificado]` siguen ahí.

---

## Anti-patterns (con su antídoto)

| Falla | Antídoto |
|---|---|
| **Rellenar el hueco** — inventar el objetivo porque el modelo siempre responde | Sin evidencia en el texto → se pregunta. Validación mecánica: cada línea trazable o `[SUPUESTO: base]` |
| Brief de 4 páginas con contexto de mercado | Tope duro de 1 página. Si una sección no cambia lo que Alejandra va a hacer, se borra |
| Aceptar "quiero un reel" como objetivo | El test de 4 preguntas corre **antes** de decidir el modo, y es bloqueante |
| 12 preguntas de checklist genérico | Máx. 5, derivadas de esta solicitud, cada una con ejemplo Viventa |
| Confundir faltante con asumible | Jerarquía P0/P1/P2 aplicada mecánicamente |
| Inventar números de negocio o mezclar CPL con CAC | Solo conversiones canónicas, siempre `[SUPUESTO]` |
| Comprometer la fecha de Alejandra | Se propone ruta crítica; la fecha la confirma ella |
| Mandar la pieza a 4 aprobadores en paralelo | Secuencial siempre, un dueño por paso, consolidador único |
| "Si no responde en 48 h se da por aprobado" | Viola la regla durable #1. El silencio corre la fecha y escala, nunca aprueba |
| Estimar precios o condiciones | Se copian de la fuente o `[FALTA]` |
| Duplicar el skill de eventos | Si es evento, una línea de redirección y para |
| Flujo multi-fase con research | Una sola pasada — las cuentas de Claude son compartidas y sin créditos hasta 4 horas |
