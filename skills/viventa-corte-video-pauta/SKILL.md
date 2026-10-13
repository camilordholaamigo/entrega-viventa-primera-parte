---
name: viventa-corte-video-pauta
description: >-
  Arma el primer corte de los videos de pauta de Viventa a partir del material grabado: transcribe,
  elige la mejor toma de cada línea del guion, quita silencios, quema subtítulos y exporta en 9:16,
  4:5 y 1:1 con la lista de decisiones de edición (EDL). Corre con ffmpeg, no en el chat. USA
  cuando: "tengo las grabaciones del evento, sácame los cortes", "edita los cinco videos del
  brief", "ponle subtítulos y sácalo en formatos para pauta", "versiones de 15 y 30 segundos".
  Es postproducción gruesa: viventa-guiones-evento escribe lo que se graba y la productora pule.
metadata:
  version: "1.0.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-corte-video-pauta

Saca el trabajo mecánico de la edición de los videos de pauta para que la productora de contenidos
—una sola persona para más de 100 videos al mes— pase de editar desde cero a pulir. Tres
invariantes en toda corrida: **el corte nunca cambia lo que se dijo** (se quitan silencios y tomas
fallidas, no palabras que cambien el sentido), **cada decisión queda en la EDL con su motivo**, y
**nada se publica ni se sube a Ads Manager**: el entregable es un borrador para que ella lo termine.

Corre en **Claude Code con ffmpeg** sobre la carpeta de grabaciones. En el chat no edita video: si
alguien lo pide ahí, explicá que necesita la carpeta local y ffmpeg, y ofrecé solo la EDL a partir
de una transcripción pegada.

## Cuándo usar

- Explícito: "tengo las grabaciones del evento, sácame los cortes", "edita los cinco videos del
  brief", "ponle subtítulos y sácalo en formatos para pauta", "corta este material en versiones de
  15 y 30 segundos", "necesito los videos de optimización para mañana".
- Implícito: terminó el día de grabación de un evento (5 videos, en dólares y en euros) y empieza la
  postproducción de 2 a 3 días.
- Cadencia: por evento (mínimo 3 al mes) y otra vez por cada tanda de optimización.

## Cuándo NO usar

- Todavía no hay guion → `viventa-guiones-evento`.
- Hay que redactar el copy de cada archivo del pack o el CSV de los flyers → `viventa-pack-evento`.
- Cambiar solo las placas de ciudad, fecha o consultora en un video ya editado →
  `viventa-versionador-piezas`.
- Un reel orgánico con edición de retención fina (ritmo, b-roll, efectos) → `retention-edit-plan`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Carpeta con las grabaciones | Ruta local | *"¿En qué carpeta están los archivos crudos de la grabación?"* **Bloquea** |
| Los guiones (los 5 del evento o los de optimización) | Salida de `viventa-guiones-evento` o el documento del brief | *"Pásame los guiones: con ellos sé qué toma corresponde a cada línea."* Sin guion se corta solo por silencios y se avisa |
| Evento, ciudad y moneda de cada versión | El brief | *"¿Para qué evento y ciudad es, y qué versiones van en USD y cuáles en EUR?"* |
| Formatos y duraciones | El pedido | No se pregunta: por defecto 9:16, 4:5 y 1:1 a duración completa. 15 s y 30 s solo si los piden |
| Estilo de subtítulos (fuente, color, caja) | Manual de marca o un video aprobado de referencia | *"¿Tienes un video aprobado con los subtítulos de marca? Copio ese estilo."* Si no, estilo neutro (blanco con borde negro) marcado `estilo provisional` |
| Transcripciones (si no hay transcriptor local) | SRT exportado de CapCut o Premiere | Solo si falla el Paso 1: *"No tengo transcriptor instalado. ¿Me exportas el SRT de CapCut de cada clip?"* |

## Workflow

### Paso 0 · Puesta en marcha (solo la primera vez)

1. Verificá `ffmpeg -version` y `ffprobe -version`. Si falta, pará y dale el comando de instalación
   de su sistema; la primera instalación se hace acompañada por alguien técnico, como pidió el equipo.
2. Verificá un transcriptor local (`whisper`, `faster-whisper` o `whisper.cpp`). Si no hay, el skill
   funciona con los SRT que exporte CapCut.
3. Probá con **un solo clip** antes de procesar el evento entero y mostrale el resultado.

### Paso 1 · Inventario y transcripción

1. Listá los clips con `ffprobe`: duración, resolución, orientación, fps y si traen audio.
   Marcá los clips sin audio o de menos de 2 s como `descartado: sin audio / falso arranque`.
2. Transcribí cada clip **con marcas de tiempo por palabra**, en español. Guardá un `.json` por clip.
3. Si la confianza del transcriptor es baja en un tramo (ruido, viento), marcalo: esas líneas no se
   eligen solas, van a la EDL como `revisar a mano`.

### Paso 2 · Emparejar tomas con el guion

1. Partí cada guion en líneas (hook, cuerpo, CTA).
2. Para cada línea buscá en las transcripciones las tomas que la dicen (coincidencia aproximada de
   palabras, tolerante a muletillas).
3. Elegí la mejor toma con este orden de criterios, y escribí cuál pesó:
   1. dice la línea completa, sin cortes ni repeticiones;
   2. no tiene tropiezos ni reinicios en medio ("eh… no, otra vez");
   3. entre tomas igual de limpias, la última (suele ser la que salió bien);
   4. nivel de audio usable (sin picos ni saturación).
