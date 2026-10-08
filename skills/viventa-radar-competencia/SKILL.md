---
name: viventa-radar-competencia
description: >-
  El radar mensual de mercado: qué publicaron y qué pautaron los competidores, cómo va Viventa
  contra el benchmark del sector, y qué se dijo de la marca en el periodo. Cierra con qué cambió
  desde la corrida anterior y qué implica para la parrilla del mes. Compara contra el baseline
  real del Voice of Customer, no contra cero, y lo que no se pudo verificar va a "no observado"
  en vez de estimarse.
metadata:
  version: "1.0.0"
  domain: "analyze"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# viventa-radar-competencia

Produce **el radar de mercado del mes**: competencia, benchmark y menciones de marca, en un solo
documento de máximo 2 páginas.

**Quién lo usa:** Lizeth Henríquez y Daniel Vélez.

**La regla que gobierna todo:** este skill **observa y reporta**. No recomienda campañas, no
escribe copy y no decide presupuesto. Su salida alimenta a `viventa-parrilla-base` y a
`viventa-inteligencia-campana`.

**Una sola pasada.** Cuentas compartidas, créditos limitados. **Nada de research de 6 fases** —
si el material no está en el input o en una búsqueda acotada, va a "no observado".

---

## Por qué este skill existe

`viventa-inteligencia-campana` mira ángulos de competencia **como insumo de una campaña puntual**.
Nadie mira el mercado **como proceso**, y por eso no hay forma de saber qué cambió.

El Voice of Customer que usan todos los skills es un **snapshot de 90 días congelado**. Sirve como
baseline, pero no dice qué pasó este mes.

Dos hechos que cambian cómo se mira:

**1. Meta Special Ad Category.** Desde el 14-ene-2025, los anuncios de productos financieros
pierden segmentación por edad, género y código postal. **El hook sustituye al targeting.** Por eso
este radar mira **hooks y ángulos**, no audiencias — mirar audiencias sería mirar lo que ya no
decide nada. También puede explicar parte del CAC de Meta ([cifra interna]) mejor que el creativo.

**2. El ángulo "raíces" está saturado.** Los ~8 brokers autorizados por Bancolombia lo usan todos.
Un radar que reporte "la competencia habla de volver a casa" no está reportando nada.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **Lo no verificado va a "no observado".** Nunca se estima el gasto de un competidor, su
   volumen de leads ni su resultado. Si no se vio, no se dice.
2. **Toda observación lleva su evidencia:** qué pieza, dónde, cuándo. Una afirmación sobre la
   competencia sin el ejemplo concreto no entra.
3. **Toda fila de benchmark declara fuente, ventana y universo.** Si los tres no están, la fila
   no se emite y va a "métricas no emitidas".
4. **Solo se compara lo comparable.** Métrica propia contra métrica ajena medida distinto es una
   comparación falsa aunque los números existan. Ante la duda, no se compara y se dice por qué.
5. **El social listening compara contra el baseline real, no contra cero.** Baseline del VOC 90d:
   **6 % de comentarios** (vs 0-0,3 % de competidores) · **1,7 % de negativos** (vs 10-15 % del
   sector) · **41 testimoniales largos espontáneos** · **5 recompradores**.
6. **Cero PII.** Las menciones se reportan por volumen y sentimiento. Un verbatim público se cita
   textual y sin identificar a la persona más allá de su handle público.
7. **Cero cifras fuera de `references/cifras-canonicas.md`** para lo propio. CPL ≠ CAC. El +42 %
   es participación del segmento de no residentes, **no crecimiento del mercado** (el mercado
   total crece 5-12 %).
8. **No escribe copy ni propone campañas.** Eso es `inteligencia-campana` y `parrilla-base`.
9. **Español de Colombia, tuteo.**
10. Máximo **2 páginas**.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| Periodo a cubrir | **Sí** | Asumir el mes cerrado anterior y decirlo |
| Lista de competidores a mirar | No | Usar los brokers autorizados por Bancolombia y declararlo |
| Piezas o anuncios recolectados (capturas, links, texto) | No | Búsqueda acotada. Lo no hallado → "no observado" |
| Métricas propias del periodo (de `viventa-reporte-campanas`) | No | El bloque de benchmark sale incompleto y se dice |
| Menciones de marca recolectadas | No | Búsqueda acotada, mismo criterio |
| Radar del mes anterior | No | **El bloque "qué cambió" no se emite.** No se inventa una comparación |

---

## Workflow

### Fase 1 — Encuadre

