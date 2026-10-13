# Specs de formato, safe zones y naming

## 1. Video — safe zones

En marzo de 2026 Meta unificó las safe zones de Facebook Stories, Facebook Reels, Instagram
Stories e Instagram Reels en un solo 9:16, usando la medida más restrictiva (Reels).

| Formato | Lienzo | Zona segura | Implicación para Viventa |
|---|---|---|---|
| **9:16 (`9x16`)** | 1080 × 1920 | Superior **14%** (~269 px) · inferior **35%** (~670 px) · laterales **6%** (~65 px) | **El bloque de dirección NO puede ir abajo.** La convención de flyer lo pone abajo; en vertical la UI de Meta tapa 670 px. Colocar dirección + CTA a altura **45-60%** |
| **1:1 (`1x1`)** | 1080 × 1080 | Sin obstrucción de UI en feed; mantener 6% de margen | Es el formato de feed y el de WhatsApp |
| **4:5** | 1080 × 1350 | — | ⚠ **Hallazgo accionable:** Meta ya recomienda **4:5 para imagen y 9:16 para video**, alejándose del 1:1 como default. Viventa produce todo en 1:1. **Es decisión del aprobador de marca, no del skill** — pero la matriz debe poder emitir 4:5 cuando se lo pidan |

Meta Ads Manager incluye un **"Safe Zone Guardrail"** que superpone las zonas durante el setup
del anuncio. Va en el checklist de la productora de video antes de exportar.

---

## 2. Límites de caracteres — Meta

> `[⚠ no verificado]` Meta no publica límites duros oficiales y las fuentes de terceros
> **discrepan entre sí** (headline: 27 / 40 / 45; description: 18 / 25 / 30). Verificar en la
> Meta Ads Guide antes de fijarlos como spec de producción.

| Superficie | Objetivo de redacción | Nota |
|---|---|---|
| Primary text (feed) | **≤125 caracteres antes del corte "ver más"** | Lo que decide el clic es la primera oración. El hook va ahí, **y la dirección después del corte** — la dirección es para quien ya se enganchó |
| Headline (feed) | **≤40 caracteres**, idealmente ≤27 | |
| Headline (Reels overlay) | **≤10 caracteres visibles** | Reels invierte la relación: headline ~55 / primary ~40 |
| Description | **≤25-30 caracteres** | **Frecuentemente no se muestra** en Stories, Reels, Explore e Instagram Feed. **Nunca poner ahí la dirección** |
| Texto en imagen | Sin regla del 20% ya, pero menos texto rinde mejor | |

⚠ **Emojis:** banderas y familias cuentan 2-7 caracteres según el grapheme cluster. Si el copy
usa 🇺🇸 o 🇪🇸 el conteo se rompe. **Regla: cero emojis de bandera en primary text.**

Cada celda de copy Meta de la matriz lleva su conteo de caracteres.

---

## 3. Impresos y piezas comerciales

| Pieza | Formato | Uso real | Contenido obligatorio |
|---|---|---|---|
| **Flyer general A3** | 297 × 420 mm, PDF, sangrado 3 mm, CMYK, 300 dpi | Uno por evento, sin consultora | Las 10 ranuras completas |
| **Flyer consultora A3** | 297 × 420 mm | Impreso para punto físico | Igual + bloque de 4 campos de persona |
| **Flyer consultora A4** | 210 × 297 mm | Reparto en mano / PDF por WhatsApp | Igual, jerarquía comprimida |
| **Flyer convocatoria** | A4 | Solo Tampa y Lanzarote lo tienen — pieza distinta del flyer de asesora | `[⚠ no determinado]` — confirmar con la diseñadra qué la diferencia antes de generarla |
| **Pieza redes / WhatsApp** | 1080 × 1080 JPG | Todas las carpetas la tienen | Legible a 300 px de ancho: dirección en una sola línea, nada de párrafos |

---

## 4. Las 10 ranuras del flyer

Extraídas de los flyers reales de Alicante y Tampa. **El skill llena ranuras; no rediseña.**

```
1  Logo Viventa (+ lockup de modalidad: "¡Más cerca de ti!" / "EXPOCOLOMBIA BY Viventa")
2  Headline           → "Tu casa, tu crédito. Todo en un solo lugar."       [por modalidad]
3  Badge ciudad+fecha → "TAMPA · 30-31 de mayo"                             [por evento]
4  Render de proyecto                                                       [asset, no copy]
5  Bloque logístico   → venue · dirección completa · horario                [OBLIGATORIO]
6  3 beneficios       → "Reserva desde 280 USD" / "Financiamiento de hasta el 80%"
                        / "Análisis inicial de crédito para saber cuánto podrías financiar."
7  Promesa            → "Con Viventa todo saldrá bien." + bajada de acompañamiento
8  Bloque consultora  → nombre · cargo · email · teléfono · foto
9  CTA                → "¡Reserva tu cita!"  (+ QR si aplica)
10 Footer respaldo    → "Evento exclusivo para colombianos en {país}" · 5 bancos · +20 constructoras
```

Headlines observados por modalidad: *Viventa Más Cerca de Ti* (Alicante) → "Tu hogar propio en
Colombia con el crédito ideal." · *ExpoColombia* (Tampa) → "Tu casa, tu crédito. Todo en un
solo lugar." Modalidad distinta → arquitectura de flyer distinta.

**Cifras de la ranura 6:** solo las que vengan en el input. En Tampa fueron 280 USD y "hasta el
80%", tomadas del flyer real. **Ningún otro monto, tasa o condición de crédito se escribe sin
que venga en el input.**

---

## 5. Naming — resumen (fuente canónica: `naming-y-datamerge.md`)

> Las reglas completas —tabla de `CIUDAD3`, valores de `tipo` y `formato`, tabla país→moneda y
> esquema del CSV de data merge— viven en `references/naming-y-datamerge.md`. Ante cualquier
> discrepancia, manda ese archivo.

Hoy conviven 5 convenciones en el mismo mes: `Cuando algo importa - LANZ - 1.1.mov`,
`1 LANZAROTE 1.1_1.jpg`, `A3.pdf`, `PIEZAS REDESMesa de trabajo 1_3.jpg` (nombre de artboard de
Illustrator sin renombrar) y `CONSULTORA FLYRES A3 ALICANTE.pdf` (typo). También `MISSISAUGA` vs
`MISSISAGUA II`. El resultado: **no se puede cruzar un archivo con su fila del reporte de pauta.**
El nombre de archivo es el join key entre producción y analytics.

```
{CIUDAD3}_{tipo}_{concepto|carruselN|superficie}_{formato}_{vNN}[_{Consultora}].{ext}

TP_video_TrabajasParaEsto_9x16_v01.mov
TP_video_TrabajasParaEsto_1x1_v01.mov
TP_carrusel_C1_s03_9x16_v01.jpg
TP_estatica_Respaldo_1x1_v01.jpg
TP_flyer_A3_v01.pdf
TP_flyer_A4_v01_NombreApellido.pdf
TP_redes_1x1_v01_NombreApellido.jpg
```

Reglas:
- Versión de **dos dígitos** (`v01`, no `v1` — ordena mal a partir de v10).
- Sin espacios, sin tildes, sin `final_final`.
- El bump de versión encodea **qué** cambió: nuevo hook, nuevo ratio, nueva oferta.
- **La convención se emite desde la matriz**, no se le pide a nadie que la recuerde. El fallo
  común no es la convención sino su enforcement.
