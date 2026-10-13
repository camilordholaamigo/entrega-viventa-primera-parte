---
name: viventa-forecast-pauta
description: >-
  Convierte los exports pegados de Meta Ads, Zoho Expense y tarjetas corporativas en el forecast del
  mes: cuánto va a cerrar la pauta y todo el presupuesto de mercadeo por campaña y rubro, con 4 capas
  de gasto, días útiles para corregir, alertas tempranas y la conciliación cuando llega la
  contabilidad. Alerta y recomienda; no aprueba nada. USA cuando: "¿cómo vamos de presupuesto?",
  "¿nos vamos a pasar este mes?", "proyecta el gasto de la campaña", "llegó la contabilidad, concilia
  el mes". Es el mes en curso: viventa-reporte-campanas consolida resultados.
metadata:
  version: "1.2.0"
  domain: "finance"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-forecast-pauta

Produce **la ficha de forecast de pauta de 1 página** con la que la gerente de Growth sale, en 90
segundos, con una decisión que **todavía cabe dentro del mes**.

El dolor es de **devengo, no de reporting**: el gasto se reconoce cuando llega la factura, así que al
15 de junio se tiene información hasta mayo (20-25 días de latencia). Este skill **no espera
facturas**: el spend-to-date del Ads Manager es dato duro aunque contabilidad no lo haya visto.

Invariantes: **alerta y recomienda; no aprueba, no pausa, no recorta, no reasigna** (regla durable
del cliente); toda opción sale rotulada *"requiere aprobación de dirección financiera"*. **Una sola
pasada**: sin research web, sin llamadas externas, sin ronda de repreguntas (las cuentas de IA son
compartidas y se quedan sin créditos hasta 4 horas). Lo que falte se declara dentro del output.

## Cuándo usar

- Explícito: "¿cómo vamos de presupuesto de pauta este mes?", "haceme el forecast de pauta de
  {mes}", "siento que esta campaña nos va a salir muy costosa", "¿nos vamos a pasar del presupuesto
  en Meta?", "estamos a 15 y no sé cuánto llevamos gastado de verdad", "¿todavía alcanzo a corregir
  esto o ya se me fue el mes?", "corte de pauta al día {n}", "¿el gasto que llevamos nos va a dar
  los leads que necesitamos?".
- Cadencia sugerida: día 10 (solo gasto y pacing) · **día 15 (corte principal, ficha completa)** ·
  día 22-23 (último corte con margen) · día 1-2 del mes siguiente (cierre: devengado real contra lo
  proyectado el 15, para calibrar el método).

## Cuándo NO usar

- El consolidado de resultados del área (leads, CPL, conversión) de una semana o mes → 
  `viventa-reporte-campanas`.
- Cómo va un evento puntual y si se repite → `viventa-monitor-evento`.

## Input del usuario

