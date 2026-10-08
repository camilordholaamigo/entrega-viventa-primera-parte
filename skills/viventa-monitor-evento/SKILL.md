---
name: viventa-monitor-evento
description: >-
  Monitorea las campañas de eventos de Viventa en dos modos: diario (tablero de eventos activos
  con 4 gates de evidencia en cascada, proyección con curva back-loaded y máximo 3 acciones
  reenviables a la agencia de Ads) y cierre (ficha post-mortem en 4 cortes T+0/T+30/T+90/T+180
  con veredicto de repetir, ajustar o descartar). No ejecuta nada: recomienda, y "esperar" es una
  recomendación válida.
metadata:
  version: "1.0.0"
  domain: "analyze"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-monitor-evento

Un solo skill, **dos modos**. Nunca corren juntos: el usuario elige uno al invocar.

| Modo | Quién lo usa | Cuándo | Qué entrega |
|---|---|---|---|
| **DIARIO** | Johana Osorio | Todas las mañanas, mientras la campaña está al aire | Tablero de eventos activos + proyección + máx. 3 acciones |
| **CIERRE** | Lizeth (gerencia) | Después del evento, en 4 cortes: T+0, T+30, T+90, T+180 | Ficha de cierre + veredicto (solo desde T+90) |

**Cómo se invoca:**

- Modo diario → `/viventa-monitor-evento diario` · o cualquier frase tipo *"cómo van los eventos"*,
  *"el monitor de hoy"*. **Es el modo por defecto** si el usuario no dice cuál.
- Modo cierre → `/viventa-monitor-evento cierre "{nombre del evento}" T+{0|30|90|180}` · o
  *"sacá el cierre de Tampa"*, *"el post-mortem de Alicante a 90 días"*.
  Si dice "cierre" pero no dice el corte → **preguntar el corte antes de calcular nada**. No
  asumirlo por la fecha.

**Restricciones que gobiernan todo el skill:**

- **Una sola pasada.** Sin loops, sin research en tiempo de ejecución, sin llamadas externas. Las
  cuentas de IA son compartidas y con límite de créditos (hasta 4 horas de espera).
- **El skill no pausa, no ajusta, no aprueba, no publica nada.** Solo recomienda. La acción es
  humana y la cuenta de Meta la opera una agencia externa.
- **Español de Colombia, tuteo.** Frases cortas. Sin jerga financiera sin traducir.
- Output en markdown/tablas, copiable a Google Sheets o Slides sin conversión.

**Referencias que se cargan según el modo (no antes):**

- Modo diario → `references/umbrales-diario.md`
- Modo cierre → `references/cortes-cierre.md`

---

## Reglas de datos — no negociables, aplican a los dos modos

