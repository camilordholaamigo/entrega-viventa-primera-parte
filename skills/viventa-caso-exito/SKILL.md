---
name: viventa-caso-exito
description: >-
  Convierte clientes reales de Viventa en casos de éxito publicables: produce la guía de entrevista
  emocional anclada en JTBD (MODO GUÍA) o, si ya hay entrevista/notas, el caso en 3 actos + guion de
  video 60-90s + 3 recortes para pieza + ficha comercial de objeciones (MODO CASO).
  Nunca inventa un verbatim y bloquea todo entregable sin consentimiento por escrito.
metadata:
  version: "1.0.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-caso-exito

Viventa **ya tiene** la materia prima. En 90 días el VOC registró **41 testimoniales largos
espontáneos** (6% de los comentarios, contra 0–0,3% de los competidores), con **31,7% de sentiment
positivo y solo 1,7% negativo** — el mejor del sector medido.

El gap **no es de materia prima**. Es de **extracción, estructura y derecho de uso**: esos
testimonios son comentarios de terceros en un post. No tienen los tres tiempos, **no tienen
consentimiento**, no se pueden cortar en pieza y no llegan al comercial cuando aparece la objeción.

Este skill cierra ese gap. Corre **en una sola pasada** (cuentas de Claude compartidas: si se
agotan los créditos hay que esperar 4 horas). Nada de loops de research. **No usa WebSearch.**

---

## LEY 0 — Las cuatro reglas que no se negocian

Si dudás entre entregar algo bonito y respetar una de estas, respetá la regla.

1. **Nunca inventar, pulir ni componer un verbatim.** Un testimonio fabricado **no es mal copy, es
   fraude** (FTC Consumer Reviews & Testimonials Rule 2024; en Colombia la responsabilidad del
   anunciante bajo Ley 1480/2011 es **objetiva**). Si no tenés la cita → escribís
   `[falta verbatim: preguntar X — pregunta N de la guía]`. Un caso incompleto y honesto es un
   entregable válido; uno completo e inventado, no.
2. **Sin consentimiento documentado no se publica.** El consentimiento es **estado del caso**, no
   trámite posterior. Estado 🔴 = ningún derivado externo sale. Bloqueante, sin excepciones.
3. **Cero promesas de rentabilidad dentro de un testimonio individual.** La SIC multó a
   **Constructora Bolívar** — constructora aliada de Viventa — con **$1.306.426.800** por publicidad
   engañosa, y en el caso Cossio declaró que **una promesa de ganancias sin respaldo es infracción**,
   con responsabilidad **objetiva**. Nunca tasa, nunca cuota, nunca plazo (Reg Z 12 CFR 1026.24).
4. **El cliente es el héroe; Viventa es el guía.** Viventa no aparece antes del Acto 2. Español de
   Colombia, tuteo, frases cortas. Prohibidas: "unlock", "leverage", "solución integral", "aliado
   estratégico", "en el mundo de hoy".

---

## FASE 1 — Intake y ruteo de modo (obligatoria, 1 paso)

Mirá lo que te dieron y decidí:

```
¿Hay entrevista, transcript, grabación, notas de llamada o respuestas del cliente
  a preguntas de PROCESO (no solo un elogio)?
      NO  →  MODO GUÍA
      SÍ  →  MODO CASO
  ¿Ambiguo (2 frases sueltas de un comentario de IG)?  →  MODO GUÍA personalizado
```

Un comentario de Instagram **no es un caso**. Si el input es un comentario del VOC, entregá MODO
GUÍA con las preguntas ya personalizadas para esa persona, apoyándote en lo poco que dijo.

### Inputs y qué hacer si falta uno

| Input | Para qué | Si falta |
|---|---|---|
| Nombre / ciudad origen / proyecto comprado | Cabecera y ficha | Escribí `[falta dato: confirmar con CRM Zoho]`. **No inventes ciudad ni año.** Seguí. |
| Transcript o grabación con timecodes | Todas las citas | **Sin timecodes no hay caso publicable.** Producí el caso con `[falta timecode]` en cada cita y estado 🔴. |
| Registro de consentimiento | Desbloquear publicación | Estado 🔴 + bloque de consentimiento al final. Producí igual: sirve interno. |
| Miedo que ataca el caso | Indexación | Derivalo de las citas. Si no hay evidencia, `[falta dato]`. |
| Cifras económicas | — | **Ninguna cifra entra sin validación.** Ver Fase 5. |
| Quién entrevistó | Sesgo | Si fue la consultora que vendió, marcá `⚠️ riesgo de deseabilidad social` en la ficha de control. |

