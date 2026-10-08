# Modo cierre — cortes, bloques y matriz de veredicto

Se lee completo antes de emitir cualquier ficha de cierre.

---

## Los 4 cortes

| Corte | Cuándo | Qué se mide | ¿Veredicto? |
|---|---|---|---|
| **T+0** | Día siguiente al evento | Leads de pauta, leads no pagados, CPL de pauta, composición USA, inversión vs presupuesto, asistentes, show rate | **NO.** Ficha de operación pura. Prohibido cualquier juicio de negocio. |
| **T+30** | 30 días después | Lo anterior + citas agendadas, SV pagados tempranos, leads en gestión | **NO.** Lectura parcial explícita: *"a T+30 se observa típicamente una fracción minoritaria del resultado final"*. |
| **T+90** | 90 días después | + SV pagados, operaciones Vive Casas, pipeline vivo, costo por SV, retorno | **SÍ — corte de veredicto.** |
| **T+180** | 180 días después | + desembolsos cerrados, retorno total definitivo | **SÍ — recierre.** Puede revertir el veredicto de T+90. |

### Prohibición léxica (la regla más importante del modo cierre)

Antes del corte T+90 el skill **tiene prohibido** escribir las palabras **fracaso**, **no
funcionó**, **descartar**, **no rentable** (ni sinónimos: "fue un fiasco", "perdimos la plata",
"no vale la pena repetirlo").

Cuando en T+0 o T+30 el negocio va por debajo de meta, la redacción **obligatoria** es:

> resultado de negocio parcial — la ventana de conversión de este evento cierra el {fecha T+90}

Razón: Viventa vende crédito hipotecario. El desembolso puede tardar meses después del evento.
Medir a 30 días subcuenta el impacto de forma sistemática.

---

## Los 3 bloques que nunca se mezclan

**Bloque 1 — Adquisición** (cerrado a T+0, ya no cambia):
`leads de pauta vs meta` · `CPL de pauta vs CPL objetivo` · `composición USA vs 85%` ·
`inversión de pauta vs presupuesto`
→ Juzga a la pauta y a la agencia externa. **Es lo único juzgable el día después.**

**Bloque 2 — Conversión** (madura hasta T+180):
`leads → asistentes (show rate)` · `asistentes → citas` · `citas → SV pagados` ·
`SV → desembolso`
→ Juzga al equipo comercial y al follow-up, **no a mercadeo**. Separarlos impide que un buen
evento con mal seguimiento se lea como problema de pauta.

**Bloque 3 — Eficiencia económica** (veredicto T+90, recierre T+180):
- `costo total cargado ÷ SV pagados` = **costo por SV** (`$/cierre`), contrastado contra el
  **CAC fully-loaded de eventos = [cifra interna]**, el más caro de todo el stack.
- `(ingreso SV + ingreso Vive Casas) ÷ costo total cargado` = **retorno del evento**.
  Umbral de repetición: **1.0x a T+180**.

CPL vive en el Bloque 1 (`$/lead`). CAC y costo por SV viven en el Bloque 3 (`$/cierre`).
**Nunca en la misma tabla.**

---

## Matriz de veredicto (a T+90)

| Retorno a T+90 | Proyección a T+180 | Veredicto | Qué significa |
|---|---|---|---|
| ≥ 1.0x | — | 🟢 **REPETIR** | Se repite formato y plaza con el mismo modelo. |
| 0.6 – 1.0x | ≥ 1.0x | 🟢 **REPETIR** (confirmar en T+180) | Va camino a pagarse. No tocar. |
| 0.6 – 1.0x | < 1.0x | 🟠 **AJUSTAR** | Se repite cambiando la capa señalada. Nombrarla. |
| 0.3 – 0.6x | < 1.0x | 🟠 **AJUSTAR** | Igual, con revisión de presupuesto antes de aprobar el siguiente. |
| < 0.3x | < 0.6x | 🔴 **NO REPETIR ESTE MODELO** | Y solo con **2+ eventos** de la plaza en el mismo rango: 🔴 **DESCARTAR PLAZA**. Con un solo evento: `veredicto de plaza no emitible`. |

### Reglas de emisión

1. **El veredicto de T+90 es del EVENTO.** El veredicto de **PLAZA** exige **≥2 eventos** en la
   misma ciudad con corte T+90 completo. Un solo evento nunca mata una plaza: la variabilidad
   entre eventos individuales es mayor que la señal de la plaza.
2. **El veredicto siempre nombra la capa que falló:** *adquisición* · *conversión* ·
   *estructura de costo*. Un evento con CPL bueno y retorno malo **no es un problema de pauta**;
   decir lo contrario manda al equipo a optimizar lo que ya funciona.
3. **Salvaguarda anti-descarte:** antes de emitir 🔴 DESCARTAR PLAZA, verificar que el peor y el
   mejor evento de la plaza no difieran en más de **2x** en retorno. Si difieren más, la
   variabilidad domina la señal → veredicto `insuficiente — se requiere un tercer evento`.
4. **Recierre obligatorio a T+180.** Todo veredicto de T+90 se agenda para recierre; si el
   retorno total supera 1.0x en T+180, el evento pasa a 🟢 REPETIR retroactivamente.

### Pie obligatorio del veredicto

Los eventos van deliberadamente a geos de **baja saturación** (Alicante, Valencia, Lanzarote,
Mississauga, Tampa) en vez de Miami/NY. Un CPL más alto en una plaza nueva puede ser el precio
correcto de una estrategia correcta. El skill lo dice; no lo esconde detrás de un número rojo.

---

## Referencias económicas para el Bloque 3

| Referencia | Valor | Uso |
|---|---|---|
| Ticket Servicio Viventa (SV) | **$480 USD** | Todo ingreso SV se calcula sobre $480. No $495. |
| CAC fully-loaded eventos | **[cifra interna] / cierre** | Referencia contra la que se juzga el costo por SV. |
| CAC ad-spend eventos | [cifra interna] / cierre | Solo pauta, sin equipo ni producción. |
| CPL Meta canónico | [cifra interna] / lead | Referencia de canal para el CPL de pauta. |
| Conversión canal eventos | 1.03% | Lead → cierre del canal. |
| Conversión a **pago de servicio** | **[cifra interna]** | → mapea a ingreso SV ($480). |
| Conversión a **desembolso** | **[cifra interna]** | → mapea a ingreso Vive Casas (valor = input de setup). |
| Valor por operación Vive Casas | **`[n/d]` — input de setup obligatorio** | `[⚠ no verificado]` No existe en las cifras canónicas. Sin él, la rentabilidad es **no calculable**. |

**CAC fully-loaded por canal (contexto):** Web [cifra interna] · Email [cifra interna] · WhatsApp [cifra interna] · Instagram [cifra interna] ·
Meta [cifra interna] · Google [cifra interna] · **Eventos [cifra interna]**.

**Consecuencia dura:** con ticket SV $480 y CAC loaded [cifra interna], el margen de contribución del SV
solo es **[cifra interna] por cierre**. **Ningún evento se paga con SV solos.** Todo veredicto de
rentabilidad obliga a cargar Vive Casas. Si el valor de Vive Casas no está cargado, el veredicto
se emite como `no emitible — rentabilidad no calculable`, nunca estimado.

**Empate por imprecisión (D8):** la asignación de costo de equipo del CAC loaded es declarada, no
medida (±20%). Cualquier comparación de costo por SV entre canales que caiga dentro de ±20% se
declara **empate**, no diferencia.