Los exports vienen **pegados como CSV o tabla**. No hay integración por API con Meta ni con Zoho.

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| A · Export Meta Ads del 1 al día de corte, por ad set: nombre, gasto, leads, presupuesto diario, estado | Ads Manager, pegado | *"Pegame el export de Meta del 1 al {día}, por ad set, con gasto, leads, presupuesto diario y estado."* **Bloquea**: sin esto no hay ficha |
| B · Presupuesto aprobado del mes por canal | Dirección financiera / el usuario | *"¿Cuál es el presupuesto aprobado de pauta por canal para {mes}?"* Si no lo tiene: ficha solo con capas y pacing sin meta, y arriba *"sin presupuesto aprobado cargado no hay desviación calculable"*. **Nunca se infiere** |
| C · CPL objetivo del mes (el que fijó la agencia) | La agencia de pauta | *"¿Qué CPL objetivo fijó la agencia para {mes}?"* Si no lo tiene: no se emite el cruce gasto↔leads ni la alerta "va a salir cara"; se reporta CPL real `[dato]` sin contra qué comparar |
| D · Export Zoho Expense con su fecha de corte | Zoho Expense | *"¿Tenés el export de Expense? ¿A qué fecha?"* Si no: capa 3 = `[n/d]` y va a "Qué no sé" como sub-estimación probable |
| E · Eventos del mes: nombre, fecha, pauta briefeada | Brief de eventos | *"¿Hay eventos este mes con pauta briefeada? Nombre, fecha y monto."* Si no: *"no se cargaron eventos; si hay alguno, esta proyección lo sub-estima"* |
| F · Export Google Ads u otros canales | Plataforma | No se pregunta: la fila del canal va en `[n/d]`, no se omite |
| G · Latencia de la agencia (round-trip brief→implementación) | El usuario | No se pregunta: default **4-5 días** (2 hábiles de round-trip + 2-3 de re-estabilización algorítmica) `[⚠ no verificado — calibrar con la gerente de Growth]` |
| Mes y día de corte | El usuario o la fecha del export | *"¿A qué día cortamos?"* — default: último día del export A, declarado |
| H · Presupuesto de mercadeo por rubro y campaña (modo C) | Gerencia de Growth / dirección financiera | *"¿Cuál es el presupuesto aprobado del mes por rubro (pauta, agencias, eventos, producción, merchandising, herramientas) y por campaña?"* Sin él, el modo C muestra gasto y proyección sin desviación |
| I · Cargos de tarjetas corporativas (modo C) | Extracto o export: fecha, comercio, monto, centro de costo o campaña, legalizado sí/no — **sin número de tarjeta** | *"¿Me pasas los cargos de las tarjetas corporativas de mercadeo del mes, con si ya están legalizados?"* Sin esto, la fila de tarjetas va `[n/d]` y a "Qué no sé" |
| J · Cierre contable del mes (modo D) | Contabilidad | Solo en modo D: *"Pásame el cierre contable de mercadeo de {mes} por rubro."* **Bloquea** el modo D |

**Por qué B y C no se infieren:** el CAC ad-spend de Meta ([cifra interna] con [cifra interna] leads/6m) implica un CPL de
~$2.90, incompatible con el CPL canónico de [cifra interna]. Los "leads de Meta" mezclan pagados con orgánicos,
así que de ahí no se deriva nada. `[⚠ no verificado]`

## Workflow

### Fase 1 — Encuadre del corte
Fija: mes, día de corte, días transcurridos, días calendario restantes, % del mes.
Anota la **ventana de cada export** (ej. "Meta 1-15 ago · Expense al 14-ago"). Si un export
termina antes del día de corte, el hueco va a "Qué no sé" desde ya.

### Fase 2 — Clasificar el gasto en las 4 capas
Cada peso del export cae en exactamente una capa. Ver `references/capas-y-metodos.md`.

| # | Capa | Origen | Reversible |
|---|---|---|---|
| 1 | Ejecutado y facturado | Contabilidad / Expense aprobado | No |
| 2 | **Ejecutado sin facturar** | Spend-to-date del Ads Manager | No — *es el ciego de hoy* |
| 3 | Pendiente de legalizar | Zoho Expense cargado sin aprobar | No (ya ocurrió) |
| 4 | Comprometido | Presupuesto diario activo × días restantes + brief de agencia + retainer | **Sí, parcialmente** |

**Capas 1+2+3 = posición devengada.** Subtotal siempre visible. Las 4 filas se muestran aunque
una vaya en cero: `Eventos: comprometido $0` informa.

### Fase 3 — Proyectar el cierre, por canal
Nunca en agregado — un canal sub-ejecutando enmascara a otro sobre-ejecutando.

```
Cierre proyectado = Posición devengada (1+2+3)
                  + Comprometido remanente (4)
                  + Gasto libre proyectado (ritmo × días restantes sin compromiso)
```
Se corren los **tres métodos** (compromisos ← primario, run-rate lineal, ventana de 3 días). Si
difieren >5%, **se reporta banda, no punto**. Los eventos salen del run-rate y entran como
bloque fechado en capa 4.
**El supuesto de ritmo va escrito debajo, siempre.**

