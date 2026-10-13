---
name: viventa-piezas-figma
description: >-
  Produce en Figma el primer borrador de las piezas gráficas de Viventa a partir de un brief completo:
  usa la librería de componentes y el manual de la marca, aplica los textos finales del brief y arma
  cada formato de canal (feed, historia, carrusel, estático de pauta, correo, landing, impreso) con
  nombre estándar. Diseño pasa de producir desde cero a ajustar y aprobar. USA cuando: "diseña las
  piezas de este brief", "necesito el carrusel y las estáticas del evento", "haz las piezas de la
  parrilla de esta semana". Es diseñar la maestra: viventa-versionador-piezas la multiplica después.
metadata:
  version: "1.0.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-piezas-figma

Le quita a la única diseñadora del área la parte de armar desde cero, sobre más de 500 piezas al mes.
Tres invariantes: **el borrador solo usa componentes, estilos y colores de la librería de Viventa en
Figma** (nada inventado ni copiado de memoria), **los textos van exactamente como vienen en el brief**
(no se corrigen ni se mejoran: eso pasa antes, en el brief), y **todo frame sale marcado como
borrador**: la dirección creativa y la aprobación siguen siendo humanas.

## Cuándo usar

- Explícito: "diseña las piezas de este brief", "necesito el carrusel y las estáticas del evento",
  "haz las piezas de la parrilla de esta semana", "saca un primer borrador del correo", "prepara los
  archivos finales para impresión".
- Implícito: hay un brief aprobado con textos finales y todavía no hay frames.

## Cuándo NO usar

- El brief no está completo o los textos no son finales → `viventa-brief-requerimiento` primero.
- La pieza ya existe y hay que sacar versiones por ciudad, consultora o precio → `viventa-versionador-piezas`.
- Un carrusel de contenido orgánico con su guion → `carrusel-figma`.
- Una presentación comercial → `presentacion-persuasiva-figma`.

## Conexiones

| Conexión | Para qué | Si falta |
|---|---|---|
| Figma (MCP) | Leer la librería (componentes, estilos de texto, variables de color), crear los frames y exportar | Degrada a **spec por frame**: tamaño, componente a usar y texto por capa, para armarlo a mano. Lo dice en la primera línea |

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Brief con textos finales | Salida de `viventa-brief-requerimiento` o `viventa-pack-evento` | *"Pásame el brief aprobado con los textos finales."* **Bloquea**: diseñar con textos provisionales es el reproceso que más tiempo se come |
| Archivo de Figma con la librería de Viventa | Link | *"¿En qué archivo está la librería de componentes y estilos de Viventa?"* **Bloquea**: sin librería no hay borrador de marca |
| Formatos pedidos | El brief | No se pregunta: si el brief no los dice, los del canal (tabla del Paso 3) |
| Imágenes y fotos | El brief o la carpeta compartida | No se pregunta: sin ellas, marco de imagen vacío con la descripción de lo que va |
| Archivo de destino | El pedido | No se pregunta: página nueva `Borradores <brief> <fecha>` en el archivo del brief o de la librería |

## Workflow

1. **Revisá el brief**: objetivo, canal, formatos, textos finales, CTA y fecha. Si algún texto dice
   "por definir", "TBD" o tiene opciones ("A o B"), pará y devolvé la lista de textos pendientes.
2. **Leé la librería**: componentes disponibles por tipo de pieza, estilos de texto y variables de
   color. Si existen plantillas maestras para ese tipo de pieza, usá la maestra (no armes otra).
3. **Elegí los formatos** del canal:

   | Canal | Formatos |
   |---|---|
   | Feed | 1080×1350 (4:5) y 1080×1080 |
   | Historia / Reel (portada) | 1080×1920 |
   | Carrusel | 1080×1350 por lámina |
   | Estático de pauta | 1080×1350, 1080×1080 y 1080×1920 |
   | Correo | 600 px de ancho, cabezote + bloques |
   | Landing | Sección hero en escritorio y en móvil |
   | Impreso | A3 / A4 con 3 mm de sangrado |

4. **Armá cada frame** en la página de borradores: instancia del componente o de la maestra, textos
   del brief en sus capas, imágenes en sus marcos. Si un texto no cabe, no achiques la letra por debajo
   del estilo: anotalo como `texto largo: recortar N caracteres` para el brief.
5. **Nombrá cada frame** con la convención de
   `references/naming-y-datamerge.md` y la
   etiqueta `BORRADOR` en el nombre de la página.
6. **Anotá las reglas aplicadas** en un frame de notas al lado: qué componente se usó, qué estilo, qué
   regla del manual se respetó y qué quedó a decisión de diseño.
7. **Exportá solo si lo piden**: web (PNG o JPG optimizado) o impresión (PDF con sangrado). Para
   impresión, avisá que la conversión a CMYK y la prueba de color las cierra diseño.

## Reglas duras

- **Nunca usa colores, tipografías o logos que no estén en la librería de Viventa.**
- **Nunca cambia un texto del brief**, ni para corregirlo: lo anota para que lo corrija quien escribe.
- **Nunca genera imágenes de personas ni renders de proyectos** que pasen por reales: los marcos sin
  foto quedan vacíos con su descripción.
- **Nunca toca componentes ni plantillas maestras** de la librería: trabaja con instancias.
- **Nunca marca una pieza como aprobada** ni la exporta como final: aprobación de marca primero.

## Output esperado

En Figma, la página `BORRADOR · <brief> · <AAAA-MM-DD>` con un frame por formato y un frame de notas.
En disco, `salidas/viventa-piezas-figma/<AAAA-MM-DD>-<brief>.md`:

```
BORRADORES — {brief} · {fecha}
{n} frames · {n} con texto largo · {n} sin imagen
Link a la página: {link}

| Frame | Formato | Componente / maestra | Pendiente para diseño |

Textos que no cupieron (para el brief): {frame}: recortar {n} caracteres.
Siguiente paso: ajuste de diseño → viventa-qa-marca → aprobación de marca.
```

Al terminar, decí: *"{n} borradores en la página {nombre}. Quedan para tu ajuste: {resumen de pendientes}."*

## Skills relacionados

- **Antes:** `viventa-brief-requerimiento` (brief con textos finales) o `viventa-pack-evento` (copy por archivo).
- **Después:** `viventa-versionador-piezas` multiplica la pieza aprobada; `viventa-qa-marca` la revisa.
- **En vez de este:** `carrusel-figma` para carruseles orgánicos con guion propio;
  `presentacion-persuasiva-figma` para presentaciones.
