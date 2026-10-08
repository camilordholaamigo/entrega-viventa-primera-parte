# Plantillas de output — `viventa-reporte-campanas`

> Molde exacto del entregable. **Los números de abajo son ILUSTRATIVOS, inventados para mostrar
> forma y tono.** No son cifras de Viventa y nadie los puede citar. El skill los reemplaza con el
> input real.

---

## A. Plantilla semanal (rellenar)

```
REPORTE DE DESEMPEÑO — GROWTH & MARKETING
Semana {inicio} a {fin} · vs semana anterior ({inicio prev} a {fin prev}) · Emitido {fecha}
Fuentes: {lista de sistemas usados}
Cierre de datos: {fecha} {hora} COT. Cifras de cierre sujetas a maduración — ver nota de ventanas.

LO QUE PASÓ
{4-6 líneas de prosa. Qué se movió, dónde está concentrado, qué se movió del otro lado.
Nivel 1 mínimo, nunca nivel 0.}

HALLAZGOS (máx. 3)
1. {Afirmación} — {descomposición}. Evidencia: {fuente, corte, periodo}.
2. ...
3. ...

ALERTAS (máx. 3)   🔴 bloquea · 🟠 hay que resolver · 🟡 vigilar
1. {emoji} {Titular}. {Qué pasa, qué se emite en su lugar, qué dato lo desbloquea}.
2. ...

RECOMENDACIONES (máx. 3)
| # | Qué hacer | Por qué | Dueño sugerido |
|---|---|---|---|
| 1 | {verbo concreto + objeto} | {por qué, con cifra} | {Alejandra / Lizeth / agencia / admin CRM} |

Recordatorio: ninguna de estas acciones lanza pauta. Todas terminan en revisión humana.

--- PÁGINA 2 ---

| Canal | Leads | Δ vs prev | Inversión | CPL (costo por lead) | Conversión | Fuente |
|---|---|---|---|---|---|---|
| ... |

⚠ Nota del blended: {inversión} / {leads PAGADOS} = ${x}. NO se divide entre el total de leads:
{n} de esos leads no vienen de pauta. El blended contra el total daría ${y} y sería falso.

Anexo (no requiere lectura): impresiones, alcance, CTR, CPM, aperturas y clics de email,
sesiones GA4, seguidores, detalle por ad set.

MÉTRICAS NO EMITIDAS ESTA SEMANA Y POR QUÉ
- {Métrica} → {condición de negativa} · desbloquea: {dato}
(si no hay ninguna, escribir "Ninguna.")
```

---

## B. Ejemplo recortado (CIFRAS ILUSTRATIVAS — no citar)

**REPORTE DE DESEMPEÑO — GROWTH & MARKETING**
Semana 27-jul a 2-ago-2026 · vs semana anterior (20-26 jul) · Emitido 3-ago
Fuentes: Zoho CRM (leads, cierres) · Meta Ads Manager (inversión) · Google Ads (inversión) ·
Zoho Campaigns (email) · GA4 (tráfico web)
Cierre de datos: 2-ago 23:59 COT. Cifras de cierre sujetas a maduración — ver nota de ventanas.

**LO QUE PASÓ**

Entraron **688 leads**, 7% menos que la semana pasada (742). La caída está concentrada en **un
solo canal**: Meta pasó de 341 a 296 leads (−13%) con la misma inversión, lo que subió su CPL de
$43 a $50. Los demás canales se movieron dentro del rango normal de las últimas 6 semanas.

**HALLAZGOS (3)**

1. **La caída de leads es de Meta, no del mercado.** Meta explica 45 de los 54 leads perdidos
   (83% de la caída). Web, email y WhatsApp cerraron dentro de ±5%.
   *Evidencia: Zoho CRM, leads por fuente, semanas 20-26 vs 27-2, universo leads totales.*
2. **El CPL de Meta subió 16% con inversión plana** ($14.800 ambas semanas): mismo presupuesto,
   menos leads. Conversión de Meta sin cambio (0.64%), así que el problema es de costo de
   adquisición, no de calidad.
   *Evidencia: Meta Ads Manager (inversión, fechada por clic) + Zoho CRM (leads, fechados por
   creación).*
3. **Hipótesis:** desgaste de creativo en el ad set principal de Meta.
   **Qué la confirmaría:** frecuencia > 3.0 y caída de CTR > 20% en los últimos 30 días, por
   anuncio.
   **Quién lo tiene:** la agencia de pauta.
   *(No se afirma. La fatiga de creativo está en la lista de causas prohibidas sin evidencia.)*

**ALERTAS (3)**

1. 🔴 **El CPL de Eventos no es emitible.** Los 84 leads de la semana mezclan pauta, base propia
   y contactos de la fuerza comercial en un solo campo del CRM. Dividir la inversión entre los 84
   da un CPL falsamente bajo (~$5 contra [cifra interna] de Meta). **Se emite volumen, no costo**, hasta que
   el CRM permita separar los dos universos.
