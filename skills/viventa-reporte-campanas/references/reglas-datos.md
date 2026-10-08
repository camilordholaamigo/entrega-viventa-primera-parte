# Reglas de datos y anti-patterns — `viventa-reporte-campanas`

Fuentes canónicas (mandan sobre cualquier input):
- `references/cifras-canonicas.md`
- `{{config.sources.documents_dir}}/CAC_POR_CANAL.md`
- `references/contexto-viventa.md`

---

## 1. Cifras canónicas de referencia

| Cifra | Valor | Cómo se dice | Cómo NO se dice |
|---|---|---|---|
| Ticket Servicio Viventa | **$480 USD** | "el ticket del SV, $480" | $495 |
| Conversión a desembolso / cierre | **[cifra interna]** ([cifra interna] cierres) | "conversión a desembolso: [cifra interna]" | "conversión: [cifra interna]" |
| Conversión a pago de servicio | **[cifra interna]** (939 pagos) | "conversión a pago de servicio: [cifra interna]" | sumada o intercambiada con la anterior |
| Participación segmento no residentes | **+42%** (8.8% → 12.5% de las ventas, Camacol) | "la participación del segmento no residentes creció 42%" | **"el mercado crece 42%"** — el mercado total crece 5-12% |
| Ventas YoY | [cifra interna] | | |
| Leads YoY | [cifra interna] | | |
| CPL Meta (canónico) | [cifra interna] | "CPL (costo por lead) de Meta: [cifra interna]" | "costo de Meta: [cifra interna]" |
| CAC Meta ad-spend | ~[cifra interna] | "CAC (costo por cierre)" | mezclado con CPL |
| CAC Meta fully-loaded | **[cifra interna]** | el peor ROI del stack | |
| CAC Web fully-loaded | [cifra interna] · convierte 4.19% | CPL: `n/a (sin pauta)` | CPL $0 |
| CAC Instagram orgánico fully-loaded | [cifra interna] | CPL: `n/a (sin pauta)` | CPL $0 |
| CAC Email fully-loaded | [cifra interna]/cierre | | |
| CAC evento fully-loaded | **[cifra interna]** | vs ticket SV $480 = [cifra interna]/cierre **solo cargando SV** | "eventos pierde plata" a secas |
| Eventos, 6 meses | 4.566 leads · conversión 1.03% · ~47 cierres · ~$22K pauta | volumen sí | CPL implícito $4.83 — **nunca se publica** |

**La discrepancia de 10x:** CPL implícito de eventos ≈ $4.83 contra CPL Meta canónico ≈ [cifra interna].
No es un canal barato: es un universo mezclado. Ver protocolo de 4 pasos en el SKILL.md.

---

## 2. Qué fuente manda por tipo de dato

| Dato | Manda | Notas |
|---|---|---|
| Leads | **Zoho CRM** | Fechado por creación del lead. Last-touch |
| Cierres, desembolsos, pagos de servicio | **Zoho CRM** | Única fuente de verdad del dinero |
| Inversión | Meta Ads Manager / Google Ads | Fechada por **clic**, ventana 7d clic / 1d view |
| Impresiones, alcance, CTR, CPM, frecuencia | Meta / Google | Señal de optimización, no reporte de resultados |
| Tráfico, sesiones, comportamiento en sitio | GA4 | Modelo de atribución propio |
| Email (envíos, aperturas, clics) | Zoho Campaigns | |
| WhatsApp | Wati (volumen) / Zoho (lead creado) | Integración Wati↔Zoho es un pendiente de TI, no de este skill |

**Regla:** Zoho manda para leads, cierres y plata. Meta/GA4 mandan solo para inversión,
impresiones, CTR y CPM. **Nunca al revés.**

---

## 3. Tabla completa de comparabilidad

| Comparación | ¿Válida? | Condición |
|---|---|---|
| Mismo canal, periodo vs periodo anterior, misma fuente | ✅ | Comparación base |
| CPL de dos canales pagados (Meta vs Google) | ✅ | Universo pagado limpio en ambos + conversión al lado |
| CPL de canal pagado vs canal sin pauta | ❌ | El de $0 pauta no tiene CPL. Se compara por CAC loaded |
| Leads de Meta Ads Manager vs leads de Zoho | ⚠ | Se muestran ambos, se declara que manda Zoho. **Nunca se suman** |
| CPL de Eventos vs CPL de Meta | ❌ hoy | Universo de Eventos mezclado |
| Conversión a desembolso vs conversión a pago de servicio | ❌ | Dos KPIs. Nunca se suman ni se intercambian |
| Mes actual vs mes anterior | ⚠ | Solo con días hábiles normalizados. Preferir mismo mes año anterior |
| Blended CPL sobre leads totales | ❌ | Denominador = solo leads pagados, declarado |
| Tasa de conversión con n<30 leads | ❌ | Piso de denominador |
| CAC con menos de 10 cierres | ❌ | Piso de denominador |
| Conversión en ventana semanal | ❌ | Ciclo hipotecario > semana. Solo mensual y por cohorte |

