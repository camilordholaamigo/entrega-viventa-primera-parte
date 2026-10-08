---
name: viventa-parrilla-base
description: >-
  Convierte el export agregado de la base de Zoho (candidatos y contactos) en tres cosas que hoy
  nadie produce: el conteo real por segmento cruzando fase × ciudad × tipo de inversión × rango
  de ingresos, la parrilla de comunicaciones del mes con asunto, preheader, copy y CTA ya
  redactados por segmento, y el plan de a quién se impacta y a quién no. Donde match-proyecto-lead
  resuelve un lead, este opera sobre toda la base. Planifica y redacta; no envía ni segmenta en
  la plataforma.
metadata:
  version: "1.0.0"
  domain: "convert"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-parrilla-base

Produce **la capa agregada del ciclo del lead**: qué hay en la base, cómo se agrupa, y qué se le
manda a cada grupo este mes.

**Quién lo usa:** Lizeth Henríquez (growth) y Juan Camilo Usuga (email marketing).

**La regla que gobierna todo:** este skill **planifica y redacta**. No envía, no segmenta en Zoho,
no toca la base. Termina en un documento que un humano revisa y ejecuta. Regla durable #1 del
cliente.

**Una sola pasada.** Las cuentas de Claude del cliente son compartidas y se quedan sin créditos
hasta 4 horas. Sin loops, sin research web.

---

## Por qué este skill existe

Todo lo construido hasta hoy resuelve **el caso individual**: `viventa-match-proyecto-lead`
empareja un lead con proyectos, `viventa-reactivacion-lead` reabre un lead caído,
`viventa-comunicaciones-campana` convoca a un evento. Ninguno mira la base entera.

El resultado es que las decisiones de a quién escribirle se toman de memoria. El cliente lo pidió
así: *"debe diseñar una parrilla para candidatos y contactos… análisis cuántos hay de cada
categoría y cómo los voy a impactar."*

Y hay una razón económica: **email tiene un CAC fully-loaded de [cifra interna] contra [cifra interna] de Meta y [cifra interna] de
un evento.** Con ~250K registros y ~3.000 leads/mes entrando, la palanca no es más tráfico —
es hablarle bien a quien ya está adentro.

**Pero el dominio ya cae en spam** y la base de 250K está sin limpiar. Por eso la parrilla no es
un calendario de ideas: **es un plan de volumen restringido por deliverability.** El problema
nunca fue tener 250K registros. Es escribirles a los 250K.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **Cero PII.** La base entra **agregada o anonimizada**: conteos y atributos, nunca nombres,
   correos, teléfonos ni documentos. Si el input trae PII, el skill **para**, lo dice, y pide el
   export agregado. No la procesa "con cuidado": no la procesa.
2. **El skill no accede a Zoho.** Todo entra pegado como tabla. No hay integración y no se
   simula que la haya.
3. **Ningún segmento sin conteo.** Una fila de la parrilla sin cuántas personas tiene detrás es
   una idea, no un plan. Si el conteo no está, la fila sale marcada `⛔ sin conteo` y no recibe
   volumen asignado.
4. **El techo de deliverability manda sobre la ambición.** Ninguna parrilla propone un volumen
   mensual que supere el techo calculado en la Fase 4. Si el plan deseado no cabe, se recorta el
   plan — nunca se sube el techo.
5. **Tier 3 (+180 días sin abrir) no recibe campaña.** Va a re-permiso o a Meta. Escribirle es
   lo que mantiene el dominio en spam.
6. **Cero placeholders en copy.** Asuntos, preheaders y CTA salen redactados y finales. Dato que
   falta → `⛔ INPUT REQUERIDO: {qué} → pedir a: {quién}`.
7. **Nunca tasa, cuota, plazo ni cuota inicial** (triggering terms de Reg Z). Nunca prometer
   aprobación de crédito ni "viabilidad inmediata" (MAP Rule). Nunca superlativos sobre
   condiciones ("el crédito ideal") — Ley 1480 art. 29.
8. **Español de Colombia, tuteo,** en todos los territorios.
9. **Cero cifras fuera de `references/cifras-canonicas.md`.** CPL ≠ CAC. Conversión a desembolso
   ([cifra interna]) ≠ a pago de servicio ([cifra interna]).
