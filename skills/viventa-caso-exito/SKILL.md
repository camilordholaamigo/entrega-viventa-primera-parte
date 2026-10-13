---
name: viventa-caso-exito
description: >-
  Convierte clientes reales de Viventa en casos de éxito: sin entrevista, la guía JTBD (modo
  guía); con grabación, el caso en 3 actos con timecodes, guion de video, 3 recortes y ficha
  comercial (modo caso). Nunca inventa un verbatim y bloquea lo externo sin consentimiento. USA cuando: "necesitamos casos de
  éxito documentados", "tengo la grabación de una clienta, sácame el caso", "un video testimonial
  que no sea el zombie de siempre", "pásame la ficha de este caso para el comercial". Es el
  caso de Viventa con su compliance: case-study-interview-guide y case-study-builder hacen la
  versión genérica.
metadata:
  version: "1.1.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-caso-exito

Viventa **ya tiene** la materia prima: en 90 días el VOC registró 41 testimoniales largos
espontáneos (`references/voice-of-customer-90d.md`). El gap es de **extracción, estructura y
derecho de uso**: son comentarios de terceros sin los tres tiempos, **sin consentimiento**, que no
se cortan en pieza ni llegan al comercial cuando aparece la objeción.

Invariantes en toda corrida: ninguna cita sin timecode, ningún derivado externo sin
consentimiento escrito, ninguna cifra de rentabilidad dentro de un testimonio, y el cliente es el
héroe (Viventa aparece recién en el Acto 2). Corre **en una sola pasada**, sin búsqueda web.

## Cuándo usar

- Explícito: "necesitamos casos de éxito documentados", "hazme la guía para entrevistar a un
  cliente", "tengo la grabación de una clienta, sácame el caso", "un video testimonial que no sea
  el zombie de siempre", "qué le pregunto al cliente para que cuente la emoción", "pásame la ficha
  de este caso para el comercial".
- Implícito: aparece un comentario de un cliente contento en redes y alguien quiere "usarlo";
  o el comercial pide prueba social para una objeción concreta.

## Cuándo NO usar

- **Caso de éxito de otra empresa o B2B** → `case-study-builder` (redacta) o
  `case-study-interview-guide` (entrevista).
- **Kit para que un cliente refiera a otro** → `viventa-kit-referidor`.
- **Medir qué se dice de la marca en el mes** → `viventa-radar-competencia`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Material del cliente | El usuario pega transcript, notas, respuestas o un comentario | *"¿Tenés la grabación o el transcript de la entrevista, o solo el comentario?"* — sin nada, modo guía en blanco |
| Timecodes de la grabación | El transcript con marcas de tiempo | *"¿El transcript trae los minutos?"* — si no, cada cita va `[falta timecode]` y el caso queda 🔴 |
| Nombre, ciudad de origen, proyecto y año de compra | El usuario o el CRM | *"¿Nombre, desde qué ciudad compró, qué proyecto y en qué año?"* — sin respuesta: `[falta dato: confirmar con el CRM]`, nunca se inventa |
| Registro de consentimiento | El usuario (WhatsApp con "sí, autorizo" o documento firmado) | *"¿Hay autorización por escrito? ¿Qué cubre: nombre, foto, voz, cifras?"* — sin registro, estado 🔴 y se produce igual para uso interno |
| Si hubo incentivo | El usuario | *"¿Se le dio algo a cambio?"* — si sí, la pieza lo divulga (Paso 7) |
| Quién entrevistó | El usuario | *"¿Entrevistó la misma persona que le vendió?"* — sin respuesta, la ficha de control dice "desconocido" |
| Casos ya producidos | El índice en `salidas/viventa-caso-exito/indice-casos.md` | Se lee; si no existe, el test de unicidad del Paso 9 se marca "sin casos previos para comparar" |

Una sola tanda de aclaraciones. Si no responden, se produce con los huecos marcados. Cifras,
voz y reglas de marca salen de `references/cifras-canonicas.md` y `references/contexto-viventa.md`
(los inyecta el build del plugin del cliente).

## Workflow

1. **Elegí el modo.** Si hay entrevista, transcript o respuestas a preguntas de **proceso** →
   modo caso (Paso 4). Si no hay nada, o solo un elogio o un comentario de redes → modo guía
   (Paso 2), personalizado con lo poco que dijo. Un comentario de Instagram no es un caso.