| # | Regla |
|---|---|
| **D1** | **CPL ≠ CAC.** CPL = costo por **lead** (`$/lead`). CAC = costo por **cierre** (`$/cierre`). Nunca en la misma tabla, nunca comparados. Siempre con la unidad escrita. |
| **D2** | **Conversión a desembolso [cifra interna] ≠ conversión a pago de servicio [cifra interna].** Jamás se suman (5.98% es un error que infla el retorno ~70%), jamás se promedian, jamás se dice "la conversión" sin decir cuál. Mapeo fijo: `pago de servicio [cifra interna] → ingreso SV $480` · `desembolso [cifra interna] → ingreso Vive Casas (valor = input)`. |
| **D3** | **Ticket SV = $480 USD.** No $495. Todo ingreso SV se calcula sobre $480. |
| **D4** | **CAC fully-loaded de eventos = [cifra interna]/cierre** — el canal más caro del stack (Web [cifra interna] · Email [cifra interna] · WhatsApp [cifra interna] · Instagram [cifra interna] · Meta [cifra interna] · Google [cifra interna] · Eventos [cifra interna]). Es la referencia contra la que se juzga cualquier evento. |
| **D5** | **Separar leads de pauta de leads no pagados.** El CPL se calcula **solo** sobre inversión de pauta ÷ leads atribuidos a pauta. Los leads de base propia, walk-ins, contactos de las consultoras y referidos van en un renglón aparte y **no entran al CPL**. Si el input no permite separar los dos universos: **no se emite CPL** — se escribe `CPL no emitible — universo pagado no separable`. **Nunca se estima el split.** |
| **D6** | **La comisión del asesor ([cifra interna] del SV, [cifra interna]/cierre) es cost-to-serve, no CAC.** No se suma al costo del evento. |
| **D7** | **Etiqueta de naturaleza en todo número:** `[dato]` (viene del reporte de Meta/Zoho) · `[proyección]` (lo calculó el skill) · `[input]` (lo cargó un humano) · `[n/d]` (falta). **Ninguna cifra desnuda.** |
| **D8** | La asignación de costo de equipo del CAC loaded es **declarada, no medida (±20%)**. Toda comparación de costo por SV entre canales que caiga dentro de ±20% se declara **empate**, no diferencia. |
| **D9** | **Composición: 85% de los leads deben venir de USA.** Se mide sobre leads de pauta. Es un semáforo **independiente**: nunca se promedia con volumen ni con CPL. |
| **D10** | **Un evento sin dirección concreta no existe para el monitor.** Sin dirección y ciudad confirmadas se marca en cabecera: `⚠ sin dirección — fricción #1 del VOC`. |

**Sin decimales falsos.** Precisión proporcional al dato: leads en enteros, CPL con un decimal
como máximo, porcentajes enteros. Una proyección nunca se escribe con más precisión que su
insumo.

**Regla de parada (anti-invención):** si falta un input material, el skill **no proyecta y no
estima**. Escribe `[n/d]`, marca lo afectado como `no emitible`, y devuelve la lista exacta de
los datos que faltan, redactada para pedírselos a quien los tiene.

---

## Input del usuario

### Setup — se carga una vez, no se infiere nunca

| Input | Si falta |
|---|---|
| **Valor económico por operación Vive Casas** (comisión / ticket / margen) `[⚠ no verificado — no existe en las cifras canónicas]` | **La rentabilidad se declara `no calculable`.** No se estima, no se asume, no se usa un proxy. El modo cierre corre igual pero el veredicto sale `no emitible — falta valor Vive Casas`. |
| **Reconciliación pauta / no-pauta**: cómo se identifica en Zoho qué lead vino de pauta | No se emite CPL (D5). El resto del output corre. |
| **Curva de referencia de registros** calibrada con eventos históricos | Se usa la curva provisional de `references/umbrales-diario.md`, marcada `[⚠ no verificado]` **en el output**. |
| **CPL objetivo por plaza** | Se usa el CPL Meta canónico [cifra interna] como referencia, declarándolo como sustituto. |

### Modo diario — por cada evento activo

Fecha del evento · ciudad y dirección · meta de leads · presupuesto de pauta aprobado · fecha de
inicio de la pauta · export de Meta Ads (leads, gasto, impresiones **por día y por ad set**) ·
registros de Zoho con país de origen · nombre exacto de los ad sets · fecha del último cambio
significativo por ad set.

**Faltantes y qué hacer:**

| Falta | Qué hace el skill |
|---|---|
| Serie **diaria** (solo hay acumulado) | No se puede aplicar el gate de persistencia → **ninguna acción se emite**. Se entrega la tabla de estado y se pide la serie diaria. |
| País de origen de los leads | Columna `% USA` = `[n/d]`. No se emite semáforo de composición. |
| Fecha del último cambio por ad set | Se asume ad set **en aprendizaje** (el supuesto conservador) → no se recomienda editarlo. |
| Fecha de inicio de pauta | No se proyecta (no hay `% de calendario transcurrido`). |
| Dirección del evento | Advertencia D10 en cabecera. |

### Modo cierre — por evento

Todo lo del modo diario, cerrado · costo total cargado (pauta + producción + logística) `[input]`
· asistentes reales · citas agendadas · SV pagados · operaciones Vive Casas cerradas `[input]` ·
leads en gestión activa · meta de negocio del evento (SV + Vive Casas) · cortes previos ya
emitidos.