10. El skill **no aprueba, no publica y no envía**.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| **Export agregado de la base**: conteo por fase del funnel | **Sí — bloqueante** | **PARAR.** Sin conteos no hay parrilla, solo opiniones |
| Corte de engagement por tier (1 / 2 / 3 / 4) | **Sí — bloqueante** | **PARAR.** Es lo que define el techo de envío |
| Ciudad o país de interés, agregado | No | Se omite el eje geográfico y se declara |
| Tipo de inversión declarado (formulario CC) | No | Se omite el eje y se declara |
| Rango de ingresos declarado | No | Se omite el eje y se declara |
| Mes objetivo de la parrilla | **Sí** | Asumir el mes entrante y decirlo |
| Eventos del mes (de `viventa-brief-evento`) | No | Advertir que la parrilla puede chocar con la convocatoria |
| Insumo del mes anterior (de `viventa-reporte-campanas`, sección INSUMO PARA LA PARRILLA) | No | Se arma sin aprendizaje y **se dice explícitamente** |
| Salud del dominio / tasa de rebote actual | No | Usar el supuesto conservador y marcarlo `[⚠ no verificado]` |

---

## Workflow

### Fase 1 — Gate de inputs

Si falta el conteo por fase o el corte por tier, **detenete** y emití solo:

```
⛔ NO SE PUEDE ARMAR LA PARRILLA — {mes}

INPUTS REQUERIDOS
- Conteo de la base por fase del funnel → pedir a: Juan Camilo (Zoho)
- Corte de engagement por tier (abrió ≤90d / 91-180d / +180d / rebote) → pedir a: Juan Camilo

Motivo: sin conteos, una parrilla es una lista de ideas sin plan de impacto.
```

**Ese bloque es un output válido.** No estimes la composición de la base.

### Fase 2 — Mapa de la base

Cruzá los ejes que tengas. **Nunca inventes un eje que no vino en el input.**

Ejes, en orden de prioridad:
1. **Fase del funnel** — obligatorio
2. **Tier de engagement** — obligatorio (define quién puede recibir qué)
3. **Tipo de inversión** — vivienda propia / inversión / retorno al país
4. **Rango de ingresos**
5. **Ciudad o país de interés**

Reglas del mapa:
- Toda celda lleva **conteo absoluto y % de la base**.
- Las celdas **vacías se muestran**: un segmento en cero es información.
- Los registros que no se pueden clasificar van a una fila **`Sin clasificar`** con su conteo.
  **Nunca se reparten proporcionalmente.** Si esa fila es grande, es el hallazgo de la corrida.
- Si un eje tiene más de 40 % sin clasificar, se declara **no utilizable** para segmentar este mes.

### Fase 3 — Priorizar segmentos

No todos los segmentos se atacan. Priorizá por **volumen × cercanía a la conversión × costo de
alcanzarlos**, y quedate con un máximo de **6 segmentos activos**.

Un segmento entra a la parrilla si cumple las tres:
1. Tiene **≥ 200 personas** (por debajo, el esfuerzo de redacción no se paga)
2. Está en **tier 1 o 2**
3. Tiene un mensaje que **no es el mismo** que el de otro segmento ya incluido

**Si dos segmentos reciben el mismo mensaje, son un segmento.** Partirlos infla la parrilla sin
cambiar nada.

### Fase 4 — Techo de deliverability

Antes de asignar un solo envío:

```
Techo mensual = contactos tier 1 y 2 alcanzables
              × frecuencia máxima por contacto (default: 4 correos/mes)
              − volumen ya comprometido por convocatorias de evento
```

Detalle y reglas de higiene: `references/techo-deliverability.md`.

- **El volumen de eventos tiene prioridad.** La convocatoria de un evento es fechada e
  irreversible; la parrilla vive en lo que sobra.
- **Frecuencia máxima por contacto: 4 correos/mes**, contando los de evento. Un contacto que ya
  recibe 6 correos de convocatoria **no entra en la parrilla**.
- Si la parrilla deseada no cabe en el techo, **se recorta por prioridad de la Fase 3** y se dice
  qué quedó afuera y por qué.

### Fase 5 — Redactar la parrilla

Una fila por **segmento × envío**. Cada fila trae:

