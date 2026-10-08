---
name: viventa-brief-evento
description: >-
  Convierte una solicitud suelta de evento (un mensaje de WhatsApp, un correo, una nota)
  en el brief canónico de 1 página que dispara la cadena de mercadeo: modalidad, semáforo
  de anticipación, metas con su supuesto declarado, tamaño del pack y bloqueantes.
  Úsalo apenas alguien pide un Open House, ExpoColombia, Expo Casa o Viventa Más Cerca de Ti,
  antes de mover a guiones, pauta o diseño.
metadata:
  version: "1.0.0"
  domain: "process"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# viventa-brief-evento

Toma una solicitud de evento como llega en la vida real —un mensaje suelto, sin dirección, con
la fecha encima— y produce **un documento de una página que se lee en 90 segundos** y con el que
Lizeth (o Daniel) puede decidir tres cosas: si el evento arranca, con qué meta, y qué se le va a
pedir a Alejandra y a Johana.

**Este skill no aprueba, no lanza, no activa pauta y no compromete fechas del equipo.** Termina
en un documento para que un humano decida.

**Una sola pasada.** Sin research, sin web, sin loops, sin ronda de repreguntas. Todo lo que
falte se declara como faltante dentro del mismo output.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **Sin dirección exacta, el brief se bloquea.** Es la fricción #1 del Voice of Customer. No se
   escribe "en Miami" ni "el venue se confirma". Se escribe calle, número, venue, ciudad, país.
   Si no está, el output es la ficha con lo que hay + el bloqueo + el mensaje para pedirla.
   **No existe estado intermedio ni TBD.**
2. **Cero invención.** Toda cifra lleva pegada su línea `Supuesto:`. Si no hay insumo para
   calcular, el campo dice `NO CALCULABLE — falta {dato}` y el dato se pide en el bloque 5,
   nombrando a quién.
3. **Cero verbos de decisión.** Prohibido *aprobar*, *lanzar*, *activar*, *cancelar*, *recomiendo
   cancelar*, *listo para producción*. El skill lista opciones con su costo; elige un humano.
4. **CPL ≠ CAC.** Siempre etiquetados: "CPL = costo por lead", "CAC = costo por cierre". Nunca en
   la misma línea sin nombre.
5. **Las dos metas de negocio van en líneas separadas y nunca se suman.** Pago de servicio ([cifra interna]
   × USD 480) y desembolso / Vive Casas ([cifra interna]) son KPIs distintos.
6. **Nunca tasa, cuota, plazo ni cuota inicial** — son triggering terms de Reg Z y un disclaimer
   no los cura. **Nunca prometer aprobación de crédito ni valorización.** Si el solicitante los
   incluyó, la línea se marca `requiere visto bueno de Crédito` y no se propaga.