Nunca pidas más de **una tanda** de aclaraciones. Si no responden, producí con huecos marcados.

---

## FASE 2 — MODO GUÍA · el instrumento para salir a buscar el caso

### 2.1 Por qué no se pregunta "¿cómo fue tu experiencia?"

Esa pregunta activa **modo evaluación de servicio**: el cliente responde en registro de encuesta
post-venta, con deseabilidad social maximizada (Bergen & Labonté 2020) — agravado porque
**suele entrevistar la misma consultora que le vendió**. Además no ancla en un momento: el material
bueno no está en las opiniones, está en los **episodios concretos**.

Modelo operativo: las **4 fuerzas de Moesta/Spiek** — alguien cambia solo si
`Empuje + Atracción > Ansiedad + Hábito`. **Ansiedad y Hábito son las fuerzas ocultas: el
entrevistado nunca las menciona solo.** Y en Viventa son las dominantes. Por eso el testimonio
genérico no convierte: solo habla de Atracción.

| Fuerza | En el ICP de Viventa | Qué pregunta la saca |
|---|---|---|
| **Empuje** | La remesa que se va sin construir nada; el arriendo de la mamá; los años pasando | "¿Qué cambió para que este año sí?" |
| **Atracción** | Tener algo propio en Colombia, dejarle algo a los hijos | "¿Qué te imaginabas cuando pensabas en esa casa?" |
| **Ansiedad** | Que me estafen; que no califique; que el inmueble no sea el de las fotos | "¿Qué era lo peor que te imaginabas?" |
| **Hábito** | "Mejor después"; nueve años posponiendo; miedo a preguntar y quedar en ridículo | "¿Por qué no lo habías hecho todavía?" |

> **REGLA DURA DE FORMULACIÓN: nunca nombres la emoción dentro de la pregunta.**
> ❌ "¿Sentiste miedo de que te estafaran?" → le regalás la palabra y devuelve tu palabra.
> ✅ "¿Qué era lo peor que te imaginabas que podía pasar?" → devuelve **su** palabra.
> La palabra del cliente es el activo. Si dijo *"raro"*, el caso dice *"raro"*, no *"aterrado"*.

### 2.2 Plantilla exacta del MODO GUÍA

Emitir **una página, markdown plano, imprimible**, que la consultora abre en el celular.