Fijá periodo, competidores y qué fuentes se pudieron mirar de verdad. **Escribí desde el arranque
qué no se pudo cubrir** — es lo que evita que el lector asuma cobertura total.

### Fase 2 — Competencia: contenidos y pauta

Por competidor, solo lo observado:
- Qué publicó en el periodo (formato y tema)
- Qué ángulo o hook está corriendo, **con la pieza como evidencia**
- Si está pautando y qué anuncio se vio (Meta Ad Library si está disponible)

**Prohibido:** estimar presupuesto, inferir resultados, deducir estrategia de una sola pieza.

**Qué sí es señal:** un ángulo que aparece en varios competidores a la vez, un formato nuevo, un
sub-segmento que alguien empezó a atender.

### Fase 3 — Benchmark

Tabla contra métricas propias, **solo filas comparables**. Fuente, ventana y universo en cada una.

Lo que no cumpla las tres cosas va a **"Métricas no emitidas y por qué"**, igual que en
`viventa-reporte-campanas`.

### Fase 4 — Social listening

Volumen de menciones, separando **espontáneas** de **respondidas**, con saldo de sentimiento.

Contra el baseline de la regla 5. **Un 3 % de negativos no es "malo": es casi el doble del
baseline propio y aún así muy por debajo del sector.** Sin baseline, cualquier número se lee mal.

Recogé también los **sub-segmentos desatendidos** que aparezcan — el VOC ya identificó veteranos
con VA loan, Puerto Rico, vivienda usada y compra sin cuota inicial. Si alguien de la competencia
los está atendiendo, eso es el hallazgo del mes.

### Fase 5 — Qué cambió

**Solo si hay radar anterior.** Si no lo hay, la sección dice *"primera corrida — no hay
comparación posible"* y se establece este radar como baseline.

Máximo 3 cambios, cada uno con su implicación para la parrilla en una línea.

### Fase 6 — Autovalidación

Corré el checklist antes de emitir.

---

## Formato del entregable

```
# Radar de mercado — {periodo}

Cobertura: {qué se miró} · No cubierto: {qué no}

## 1. Competencia
{por competidor: qué publicó, qué ángulo, evidencia}

## 2. Benchmark
{tabla comparable, con fuente/ventana/universo}
### Métricas no emitidas y por qué

## 3. Menciones de marca
{volumen, espontáneas vs respondidas, sentimiento vs baseline}

## 4. Qué cambió desde la corrida anterior
{máx. 3, con implicación para la parrilla}

## 5. No observado
{lo que no se pudo verificar}
```

---

## Fronteras

| Este skill | El otro |
|---|---|
| Observa el mercado, mensual | `viventa-inteligencia-campana` produce el insight de **una campaña** |
| No propone envíos | `viventa-parrilla-base` los planifica, consumiendo esta salida |
| Mira afuera | `viventa-reporte-campanas` mira adentro |

---

## Checklist de autovalidación

**A · Verificabilidad**
- [ ] Toda observación de competencia trae su evidencia concreta
- [ ] Cero estimaciones de presupuesto, leads o resultados ajenos
- [ ] Existe la sección **"No observado"**, aunque diga "nada relevante"
- [ ] La cobertura real está declarada arriba

**B · Benchmark**
- [ ] Toda fila declara fuente, ventana y universo
- [ ] Las filas que no cumplen están en "métricas no emitidas", no omitidas
- [ ] No comparé métricas medidas distinto
- [ ] CPL y CAC nombrados completos, nunca mezclados

**C · Social listening**
- [ ] El sentimiento se comparó contra el baseline del VOC, no contra cero
- [ ] Espontáneas y respondidas están separadas
- [ ] Cero PII más allá de handles públicos

**D · Lectura**
- [ ] Si no hay radar anterior, "qué cambió" dice que es la primera corrida
- [ ] No reporté "la competencia habla de raíces" como hallazgo — está saturado y ya se sabe
- [ ] Miré hooks y ángulos, no audiencias (Special Ad Category)
- [ ] Máximo 3 cambios, cada uno con implicación

**E · Alcance**
- [ ] No escribí copy ni propuse campañas
- [ ] Cabe en 2 páginas
- [ ] El +42 % está descrito como participación del segmento, no como crecimiento del mercado

---

## Referencias

- `references/panorama-competitivo.md` — los brokers autorizados, el mapa de ángulos saturados,
  Special Ad Category y los sub-segmentos desatendidos
- `references/cifras-canonicas.md` — fuente de verdad de todo número propio
- `references/contexto-viventa.md` — contexto del cliente
- `references/voice-of-customer-90d.md` — el baseline de social listening
