---
name: viventa-datos-publicables
description: >-
  Convierte la información comercial y de proyectos que tienen otras áreas de Viventa (viviendas
  vendidas, negocios cerrados, precios y disponibilidad de proyectos) en la hoja mensual de datos
  publicables: cada dato con fuente, fecha de corte, vigencia, quién lo aprobó y para qué uso sirve.
  Redacta el pedido a cada área dueña y valida lo que vuelve. USA cuando: "necesito las cifras de
  viviendas vendidas para un post", "pásame el precio actualizado del proyecto", "qué datos de ventas
  puedo publicar este mes". Es la fuente: viventa-ficha-proyecto y viventa-versionador-piezas la consumen.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-datos-publicables

Corta la espera de cada mes por los datos que mercadeo necesita y no tiene (ventas, cierres, precios
de proyectos), sin darle a mercadeo acceso a información confidencial. Tres invariantes: **un dato
solo entra a la hoja si el área dueña lo entregó y lo aprobó** (con nombre del área y fecha),
**todo dato tiene fecha de corte y vigencia**, y **lo que no se puede publicar no entra**, aunque
llegue: las cifras internas se quedan internas.

## Cuándo usar

- Explícito: "necesito las cifras de viviendas vendidas para un post", "pásame el precio actualizado
  del proyecto", "qué datos de ventas puedo publicar este mes", "actualiza las fichas de proyectos",
  "pídele a comercial los datos del mes para contenidos".
- Implícito: empieza el mes y hay que armar la parrilla o versionar piezas de proyecto.
- Cadencia: mensual (primera semana), y puntual cuando cambia un precio.

## Cuándo NO usar

- La ficha completa de un proyecto para llamada o pieza → `viventa-ficha-proyecto` (con los datos de esta hoja).
- Cruzar proyectos con un lead → `viventa-match-proyecto-lead`.
- Revisar si una cifra está bien usada en una pieza → `viventa-qa-marca`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Qué datos se necesitan este mes | Parrilla, eventos y piezas del mes | *"¿Qué datos necesitas: ventas, cierres, precios de qué proyectos?"* |
| Hoja del mes anterior | `salidas/viventa-datos-publicables/` | No se pregunta: si existe, se parte de ella y se marcan los datos vencidos |
| Respuestas de las áreas dueñas | Lo que devuelvan comercial y el área de información de proyectos (Excel, export de Vivehome, correo) | No se pregunta en la primera pasada: primero se redactan los pedidos |
| Reglas de cifras | `references/cifras-canonicas.md` | No se pregunta: si no está, los datos agregados de la empresa van `⚠ verificar` |

## Workflow

1. **Listá lo que vence**: datos de la hoja anterior cuya vigencia terminó y precios con más de 30 días de corte.
2. **Redactá un pedido por área dueña** (comercial, información de proyectos, crédito si aplica), con:
   el dato exacto, el nivel de agregación (total del mes, por país, por proyecto), la fecha de corte
   que se pide, para qué se va a usar y la fecha límite. Un pedido corto que se responda en una tabla.
3. **Cuando llegan las respuestas, validá cada dato**:
   - es agregado y no identifica a ningún cliente (nada de nombres, ciudades + montos que permitan
     reconocer a alguien, ni casos individuales sin consentimiento);
   - trae fecha de corte y quién lo aprobó;
   - no es una cifra interna: ingresos, CAC, comisiones, márgenes, metas, CPL y tasas de conversión
     **no se publican** aunque vengan en el archivo;
   - respeta las reglas de `references/cifras-canonicas.md` (por ejemplo, el +42% es participación del segmento,
     no crecimiento del mercado);
   - precios de proyecto: en la moneda del proyecto, con "desde" si es el menor, y sin tasa, cuota ni
     plazo (eso lo da el asesor en llamada).
4. **Asigná el uso permitido** a cada dato: orgánico, pauta (Colombia, EE. UU., España), impreso. Un
   dato que solo se puede usar en Colombia se marca así.
5. **Escribí la frase publicable sugerida** para los datos de la empresa ("En septiembre acompañamos
   a {n} familias…"), sin adjetivos que el dato no sostenga.
6. **Armá la tabla de proyectos** con lo validado, lista para `viventa-ficha-proyecto` y
   `viventa-versionador-piezas`.

## Reglas duras

- **Nunca publica ni sugiere un dato que el área dueña no aprobó.** Lo no aprobado va a `pendiente`.
- **Nunca incluye cifras internas** (ingresos, CAC, comisiones, márgenes, metas, conversiones) en la hoja.
- **Nunca incluye datos que identifiquen a un cliente.**
- **Nunca actualiza un precio por su cuenta** ni lo convierte de moneda.
- **Nunca deja un dato sin fecha de corte**: sin fecha, no entra.

## Output esperado

`salidas/viventa-datos-publicables/<AAAA-MM>.md` y el mismo contenido en
`<AAAA-MM>.csv` para pegar en Sheets:

```
DATOS PUBLICABLES — {mes} · actualizado {fecha}
{n} datos vigentes · {n} pendientes de aprobación · {n} vencidos

Datos de la empresa
| Dato | Valor | Fuente (área) | Aprobó | Corte | Vigente hasta | Uso permitido | Frase sugerida |

Proyectos
| Proyecto | Ciudad | Precio desde | Moneda | Rango | Disponibilidad | Corte | Fuente | Aprobó |

Pendientes: {dato} — pedido a {área} el {fecha}.
Descartados por no publicables: {n} (cifras internas recibidas que no entran).
```

Los pedidos a las áreas se entregan en la conversación, listos para pegar en correo o chat. Al
terminar, decí: *"Hoja de {mes} en `<ruta>`: {n} datos listos, {n} pendientes. Los pedidos a
{áreas} están arriba."*

## Skills relacionados

- **Después:** `viventa-ficha-proyecto` (ficha completa del proyecto), `viventa-versionador-piezas`
  (piezas con precio nuevo), `viventa-parrilla-base` y la parrilla orgánica (datos para contenido).
- **Relacionado:** `viventa-qa-marca` revisa el uso de cada cifra en la pieza final.
