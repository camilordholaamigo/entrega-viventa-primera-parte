# Los 5 ejes de segmentación

Referencia de `viventa-parrilla-base`, Fase 2.

**Regla que atraviesa todo el archivo: nunca inventes un eje que no vino en el input.** Si el
export no trae ingresos, la parrilla no segmenta por ingresos y lo dice. Un eje inventado produce
una parrilla que no se puede ejecutar en Zoho, que es peor que una parrilla más chica.

---

## Eje 1 — Fase del funnel `obligatorio`

Zoho separa **candidatos** (leads) de **contactos** (ya calificados). El correo del cliente los
nombra así, y la parrilla los trata distinto porque están a distancia distinta de la compra.

| Fase | Qué es | Ángulo que le sirve |
|---|---|---|
| Candidato nuevo | Dejó datos, sin contacto aún | **Pain** — nombrar el problema |
| Candidato contactado | Hubo llamada o mensaje | **Plan** — cómo funciona |
| Candidato en proceso | Documentación en curso | **Philosophy** — acompañamiento |
| Contacto calificado | Precalificado por Crédito | **Proof** — casos, bancos |
| Contacto frío | Sin movimiento 3-6 meses | **Proof → Plan** |

⚠️ **"Fase OP" en Zoho no tiene definición documentada.** Está en los gaps pendientes desde junio.
Si aparece en el export, se reporta tal cual y **no se interpreta**.

---

## Eje 2 — Tier de engagement `obligatorio`

No es un eje de contenido: es el que decide **quién puede recibir algo**. Ver
`techo-deliverability.md`. Se cruza con todos los demás y manda sobre todos.

---

## Eje 3 — Tipo de inversión

Del formulario CC del CRM. Es el eje que más cambia el mensaje.

| Valor | Qué busca | Qué NO decirle |
|---|---|---|
| **Vivienda propia** | Volver a Colombia, o tener casa para la familia | No hablarle de rentabilidad |
| **Inversión / renta** | Retorno, no vivir ahí | No hablarle de "tu hogar" |
| **Retorno al país** | Plan de regreso con fecha | No tratarlo como turista |

⚠️ La lógica detallada está en `references/proposito-inversion.md`.
**Este skill la referencia, no la duplica.** Si cambia allá, cambia acá.

---

## Eje 4 — Rango de ingresos

Declarado, no inferido. Se usa para dimensionar el rango de proyecto que tiene sentido mostrarle.

**Tres cuidados, todos duros:**

1. **Nunca se menciona el ingreso en el copy.** Ni "para tu nivel de ingresos", ni nada parecido.
   Es un eje de *targeting interno*, no un argumento de venta.
2. **No determina capacidad de crédito.** Eso lo dice el área de Crédito con la documentación
   completa. La parrilla nunca sugiere un monto aprobable.
3. **Es el campo con más autodeclaración imprecisa.** Si el % sin clasificar de este eje supera
   40 %, se declara no utilizable.

---

## Eje 5 — Ciudad o país de interés

Dos cosas distintas que se confunden seguido:

- **Dónde vive** (USA, España) — decide moneda, horario e idioma del ejemplo
- **Dónde quiere comprar** (Bogotá, Medellín, Santa Marta) — decide qué proyecto le sirve

**El export tiene que decir cuál de las dos es.** Si no lo dice, se pide; no se asume.

⚠️ Meta 85 % de leads de USA es KPI de producción de eventos, no de la base entera. No mezclar.

---

## Qué hacer con lo no clasificable

**Fila `Sin clasificar`, con su conteo, siempre visible.**

Prohibido:
- Repartir proporcionalmente entre las categorías conocidas
- Asignarlos a la categoría más grande
- Omitirlos del total

**Si esa fila es grande, ese es el hallazgo de la corrida** — y probablemente vale más que la
parrilla. Un 45 % sin tipo de inversión declarado significa que el formulario CC no se está
llenando, y eso es un problema de proceso que ninguna parrilla arregla.

Umbral: **> 40 % sin clasificar en un eje → ese eje no se usa este mes**, y va al bloque
"Qué falta" con a quién pedírselo.

---

## Cuántos segmentos activos

**Máximo 6.** Con 5 ejes el producto cartesiano explota rápido, y una parrilla de 30 segmentos no
se ejecuta: se abandona.

Criterio de fusión: **si dos segmentos reciben el mismo mensaje, son un segmento.** Partirlos
infla el documento sin cambiar un solo envío.

Criterio de exclusión: **menos de 200 personas**, el esfuerzo de redacción no se paga. Va al plan
de impacto como "no atacado este mes" con su razón.