2. **Modo guía: armá la guía.** Copiá la plantilla 1 de `references/plantillas.md` (una página,
   16 preguntas en Antes 40 % / Durante 40 % / Hoy 20 %, apertura leída en voz alta y cierre de
   consentimiento en caliente) y completá cabecera y el "hace {N} años" con los datos que haya.
   Anexá **siempre** la tabla de repreguntas que está debajo de esa plantilla (convierte a quien
   vendió en entrevistadora). Si entrevista quien vendió, la ficha de control marca
   `⚠️ riesgo de deseabilidad social`. La guía sigue las 4 fuerzas
   (`Empuje + Atracción > Ansiedad + Hábito`, detalle en `references/tecnica-entrevista.md`):
   Ansiedad y Hábito son las que el cliente no dice solo, por eso las preguntas 3, 5 y 9 son las
   madres. **Ninguna pregunta nombra la emoción**: ✅ "¿qué era lo peor que te imaginabas?"
   · ❌ "¿sentiste miedo de que te estafaran?".
3. **Modo guía: sumá a quién entrevistar.** Desembolso de menos de 12 meses primero, luego
   recompradores, y no más de 2 casos seguidos de la misma plaza. Si se puede, que no entreviste
   quien vendió. Entregá la guía y cerrá: el modo guía no corre el Paso 9 ni escribe en `indice-casos.md`, que solo indexa casos.
4. **Modo caso: clasificá cada línea** en uno de tres niveles:

   | Nivel | Forma | ¿Publicable? |
   |---|---|---|
   | Cita literal | `> "…" — Nombre, ciudad · [mm:ss–mm:ss]` | ✅ solo con timecode |
   | Narración | Texto corrido de Viventa, tercera persona, sin comillas | ✅ como texto de Viventa |
   | Hueco | `[falta verbatim: preguntar X — pregunta N de la guía]` en negrita | ⛔ bloquea |

   Sin timecode es hueco, no cita. Edición permitida en una cita: cortar por los extremos, quitar
   muletillas, quitar una frase del medio con `[…]` visible, aclarar un referente entre
   corchetes, corregir ortografía. **Prohibido**: sinónimos, reordenar, coser dos momentos (una
   cita = un timecode continuo), atribuirle a uno lo que dijo otro, "mejorar" su español.
   Otras marcas: `[falta timecode: …]`, `[falta dato: …]`, `[falta consentimiento: …]`,
   `[⚠ no verificado: …]`.
5. **Modo caso: armá los 3 actos** con la plantilla 2 de `references/plantillas.md`:

   | Acto | Función | Miedo que desactiva | Peso |
   |---|---|---|---|
   | 1. Antes | Identificación: tenía el mismo miedo, se valida, no se refuta | Ser estafado | ~35 % |
   | 2. Durante | Mecanismo: quién explicó, qué revisó, cuándo dejó de dudar | Inmueble que no es | ~40 % |
   | 3. Hoy | Permiso: entrega, llaves, recompra (sin citar cifras) | Perder la plata | ~25 % |

   Decisiones: si el Acto 1 no tiene miedo o bloqueo citado, el caso **se devuelve a entrevistar**
   (se entrega la guía con las preguntas faltantes). Sin cita del momento de quiebre, el caso
   queda 🔴. "Viventa" aparece como máximo 1 vez en el Acto 1. Un detalle irrepetible por acto
   (lugar, hora, persona, objeto) y al menos una aspereza real citada; sin aspereza,
   `[falta verbatim: pregunta 12]`. Emociones solo con la palabra del cliente: si dijo "raro",
   el caso dice "raro".
6. **Tratá las fuentes sin consentimiento.** Citas del documento interno de verbatims de clientes
   con desembolso o de comentarios públicos del VOC van `[⚠ no verificado — sin consentimiento
   registrado]`: sirven para calibrar tono y elegir a quién llamar, nunca bajan a un derivado
   externo. Un handle público no es consentimiento comercial.
7. **Aplicá compliance** (`references/compliance.md`):
   - **Estado:** 🟢 publicable solo con consentimiento escrito que cubra alcance (redes, pauta,
     web, material comercial), qué se usa (nombre, foto, voz, cifras), revocación, mayoría de
     edad y fecha. Cualquier faltante → 🔴. Si hubo incentivo, la pieza lo divulga.
   - **Cifras:** si el cliente dijo una, se registra literal en el caso interno, se marca
     `⚠️ CIFRA — requiere validación de Crédito/Finanzas + consentimiento específico` y no baja a
     ningún derivado externo hasta validarse. La rentabilidad se trabaja a nivel campaña con dato
     macro fechado, nunca dentro de un testimonio.
   - **Nunca tasa, cuota, plazo ni aprobación de crédito** (triggering terms de Reg Z 12 CFR
     1026.24). El VA loan no financia propiedad fuera de EE. UU. y sus territorios.
   - Toda pieza externa con caso individual cierra con *"Experiencia de un cliente. Los
     resultados dependen de cada caso."*