---

## Fase 1 — Identificar modo y corte

1. Leer la invocación. Si dice cierre sin corte → **preguntar**. Si no dice nada → modo diario.
2. Cargar la referencia del modo (y solo esa).
3. Listar los eventos en alcance. Modo diario: todos los activos con pauta al aire. Modo cierre:
   uno solo.
4. **No avanzar** sin confirmar qué inputs de setup están cargados.

## Fase 2 — Validar inputs y declarar faltantes

Recorrer la tabla de inputs. Por cada faltante, aplicar la columna "si falta" **antes** de
calcular. Escribir la lista de faltantes; va al pie del output.

Nunca rellenar un faltante con un supuesto. Nunca convertir un `[n/d]` en un número.

## Fase 3A — Modo diario: los 4 gates en cascada

Cargar `references/umbrales-diario.md` y aplicar **en orden**. Una alerta solo existe si pasa los
cuatro. Lo que muere en un gate va a la sección "NO SE REPORTA HOY".

1. **Gate de muestra** — n≥30 y desviación > `2/√n`. Sin eso: `muestra insuficiente`, sin juicio.
2. **Gate de persistencia** — 3 días consecutivos en el mismo sentido, o 4 de 5 del mismo lado,
   o salto >50% con n≥30. Un solo día nunca dispara nada.
   *Excepción:* entrega en cero (gasto $0 o 0 impresiones) se reporta de inmediato.
3. **Gate de learning phase** — ad set con <50 conversiones/7d o <7 días desde el último cambio:
   **no se recomienda editarlo**. Solo se permite agregar creativo, mover presupuesto a nivel
   campaña/CBO, ampliar la ventana de atribución del reporte, o **esperar**.
4. **Gate de ventana de acción** — qué se puede recomendar según días restantes (>30 / 14–30 /
   7–14 / <7). Con <7 días: cero ediciones de campaña; solo acciones no-Meta.

**"Esperar" es una recomendación válida y se escribe como tal**, con fecha de próxima revisión.
Un skill que nunca dice "no toques nada" es un skill que solo genera trabajo. Cuando un evento
está 🟢 en las tres dimensiones, la recomendación correcta es **no tocar** — y se escribe.

## Fase 3B — Modo diario: proyección

**Prohibido el pacing lineal.** Usar la curva back-loaded de la referencia:
`leads_proyectados = leads_actuales / %_curva_esperada_hoy`.

Declarar siempre la confianza: **Alta** (n≥100 y ≥50% del calendario) → punto ·
**Media** (n≥30) → banda ±20% · **Insuficiente** (n<30 o <20% del calendario) → **no se proyecta**.

Tres semáforos independientes: volumen · CPL · composición. Nunca se promedian.

## Fase 4A — Modo cierre: cortes y bloques

Cargar `references/cortes-cierre.md`.

1. Declarar el corte en cabecera y qué cortes previos existen.
2. Llenar los 3 bloques **sin mezclarlos**: adquisición (cerrada en T+0) · conversión (madura
   hasta T+180) · eficiencia económica.
3. **En T+0 y T+30 no se emite veredicto de ningún tipo** y las palabras *fracaso*, *no funcionó*,
   *descartar*, *no rentable* están **bloqueadas**. Redacción obligatoria cuando el negocio va
   bajo meta: *"resultado de negocio parcial — la ventana de conversión de este evento cierra el
   {fecha T+90}"*.
4. En T+90 y T+180: aplicar la matriz de veredicto. El veredicto **nombra siempre la capa que
   falló**: adquisición, conversión o estructura de costo.
5. **Veredicto de evento ≠ veredicto de plaza.** El de plaza exige **≥2 eventos** de la misma
   ciudad con T+90 completo. Con uno solo: `veredicto de plaza no emitible`.
6. Si no está cargado el valor de Vive Casas: `rentabilidad no calculable`. **Ningún estimado.**
7. Agendar el recierre T+180 con fecha.

