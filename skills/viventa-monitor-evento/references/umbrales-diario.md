# Umbrales del modo diario — tablas de consulta

Se lee completo antes de emitir cualquier alerta del modo diario.
Los 4 gates se aplican **en cascada y en orden**. Una alerta solo existe si pasa los cuatro.

---

## Gate 1 — Muestra mínima

El error relativo del CPL sobre `n` leads es ≈ `1/√n`. Con n=9 el error de muestreo solo ya es ±33%.

**Regla dura:** con `n < 30` leads acumulados (del evento o del ad set, según lo que se esté
juzgando) **no se emite juicio de CPL**. Se reporta el número con la etiqueta `muestra
insuficiente` y se sigue de largo.

**Umbral dinámico de desviación relevante:** una desviación de CPL solo es señal si supera `2/√n`.

| n leads | Desviación mínima para ser señal |
|---|---|
| 30 | > 36% |
| 50 | > 28% |
| 75 | > 23% |
| 100 | > 20% |
| 150 | > 16% |
| 200 | > 14% |
| 400 | > 10% |

Esto **reemplaza** cualquier umbral fijo tipo "alertar si el CPL sube 20%". Un umbral fijo genera
pánico el día 3 y ceguera el día 30.

---

## Gate 2 — Persistencia

Una desviación de un solo día **nunca** dispara acción, sin importar la magnitud.

| Patrón observado | Lectura | Qué hace el skill |
|---|---|---|
| 1 día fuera de banda | Ruido | Nada. Ni se menciona. |
| 2 días consecutivos en el mismo sentido | Observar | Va a "vigilancia", sin acción. |
| **3 días consecutivos** en el mismo sentido | Señal | Candidata a acción. |
| **4 de 5 días** del mismo lado de la media | Señal de deriva | Candidata a acción. |
| Salto >50% de un día a otro con n≥30 | Señal de ruptura | Candidata a acción inmediata (posible rechazo de creativo, agotamiento de audiencia, error de tracking). |

**Excepción única:** *entrega en cero*. Si un ad set gastó $0 o entregó 0 impresiones en un día,
se reporta de inmediato sin esperar persistencia. No es varianza, es falla operativa (rechazo por
política, presupuesto agotado, error de facturación).

---

## Gate 3 — Learning phase

Meta necesita ~50 eventos de conversión por ad set en 7 días para salir de aprendizaje. Editar
presupuesto, puja, optimización o audiencia **reinicia** el aprendizaje.

**Regla dura:** si un ad set tiene `<50 conversiones en los últimos 7 días` **O** `<7 días desde
su último cambio significativo`, el skill **no recomienda editar ese ad set**.

Acciones permitidas que **no** reinician aprendizaje:

- **Agregar** un creativo nuevo al ad set existente (no reemplazar).
- Cambios a nivel campaña / presupuesto total si la cuenta usa Advantage+ o CBO.
- Ampliar la ventana de atribución **del reporte**, no de la campaña.
- **Esperar** — recomendación válida, se escribe como tal, con fecha de próxima revisión.

**Regla de "un solo cambio":** máximo **una edición por ad set por semana**. Si hay dos cambios
deseables sobre el mismo ad set, se elige uno y el otro se aplaza con fecha explícita.

**Nota estructural que el skill lleva dentro:** con CPL [cifra interna], salir de learning phase exige
~$2,500/semana por ad set. Los eventos "Viventa Más Cerca de Ti" no llegan ahí — para ellos el
estado normal es estar en aprendizaje, no la excepción. La recomendación estructural correcta es
**consolidar ad sets** (menos ad sets, más gordos) en vez de fragmentar por ciudad/consultora.
Eso se propone **una vez**, como decisión de arquitectura de cuenta, nunca como alerta diaria.

---

## Gate 4 — Ventana de acción por días restantes

| Días restantes al evento | Qué puede recomendar el skill |
|---|---|
| **> 30** | Cualquier cambio, incluidos los que reinician aprendizaje. Hay margen para reaprender. |
| **14 – 30** | Solo cambios de presupuesto y adición de creativos. Nada que reinicie aprendizaje en más de un ad set. |
| **7 – 14** | Solo presupuesto (subir/bajar). Ningún cambio de segmentación ni de optimización — el reinicio se come la ventana entera. |
| **< 7** | **Ninguna edición de campaña.** Solo acciones no-Meta: WhatsApp a registrados, refuerzo de recordatorio, activación de base propia, empuje de las consultoras. La pauta ya dio lo que iba a dar. |

**Advertencia de cabecera obligatoria:** si el evento arrancó con menos de 45 días de pauta:

```
⚠ campaña lanzada a N días — el CPL de este evento no es comparable contra el objetivo
```

---

## Proyección — curva back-loaded

**Prohibido el pacing lineal.** La curva de registros a eventos es back-loaded: la mayoría llega
cerca de la fecha. Un pacing recto declara "vas atrasado" en la semana 1 de todos los eventos.

**Curva provisional por defecto** `[⚠ no verificado — porcentajes estimados; reemplazar por la
serie histórica de Viventa apenas haya 3+ eventos con datos diarios]`:

| % tiempo transcurrido | 10% | 20% | 40% | 60% | 80% | 90% | 100% |
|---|---|---|---|---|---|---|---|
| % leads esperados | 3% | 8% | 22% | 42% | 68% | 84% | 100% |

Interpolar linealmente entre puntos. Si existe curva calibrada en el setup, esa manda.

**Fórmula:** `leads_proyectados = leads_actuales / %_curva_esperada_al_día_de_hoy`

**Confianza — se declara siempre, nunca se da un punto solo:**

| Condición | Confianza | Cómo se reporta |
|---|---|---|
| n ≥ 100 **y** ≥50% del calendario transcurrido | Alta | Un punto |
| n ≥ 30 | Media | Banda de ±20% |
| n < 30 **o** < 20% del calendario | Insuficiente | `n/d — muestra insuficiente`. **No se proyecta.** |

---

## Semáforos — tres, independientes, nunca promediados

**Volumen (proyección vs meta):**

| Proyección vs meta | 🚦 | Lectura |
|---|---|---|
| ≥ 95% | 🟢 | En curso. Recomendación por defecto: **no tocar**. |
| 85 – 95% | 🟡 | Recuperable con ejecución. El requerido diario está dentro de ~20% del ritmo actual. |
| 70 – 85% | 🟠 | Requiere intervención con decisión de presupuesto. |
| < 70% | 🔴 | **Estructural.** Requerido diario >50% sobre el ritmo actual → fuera de alcance con la misma pauta. Lo honesto es **replanificar meta o presupuesto**, no "optimizar". |

**CPL (vs objetivo, sujeto a los gates 1 y 2):** 🟢 ≤ objetivo · 🟡 hasta +`2/√n` sobre objetivo ·
🔴 sobre objetivo por más de `2/√n` **y** con persistencia confirmada.

**Composición USA (sobre leads de pauta):** 🟢 ≥85% · 🟡 70–85% · 🔴 <70%.

Un evento puede ser 🟢 en volumen y 🔴 en composición. El output muestra los tres. Si composición
está en 🔴, **ninguna acción de volumen puede ser prioridad 1** — subir presupuesto con la
segmentación equivocada solo trae más leads del país equivocado.

**Estado ⚪ (sin juicio):** evento con n<30 o <20% del calendario. Se lista en la tabla, no se
juzga, y se anota la fecha estimada del primer juicio válido.