8. **Derivá los 3 entregables** (plantillas 3-5 de `references/plantillas.md`). Son recortes del
   material verificado: ningún texto nuevo en boca del cliente, y todos **heredan el estado** del
   caso.
   - **Guion de video 60-90 s**: plan de montaje grabable con una llamada, una foto y un editor
     móvil. Filas CLIP = audio real con timecode; filas Producción = texto de Viventa con
     tipografía distinta. Fila sin timecode → `[falta verbatim]` y el video no se produce. Si
     ninguna cita menciona una emoción previa a la compra, es un testimonio zombie y no se
     produce. Export 4:5 por defecto, más 9:16.
   - **3 recortes**: uno por miedo, máximo 14 palabras, cortados solo por los extremos. Miedo sin
     cita → recorte vacío con `[falta verbatim]`, no se sustituye. Ningún recorte afirma más que
     el caso.
   - **Ficha comercial** (uso interno): tabla "si el lead dice… / contale que… / cita exacta",
     a qué leads sirve y a cuáles no, y qué no se puede decir del caso.
9. **Autovalidá, guardá e indexá.** Corré los gates: cero citas sin timecode, estado coherente
   con el consentimiento, Acto 1 con miedo citado, Acto 2 con quiebre citado, cero cifras sin
   validar en derivados, cero tasa/cuota/plazo, "Viventa" ≤ 1 en Acto 1. Test de unicidad contra
   el índice: es **duplicado** si comparte con un caso ya indexado el mismo miedo del Acto 1, la
   misma plaza de origen y el mismo detalle irrepetible (lugar, hora, persona u objeto). Dos de
   tres → se marca "parecido" y se reescribe el Acto 1 con otro detalle de la grabación; tres de
   tres → se marca para descartar (heurística propia, ajustable). Sin índice → "sin casos previos
   para comparar". Guardá y sumá la fila al índice (plantilla 6).
   Decí en el output que **la verificación de audio la tiene que hacer una persona distinta de
   quien redactó**: 3 citas al azar contra la grabación, 3 de 3 exactas o se rehace. El skill no
   puede ejecutar ese gate.

## Reglas duras

- **Nunca inventa, pule ni compone un verbatim.** Un testimonio fabricado es fraude (FTC 2024;
  responsabilidad objetiva bajo Ley 1480/2011). Sin cita, hueco marcado.
- **Ninguna cita sin timecode continuo** y fuente.
- **Ningún derivado externo en 🟢 sin consentimiento escrito registrado.**
- **Ninguna cifra de rentabilidad, tasa, cuota, plazo ni promesa de aprobación** en un testimonio
  o derivado externo. Permitido en el caso interno: la cifra literal marcada `⚠️ CIFRA`.
- **Nunca nombra la emoción dentro de una pregunta de la guía.**
- **Nunca publica.** Todo termina en un entregable para que el responsable de marca de Viventa
  lo apruebe.
- **Sin voz de agencia:** ninguna de "unlock", "leverage", "solución integral", "aliado
  estratégico", "en el mundo de hoy". Español de Colombia, tuteo.

## Output esperado

Archivos en `salidas/viventa-caso-exito/`:

- Modo guía: `GUIA_{nombre}_{ciudad-origen}.md` — una página imprimible con la guía, la tabla de
  repreguntas y a quién entrevistar.
- Modo caso: `CASO_{nombre}_{ciudad-origen}_{año}.md` con cabecera de conteo
  (`Citas verificadas: N de M · huecos críticos: K · 🔴/🟢`), los 3 actos, la ficha de control y,
  debajo, guion de video, 3 recortes y ficha comercial.
- `indice-casos.md` actualizado con una fila por caso.

Al terminar se le dice al usuario: modo, ruta, estado (🔴/🟢 y por qué), los huecos críticos con
la pregunta de la guía que los cierra, y que falta el gate de audio por otra persona.

## Skills relacionados

- **Antes:** `viventa-radar-competencia` muestra qué prueba social tiene la competencia y qué
  sub-segmentos no tienen caso.
- **Después:** `viventa-parrilla-base` ubica las piezas en el mes; `viventa-match-proyecto-lead`
  puede usar la ficha comercial en la conversación con el lead.
- **En vez de este:** `case-study-interview-guide` y `case-study-builder` para casos fuera de
  Viventa; `viventa-kit-referidor` cuando el cliente contento va a referir, no a testimoniar.