### Fase 4 — Días útiles y monto influenciable
```
Días útiles = días calendario restantes
            − latencia de la agencia externa (~4-5 días)
            − días bloqueados por compromisos irreversibles
```
Compromisos irreversibles = pauta de eventos dentro de la ventana de 45 días + todo lo devengado.
El **monto influenciable** es su complemento en plata. Ambos van **arriba, en el titular**.

**Si días útiles ≤ 0, o hay desvío y quedan menos de 5 días útiles (1-4) → salta al Modo B (§Modos de salida) y termina.** No emitas alertas ni
opciones.

### Fase 5 — Cruce gasto ↔ leads y matriz de divergencia
Por canal: leads a la fecha `[dato]`, inversión `[dato]`, CPL real `[dato, derivado]`,
CPL proyectado a cierre `[proyección]`, meta `[input]`.
Leads proyectados = `leads a la fecha ÷ % del mes transcurrido`, **solo válido en régimen**. Si
el gasto proyectado difiere >20% del ritmo actual, la proyección de leads **se degrada a rango y
se dice**.

Clasifica en la matriz (detalle en `references/umbrales-alertas.md`):

|  | Leads en ritmo | Leads atrasados |
|---|---|---|
| **Gasto en ritmo** | 🟢 Sano | 🔴 **EFICIENCIA** — el CPL se degradó |
| **Gasto atrasado** | 🟢 Mejor de lo planeado | 🟡 **ENTREGA** — el CPL está sano, no está gastando |
| **Gasto sobre-ejecutando** | 🟡 Volumen comprado, revisar el marginal | 🔴🔴 Peor cuadrante |

Nombra el cuadrante con esa palabra: **eficiencia** o **entrega**. Hoy las cuatro celdas se
llaman igual ("nos sobre-ejecutamos") y son cuatro conversaciones distintas.

**Al proponer subir gasto:** declara que la extrapolación no es válida hacia arriba (curva S, el
inventario barato ya se agotó) y no prometas leads proporcionales.

### Fase 6 — Semáforo y alerta
Umbrales completos en `references/umbrales-alertas.md`. Doble condición **% y monto**, con
persistencia de 2 días. La alerta *"esta campaña va a salir cara"* exige las tres juntas:
CPL real ≥20% sobre objetivo · sostenido ≥3 días · quedan ≥5 días útiles.
Sub-ejecución <75% al día 20 dispara **alerta simétrica** — presupuesto sin usar es mala
planeación, no ahorro.

### Fase 7 — Máximo 3 opciones
Cada una: **qué se tocaría · cuánto libera · por qué esa y no otra · qué riesgo tiene.**
Si hay más de 3 candidatas, prioriza por monto liberado ÷ riesgo y **di en una línea qué dejaste
fuera**. Marca explícitamente **QUÉ NO SE TOCA** (pauta de eventos a ≤45 días).
Al señalar dirección de reasignación puedes usar el CAC fully-loaded canónico como marco
(Web [cifra interna] · Email [cifra interna] · WhatsApp [cifra interna] · Instagram [cifra interna] · Meta [cifra interna] · Google [cifra interna] · Eventos [cifra interna]),
**sin prometer el resultado de la reasignación**.

### Fase 8 — "Qué no sé" y autovalidación
Declara huecos y ventanas de export. Corre el checklist del final. Si algo falla, corrígelo
antes de emitir — no hay segunda pasada.

---

### Modos de salida

- **Modo A — Ficha completa** (≥5 días útiles, o 1-4 días útiles sin desvío): la plantilla de `Output esperado`.
- **Modo C — Presupuesto de mercadeo completo** (cuando piden "presupuesto de mercadeo", una
  campaña o un rubro que no es pauta): las mismas 4 capas, ahora por **rubro y campaña**. Capa 2 suma
  los cargos de tarjetas sin legalizar; capa 3, lo cargado en Expense sin aprobar; capa 4, lo aprobado
  en Expense que todavía no se gasta, los retainers y la pauta comprometida. Entrega la tabla semanal
  (presupuesto · comprometido · ejecutado · proyección al cierre · desviación) por campaña y por rubro,
  y las **alertas tempranas ordenadas por riesgo**: primero lo que va a sobreejecutarse con menos días
  útiles para corregir. Un rubro sin presupuesto cargado se muestra igual, marcado.