**Varianza entre plataformas: es normal, no es un error a resolver.** Meta fecha por clic, Zoho
por evento, GA4 tiene su propio modelo. La meta operativa es **varianza estable y explicable**.
Un delta Meta-vs-Zoho consistente (p.ej. Meta reporta 15-25% más, siempre) se reporta como normal.
Un delta que se sale del rango histórico es **alerta de tracking**, no hallazgo de negocio.

---

## 4. Los 3 inputs de setup pendientes

Se piden **una vez**, no cada periodo. Mientras falten, cada reporte los repite en "Métricas NO
emitidas y por qué".

1. **Valor promedio por operación de Vive Casas** (comisión o margen) y cómo se atribuye al canal.
   `[⚠ no verificado — no existe en cifras canónicas]`
   → Sin esto, Eventos va con **"rentabilidad no calculable"**, nunca "negativa".
2. **Campo en Zoho que separe el origen del lead de evento**: pauta / base propia / fuerza
   comercial / walk-in.
   → Sin esto, el CPL de Eventos es `no emitible — universo mezclado`.
3. **Ventana de atribución configurada y declarada en Meta y en Google.**
   → Sin esto, todo cociente cross-fuente dispara la condición de negativa #2.

---

## 5. Anti-patterns con antídoto

| # | Anti-pattern | Por qué pasa | Antídoto |
|---|---|---|---|
| 1 | **Describir en vez de interpretar** — "los leads bajaron 12%" y punto | Es lo más fácil de generar y suena a reporte | Escalera de evidencia: el nivel 0 no se publica. Todo hallazgo llega mínimo a nivel 1 |
| 2 | **Inventar la causa** — estacionalidad, algoritmo | El LLM agarra la causa estereotípica de su corpus y la entrega con confianza alta | Lista negra + plantilla de hipótesis. Toda causa cita una cifra del input |
| 3 | **Mezclar universos** — CPL de eventos sobre leads totales | El campo del CRM se ve como un canal más | Protocolo de 4 pasos. Nunca estimar el split |
| 4 | **Blended sobre el denominador equivocado** | El total está a la mano | Blended solo entre leads pagados, con nota explícita |
| 5 | **20 métricas sin jerarquía** | Poner todo se siente completo y evita decidir | Tope duro 3/3/3 + criterio de corte (¿cambia una decisión de la semana entrante?) |
| 6 | **Inventar el tercer hallazgo para llenar la plantilla** | La plantilla tiene 3 casillas | Menos es válido. Una semana plana puede tener 1 hallazgo. Es la falla más cara del skill |
| 7 | **CPL sin conversión al lado** | El CPL parece ordenar canales por valor | CPL y conversión en la misma vista. Prohibido CPL solo en página 1 |
| 8 | **Tratar la varianza entre plataformas como error a resolver** | Incomoda tener dos números | Se muestran los dos, se declara cuál manda, se reporta el delta. La varianza estable es lo normal |
| 9 | **Reportar conversión semanal** | La columna está en el CRM | Ciclo hipotecario > semana. Solo mensual y por cohorte |
| 10 | **Leer ruido como tendencia** — 2% de variación con 30 leads | Todo cambio parece señal | Piso de denominador + rango de las últimas 6 semanas como referencia de normalidad |
| 11 | **Comparar mes contra mes sin normalizar** | Es la comparación por defecto | Mensual compara contra mismo mes del año anterior; si no, se normaliza por días hábiles y se dice |
| 12 | **Confundir mezcla con desempeño** — "cayó la conversión" cuando cambió el mix | La métrica agregada no muestra su composición | Mostrar la mezcla junto a la tasa antes de interpretar |
| 13 | **Recomendaciones sin dueño ni plazo** — "optimizar Meta" | Suena a acción sin serlo | Verbo concreto + dueño + ejecutable en el periodo entrante |
| 14 | **Presentar Eventos como rentable o como ruinoso** | Solo se carga SV ($480 vs [cifra interna]) | Falta Vive Casas: **rentabilidad no calculable** hasta tener el input de setup |
| 15 | **Duplicar `viventa-monitor-evento`** — umbrales diarios, veredicto de plaza | Eventos es tentador de analizar | Eventos es **una fila** de la tabla consolidada. El detalle es del otro skill |
| 16 | **Limpiar los `[⚠ no verificado]`** | Ensucian el reporte | Sobreviven al output como advertencia visible |

---

## 6. Lenguaje prohibido

**Jerga de consultora:** "solución integral" · "aliado estratégico" · "leverage" · "unlock" ·
"palanca" · "accionable" · "insight clave" · "de cara a" · "en aras de" · "holístico".

**Jerga financiera sin traducir:** LTV, DTI, amortización, ARPU. Si hay que usarla, se traduce
en la misma línea.

**Causas prohibidas sin evidencia** (van solo como hipótesis con plantilla): estacionalidad ·
"cambió el algoritmo de Meta" · fatiga o saturación de creativo · saturación de audiencia · "el
mercado está lento" · competencia · cambios de privacidad de iOS.