7. **El semáforo es aritmética de fechas, no juicio.** No se suaviza el rojo ("con 20 días todavía
   se puede hacer algo bonito") ni se dramatiza. Se reportan días reales y consecuencia técnica.
8. **Sin PII.** De las consultoras solo nombre y rol. Nada de teléfonos, correos ni datos de leads.
9. **Español de Colombia, tuteo, frases cortas.** Cero jerga de consultora: nada de "aliado
   estratégico", "solución integral", "unlock", "leverage".
10. **Los `[⚠ no verificado]` heredados sobreviven en el output.** No se limpian ni se redondean a
    certeza. Especialmente el benchmark de 20 leads/ejecutiva-día.
11. **Una sola proposición por bloque.** Si una línea necesita un "y" para caber, todavía no está
    destilada. El research de fondo va en otro archivo, no acá.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| **Dirección exacta**: venue, calle, número, ciudad, país | **Sí — bloqueante** | **Bloquea.** Pedir a quien propuso el evento (consultora en *Más Cerca de Ti*, coordinación de eventos en los demás) |
| **Fecha del evento** | **Sí — bloqueante** | **Bloquea.** Sin fecha no hay semáforo |
| **Hora de inicio y de cierre** | **Sí — bloqueante** | **Bloquea.** Va en flyer, video y voz en off |
| **Modalidad** (Open House · Expo Colombia · Expo Casa · Viventa Más Cerca de Ti) | **Sí — bloqueante** | **Bloquea.** No la deduzcas: preguntala |
| **N.º de ejecutivas que atienden** | **Sí — bloqueante** | **Bloquea la meta**, no el brief: la ficha sale, las metas dicen `NO CALCULABLE`. Pedir a Lizeth |
| Consultoras asignadas (nombre y rol) | No | Seguir. El conteo de flyers queda como rango y se declara |
| Audiencia: ¿solo el país local o también colombianos en USA? | No | **Preguntar, no asumir.** Define si el pack lleva versión en dólares — es la diferencia entre 24 y 34 entregables sobre una sola diseñadora |
| Presupuesto de pauta | No | Seguir. La meta se escala por equipo, no por presupuesto |
| Proyectos / constructoras que se presentan | No | Seguir; se marca como dato pendiente para guiones |

Moneda: **se deriva del país**, no se pregunta. USA/Canadá → USD · España/Francia/Italia → EUR ·
UK → GBP.

---

## Workflow

### Fase 1 — Clasificar modalidad y extraer la ficha

Leé la solicitud tal como llegó y extraé: modalidad, ciudad, país, dirección, fecha, horario,
consultoras, n.º de ejecutivas, quién lo propuso.

La **modalidad va primero** porque modula todo lo demás. Las 4 exactas y sus implicaciones están en
`references/tipologias-evento.md`. No inventes una quinta. Si la solicitud no encaja limpio,
declarala faltante.

Marcá el origen: **compañía** (Open House · Expo Colombia · Expo Casa) o **fuerza comercial**
(Viventa Más Cerca de Ti). Los de la fuerza comercial llegan por mensaje suelto y son los que más
suelen incumplir los 45 días — revisá los bloqueantes con lupa.

### Fase 2 — Gate de bloqueantes

Contrastá contra la lista cerrada de campos bloqueantes (`references/tipologias-evento.md`, §3).

**Si falta la dirección exacta**, el brief no sale completo. Emití la ficha con lo que hay, el
bloqueo visible arriba, y el mensaje listo para copiar y pegar pidiendo el dato. Ese output es
válido y termina ahí. No inventes un venue plausible ni escribas "por confirmar".

### Fase 3 — Semáforo de anticipación

`dias = fecha_evento − hoy`. Pintá 🟢 ≥45 · 🟡 30-44 · 🔴 <30 según la tabla de
`references/tipologias-evento.md`, §2.

Reportá tres cosas y nada más: el número real de días, la consecuencia técnica esperada en CPL, y
—si es ámbar o rojo— las salidas posibles con su costo. La decisión de correr igual es humana y se
dice explícitamente.

### Fase 4 — Metas, con el supuesto pegado al lado

Cargá `references/formulas-y-defaults.md` y calculá:

```
leads_atendibles = N_ejecutivas × leads_por_ejecutiva_dia    (default 20)
meta_registros   = leads_atendibles ÷ (1 − tasa_no_show)     (default 40%)
```

Cada cifra lleva **inmediatamente debajo** su línea `Supuesto:` con los parámetros usados y su
origen. Si existe histórico de un evento comparable, **el histórico gana sobre el benchmark** y el
brief dice cuál usó.

La meta de negocio va en **dos líneas separadas**:

```
Pago de Servicio Viventa: meta_registros × [cifra interna] ≈ {n} pagos ≈ USD {n × 480}
Desembolso / Vive Casas:  meta_registros × [cifra interna]  ≈ {n} cierres
```

Nunca sumadas, nunca promediadas. Debajo, la referencia de costo con etiquetas: CAC histórico del
canal eventos ≈ [cifra interna] **por cierre**; CPL Meta ≈ [cifra interna] **por lead**.

**Chequeo de coherencia obligatorio:** si el país ≠ USA, el KPI de composición "85% de leads desde
USA" **no aplica** — decilo y pedí la meta de composición correcta a Lizeth.

Si falta `N_ejecutivas`: **si la solicitud trae las consultoras asignadas**, derivá 1 ejecutiva por
consultora y declaralo como supuesto en la misma línea, pidiendo confirmación a Lizeth. Si no hay ni
consultoras: `NO CALCULABLE — falta N.º de ejecutivas → pedir a Lizeth`. Fuera de esa derivación
declarada, no estimes.

### Fase 5 — Dimensionar el pack

Aplicá las fórmulas de conteo de `references/formulas-y-defaults.md`, §4. Reportá el total de
entregables y, al lado, las **unidades de copy** reales — que es donde de verdad se va el trabajo.

Recordá la carga: ~5 días de producción sobre **una** productora de video y **una** diseñadora,
con 3+ eventos al mes. Eso es dato, no reproche.

Si no sabés si el evento se promociona a una sola audiencia o a dos monedas, **preguntalo en el
bloque 5**; no asumas 2.

### Fase 6 — Ensamblar el output

Una página. Cinco bloques, en este orden: **ficha · semáforo · metas · pack · bloqueantes**.
Nada más. Si no cabe en una página, sobra texto, no falta página.

---

## Formato del output

```
# BRIEF DE EVENTO — {Modalidad} · {Ciudad}, {País}
Solicitado por: {quién} · Origen: {compañía | fuerza comercial} · Fecha del brief: {hoy}

## 1. Ficha
Modalidad: {una de las 4}
Ciudad / país: {ciudad}, {país}
Dirección exacta: {venue, calle, número}   ← o: ⛔ FALTA — bloquea el anuncio
Fecha y hora: {fecha}, de {hora inicio} a {hora cierre}
Consultoras asignadas ({n}): {nombre · nombre · nombre}
Ejecutivas que atienden: {n}

## 2. Semáforo de anticipación
{🟢|🟡|🔴} {COLOR} — {n} días de anticipación (mínimo: 45).
Consecuencia esperada: {consecuencia técnica en CPL, sin adjetivos}
Salidas posibles: {opción A} · {opción B} · {opción C}. No es decisión del skill.

## 3. Metas (con supuesto declarado)
Meta de leads: {n} registros
  Supuesto: {n} ejecutivas × {n} leads/ejecutiva-día [⚠ benchmark de trade shows B2B,
  no histórico Viventa] = {n} atendibles ÷ {1−no_show} (asume {n}% de no-show en evento
  gratuito) ≈ {n} registros.
Composición objetivo: {85% USA — o la advertencia si el país no es USA}
Meta de negocio:
  Pago de Servicio Viventa: {n} × [cifra interna] ≈ {n} pagos ≈ USD {n} (ticket SV USD 480)
  Desembolso / Vive Casas:  {n} × [cifra interna]  ≈ {n} cierres
  Supuesto: conversiones del cohort {periodo}. Son dos KPI distintos, no se suman.
Referencia de costo: CAC eventos ≈ [cifra interna] por cierre · CPL Meta ≈ [cifra interna] por lead. CPL ≠ CAC.

## 4. Pack de producción
Videos: {n} · Carruseles: {n} · Estáticas: {n} · Flyers: {n} ({n} consultoras × A3/A4/redes)
Total archivos: {n} · Unidades de copy reales: {n}
Carga: ~5 días sobre 1 productora y 1 diseñadora.
Voz en off: una línea por cada ciudad y cada fecha.

## 5. Bloqueantes y datos por pedir
⛔ BLOQUEA EL ANUNCIO
1. {dato} → pedir a: {persona}
Por pedir (no bloquea)
2. {dato} → pedir a: {persona}
3. {pregunta} → de eso depende {consecuencia concreta}

Este documento no aprueba ni lanza nada. Decide {Lizeth | Daniel}.
```

---

## Ejemplo (real, recortado)

Solicitud como llegó, por WhatsApp: *"Hola! Vamos a hacer un Viventa Más Cerca de Ti en Alicante
el 9 de mayo. Van Carolina, Johana de la Hoz y Mirley. ¿Nos ayudan con las piezas?"*

```
# BRIEF DE EVENTO — Viventa Más Cerca de Ti · Alicante, España
Solicitado por: consultoras de plaza · Origen: fuerza comercial · Fecha del brief: 27-abr-2026

## 1. Ficha
Modalidad: Viventa Más Cerca de Ti
Ciudad / país: Alicante, España
Dirección exacta: ⛔ FALTA — bloquea el anuncio
Fecha y hora: 9 de mayo · hora ⛔ FALTA
Consultoras asignadas (3): Carolina Ronderos · Johana de la Hoz · Mirley Valencia
Ejecutivas que atienden: 3 ⚠ supuesto — 1 por consultora asignada, confirmar con Lizeth

## 2. Semáforo de anticipación
🔴 ROJO — 12 días de anticipación (mínimo: 45).
Consecuencia esperada: la pauta no alcanza a salir de la fase de aprendizaje de Meta
(~50 conversiones por conjunto de anuncios en ventana móvil de 7 días). Entrega inestable
y CPL por encima del objetivo justo en la semana crítica.
Salidas posibles: correr asumiendo CPL alto · mover la fecha · recortar el pack a una sola
ciudad. No es decisión del skill.

## 3. Metas (con supuesto declarado)
Meta de leads: 100 registros
  Supuesto: se asume 1 ejecutiva por consultora asignada (3) — la solicitud no trae el dato,
  confirmar con Lizeth. 3 ejecutivas × 20 leads/ejecutiva-día [⚠ benchmark de trade shows
  B2B, no histórico Viventa] = 60 atendibles ÷ 0.6 (asume 40% de no-show en evento gratuito)
  ≈ 100 registros.
Composición objetivo: ⚠ el KPI de 85% de leads desde USA no aplica — el evento es en España.
  Confirmar meta de composición con Lizeth.
Meta de negocio:
  Pago de Servicio Viventa: 100 × [cifra interna] ≈ 2 pagos ≈ USD 960 (ticket SV USD 480)
  Desembolso / Vive Casas:  100 × [cifra interna]  ≈ 3 cierres
  Supuesto: conversiones del cohort nov-25/abr-26. Son dos KPI distintos, no se suman.
Referencia de costo: CAC eventos ≈ [cifra interna] por cierre · CPL Meta ≈ [cifra interna] por lead. CPL ≠ CAC.

## 4. Pack de producción
Videos: 10 (5 guiones × 2 formatos, 1 moneda: EUR) · Carruseles: 3 · Estáticas: 2
Flyers: 9 (3 consultoras × A3/A4/pieza de redes)
Total archivos: 24 · Unidades de copy reales: ~11
Carga: ~5 días sobre 1 productora y 1 diseñadora.
Voz en off: una línea para "Alicante" y una para "9 de mayo".

## 5. Bloqueantes y datos por pedir
⛔ BLOQUEA EL ANUNCIO
1. Dirección exacta del punto de información en Alicante (venue, calle, número)
   → pedir a: Carolina Ronderos. Sin esto ninguna pieza sale: es la fricción #1 declarada
   por los clientes.
2. Hora de inicio y de cierre → pedir a: Carolina Ronderos.
Por pedir (no bloquea)
3. ¿Se promociona solo a audiencia en España o también a colombianos en USA?
   De eso depende si el pack lleva versión en dólares (24 vs. 34 entregables).
   → pedir a: Lizeth Henríquez.

Este documento no aprueba ni lanza nada. Decide Lizeth.
```

---

## Checklist de autovalidación

Antes de entregar, todas tienen que dar sí:

- [ ] Cabe en **1 página** y tiene exactamente **5 bloques**: ficha · semáforo · metas · pack ·
      bloqueantes.
- [ ] La **modalidad** está declarada y es una de las 4 exactas.
- [ ] Hay **dirección exacta**, o el brief está explícitamente bloqueado por su ausencia. No hay
      estado intermedio ni "TBD".
- [ ] El **semáforo** muestra el número real de días y la consecuencia esperada en CPL.
- [ ] **Cada cifra** tiene su línea `Supuesto:` inmediatamente debajo. Ninguna cifra huérfana.
- [ ] Las dos metas de negocio están en **líneas separadas**, con su nombre completo, sin sumar.
- [ ] CPL y CAC aparecen **etiquetados** y nunca intercambiados.
- [ ] Si el país ≠ USA, el KPI de 85% USA está marcado como no aplicable.
- [ ] Los faltantes dicen **qué dato es y a quién se le pide**.
- [ ] Los `[⚠ no verificado]` heredados siguen visibles — sobre todo el de 20 leads/ejecutiva-día.
- [ ] **Cero verbos de decisión**: buscá *aprobar*, *lanzar*, *activar*, *recomiendo*. Si aparecen,
      reescribí.
- [ ] Ninguna mención de tasa, cuota, plazo, cuota inicial ni promesa de aprobación.
- [ ] Sin PII: de las consultoras, solo nombre y rol.
- [ ] Español de Colombia, tuteo, sin jerga de consultora.
- [ ] Se produjo en **una sola pasada**, sin ronda de repreguntas.

---

## Referencias

- `references/tipologias-evento.md` — las 4 modalidades, semáforo de anticipación y lista cerrada
  de campos bloqueantes.
- `references/formulas-y-defaults.md` — fórmulas de meta de leads y de negocio, defaults con su
  nivel de confianza, cifras canónicas y conteo del pack.
