# Fórmulas, defaults y cifras canónicas — `viventa-brief-evento`

Todos los parámetros son **declarables y sobreescribibles**. Si el usuario trae un dato propio, ese
gana. Si existe histórico de un evento comparable (misma modalidad, ciudad parecida), **el histórico
gana siempre sobre el benchmark**, y el brief debe decir cuál usó.

---

## 1. Meta de leads

```
leads_atendibles = N_ejecutivas × leads_por_ejecutiva_dia
meta_registros   = leads_atendibles ÷ (1 − tasa_no_show)
```

| Parámetro | Default | Origen | Confianza |
|---|---|---|---|
| `leads_por_ejecutiva_dia` | 20 | Regla general de industria para staff de evento/booth (trade shows B2B) | **Baja** — `[⚠ no verificado]` no viene de servicios financieros ni inmobiliarios ni del histórico de Viventa. Es orden de magnitud, no target |
| `tasa_no_show` | 40% | Eventos gratuitos: 28% en un dataset medido; fuentes de industria citan 40-60% | Media |

**Ajuste por modalidad** — `[⚠ no verificado]`: heurística propuesta, **no es dato de Viventa**.
Validar con Lizeth antes de usarla como regla. Si se aplica, decirlo en la línea `Supuesto:`.

| Modalidad | Multiplicador |
|---|---|
| Expo Colombia | ×1.5 |
| Open House | ×1.0 |
| Viventa Más Cerca de Ti | ×1.0 |
| Expo Casa | ×0.6 |

La variable independiente de la meta es **el equipo asignado**, no el presupuesto. La guía interna
lo dice textual: la meta se establece "en función del número de integrantes que atenderán el evento".

Si falta `N_ejecutivas`, la meta dice `NO CALCULABLE — falta N_ejecutivas` y el dato se pide en el
bloque 5.

---

## 2. Meta de negocio

```
pagos_SV     = meta_registros × [cifra interna]    → valor USD = pagos_SV × 480
cierres_Vive = meta_registros × [cifra interna]
```

- Se reportan como **dos líneas separadas**, nunca como un total combinado.
- No se estima ingreso de Vive Casas: no hay ticket canónico. Se reportan unidades.
- `[⚠ no verificado]` No existen benchmarks públicos de conversión asistente→cierre para eventos de
  servicios financieros/inmobiliarios. Por eso se usan las conversiones propias de Viventa **sobre
  leads**, no sobre asistentes.

---

## 3. Cifras canónicas de Viventa

| Cifra | Valor | Nota |
|---|---|---|
| Conversión a desembolso / cierre | [cifra interna] | KPI distinto del de abajo. Nunca se suman ni se promedian |
| Conversión a pago de servicio | [cifra interna] | |
| Ticket Servicio Viventa | USD 480 | |
| CAC canal eventos | [cifra interna] por cierre | CAC = costo por **cierre** |
| CPL Meta | ≈ [cifra interna] (estimado) | CPL = costo por **lead** |
| Composición de leads | 85% desde USA | KPI de la productora de contenidos. **No aplica a eventos europeos** — señalarlo y pedir la meta correcta |
| Ventas YoY | [cifra interna] · Leads YoY [cifra interna] | |
| +42% | Participación del segmento no residentes | **Nunca** decir "el mercado crece 42%" |

**CPL ≠ CAC.** Etiquetar siempre, en toda pieza y todo reporte.

---

## 4. Conteo del pack

```
videos     = 5 × N_monedas × 2 formatos (vertical, 1:1) × N_ciudades
carruseles = 3
estáticas  = 2
flyers     = 3 (A3, A4, pieza de redes) × N_consultoras × N_ciudades
```

- Default `N_monedas = 2` (USD y EUR). **Si el evento se promociona a una sola audiencia, preguntá
  en vez de asumir**: es la diferencia entre 34 y 24 entregables sobre una sola diseñadora.
- Voz en off: una línea distinta por fecha y por ciudad.
- Carga de producción: ~5 días (1 día guiones · ½ día validar el brief del equipo de Ads externo ·
  1 día grabación · 2-3 días postproducción y adaptaciones), sobre **una** productora y **una**
  diseñadora, con 3+ eventos al mes.

**Qué multiplica de verdad** (verificado contra los 9 eventos de mayo 2026):

| Eje | ¿Multiplica copy? | Por qué |
|---|---|---|
| Ciudad / plaza | **Sí** | Dirección, fecha, horario y prueba social local cambian de verdad |
| Consultora | **Sí, pero solo 4 campos** | Nombre, email, teléfono y foto. El resto del flyer es idéntico → data merge, no rediseño |
| Moneda (USD/EUR) | No | Se deriva del país |
| Formato (9:16 / 1:1) | No | Son exports del mismo copy |

Referencia real: ExpoColombia Tampa = **57 archivos pero solo 20 unidades de copy**. El trabajo
intelectual está en las 20.

Nota de formato: Meta ya recomienda **4:5 en vez de 1:1**, y Viventa produce todo en 1:1. Si el
brief menciona formatos, dejar la observación; no cambiar el estándar por cuenta propia.