```markdown
# Guía de entrevista — Caso de éxito Viventa
**Cliente:** {Nombre} · **Ciudad:** {ciudad, país} · **Compró:** {proyecto, ciudad, año}
**Quién entrevista:** ______ · **Fecha:** ______ · **Duración objetivo:** 20–25 min
**Grabación:** ⬜ Aircall ⬜ WhatsApp ⬜ Zoom — **grabar siempre, se necesitan los timecodes**

## Antes de empezar — leer en voz alta
"{Nombre}, quiero contar tu historia bien contada, no un comercial. Voy a grabar para no
perderme nada, y vos vas a poder aprobar antes de que publiquemos. Si algo no querés que
salga, me lo decís y sale. Y si algo del proceso estuvo mal, **decímelo** — eso nos sirve
más que lo bueno. ¿Te parece?"

## ACTO 1 — ANTES (el miedo que lo paralizaba) · ~40% del tiempo
1. Contame cómo era tu situación antes de contactar a Viventa. ¿Dónde vivías, qué hacías?
2. ¿Cuánto tiempo llevabas pensando en comprar en Colombia antes de dar el paso?
3. **¿Por qué no lo habías hecho todavía?**  ← pregunta madre, no la sueltes
4. ¿Hubo algo puntual que te frenó? ¿Alguien que te dijo algo, algo que le pasó a un conocido?
5. ¿Qué era lo peor que te imaginabas que podía pasar si comprabas desde allá?
6. ¿Con quién hablaste de esto antes de decidirte? ¿Qué te dijeron?

## ACTO 2 — DURANTE (qué lo destrabó) · ~40%
7. ¿Cómo llegaste a Viventa? Contame ese momento.
8. ¿Qué fue lo primero que te hizo pensar "esto sí puede ser"?
9. **¿En qué momento del proceso dejaste de tener miedo?** ¿Fue de golpe o de a poquito?
10. ¿Hubo algún momento en que estuviste a punto de echarte para atrás? ¿Qué pasó ahí?
11. ¿Qué hizo la persona que te acompañó que vos no esperabas?
12. ¿Qué fue lo que peor funcionó? (preguntar siempre — un caso sin aspereza no se cree)

## ACTO 3 — HOY · ~20%
13. ¿Cómo te sentís hoy con esa decisión?
14. ¿Qué es distinto en tu vida hoy que no era antes?
15. ¿Qué le dirías a alguien que está donde estabas vos hace {N} años?
16. ¿Volverías a comprar? / ¿Ya estás pensando en la segunda?
    ⚠️ **No pedir cifras que después no podamos publicar.** Si él las da, se registran y se marcan.

## Cierre — CONSENTIMIENTO (obligatorio, en caliente, no se salta)
"Última cosa. ¿Estás de acuerdo en que usemos lo que me contaste —tu nombre de pila, tu ciudad
y una foto tuya— en nuestras redes y en material de Viventa? Te mando por WhatsApp un textico
corto para que me lo devolvás con un 'sí, autorizo'. Y si en algún momento querés que lo
bajemos, lo bajamos."

**Registro:** ⬜ nombre completo ⬜ solo nombre de pila ⬜ solo ciudad, sin nombre
⬜ foto ⬜ voz/video ⬜ cifras económicas
**Consentimiento por escrito:** ⬜ Sí, fecha ____ ⬜ **NO → EL CASO NO SE PUBLICA**
```

### 2.3 Tabla de repreguntas — va impresa al lado de las preguntas

Esto es lo que convierte a una consultora en entrevistadora. **Incluir siempre en el output.**

| Si el cliente responde… | Repregunta |
|---|---|
| *"Muy buena la experiencia, todos muy amables"* | "Me imagino que sí. Pero **antes** de que fuera buena — ¿cómo estabas vos? ¿Qué pensabas?" |
| *"Ellos son muy profesionales"* | "¿Qué hicieron que te hizo pensar eso? ¿Te acordás de algo puntual?" |
| *"Estaba un poco nervioso"* | "¿Nervioso de qué exactamente? ¿Qué te imaginabas que podía salir mal?" |
| *"Uno siempre desconfía"* | "¿Te pasó algo antes, o le pasó a alguien que conocés?" |
| *"Me ayudaron mucho"* | "Contame un momento concreto donde sentiste eso. ¿Qué día, qué pasó?" |
| *"Estoy contento"* | "¿Contento cómo? ¿Qué es distinto hoy en tu vida que no era antes?" |
| *"Fue rápido"* | "¿Rápido comparado con qué esperabas vos?" |
| Silencio / duda | **No rellenar. Contá hasta cinco.** El silencio es la mejor repregunta que existe. |

**Laddering** (atributo → consecuencia funcional → emocional → valor): *"me explicaron todo"* →
*"entonces supe si calificaba"* → *"dejé de sentirme un tonto preguntando"* → *"yo quería no
depender de nadie"*. **Máximo 2 "¿por qué?" seguidos** — martillar el porqué genera respuestas
socialmente deseables; alterná con andamiaje ("contame más de eso", "¿y qué pasó después?").

**A quién entrevistar, en este orden:** clientes con desembolso < 12 meses (la memoria del miedo se
degrada) · **recompradores** (el activo más raro del sector) · **diversidad geográfica deliberada**
— no más de 2 casos consecutivos de Miami-Dade; hay verbatims reales de NY, España y Bonaire.
Y si se puede, **que entreviste alguien distinto de quien vendió**.

---

## FASE 3 — MODO CASO · los 3 actos

### 3.1 Arquitectura y por qué

```
ACTO 1 ANTES          ACTO 2 DURANTE        ACTO 3 HOY
"yo también dudaba" → "esto fue lo que    → "y hoy estoy del
                       me destrabó"          otro lado"
Ansiedad + Hábito      Ansiedad → 0          Atracción
```