- **Modo D — Conciliación con contabilidad** (cuando llega el cierre contable): compará por rubro la
  proyección del último corte contra lo contabilizado. Cada diferencia mayor a 5 % se explica en una
  de cuatro causas: desfase de fechas, reclasificación de rubro, gasto no visto en ninguna fuente o
  error de proyección. Cerrá con qué ajustar del método para el mes siguiente.
- **Modo B — Nota para el mes entrante** (días útiles ≤ 0, o desvío con <5 días útiles):
  sin alertas, sin opciones. Estructura: titular con el cierre proyectado ·
  4 capas · qué explicó la desviación · **qué cargar distinto en el presupuesto del mes
  siguiente** · qué no sé. Encabezado literal:
  *"{Mes} ya está definido en $X `[proyección]`. Lo accionable es el presupuesto de {mes+1}."*

### Checklist de autovalidación (todo bloqueante)

**Estructura**
- [ ] Cabe en 1 página. El titular está arriba y se entiende sin leer el resto.
- [ ] Las 4 capas son filas separadas, con subtotal de posición devengada visible.
- [ ] Máximo 3 opciones, cada una con monto, línea específica y riesgo.
- [ ] Existe "Qué no sé" con las ventanas de los exports.

**Integridad numérica**
- [ ] Cero números sin etiqueta `[dato]`/`[proyección]`/`[input]`/`[n/d]`.
- [ ] Cero decimales en cifras proyectadas.
- [ ] Toda proyección tiene su supuesto de ritmo escrito debajo.
- [ ] Si los métodos difieren >5%, hay banda y no punto.
- [ ] Ninguna cifra suma capas de distinta naturaleza sin desglose.

**Reglas del cliente**
- [ ] CPL y CAC nunca en la misma columna sin etiqueta.
- [ ] Ninguna tasa de conversión usada sin nombrar cuál ([cifra interna] desembolso / [cifra interna] pago de
      servicio). **Jamás se suman ni se promedian.**
- [ ] Ticket SV = $480 USD (no $495).
- [ ] **Cero verbos de decisión.** Encabezado "requieren aprobación de dirección financiera".
- [ ] La pauta de eventos a ≤45 días está marcada NO TOCABLE y fuera del monto influenciable.
- [ ] No se calculó CAC mensual.

**Lógica del forecast**
- [ ] Días útiles y monto influenciable están arriba, no al final.
- [ ] Si días útiles ≤0, la salida es Modo B, sin alertas ni opciones.
- [ ] El diagnóstico dice la palabra **eficiencia** o **entrega**.
- [ ] Sub-ejecución dispara alerta simétrica.

**Operación**
- [ ] Una sola pasada: sin research web, sin loops, sin llamadas externas.
- [ ] El input fueron exports pegados, nunca API.
- [ ] Salida en markdown/texto pegable en Sheets o Slides.

---

## Reglas duras

Si una se rompe, la ficha no sale.

1. **Ningún número desnudo.** Cada cifra lleva `[dato]` · `[proyección]` · `[input]` · `[n/d]`.
2. **Las 4 capas de gasto nunca se mezclan** en una sola cifra sin desglose visible. Ese es el
   pecado capital.
3. **Presupuesto aprobado y CPL objetivo son INPUT obligatorio, jamás inferencia.** No se
   derivan de las cifras canónicas (ver `Input del usuario`, filas B y C).
4. **Toda proyección lleva su supuesto de ritmo escrito inmediatamente debajo.** Sin esa línea,
   la proyección no se emite.
5. **Sin decimales falsos.** Proyecciones redondeadas a la centena, datos al dólar, porcentajes
   sin decimal. `$21,973.42` proyectado es una mentira de formato.
6. **Prohibido calcular CAC del mes.** El skill se detiene en CPL. Con 1-2 cierres mensuales
   cualquier CAC es ruido estadístico.