2. 🟠 **La rentabilidad de Eventos no es calculable con lo que tenemos.** CAC fully-loaded [cifra interna]
   vs ticket SV $480. Falta el valor por operación de Vive Casas para cerrar la cuenta. Es un dato
   de setup, no un cálculo.
3. 🟡 **Email marketing lleva 3 semanas sin campaña de conversión** (solo envíos informativos).
   El canal cuesta [cifra interna] por cierre — el segundo más barato — y está subusado.

**RECOMENDACIONES (3)**

| # | Qué hacer | Por qué | Dueño sugerido |
|---|---|---|---|
| 1 | Pedirle a la agencia el corte de frecuencia y CTR por anuncio de los últimos 30 días | Confirma o descarta el desgaste de creativo antes de tocar presupuesto | Alejandra |
| 2 | Habilitar en Zoho un campo que marque el origen del lead de evento (pauta / base / comercial) | Desbloquea el CPL de Eventos, hoy no emitible | Alejandra + admin de CRM |
| 3 | Programar una campaña de conversión de email para semana del 10-ago | Canal de [cifra interna]/cierre inactivo 3 semanas | Lizeth define la oferta |

*Recordatorio: ninguna de estas acciones lanza pauta. Todas terminan en revisión humana.*

---

**PÁGINA 2 — TABLA Y ANEXO**

| Canal | Leads | Δ vs prev | Inversión | CPL (costo por lead) | Conversión a cierre | Fuente |
|---|---|---|---|---|---|---|
| Meta | 296 | −13% | $14.800 | [cifra interna] | 0.64% | Zoho (leads) / Meta (inversión) |
| Google | 61 | +2% | $3.050 | $50 | 1.8% | Zoho / Google Ads |
| Web (directo/SEO) | 92 | +3% | $0 pauta | n/a (sin pauta) | 4.19% | Zoho / GA4 |
| Email | 108 | −4% | $0 pauta | n/a (sin pauta) | 2.1% | Zoho Campaigns |
| Instagram orgánico | 26 | +8% | $0 pauta | n/a (sin pauta) | no emitible (n<30) | Zoho |
| WhatsApp (Wati) | 21 | 0% | $0 pauta | n/a (sin pauta) | no emitible (n<30) | Wati / Zoho |
| Eventos | 84 | −6% | $4.100 | **no emitible** — universo mezclado | no emitible | Zoho (campo sin desglose) |
| **Total** | **688** | **−7%** | **$21.950** | **$61 blended** ⚠ ver nota | — | |

⚠ **Nota del blended:** $21.950 / 357 leads pagados (Meta + Google) = **$61**. NO se divide entre
688: 331 de esos leads no vienen de pauta. El blended contra el total daría $32 y sería falso.

**Anexo (no requiere lectura):** impresiones, alcance, CTR, CPM, aperturas y clics de email,
sesiones de GA4, seguidores. Detalle de campañas por ad set.

**Métricas NO emitidas esta semana y por qué:**
- **CPL de Eventos** → universo mezclado (alerta 1) · desbloquea: campo de origen del lead en Zoho.
- **Conversión de la cohorte de la semana** → la cohorte no maduró; el ciclo hipotecario supera la
  semana. Se reporta solo en el consolidado mensual y por cohorte · desbloquea: nada, es por diseño.
- **Conversión de Instagram y WhatsApp** → denominador menor a 30 leads · desbloquea: acumular
  hasta el corte mensual.
- **CAC por canal** → se recalcula mensual con el cierre financiero, no semanal.
- **Rentabilidad de Eventos** → falta el valor por operación de Vive Casas · desbloquea: input de
  setup de gerencia.

---

## C. Variante mensual — las tres diferencias

Misma estructura de 2 páginas, con estos agregados:

**1. Conversión por cohorte, en filas separadas y etiquetadas:**

| KPI | Valor | Universo | Fuente |
|---|---|---|---|
| Conversión a **desembolso / cierre** | [cifra interna] ([cifra interna] cierres) | cohorte {mes}, leads totales | Zoho CRM |
| Conversión a **pago de servicio** | [cifra interna] (939 pagos) | cohorte {mes}, leads totales | Zoho CRM |

Nunca se suman. Nunca se intercambian. Nunca aparece "conversión global" sin decir cuál.

**2. CAC por canal vs baseline + composición geográfica.**
El CAC se recalcula solo aquí, con el cierre financiero. Nunca en el semanal.
Junto a cada CAC va el volumen del canal, para que se vea el trade-off costo/volumen.

**3. Comparación contra el mismo mes del año anterior.**
Si por falta de dato se compara contra el mes anterior, se **normaliza por días hábiles** y se
escribe explícitamente: *"comparado contra {mes} normalizado por días hábiles ({n} vs {m})"*.

**4. Descomposición de mezcla obligatoria si cayó una tasa agregada.**
Tabla de participación por canal en el periodo actual vs el de comparación, al lado de la tasa.
Si la mezcla explica el movimiento, la redacción es *"no empeoró ningún canal; cambió la mezcla
hacia canales de menor conversión"*.