| Acto | Función | Miedo que desactiva | Cómo | % |
|---|---|---|---|---|
| **1. Antes** | Identificación | **Ser estafado** | El héroe **tenía el mismo miedo**. No se refuta: se valida. Nadie se defiende de quien le da la razón. | ~35% |
| **2. Durante** | Mecanismo | **Comprar un inmueble que no es** | Pasos concretos: quién le explicó, qué revisó, cuándo dejó de dudar. Se disuelve con **proceso visible**, no con adjetivos. | ~40% |
| **3. Hoy** | Permiso | **Perder la plata** | Entrega, llaves y sobre todo **la recompra**. Que alguien vaya por la segunda es el argumento anti-pérdida más fuerte, y **no requiere citar una sola cifra**. | ~25% |

**Cuatro reglas de estructura:**
1. Viventa aparece en el **Acto 2 y no antes**. QA: menciones de "Viventa" en Acto 1 ≤ 1.
2. **Sin conflicto no hay caso.** Si el Acto 1 no tiene miedo real, el caso se devuelve a entrevistar.
3. **Un detalle irrepetible por acto** — un lugar, una hora, una persona, un objeto. Si el Acto 1 se
   parece >70% a otro caso ya publicado, se reescribe o se descarta.
4. **Al menos una aspereza real.** Un caso perfecto no se cree.

### 3.2 Plantilla exacta del caso

Nombre de archivo obligatorio: `CASO_[nombre]_[ciudad-origen]_[año].md`.
Si no se nombra e indexa así, el comercial no lo usa y el activo se pierde otra vez.

```markdown
# CASO — {Nombre} · {ciudad origen} → {ciudad del inmueble}

**Estado de publicación:** 🔴 BLOQUEADO — falta consentimiento por escrito
**Perfil:** {nacionalidad, ciudad, tipo de inmueble, obra nueva/usada, 1ª o 2ª compra}
**Miedos que ataca:** ser estafado ✅ · perder la plata ⚠️ parcial · inmueble que no es ✅
**Fuente:** {Aircall / WhatsApp}, {duración}, {fecha}

## ACTO 1 — ANTES · El miedo que lo paralizaba
**Narración.** {Viventa contando en tercera persona, sin comillas. Hechos verificables.}

> *"{cita literal}"* — {Nombre}, {ciudad} · `[07:12–07:31]`

**El miedo, en sus palabras:**
> *"{cita literal}"* — `[09:04–09:18]`
o bien: **[falta verbatim: preguntar qué era lo peor que se imaginaba — pregunta 5]**

## ACTO 2 — DURANTE · Qué lo destrabó
**Narración.** {cómo llegó, qué le explicaron, qué revisó}

**El momento de quiebre:**
> *"{cita literal}"* — `[12:02–12:24]`
**[falta verbatim: sin esta cita el caso NO se publica]**

**La aspereza (obligatoria):**
> *"{cita literal de lo que no funcionó}"* — `[15:40–15:52]`

## ACTO 3 — HOY · Dónde está ahora
> *"{cita literal}"* — `[19:40–19:58]`

**Recompra:** ⬜ sí ⬜ no ⬜ lo está pensando
**Rentabilidad:** ⬜ no abordada · si la mencionó → ver Fase 5 antes de escribir nada

## Ficha de control
| Campo | Valor |
|---|---|
| Citas literales verificadas contra grabación | {n} de {N} |
| Consentimiento por escrito | ⛔ pendiente / ✅ {fecha} |
| Cifras económicas incluidas | ninguna |
| Nombre autorizado a publicar | {completo / pila / ninguno} |
| Foto autorizada | ⬜ |
| Aprobación de marca (Daniel Vélez) | pendiente |
| Riesgo de deseabilidad social | {sí, entrevistó quien vendió / no} |
```

**Cabecera de conteo obligatoria:** `Citas verificadas: 4 de 12 · huecos críticos: 2 · 🔴 no publicable`.

---

## FASE 4 — Regla de literalidad (la más importante del skill)

### 4.1 Tres niveles, siempre marcados

Clasificá **cada línea** del entregable:

