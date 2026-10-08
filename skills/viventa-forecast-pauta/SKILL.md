---
name: viventa-forecast-pauta
description: >-
  Convierte los exports pegados de Meta Ads y Zoho Expense en una ficha de 1 página que dice
  cuánto va a cerrar el mes en pauta, cuántos días útiles quedan para corregirlo y qué tres
  cosas se pueden mover — separando las 4 capas de gasto y cerrando los 20-25 días de latencia
  entre que la plata se gasta y que Lizeth se entera. Alerta y recomienda; no aprueba nada.
metadata:
  version: "1.0.0"
  domain: "finance"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-forecast-pauta

Produce **la ficha de forecast de pauta de 1 página** con la que Lizeth puede, en 90 segundos,
salir con una decisión que **todavía cabe dentro del mes**.

El dolor que resuelve es de **devengo, no de reporting**: hoy el gasto se reconoce cuando llega
la factura, así que al 15 de junio ella tiene información hasta mayo. Este skill **no espera
facturas**. El spend-to-date del Ads Manager es dato duro aunque contabilidad no lo haya visto.

**Este skill alerta y recomienda. No aprueba, no pausa, no recorta, no reasigna** (Regla durable
#5 del cliente). Todas las opciones salen rotuladas *"requieren aprobación de dirección
financiera"*.

**Una sola pasada.** Sin research web, sin llamadas externas, sin loops, sin ronda de
repreguntas — las cuentas de IA son compartidas y con límite de créditos (4 horas de espera).
Lo que falte se declara dentro del mismo output.

---

## Reglas duras (si una se rompe, la ficha no sale)

1. **Ningún número desnudo.** Cada cifra lleva `[dato]` · `[proyección]` · `[input]` · `[n/d]`.
2. **Las 4 capas de gasto nunca se mezclan** en una sola cifra sin desglose visible. Ese es el
   pecado capital.
3. **Presupuesto aprobado y CPL objetivo son INPUT obligatorio, jamás inferencia.** No se
   derivan de las cifras canónicas (ver §Inputs, caso B).
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

---

## Input del usuario

Los exports vienen **pegados como CSV o tabla**. **No hay integración por API con Meta ni con
Zoho — hoy no existe.** Si el usuario no pega nada, se le piden los bloques, no se inventa.

| # | Input | Obligatorio | Si falta |
|---|---|---|---|
| A | **Export Meta Ads** (1 al día de corte): por ad set — nombre, gasto, leads, presupuesto diario, estado | Sí | Sin esto no hay ficha. Se piden las columnas mínimas y se detiene. |
| B | **Presupuesto aprobado del mes por canal** | Sí | Se emite la ficha **solo con capas de gasto y pacing sin meta**, y se declara arriba: *"sin presupuesto aprobado cargado no hay desviación calculable"*. **Nunca se infiere.** |
| C | **CPL objetivo del mes** (el que fijó la agencia) | Sí para el cruce | Sin él **no se emite el cruce gasto↔leads ni la alerta "va a salir cara"**. Se reporta CPL real `[dato]` y se declara que no hay contra qué compararlo. |
| D | **Export Zoho Expense** con su fecha de corte | Deseable | Capa 3 = `[n/d]`, y va a "Qué no sé" como sub-estimación probable. |
| E | **Eventos del mes**: nombre, fecha, pauta briefeada | Deseable | Se declara *"no se cargaron eventos; si hay alguno, esta proyección lo sub-estima"*. |
| F | **Export Google Ads** u otros canales | Opcional | Fila del canal en `[n/d]`, no se omite la fila. |
| G | **Latencia de la agencia** (round-trip brief→implementación) | Opcional | Se usa el default **4-5 días** (2 hábiles de round-trip + 2-3 de re-estabilización algorítmica) marcado `[⚠ no verificado — calibrar con Lizeth]`. |

**Por qué B y C no se infieren:** el CAC ad-spend de Meta ([cifra interna] con [cifra interna] leads/6m) implica un
CPL de ~$2.90, incompatible con el CPL canónico de [cifra interna]. Los "leads de Meta" mezclan pagados con
orgánicos, así que de ahí no se deriva nada. `[⚠ no verificado]`

---

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

**Si días útiles ≤ 0 → salta al modo B (§Modos de salida) y termina.** No emitas alertas ni
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

## Modos de salida

- **Modo A — Ficha completa** (días útiles ≥ 1): la plantilla de abajo.
- **Modo B — Nota para el mes entrante** (días útiles ≤ 0, o desvío con <5 días útiles):
  sin alertas, sin opciones. Estructura: titular con el cierre proyectado ·
  4 capas · qué explicó la desviación · **qué cargar distinto en el presupuesto del mes
  siguiente** · qué no sé. Encabezado literal:
  *"{Mes} ya está definido en $X `[proyección]`. Lo accionable es el presupuesto de {mes+1}."*

**Cadencia sugerida:** día 10 (solo gasto y pacing) · **día 15 (corte principal, ficha
completa)** · día 22-23 (último corte con margen) · día 1-2 del mes siguiente (cierre: devengado
real vs lo proyectado el 15, para calibrar el método).

---

## Plantilla exacta del output

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

## Ejemplo recortado (formato, no datos reales de Viventa)

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
   CIERRE PROYECTADO        [proy.] $14,570  $3,000  $4,400  $21,970

 CPL Meta: $65 a la fecha [dato] · $65 proyectado [proy.] · [cifra interna] meta [input]
 → Meta va a gastar 21% más para entregar 7% menos leads. Es divergencia de
   EFICIENCIA, no de entrega: el gasto está en ritmo, los leads no.

 A · Bajar el diario de "Retargeting ES" de $180 a $110 por 14 días. Libera
     ~$980. Es el ad set con CPL $112, el peor de los 4. Riesgo: reentra en
     aprendizaje ~48-72h.
 QUÉ NO SÉ: no tengo Expense posterior al 14-ago. Si hay legalizaciones de la
 semana del 11-15 sin cargar, la posición devengada real es mayor.
```

---

## Referencias

- `references/capas-y-metodos.md` — las 4 capas en detalle, modos de falla al mezclarlas, los
  tres métodos de proyección, ajuste por eventos, qué el skill **no** modela.
- `references/umbrales-alertas.md` — tabla de semáforo, matriz de divergencia comentada, días
  útiles, cadencia de cortes.
- `references/reglas-datos.md` — las 10 reglas de datos canónicas y los 14 anti-patterns con su
  antídoto.

---

## Checklist de autovalidación (todo bloqueante)

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