7. **Proyección nunca lineal pura:** los eventos son bloques discretos fechados, fuera del
   run-rate.
8. **Si días útiles ≤ 0, el output cambia de género:** deja de ser alerta y pasa a nota para el
   mes entrante. Una alerta sin margen de acción es un post-mortem que genera ansiedad.
9. **Cero verbos de decisión.** Nunca "pausé", "recorté", "aprobado", "reasigné". Nunca
   "optimizar el presupuesto" ni "revisar la estrategia".
10. **Máximo 3 opciones**, cada una con monto liberado, línea específica y riesgo. Si no tiene
    monto, no es opción y no entra.
11. **Sección "Qué no sé" obligatoria**, con la ventana de cada export.
12. **Los `[⚠ no verificado]` sobreviven** como advertencias en el output, no se limpian.
13. Español de Colombia, tuteo. Salida en markdown/texto pegable en Google Sheets o Slides.
14. **Las cifras de presupuesto y gasto son sensibles**: la ficha es interna, no se comparte fuera
    de Viventa ni con la agencia sin aprobación de la gerencia, y nunca lleva números de tarjeta ni
    datos bancarios.

---

## Output esperado

No escribe archivos salvo que se pida; en ese caso `salidas/viventa-forecast-pauta/{AAAA-MM}-corte-{dd}.md`. Devuelve en la conversación la ficha en markdown/texto pegable en Sheets o Slides. Modo A, con esta plantilla exacta (Modo B: la estructura de §Modos de salida):

```
FORECAST DE PAUTA — {MES AÑO} · corte {dd-mmm} (día {n} de {N} · {x}% del mes)
Generado {dd-mmm hh:mm} · fuente: {export Meta 1-{n}} + {export Zoho Expense al {dd-mmm}}

┌─ EL TITULAR ────────────────────────────────────────────────────────────┐
│ Van a cerrar {mes} entre ${X} y ${Y} [proyección]                        │
│ contra un presupuesto aprobado de ${Z} [input].                          │
│ {Sobre|Sub}-ejecución proyectada: ${A} a ${B} ({p}% a {q}%).             │
│                                                                          │
│ ⏱ Quedan {c} días calendario, pero solo {u} días útiles para corregir    │
│   y ${I} de gasto todavía influenciable [proyección].                    │
│   {Los $N del evento {X} ({fecha}) están dentro de la ventana de 45      │
│    días — no entran en la conversación.}                                 │
└──────────────────────────────────────────────────────────────────────────┘

LAS 4 CAPAS DE GASTO — dónde está la plata hoy
                                       Meta   Google  Eventos    TOTAL
 1 Ejecutado y facturado    [dato]      ...      ...      ...      ...
 2 Ejecutado sin facturar   [dato]      ...      ...      ...      ...   ← el ciego de hoy
 3 Pdte. de legalizar (Exp) [dato]      ...      ...      ...      ...
   ─────────────────────────────────────────────────────────────────────
   POSICIÓN DEVENGADA al {n}            ...      ...      ...      ...

 4 Comprometido remanente   [dato]      ...      ...      ...      ...
   (ad sets activos × días restantes + pauta del evento ya briefeada)
   ─────────────────────────────────────────────────────────────────────
   CIERRE PROYECTADO         [proy.]    ...      ...      ...      ...
   Presupuesto aprobado      [input]    ...      ...      ...      ...
   Desviación                [proy.]    ...      ...      ...      ...

 Supuesto de ritmo: {los ad sets activos mantienen su presupuesto diario actual
 ($X/día Meta, $Y/día Google) hasta el {último día}. Sin eventos nuevos.}
 Método alterno (run-rate lineal puro): cierre ${W}. Por eso la banda.

SEMÁFORO POR CANAL — pacing = ejecutado ÷ esperado a día {n}
 {🔴|🟡|🟢|🔵} {Canal}  {p}%  {una línea, solo si no es verde}

EL CRUCE QUE IMPORTA — ¿este gasto va a dar los leads?
                            a la fecha [dato]  proyección [proy.]  meta [input]
 Leads {canal}                    ...                ...              ...
 Inversión {canal}                ...                ...              ...
 CPL {canal}                      ...                ...              ...

 → {Diagnóstico en una frase con el número.}
   Es divergencia de {EFICIENCIA|ENTREGA}: {por qué}.
   Supuesto: {CPL en régimen · qué no está modelado y no se promete}.

OPCIONES SOBRE LA MESA — requieren aprobación de dirección financiera
 A · {qué se tocaría, línea específica}. Libera ~${m}. {Por qué esa}.
     Riesgo: {cuál}.
 B · ...
 C · ...
 Suma A+B+C: ~${M} → cierre proyectado ~${F}, {dentro de|aún sobre} presupuesto.
 {Quedó fuera: {opción} — {razón en media línea}.}

 QUÉ NO SE TOCA: {pauta del evento {X} ({fecha}). Está dentro de los 45 días de
 aprendizaje; moverla degrada el CPL del evento.}

 QUÉ NO SÉ: {hueco 1 con su ventana de export y en qué dirección sesga la cifra}.
 {[⚠ no verificado] que apliquen.}
```