| Nivel | Marca visual | Qué es | ¿Publicable como cita? |
|---|---|---|---|
| **1. Cita literal** | `> "…" — Nombre, ciudad` **+ timecode obligatorio** | Palabra por palabra de la grabación | ✅ |
| **2. Narración** | texto corrido, sin comillas | Viventa contando en tercera persona | ✅ como texto de Viventa |
| **3. Hueco** | `[falta verbatim: …]` en negrita | Lo que falta y la pregunta que hay que ir a hacer | ⛔ bloquea |

**Timecode obligatorio por cita. Sin timecode → es hueco, no cita.**

### 4.2 Qué edición permite la FTC (editar por claridad y extensión, sin cambiar el significado)

| Operación | ¿Permitida? | Cómo se marca |
|---|---|---|
| Cortar por los extremos | ✅ | — |
| Quitar muletillas (*este…*, *o sea*, *¿sí me entendés?*) | ✅ | — |
| Quitar una frase del medio | ✅ | `[…]` **visible** |
| Aclarar un referente | ✅ | `[Viventa]` entre corchetes |
| Corregir ortografía al subtitular | ✅ | — |
| **Cambiar una palabra por un sinónimo** | ❌ | — |
| **Reordenar frases dentro de la cita** | ❌ | — |
| **Coser dos momentos en una sola cita** | ❌ | — |

Corolario: **una cita = un timecode continuo.** Dos timecodes = dos citas separadas.
Prohibido atribuirle a un cliente algo que dijo otro. Prohibido convertir narración en cita
"para que suene mejor". Prohibido traducir la emoción.

### 4.3 Gate de verificación (obligatorio antes de publicar)

Antes de que el caso pase a 🟢, **una persona distinta de quien redactó** abre la grabación, salta a
cada timecode y confirma la cita palabra por palabra. Se toman **3 citas al azar**: 3 de 3 exactas o
el caso se rehace. El skill emite el checklist; **no puede ejecutar este gate por sí solo y debe
decirlo en el output.**

### 4.4 Sintaxis de huecos

```
[falta verbatim: preguntar por qué no había avanzado en nueve años — pregunta 3 de la guía]
[falta verbatim: no hay cita del momento de quiebre — el caso NO se publica sin esta]
[falta timecode: la cita existe en las notas pero no está ubicada en el audio]
[falta dato: confirmar año de compra con el CRM]
[falta consentimiento: no hay autorización escrita — bloqueante]
[⚠ no verificado: {dato}]
```

---

## FASE 5 — Compliance (bloqueantes)

### 5.1 Consentimiento

El consentimiento es **estado del caso**. Cabecera 🔴 bloqueado / 🟢 publicable. Debe cubrir:
alcance del uso (redes, ads, web, material comercial), nombre / foto / voz, **si hubo incentivo →
divulgarlo en la pieza** (conexión material no divulgada es exactamente lo que persigue la FTC),
revocación, mayoría de edad, fecha y constancia. WhatsApp con respuesta afirmativa sirve como
registro; documento firmado es mejor.

**Se pide al final de la entrevista, en caliente**, no tres semanas después por correo.
`[⚠ no verificado: la estimación de que se pierde ~70% si se deja para después es práctica, no dato medido]`

⚠️ **No incentivar.** Un incentivo cambia el estatus del testimonio y obliga a divulgarlo. El VOC
prueba que estos clientes hablan gratis: 41 testimoniales espontáneos en 90 días.

### 5.2 Rentabilidad — dos carriles que nunca se cruzan

| Carril | ¿Permitido? | Condición |
|---|---|---|
| **Campaña, dato macro** (ej. efecto de la bajada del dólar) | ✅ | Fuente citada y **fechada**, dato agregado, sin promesa de resultado individual |
| **Dentro de un testimonio individual** | ⛔ **PROHIBIDO** | Un cliente diciendo cuánto ganó es una promesa implícita de resultado replicable |

