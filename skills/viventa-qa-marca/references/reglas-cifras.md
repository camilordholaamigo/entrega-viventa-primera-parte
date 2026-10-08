# Reglas de cifras — capa (b)

> Fuente única: `references/cifras-canonicas.md`
> (reconciliado 7-jun-2026). Una sola cifra por métrica.

## Heurística de detección

Cualquier `%`, `$`, `x` o número con separador de miles dispara chequeo contra esta tabla.
Si el número **no está** en `references/cifras-canonicas.md` y no es dato del evento (fecha, hora, cupos,
precio de vivienda), va a `⚠ VERIFICAR` con la pregunta *"¿de dónde sale esta cifra?"*.
El QA **no inventa el origen** ni asume que está bien porque suena plausible.

## Las 5 que más se rompen

| # | Regla | Error típico | Corrección |
|---|---|---|---|
| 1 | **CPL ≠ CAC.** CPL es costo por **lead** ([cifra interna] en Meta); CAC es costo por **cierre** (~[cifra interna] en Meta). | "Nuestro costo de adquisición es de [cifra interna]" · una tabla que pone el CPL de un canal junto al CAC de otro. | Etiquetar siempre: "CPL (costo por lead): [cifra interna] · CAC (costo por cierre): [cifra interna]". |
| 2 | **Conversión a desembolso [cifra interna] ≠ conversión a pago de servicio [cifra interna].** Dos KPIs distintos sobre el mismo cohort ([cifra interna] leads: [cifra interna] cierres / 939 pagos). | "Convertimos el [cifra interna]" a secas · promediar las dos · el "7%" viejo del informe interno. | Nombrar cuál: "conversión a desembolso: [cifra interna]" o "conversión a pago de servicio: [cifra interna]". Nunca "conversión global". |
| 3 | **El +42% es participación del segmento, no crecimiento de mercado.** Camacol: los no residentes pasaron de 8.8% a 12.5% de las ventas. El mercado total crece 5-12%. | "El mercado de vivienda crece 42%" — el más frecuente y el más caro, porque es verificable contra Camacol. | "La participación de los colombianos en el exterior pasó de 8.8% a 12.5% de las ventas." |
| 4 | **Ticket del Servicio Viventa: $480 USD.** No $495. | Cualquier otro número, incluida la cifra vieja. | $480 USD. |
| 5 | **Universos de leads que no se mezclan.** [cifra interna] = leads totales del cohort en abril. [cifra interna] = leads de Crédito asignados a un gerente (vs meta [cifra interna] = [cifra interna]). | Presentar [cifra interna] como "los leads de abril". Usar el "[cifra interna]" suelto. | Decir siempre de qué universo se habla. Déficit de abril = [cifra interna]. |

## Reglas satélite

- Ventas YoY **[cifra interna]** (no 13%).
- Leads YoY **[cifra interna]**.
- Brecha vs mercado **2.5x** (no 3x).
- Base de clientes históricos **15-30K** — es un **rango**, no un dato.
- Capacidad con IA: **una sola cifra (122)**.
- Valor de la oportunidad de IA: liderar con **$500-700K/año** conservador, **nunca** el techo de
  $920K.