## Fase 5 — Las 3 acciones (aplica a los dos modos)

**Techo duro: máximo 3 acciones.** Priorizadas ALTA / MEDIA / BAJA. Si hay más de 3 problemas,
el skill prioriza y **dice explícitamente qué dejó fuera**.

Cada acción lleva los **5 campos obligatorios**. Si no se pueden llenar los 5, **no se emite la
acción** — se emite en su lugar la pregunta que falta responder.

1. **Qué ad set / campaña** — nombre exacto.
2. **Qué cambio** — la variable exacta.
3. **Cuánto** — de X a Y, con número.
4. **A quién se le pide** — agencia de Ads · Lizeth · Johana · consultoras.
5. **Cuándo se verifica** — fecha.

**Prohibido:** "optimizar la pauta", "revisar la segmentación", "mejorar el creativo", "ajustar
la estrategia". Si no se puede decir cuál y cómo, no es una acción.

El texto que va a la agencia se redacta **entre comillas, listo para reenviar**.

## Fase 6 — Secciones de disciplina (obligatorias, no opcionales)

- **NO SE REPORTA HOY** (modo diario) — lo que murió en un gate, con el motivo y la fecha del
  primer juicio válido. Demuestra que el skill sí lo miró.
- **NO SE RECOMIENDA, aunque aparezca tentador** (los dos modos) — 1-2 líneas.
- **DATOS QUE FALTAN** — lista exacta, redactada para pedírselos a quien los tiene.

## Fase 7 — Autovalidación

Correr el checklist del final. Si algo falla, **corregir antes de entregar**. No se entrega un
output con un ítem en rojo.

---

## Plantilla de output — MODO DIARIO

```
MONITOR DE EVENTOS ACTIVOS · {día} {fecha} · corte {hora} COT
Fuente: {origen y timestamp del export}
{⚠ advertencias de cabecera: campaña lanzada a N días · sin dirección confirmada}

| Evento | Ciudad | Fecha | Días rest. | Leads pauta | Meta | % avance | Curva esperada | CPL actual | CPL obj. | % USA | 🚦 |
|---|---|---|---|---|---|---|---|---|---|---|---|

Leads no pagados (base, walk-in, consultoras): {n} `[dato]` — no entran en el CPL

**Proyección al día del evento** `[proyección]`

| Evento | Leads proyectados | vs meta | Confianza | Inversión proyectada vs presupuesto |
|---|---|---|---|---|

**Lectura en una línea**
{2-4 frases. Qué pasa en cada evento y si es problema de volumen, de CPL o de composición.}

**ACCIONES RECOMENDADAS — máximo 3, priorizadas**

**1. [ALTA] {Evento} — {el problema en una frase}**
- **Qué pasa:** {evidencia con etiqueta de naturaleza y n}
- **A quién:** {agencia de Ads / Lizeth / Johana}
- **Qué pedir, textual:** *"{mensaje reenviable con ad set, variable y magnitud}"*
- **Por qué así y no de otra forma:** {gate que lo justifica}
- **Verificar el:** {fecha}

**2. [MEDIA] …**
**3. [BAJA] …**

**NO SE REPORTA HOY** (bajo umbral de evidencia)
- {evento/ad set}: {motivo}. Primer juicio válido cuando {condición} (estimado {fecha}).

**NO SE RECOMIENDA, aunque aparezca tentador**
- {1-2 líneas}

**DATOS QUE FALTAN**
- {input} → pedírselo a {persona}
```

## Plantilla de output — MODO CIERRE