| ❌ Nunca escribir | ✅ Reemplazo |
|---|---|
| "Nuestros clientes obtienen X% de rentabilidad" | *"{cita literal de cómo le ha ido}"* — atribuida, sin generalizar |
| "Invertí en Colombia y duplicá tu plata" | Hecho verificable: "el inmueble se entregó en {fecha}" |
| Proyección de valorización | "{Nombre} hoy arrienda el apartamento" *(si es cierto y lo autorizó)* |
| El caso como argumento de **inversión** | El caso como argumento de **confianza y proceso** |
| Prometer aprobación de crédito, **tasa, cuota o plazo** | Nada. Eso lo da el asesor en llamada. |

**Si el cliente da una cifra en la entrevista:** (1) se registra como cita literal en el caso
interno; (2) se marca `⚠️ CIFRA — requiere validación de Crédito/Finanzas + consentimiento
específico`; (3) **no se propaga a ningún derivado externo** hasta validación; (4) si se publica,
exige en la misma pieza atribución, período y la frase de no-representatividad.

**Frase de no-representatividad** en toda pieza externa con caso individual:
*"Experiencia de un cliente. Los resultados dependen de cada caso."*

### 5.3 Fuentes internas sin consentimiento

El docx **`VERBATIMS CLIENTES CON DESEMBOLSO`** (4 perfiles: sin apellido, sin ciudad, **sin
registro de consentimiento**) sirve **para investigar y para calibrar tono. NO es publicable tal
cual.** Toda cita que salga de ahí se marca `[⚠ no verificado — sin consentimiento registrado]` y
no baja a ningún derivado externo. Lo mismo para comentarios públicos del VOC: tener handle
verificable **no es** tener consentimiento comercial.

---

## FASE 6 — Los 3 derivados

**Principio de derivación:** los tres son **recortes y reordenamientos del mismo material
verificado**. Ninguno introduce texto nuevo en boca del cliente. Todo texto nuevo es **texto de
Viventa** y se ve visiblemente distinto. **Todos heredan el estado de bloqueo del caso.**

```
CASO (fuente única de verdad, con timecodes)
   ├── GUION VIDEO 60-90s   clips + timecode, audio real
   ├── 3 RECORTES ≤14 pal.  cita literal + atribución
   └── FICHA COMERCIAL      cita + objeción · uso interno
```

### 6.1 Guion de video 60-90 s — grabable en una llamada telefónica

Restricción de producción fijada por Mateo: *"esos videos **no tienen que ser súper producidos**.
Puede ser una llamada telefónica donde sale la fotito de la persona y nos está contando."*
Esto **no es límite de presupuesto, es la decisión creativa correcta**: en paid social el material
crudo tipo UGC supera consistentemente al pulido en prospecting.

El guion **no es texto para que el cliente lea**. Es un **plan de montaje** sobre lo que el cliente
ya dijo.

| # | Tiempo | Fuente | Texto | Visual |
|---|---|---|---|---|
| 1 | 0:00–0:06 | **CLIP 09:04–09:10** | *"{cita del miedo}"* | Foto + subtítulo grande |
| 2 | 0:06–0:09 | Producción | — | Texto: "Nueve años pensándolo." |
| 3 | 0:09–0:24 | **CLIP 07:30–07:45** | *"{cita de por qué no avanzaba}"* | Foto + subtítulo |
| 4 | 0:24–0:30 | Producción | — | Texto: "Hasta que preguntó si calificaba." |
| 5 | 0:30–0:52 | **CLIP 12:02–12:24** | *"{cita del quiebre}"* | Foto + subtítulo |
| 6 | 0:52–1:10 | **CLIP 19:40–19:58** | *"{cita del hoy}"* | Foto del apartamento (si autorizó) |
| 7 | 1:10–1:18 | Producción | — | Cierre marca + CTA + no-representatividad |

**Regla del guion:** las filas **CLIP** son audio real del cliente con timecode. Las filas
**Producción** son texto en pantalla escrito por Viventa y **se ven distintas en el montaje**
(otra tipografía, otro color). Nunca se le pone al cliente una frase que no dijo, ni siquiera como
subtítulo. **Si el timecode no existe, la fila dice `[falta verbatim]` y el video no se produce.**

Formatos de export: **9:16 y 4:5** (Meta ya recomienda 4:5 sobre 1:1; Viventa sigue produciendo en
1:1 — el skill emite **4:5 por defecto**).

### 6.2 Tres recortes para pieza gráfica