| Campo | Regla |
|---|---|
| Segmento | Del mapa, con su conteo |
| Fecha | Martes, miércoles o jueves. Nunca dos envíos al mismo segmento con <6 días |
| Ángulo | Uno de las 4 P (Pain · Plan · Proof · Philosophy) |
| Propuesta gráfica | Una línea describiendo la pieza. **No la diseña** |
| Asunto | Redactado, ≤ 45 caracteres |
| Preheader | Redactado, ≤ 90 caracteres, **no repite el asunto** |
| Copy | Redactado, cuerpo completo |
| CTA | Verbo + destino concreto |
| Volumen | Conteo real del segmento |

Ninguna celda queda descrita "en general". El asunto es el asunto.

### Fase 6 — Plan de impacto y autovalidación

Cerrá con: a qué segmentos se ataca, a cuáles **no y por qué**, el volumen total contra el techo,
y los campos que faltaron para clasificar con a quién pedírselos.

Corré el checklist. Si algo falla, corregilo antes de emitir — no hay segunda pasada.

---

## Formato exacto del entregable

```
# Parrilla de la base — {mes}

Techo de envío: {N} correos · Comprometido por eventos: {N} · Disponible: {N}
Aprendizaje del mes anterior: {sí, de reporte-campanas / no disponible}

## Bloque A — Mapa de la base
{tabla de conteo por segmento, con % y fila "Sin clasificar"}

## Bloque B — Segmentos activos del mes
{los ≤6 priorizados, con por qué entró cada uno}

## Bloque C — Parrilla
{una fila por segmento × envío, con todas las columnas de la Fase 5}

## Bloque D — Plan de impacto
{a quién sí, a quién no y por qué, volumen vs techo}

## Bloque E — Qué falta
{campos sin clasificar, a quién pedírselos}
```

---

## Fronteras con otros skills

| Este skill | El otro |
|---|---|
| Planifica **el mes** sobre la base | `viventa-comunicaciones-campana` escribe la secuencia de **un evento** |
| Opera sobre **segmentos** | `viventa-match-proyecto-lead` opera sobre **un lead** |
| Define a quién se contacta | `viventa-reactivacion-lead` escribe el mensaje de **un lead caído** |
| Consume el aprendizaje del mes | `viventa-reporte-campanas` lo produce (sección INSUMO PARA LA PARRILLA) |

**El onboarding del lead nuevo que todavía no se registró a nada es de este skill**, no de
`comunicaciones-campana`.

---

## Checklist de autovalidación

**A · Datos**
- [ ] Cero PII en el input procesado y en el output
- [ ] Todo segmento de la parrilla tiene conteo absoluto
- [ ] La fila `Sin clasificar` existe y no se repartió proporcionalmente
- [ ] Ningún eje con >40 % sin clasificar se usó para segmentar
- [ ] Las celdas en cero están visibles

**B · Volumen y deliverability**
- [ ] El techo está calculado y escrito arriba
- [ ] El volumen total de la parrilla ≤ techo
- [ ] Ningún contacto recibe más de 4 correos en el mes, contando convocatorias
- [ ] Tier 3 no recibe ningún envío de esta parrilla
- [ ] El volumen comprometido por eventos se restó **antes** de asignar

**C · Copy**
- [ ] Máximo 6 segmentos activos
- [ ] No hay dos segmentos con el mismo mensaje
- [ ] Todo asunto ≤45 caracteres y todo preheader ≤90, redactados y finales
- [ ] Ningún preheader repite el asunto
- [ ] Cero placeholders, cero `TBD`
- [ ] Español de Colombia, tuteo

**D · Legal y cifras**
- [ ] Cero tasa, cuota, plazo, cuota inicial
- [ ] Cero promesa de aprobación o de "viabilidad inmediata"
- [ ] Cero superlativos sobre condiciones de crédito
- [ ] CPL y CAC nombrados completos la primera vez, nunca mezclados
- [ ] Cero cifras fuera de `references/cifras-canonicas.md`

**E · Alcance**
- [ ] El entregable no envía, no aprueba y no segmenta en Zoho
- [ ] Si no hubo insumo del mes anterior, está dicho explícitamente

---

## Referencias

- `references/techo-deliverability.md` — cálculo del techo, tiers, higiene de base y por qué el
  dominio cae en spam
- `references/ejes-segmentacion.md` — los 5 ejes, sus valores válidos y cómo tratar lo no
  clasificable
- `references/cifras-canonicas.md` — fuente de verdad de todo número
- `references/contexto-viventa.md` — contexto del cliente
- `references/voice-of-customer-90d.md` — verbatims para anclar ángulos