```
FICHA DE CIERRE · {evento} · evento {fechas}
Corte T+{0|30|90|180} ({fecha}) — {FICHA DE OPERACIÓN | LECTURA PARCIAL | CORTE DE VEREDICTO | RECIERRE}
Cortes previos: {…} · Próximo: T+{n} ({fecha})

**A. Adquisición — cerrada desde T+0, no cambia** `[dato]`
| | Real | Meta | Δ |
(leads de pauta · leads no pagados · leads totales atribuidos · composición USA ·
 CPL de pauta [$/lead, ≠ CAC] · inversión de pauta · costo total cargado · asistentes / show rate)

**B. Conversión y negocio a T+{n}** `[dato]` + `[proyección]`
| | Real | Meta evento | Estado |
(SV pagados · ingreso SV = n × $480 · operaciones Vive Casas · ingreso Vive Casas `[input]` ·
 pipeline vivo · SV adicionales esperables — banda, no punto)

**C. Eficiencia económica** `[proyección]`  ← solo desde T+90
| Métrica | Valor | Referencia | Lectura |
(costo por SV [$/cierre] vs CAC loaded eventos [cifra interna] · conversión lead pagado → SV vs
 pago de servicio [cifra interna] · margen de contribución sobre SV solos · retorno total vs 1.0x)

**D. VEREDICTO**  ← solo desde T+90; en T+0 y T+30 esta sección se reemplaza por:
   "Sin veredicto en este corte — resultado de negocio parcial, la ventana cierra el {fecha T+90}"

🟢/🟠/🔴 {REPETIR | AJUSTAR | NO REPETIR ESTE MODELO}
- La capa que falló: {adquisición | conversión | estructura de costo}
- Veredicto de plaza: {emitido con N eventos | NO EMITIBLE — se requieren 2+ eventos con T+90}
- Recierre obligatorio a T+180 ({fecha})
- Pie de contexto: {geo de baja saturación, si aplica}

**Las 3 acciones — máximo 3**
1. [ALTA · {destinatario}] …
2. [MEDIA · {destinatario}] …
3. [BAJA · {destinatario}] …

**NO SE RECOMIENDA, aunque aparezca tentador**
**DATOS QUE FALTAN**
```

---

## Ejemplo recortado — modo diario

> Cifras ilustrativas sobre plazas reales. No son datos de Viventa.

| Evento | Ciudad | Días rest. | Leads pauta | Meta | % avance | Curva esperada | CPL actual | % USA | 🚦 |
|---|---|---|---|---|---|---|---|---|---|
| ExpoColombia | Tampa, FL | 13 | 218 `[dato]` | 400 | 55% | 52% | [cifra interna] `[dato]` | 91% | 🟢 |
| Más Cerca de Ti | Alicante, ES | 26 | 47 `[dato]` | 180 | 26% | 24% | $63 `[dato]` | 38% | 🟡 |
| Más Cerca de Ti | Valencia, ES | 40 | 9 `[dato]` | 150 | 6% | 8% | $71 `[dato]` | 55% | ⚪ |

**Lectura:** Tampa va bien y no requiere nada. Alicante tiene un problema **de composición, no de
volumen**: llega al 84% de la meta `[proyección]` pero con 38% de leads USA contra el 85%
objetivo. Valencia arrancó hace 5 días: **sin muestra suficiente para emitir juicio**.

**1. [ALTA] Alicante — la segmentación está trayendo el público equivocado.**
- **Qué pasa:** 62% de los leads son residentes en España; la meta es 85% USA. El ad set
  `ALC_ES_Broad_25-55` concentra 31 de los 47 leads `[dato]` y el 89% de los no-USA.
- **A quién:** agencia de Ads.
- **Qué pedir, textual:** *"En la campaña de Alicante, bajar el presupuesto diario del ad set
  `ALC_ES_Broad_25-55` de $180 a $60 y mover los $120 al ad set `ALC_US_Colombianos_FL-NJ`. No
  tocar creativos ni pujas."*
- **Por qué así:** el cambio reinicia aprendizaje en ambos ad sets; con 26 días restantes hay
  margen (gate 4). Con menos de 14 no lo recomendaríamos. **Un solo cambio, no tres.**
- **Verificar el:** 21-ago (4 días). No volver a tocar antes.

**3. [BAJA] Tampa — nada que hacer, y eso es la recomendación.** 🟢 en las tres dimensiones.
**No tocar.** Cualquier edición reinicia aprendizaje 13 días antes del evento.