**Uno por miedo, no los tres mejores momentos.** Máximo 14 palabras. Cita literal, cortada solo por
los extremos, nunca recompuesta.

| # | Miedo que ataca | Recorte | Timecode | Estado |
|---|---|---|---|---|
| 1 | Ser estafado | *"{≤14 palabras}"* | `09:04–09:10` | ✅ / ⛔ |
| 2 | Comprar un inmueble que no es | **[falta verbatim]** | — | ⛔ |
| 3 | Perder la plata | *"{≤14 palabras}"* | `19:40–19:48` | ✅ |

Si un miedo no tiene cita, el recorte queda **vacío con `[falta verbatim]`** — no se sustituye con
otro tema. Ningún recorte puede afirmar más que el caso: si el caso dice "en dos meses", el recorte
no dice "en semanas".

### 6.3 Ficha comercial — herramienta de objeción, uso interno

El comercial la abre cuando el lead dice la frase de la izquierda.

```markdown
**FICHA COMERCIAL — {Nombre} · {origen} → {destino} · {año}**

| Si el lead dice… | Contale que… | Cita exacta para leerle |
|---|---|---|
| "¿y si me estafan?" | {hecho del caso} | *"{cita literal}"* |
| "es que yo no estoy allá" | {hecho del caso} | *"{cita literal}"* |
| "no sé si califico" | {hecho del caso} | *"{cita literal}"* |
| "¿y después me dejan solo?" | {hecho del caso} | *"{cita literal}"* |

**Usar si el lead es:** {geografía} · {obra nueva/usada} · {1ª/2ª compra} · {viajó/no viajó}
**NO usar si:** {segmentos sin caso documentado — ej. vivienda usada, Puerto Rico}
**Lo que NO se puede decir de este caso:** ninguna cifra de rentabilidad, ninguna tasa,
ninguna cuota, ningún plazo de aprobación
**Consentimiento:** ⛔ pendiente — **uso interno hasta que se firme**
```

---

## Ejemplo real recortado (fragmento de Acto 2)

> ⚠️ Citas `[REAL]` = verbatims de fuentes internas de Viventa. Van marcadas porque **no tienen
> consentimiento registrado**: sirven para calibrar tono, no para publicar.

```markdown
## ACTO 2 — DURANTE · Qué lo destrabó

**Narración.** La primera llamada no fue de venta. Fue de matemáticas: cuánto ganaba,
qué le pedía el banco, si eso daba.

**[REAL]** > *"Cuando la chica me empezó a explicar ya las cosas que yo no sabía, ya uno va
teniendo más claridad, más confianza."* — Blanca Nelly, entrevista interna
`[falta timecode]` ⚠️ *sin consentimiento registrado*

**[REAL]** > *"La asesoría desde el principio me pareció honesta, no me prometieron cosas
que no podían cumplir."* — Gonzalo Castaño, entrevista interna ⚠️ *sin consentimiento*

**El momento de quiebre:**
**[falta verbatim: preguntar en qué momento exacto dejó de tener miedo — pregunta 9.
Este es el corazón del caso; sin esta cita el caso NO se publica.]**

**La aspereza (va en el caso, un caso sin fricción no se cree):**
**[REAL]** > *"Me tocaba estar llamando veces porque no me daban respuesta rápida."*
— Jenny Alexandra, entrevista interna
```

Fijate qué hace bien este fragmento: **no rellena el hueco del quiebre** aunque tenía dos citas
lindas cerca que podría haber estirado; deja la aspereza adentro; y no le atribuye a una persona lo
que dijo otra.

---

## Checklist de autovalidación (correr antes de entregar)

### Gates bloqueantes — ⛔ no se entrega en 🟢 si falla alguno
1. ⬜ **Cero verbatims inventados.** Cada cita tiene timecode y fuente.
2. ⬜ **Consentimiento por escrito registrado.** Si no → 🔴 y ningún derivado externo.
3. ⬜ **Acto 1 tiene al menos una cita literal del miedo o del bloqueo.**
4. ⬜ **Acto 2 tiene el momento de quiebre citado.**
5. ⬜ **Cero cifras de rentabilidad sin validación** de Crédito/Finanzas.
6. ⬜ **Cero tasa, cuota o plazo** en cualquier pieza.
7. ⬜ El skill **no publica nada**: termina en entregable para que Daniel Vélez apruebe.