---

### Ejemplo recortado (formato, no datos reales de Viventa)

```
FORECAST DE PAUTA — AGOSTO 2026 · corte 15-ago (día 15 de 31 · 48% del mes)

┌─ EL TITULAR ──────────────────────────────────────────────────────────┐
│ Van a cerrar agosto entre $22,000 y $23,400 [proyección] contra un     │
│ presupuesto aprobado de $20,000 [input]. Sobre-ejecución: 10% a 17%.   │
│ ⏱ Quedan 16 días calendario, pero solo 11 días útiles para corregir    │
│   y $9,000 todavía influenciables [proyección].                        │
└────────────────────────────────────────────────────────────────────────┘

 2 Ejecutado sin facturar   [dato]   $7,050  $1,480  $    0  $ 8,530  ← el ciego
   POSICIÓN DEVENGADA al 15          $7,050  $1,480  $2,800  $11,330
 4 Comprometido remanente   [dato]   $7,520  $1,520  $1,600  $10,640
   CIERRE PROYECTADO        [proy.] $14,600  $3,000  $4,400  $22,000

 CPL Meta: $65 a la fecha [dato] · $65 proyectado [proy.] · [cifra interna] meta [input]
 → Meta va a gastar 21% más para entregar 7% menos leads. Es divergencia de
   EFICIENCIA, no de entrega: el gasto está en ritmo, los leads no.

 A · Bajar el diario de "Retargeting ES" de $180 a $110 por 14 días. Libera
     ~$1,000. Es el ad set con CPL $112, el peor de los 4. Riesgo: reentra en
     aprendizaje ~48-72h.
 QUÉ NO SÉ: no tengo Expense posterior al 14-ago. Si hay legalizaciones de la
 semana del 11-15 sin cargar, la posición devengada real es mayor.
```

Al entregar se dice: *"Ficha de pauta al {dd-mmm}: cierre proyectado {banda}, {u} días útiles. Las opciones requieren aprobación de dirección financiera."*

## Skills relacionados

- **Antes:** `viventa-brief-evento` da la fecha y la pauta briefeada de los eventos (input E);
  `viventa-compra-merchandising` y `viventa-evento-aliado`, los compromisos de esos rubros.
- **Relacionado:** `budget-builder` si hay que armar el presupuesto anual o del trimestre desde cero.
- **Después:** `viventa-reporte-campanas` consolida el mes cerrado; el corte del día 1-2 de este skill
  calibra el método contra lo devengado real.
- **En vez de este:** `viventa-monitor-evento` para la pauta de un evento puntual.
- **Referencias:** `references/capas-y-metodos.md` (las 4 capas, los tres métodos de proyección,
  ajuste por eventos, qué no se modela) · `references/umbrales-alertas.md` (semáforo, matriz de
  divergencia, días útiles, cadencia) · `references/reglas-datos.md` (reglas de datos y
  anti-patterns con antídoto).