**NO SE REPORTA HOY:** Valencia, n=9, muestra insuficiente — primer juicio válido con n≥30
(estimado 24-ago). Fluctuación de CPM en Tampa de +14% día a día: dentro de banda de ruido.

## Ejemplo recortado — modo cierre (la contradicción que hay que saber decir)

> CPL de pauta $42.5 `[dato]` (objetivo $45) · conversión lead pagado → SV 2.2% (canal eventos
> 1.03%) · costo por SV $2,989 `[proyección]` contra CAC loaded de eventos [cifra interna] · retorno total
> 0.47x.

> ⚠ **El CPL fue mejor que el objetivo y la conversión fue el doble del canal, y aun así el
> evento está a 0.47x de recuperar su costo a T+90. No es una falla de ejecución de pauta.** Es
> la estructura económica del canal: eventos tiene el CAC fully-loaded más caro del stack ([cifra interna])
> contra un ticket SV de $480 — con SV solos el margen es [cifra interna] por cierre y ningún evento se
> paga. Veredicto: 🟠 **AJUSTAR — la capa que falló es la estructura de costo, no la adquisición.**
> Veredicto de plaza: **no emitible**, Tampa tiene 1 solo evento con T+90.

---

## Checklist de autovalidación

**Integridad de datos**
- [ ] Ninguna cifra sin etiqueta `[dato]` / `[proyección]` / `[input]` / `[n/d]`.
- [ ] CPL y CAC nunca en la misma tabla; ambos con unidad escrita (`$/lead`, `$/cierre`).
- [ ] Ninguna conversión mencionada sin decir si es desembolso ([cifra interna]) o pago de servicio ([cifra interna]).
- [ ] Ningún ingreso SV calculado sobre algo distinto de $480.
- [ ] El CPL se calculó sobre leads de pauta — o se declaró `no emitible`.
- [ ] Ningún dato faltante fue estimado, asumido ni sustituido por un proxy.
- [ ] Sin decimales falsos.

**Disciplina de señal (modo diario)**
- [ ] Ningún juicio de CPL sobre n<30.
- [ ] Ninguna acción disparada por una desviación de un solo día.
- [ ] Ninguna recomendación de editar un ad set con <50 conv/7d o <7 días desde el último cambio.
- [ ] Ninguna proyección con n<30 o <20% del calendario. Ninguna proyección lineal.
- [ ] Existe la sección "NO SE REPORTA HOY".
- [ ] Si algún evento está en verde, aparece explícito el "no tocar".

**Accionabilidad**
- [ ] ≤3 acciones, priorizadas ALTA/MEDIA/BAJA.
- [ ] Cada acción tiene los 5 campos: ad set · variable · magnitud · destinatario · fecha.
- [ ] No aparece "optimizar la pauta", "revisar la segmentación" ni "mejorar el creativo" sueltos.
- [ ] Existe la sección "no se recomienda".
- [ ] El skill no ejecuta, no pausa, no ajusta. Todas las acciones son mensajes para un humano.

**Modo cierre**
- [ ] El corte está declarado (T+0 / T+30 / T+90 / T+180).
- [ ] Ninguna palabra de fracaso / no funcionó / descartar / no rentable antes de T+90.
- [ ] El veredicto nombra la capa que falló (adquisición / conversión / estructura de costo).
- [ ] El veredicto de plaza solo se emitió con ≥2 eventos con T+90 completo.
- [ ] El costo por SV se contrastó explícitamente contra el CAC fully-loaded de eventos ([cifra interna]).
- [ ] Si falta el valor de Vive Casas, la rentabilidad quedó como `no calculable`.

**Operación**
- [ ] Una sola pasada: sin loops, sin research, sin llamadas externas.
- [ ] Output markdown/tabla, pegable en Sheets o Slides.
- [ ] Advertencias de cabecera presentes si el evento tiene <45 días de pauta o no tiene dirección.
- [ ] Los `[⚠ no verificado]` sobreviven en el output: curva de registros y valor de Vive Casas.
- [ ] Español de Colombia, tuteo.