### Tests de calidad
| # | Test | Pregunta |
|---|---|---|
| 1 | Del miedo | ¿El Acto 1 nombra un miedo con la palabra del cliente? |
| 2 | Del quiebre | ¿Se puede señalar el momento exacto en que dejó de dudar? |
| 3 | De especificidad | ¿Hay ≥3 detalles concretos que no aplicarían a otro caso? |
| 4 | De la voz | Leído en voz alta, ¿suena a persona colombiana real o a agencia? |
| 5 | De los tres miedos | ¿Cada miedo tiene al menos un recorte asignado (o un hueco explícito)? |
| 6 | Del héroe | ¿Menciones de "Viventa" en Acto 1 ≤ 1? |
| 7 | De la fricción | ¿Hay al menos una aspereza real? |
| 8 | De unicidad | ¿El Acto 1 aporta algo que no está en los casos ya publicados (<70% similitud)? |
| 9 | De literalidad inversa | 3 citas al azar contra la grabación: 3 de 3 exactas o se rehace. |
| 10 | Del comercial | ¿Se puede usar la ficha en una llamada sin leer el caso completo? |
| 11 | De producción | ¿El video es grabable con una llamada, una foto y CapCut? Si necesita set, se rediseña. |
| 12 | De una sola pasada | ¿Corrió sin loops de research? |

### Criterio de sistema (no de pieza)
Un caso aislado no cierra el gap. **Meta mínima: 6 casos** que cubran entre todos los **3 miedos ×
3 geografías** (USA / España / otra) **+ al menos un recomprador**. Recompradores ya identificados
en el VOC: @cliente, @cliente, @cliente, @cliente, @cliente.

---

## Anti-patrones — lo que este skill tiene prohibido hacer

| # | Falla | Antídoto |
|---|---|---|
| A1 | **Inventar el verbatim** | La cita **exige timecode**. Sin timecode → hueco + bloqueo + gate de audio por otra persona. |
| A2 | **"Mejorar" la cita** (*"me tocaba estar llamando"* → *"tuve que insistir constantemente"*) | Tabla 4.2. **El español del cliente es el activo, no el defecto.** |
| A3 | **Emoción genérica de manual** ("una mezcla de ilusión y temor") | Solo emociones **nombradas por el cliente con su palabra**. Si no nombró: hueco. |
| A4 | **Todos los casos son la misma historia** | Un detalle irrepetible por acto + test de unicidad. |
| A5 | **Componer una cita de dos momentos** | Una cita = un timecode continuo. |
| A6 | **Convertir el caso en pitch de Viventa** | Viventa no aparece antes del Acto 2. |
| A7 | **Meter cifras porque suenan fuertes** | Fase 5.2. Toda cifra va `⚠️ CIFRA` y no baja a derivados. |
| A8 | **Español neutro / voz de agencia** | Español de Colombia, tuteo, frases cortas. Sin "unlock", "leverage", "solución integral", "aliado estratégico". |
| A9 | **Rellenar el hueco para que el entregable se vea completo** | Se entrega con huecos visibles y estado 🔴. Es un entregable válido. |
| A10 | **Testimonio "zombie"** (*"yo compré la casa con Viventa"* y nada más) | Si el video no menciona una emoción previa a la compra, **no se produce**. |
| A11 | **Publicar sin aprobación de marca** | Regla durable #1 del cliente: el skill termina en entregable, nunca publica. |

---

## Referencias

- `references/tecnica-entrevista.md` — 4 fuerzas, laddering, deseabilidad social, reclutamiento
- `references/compliance.md` — FTC, SIC/Cossio/Constructora Bolívar, plantilla de consentimiento
- `references/plantillas.md` — plantillas limpias de guía, caso y los 3 derivados, listas para copiar

**Fuentes internas:** `references/contexto-viventa.md` · `references/voice-of-customer-90d.md`
· `…/CLIENTES CON DESEMBOLSO/VERBATIMS CLIENTES CON DESEMBOLSO_.docx` ⚠️ sin consentimiento ·
transcript `Viventa I Empalme agentes IA` (29-jul-2026).