4. Si una línea **no tiene ninguna toma limpia**, no la reemplaces con otra frase: marcala
   `falta toma` y seguí. El corte sale con un hueco señalado y la EDL lo dice primero.

### Paso 3 · Recortar silencios sin comerse palabras

1. Detectá silencios con `silencedetect` (punto de partida: -30 dB, 0,35 s; ajustalo si el ambiente es ruidoso).
2. Dejá un margen de ~0,12 s antes y después de cada frase para no cortar consonantes.
3. Nunca cortes dentro de una palabra ni quites una palabra que cambie el sentido. En particular,
   **nunca recortes una aclaración legal** ("sujeto a estudio de crédito", "aplican condiciones").

### Paso 4 · Montar, subtitular y exportar

1. Uní los tramos en el orden del guion (recorte con recodificación para que los cortes sean exactos).
2. Normalizá el audio para redes (−14 LUFS integrado como referencia).
3. Generá los subtítulos **desde la transcripción de lo que quedó en el corte**, no desde el guion:
   si la persona dijo otra cosa, el subtítulo dice lo que dijo. Máximo 2 líneas, ~32 caracteres por línea.
4. Quemá los subtítulos con el estilo de marca y exportá cada formato (1080×1920, 1080×1350, 1080×1080).
   Si el material es horizontal, recortá centrado en la cara y avisá qué tomas perdieron encuadre.
   Mantené los subtítulos fuera de las zonas que tapa la interfaz de Reels y Stories
   `[verificar con la guía vigente de zonas seguras de Meta]`.
5. Si piden 15 s y 30 s: conservá hook y CTA, y llená el medio con las líneas de más peso del cuerpo
   hasta la duración. Si no cabe sin cortar una idea a la mitad, entregá la versión más cercana y decilo.

### Paso 5 · Revisar antes de entregar

- [ ] Cada video tiene su EDL y cada línea del guion aparece como usada, `falta toma` o `revisar a mano`.
- [ ] La moneda que se dice y la de los subtítulos coinciden con la versión (USD para EE. UU., EUR para España).
- [ ] Ciudad y fecha que se dicen coinciden con el evento del brief.
- [ ] Ningún subtítulo menciona tasa, cuota, plazo o aprobación de crédito que no esté en el guion aprobado.
- [ ] Ningún archivo se llama `final`: todos son `v1-corte`.

## Reglas duras

- **Nunca publica, sube ni programa** nada en Meta, YouTube ni redes. Termina en una carpeta local.
- **Nunca cambia lo que se dijo**: no reordena frases para que digan otra cosa ni quita una negación,
  una condición o una aclaración legal.
- **Nunca inventa una toma** ni rellena una línea faltante con otra frase o con voz sintética.
- **Nunca agrega música ni material de stock**: la música y el pulido (color, animaciones, placas) son
  de la productora.
- **Nunca sube el material a un servicio externo** para transcribir: la transcripción es local o la
  hace CapCut del equipo.
- **Nunca entrega un archivo como final**: el nombre lleva `v1-corte` hasta que la productora lo cierre.

## Output esperado

Una carpeta por evento en
`salidas/viventa-corte-video-pauta/<AAAA-MM-DD>-<evento>/`:

```
<evento>/
  RESUMEN.md                         ← lo primero que se lee
  guion-1/
    guion-1_<ciudad>_<moneda>_9x16_v1-corte.mp4
    guion-1_<ciudad>_<moneda>_4x5_v1-corte.mp4
    guion-1_<ciudad>_<moneda>_1x1_v1-corte.mp4
    guion-1.srt
    guion-1_EDL.csv                  ← línea, clip, entrada, salida, criterio, nota
  guion-2/ …
  transcripciones/                   ← un .json por clip
```

Si existe la matriz de `viventa-pack-evento`, los archivos llevan su nombre normalizado en vez del de arriba.

`RESUMEN.md` abre con lo que necesita atención:

```
CORTE v1 — {evento} · {ciudad} · {fecha}
{n} videos cortados · {n} líneas sin toma limpia · {n} tramos para revisar a mano

Atención primero
- guion-3, línea 4 (CTA): falta toma. Opciones: regrabar o usar la toma 2 con el tropiezo en 00:07.
- guion-5: material horizontal; en 9:16 la toma 3 pierde la mano que señala el flyer.

Por video: duración, formatos exportados, tomas usadas, criterio que más pesó.
Pendiente de la productora: color, música, placas del flyer, animaciones, revisión final.
```

Al terminar, decí: *"Cortes v1 listos en `<ruta>`. {n} líneas necesitan tu decisión (están arriba en
RESUMEN.md). Nada se subió a ningún lado."*

## Skills relacionados

- **Antes:** `viventa-guiones-evento` (lo que se graba) y `viventa-pack-evento` (el nombre de cada archivo).
- **Después:** `viventa-versionador-piezas` para las placas por ciudad, consultora o fecha;
  `viventa-qa-marca` para la revisión de marca antes de mandarlo a la agencia de pauta.
- **En vez de este:** `retention-edit-plan` y `retention-editor` cuando es un video orgánico que
  necesita plan de retención, no un primer corte de pauta.
