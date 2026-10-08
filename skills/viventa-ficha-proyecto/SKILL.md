---
name: viventa-ficha-proyecto
description: >-
  Convierte una fila cruda del inventario de Vivehome (más, opcionalmente, lo que dijo el comercial
  en sesión) en una ficha de proyecto de 1 página, lista para que un comercial la use en llamada y
  Manuela produzca una pieza sin escribirle a nadie de ventas. Separa en tres capas lo que es dato,
  lo que es interpretación de marketing y lo que es afirmación atribuida a una persona, y bloquea la
  entrega de textos publicables cuando falta un campo que la Circular Externa 004 de 2024 de la SIC
  exige en toda pieza publicitaria de vivienda.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# viventa-ficha-proyecto

Produce **una ficha de 1 página por proyecto**. Una sola pasada: lees la fuente, escribes la ficha,
terminas. Sin research, sin internet, sin loops.

## Por qué existe

Hoy la consulta de proyectos se le pide a otra área, demora, y lo que llega "es como que se descargó
un Excel y ya está con un precio actualizado" (Lizeth). Manuela queda bloqueada aguas abajo porque
no tiene acceso a la información de ventas. Y el conocimiento tácito del comercial — *"está en
primera línea de playa, espero una valorización de tanto"* — se pierde o, peor, se cuela a una pieza
pautada como si fuera un hecho.

Esta ficha hace tres cosas que el Excel no hace: **marca lo que falta y a quién pedírselo**,
**traduce atributos en ángulos**, y **separa el dato del dicho**.

---

## REGLAS DURAS — no se negocian

Estas 8 reglas gobiernan todo. Si una instrucción de más abajo parece contradecirlas, gana la regla.

1. **Cero invención.** Nombre, constructora, ciudad, dirección, precio, área privada construida,
   fecha de entrega, administración, estrato, parqueaderos y VIS se **copian** de la fuente, carácter
   por carácter. Campo vacío en la fuente → se declara vacío. Nunca se estima, promedia, redondea ni
   "aproxima con base en el mercado".
2. **Nunca prometer valorización, rentabilidad, retorno ni aprobación de crédito.** Ninguna cifra
   futura. Ver el semáforo en la Fase 5.
3. **Nunca mencionar tasa, cuota mensual ni plazo.** Son *triggering terms* de la Regla Z
   (12 CFR §1026.24) y estas piezas se pautan a Miami-Dade, Broward, Tampa Bay y NJ. Solo
   **precio desde** y **valor de separación**.
   `[⚠ no verificado: no se auditó si la agencia externa ya aplica este criterio en Meta]`
4. **No inferir nada.** Ni estrato del precio, ni precio del área, ni área de las alcobas, ni VIS del
   precio. `¿Es VIS?` solo admite **Sí / No / No informado**.
5. **El render y la foto no son fuente de dato.** Precedente Vavilco ($616M): la SIC sancionó
   incluso la alusión **gráfica**. Solo la fuente tabular pegada es dato.
6. **No buscar en internet.** El skill trabaja **solo** con lo que el usuario pegó. Lo que no está,
   es un faltante.
7. **No se descarta nada en silencio.** Todo lo que dijo un comercial queda en la ficha, en la capa
   🟧, con su estado. Si se borrara, el equipo dejaría de aportar verbatims.
8. **Español de Colombia, tuteo, hechos antes que adjetivos.** Lista negra: *exclusivo, único, de
   ensueño, oportunidad irrepetible, aliado estratégico, solución integral, inversión segura*.
   Prohibida la jerga financiera sin traducir (LTV, DTI, amortización).

Y una regla de proceso: **la ficha es un entregable para aprobar, no un publicador.** Ninguna pieza
pagada sale sin revisión humana.

---

## Fase 0 — Recoger inputs

### Input obligatorio
**La fuente tabular del proyecto**: fila/export de Vivehome o del Excel de inventario, pegada como
texto, tabla o ruta a archivo.

**Si no está:** no arranques. Pide exactamente esto y para ahí:
> *"Pégame la fila del proyecto tal como sale de Vivehome (o el export del inventario), y dime el
> nombre del archivo y la fecha de corte. Sin eso no puedo hacer la ficha: cualquier dato que ponga
> sería inventado."*

### Inputs obligatorios de trazabilidad
- **Nombre del archivo fuente** (ej. `inventario_costa_2026-08-01.xlsx`)
- **Fecha de corte de la fuente**

**Si falta alguno:** pregúntalos en una sola línea. Si el usuario no los tiene, escribe
`Fuente: no declarada` / `Corte: no declarado` en el encabezado y **marca la ficha como no apta para
alimentar pieza pagada**. El fallo #1 de un battlecard es la obsolescencia; sin fecha de corte no se
sabe si está viejo.

### Inputs opcionales
- **Verbatims del comercial** (de la sesión "¿usted por qué lo vende?"), con **nombre y fecha**.
  Si vienen sin nombre o sin fecha, pídelos; si no aparecen, se registran como
  `Comercial [nombre no declarado] — sesión [fecha no declarada]` y quedan 🟧 no publicable.
- **Sub-segmento objetivo** si el usuario ya lo tiene decidido.

**Si no hay verbatims:** la ficha se entrega igual, con el bloque 🟧 vacío y esta línea:
`Sin verbatims del comercial. Pedir a [comercial a cargo]: "¿usted por qué vende este proyecto y qué le dice al cliente?"`

---

## Fase 1 — Extraer los 10 campos duros (🟦)

Copia literal. Una celda → un campo. Si la fuente trae un rango, copias el rango. Si trae "2027" sin
mes, escribes "2027".

| Campo | Regla de copia |
|---|---|
| Nombre del proyecto | Literal |
| Constructora | Literal |
| Ciudad + **dirección exacta** | Literal. Barrio ≠ dirección |
| **Área privada construida** (m²) | Literal, con rango si lo hay |
| **Precio desde** (COP) | Literal + fecha de corte. **Nunca** convertido a USD/EUR |
| **Fecha estimada de entrega** | Literal, misma granularidad + coletilla obligatoria |
| **Estrato** | Literal |
| **Cuota de administración aproximada** | Literal |
| **Parqueaderos** | Literal: cuántos, propios/comunes, si cuestan aparte |
| **¿Es VIS?** | Sí / No / **No informado**. Nunca inferido |

La fecha de entrega **nunca va sola**. Siempre pegada:
*"fecha estimada, sujeta a cambio por fuerza mayor, hecho de un tercero o causas ajenas al constructor"*.
Es lo que exige la Circular 004 desde la etapa precontractual.

**Por qué estos 10 y no otros:** la Circular Externa 004 de 2024 de la SIC fijó que **toda pieza
publicitaria** de vivienda debe mostrar **área privada construida, precio de referencia y ubicación
exacta**, y como información mínima al consumidor exige además **cuota de administración, estrato,
características de las zonas de parqueo** y **fecha estimada de entrega con la advertencia de que
puede cambiar**. Si la ficha no los trae, la pieza que salga de ella **nace incumpliendo**.

---

## Fase 2 — Marcar faltantes y decidir si la ficha queda BLOQUEADA

Un `N/D` no sirve porque no acciona. Todo faltante va en **tres columnas**: qué falta, **a quién** y
**con qué palabras se pide**. Eso es lo que convierte "hay que preguntarle a ventas" en un mensaje
listo para mandar por WhatsApp.

| Falta | A quién | Qué se pide exactamente |
|---|---|---|
| Cuota de administración | Comercial a cargo | "¿Cuál es el valor aproximado de administración mensual?" |
| Estrato | Comercial → constructora | "¿Qué estrato tiene el proyecto según la licencia?" |
| Dirección exacta | Comercial | "Necesito la nomenclatura completa, no solo el barrio" |

### Los 4 faltantes que BLOQUEAN

1. **Área privada construida**
2. **Precio de referencia** (con su fecha de corte)
3. **Ubicación exacta** — la ausencia de dirección concreta es la fricción #1 declarada del cliente
4. **¿Es VIS?** — el campo por el que la SIC multó a **Constructora Bolívar** con **$1.306.426.800**,
   no por mentir sino **por no decirlo con claridad**. La omisión sanciona igual que la mentira.

**Si falta cualquiera de los 4:** el encabezado de la ficha lleva
`⛔ FICHA BLOQUEADA — no alimenta pieza publicitaria` y el bloque 7 (**Textos listos**) **no se
escribe**. En su lugar va la lista de lo que hay que conseguir. Los bloques 1 a 6 sí se entregan:
sirven para la llamada.

Los demás faltantes degradan la ficha pero no la bloquean.

---

## Fase 3 — Elegir el sub-segmento por puerta de entrada

No por vibra. **El precio desde y el esquema de separación filtran el segmento antes de que la
narrativa lo elija.** Un proyecto de $600M no le habla al segmento "sin cuota inicial", por bonito
que suene el ángulo.

Sub-segmentos vivos de Viventa:
- **USA** — Miami-Dade, Broward, Tampa Bay, NJ
- **España** — Madrid, Valencia, Alicante · **Reino Unido**
- **Puerto Rico** — elegible y fuera del radar de eventos
- **Vivienda usada / segunda compra** — el pitch estándar asume obra nueva
- **Sin cuota inicial ahorrada** — munición vigente: programa **"Mi Casa en Colombia"** (aprobado
  17-jun-2026, FNA hasta 100% sin cuota inicial). **Enunciable como programa existente, jamás como
  aprobación.**

Escribe: **sub-segmento primario**, **secundario** y **"no aplica bien a:"**. El "no aplica" es
obligatorio — es lo que evita que la pieza se pautee a quien va a rebotar.

---

## Fase 4 — De atributo a ángulo

El error del LLM promedio es *feature → adjetivo* ("62 m² → acogedor"). Acá el comprador **no puede
visitar**: su decisión no se juega en si le gusta, sino en si **cree**. En esta categoría **el miedo
pesa más que el dolor**. Los tres miedos nombrados: **ser estafado · perder la plata · comprar un
inmueble que no es**.

### Paso 1 — Clasificar cada atributo duro en un rol

| Rol | Qué hace | Ejemplos |
|---|---|---|
| **Reduce miedo** | Hace el proyecto verificable a distancia | Dirección exacta, estrato, constructora con nombre, área privada |
| **Habilita el deseo** | Describe la vida que va a tener | m², alcobas, zonas comunes, ciudad |
| **Define la puerta de entrada** | Determina si puede o no | Precio desde, separación, entrega, VIS/No VIS |

### Paso 2 — Escribir cada ángulo en la cadena de 4 eslabones

> **Atributo (🟦):** entrega marzo 2027
> **Qué hace:** fija una fecha con nombre propio
> **Qué significa para él:** *"en el viaje de diciembre de 2027 llegas a tu casa, no a la de tu hermana"*
> **Prueba:** constructora con nombre + oficinas de Viventa en 3 países + 20 años

### Paso 3 — Repartir SIEMPRE así: uno de miedo, uno de deseo, uno de puerta de entrada

Nunca tres de deseo. Los ~8 brokers autorizados por Bancolombia usan todos el mismo ángulo emocional
de "raíces" — se ve hasta en los nombres de marca. Ese territorio está saturado.

Cada ángulo debe apoyarse en **un dato 🟦 señalable**. Si no puedes nombrar el dato, el ángulo se cae.

Encaje en las 4 P's del equipo: *Pain* = el miedo · *Plan* = separación y crédito · *Proof* = los
datos 🟦 + las oficinas físicas · *Philosophy* = "sin volver y sin quedar solo".

---

## Fase 5 — Aplicar el semáforo legal

Aplícalo a **todo** lo publicable: ángulos, titular, bajada, CTA y respuestas de objeción.

| 🟢 Se puede decir | 🟡 Exige respaldo documentado en la ficha | 🔴 Prohibido |
|---|---|---|
| "La vivienda es un activo que puedes rentar o vender" | Cifras de valorización **históricas** de fuente citable (DANE IVP, Camacol, La Galería Inmobiliaria) — con fuente, año y ciudad **en la pieza** | Cualquier cifra de valorización o rentabilidad **futura** |
| "Colombia tiene déficit de vivienda" **con fuente y año** | Datos de rentabilidad propios de Viventa — solo con metodología, muestra y periodo documentados | "Recuperas la inversión en N años", "se paga solo con el arriendo" |
| "El precio de referencia es $X a fecha Y" | Arriendo promedio de la zona, con fuente y fecha | Proyectar en USD/EUR el retorno por tasa de cambio |
| "Tu ingreso en dólares rinde distinto en pesos" — **como hecho de tasa hoy, sin proyectar** | | "Es una inversión segura", "no puedes perder" |
| "Es un proyecto VIS" / "No es VIS" — **copiado de la fuente** | | **Inferir** si es VIS a partir del precio |

**Fundamento:** en el **caso Cossio** la SIC declaró que una promesa de ganancias sin respaldo es
infracción, con **responsabilidad objetiva** — la trayectoria del anunciante no exonera. Y el
**art. 30 de la Ley 1480** responsabiliza al **anunciante**: cuando Viventa pauta, Viventa es
anunciante. El riesgo no es solo de la constructora.

`[⚠ no verificado]` Ni la Circular 004 ni los precedentes inmobiliarios listados regulan
**expresamente** las promesas de valorización o rentabilidad en vivienda. El puente es analógico, vía
Cossio. Es sólido, pero es un puente — conviene que Viventa lo valide con su abogado antes de fijar
política. No cambia la recomendación operativa, que es conservadora por diseño.

### El ángulo de la bajada del dólar
La versión publicable es **de hecho presente, no de proyección**: cuánto cuesta hoy en pesos y cuál
es la tasa hoy. Prohibida cualquier frase que implique que la tasa se mantendrá o mejorará. Y si la
pieza se pauta a USA, no se combina precio con condiciones de financiación (Regla Z).

### El retracto — contexto que debes tener presente
La SIC ha sostenido que **el derecho de retracto del art. 47 no aplica a la venta de inmuebles sobre
planos**. Doble implicación: **(a)** nunca insinuar "si te arrepientes, te devuelven la plata";
**(b)** como el comprador no residente **no tiene esa red**, su protección real es la **publicidad
recibida**, que por el **art. 29 de la Ley 1480 obliga y entra al contrato**. Esta ficha es un
documento de exposición legal, no un documento de marketing.

---

## Fase 6 — Procesar lo que dijo el comercial (🟧)

Tres capas, tres tratamientos, **cero mezcla**. Nunca un dato 🟦 y una lectura 🟨 en la misma oración.

| Capa | Qué es | Marca | Test de pertenencia | ¿A una pieza? |
|---|---|---|---|---|
| 🟦 **Dato** | Está literal en la fuente | Tabla, sin adjetivos | ¿Puedo señalar la celda? | Sí |
| 🟨 **Interpretación** | Razonamiento de marketing sobre el dato | Prosa, bloque aparte | ¿Se deriva solo de datos 🟦? | Sí, si el dato base está |
| 🟧 **Atribuido** | Lo que dijo una persona | Cita + nombre + fecha + estado | ¿Puedo nombrar a quién lo dijo? | **No, hasta reclasificarse** |

### Ciclo de vida de cada afirmación

```
🟧 Comercial dice algo
   ├─ ¿Es un hecho verificable? (distancia al mar, colegio a 3 cuadras, acabados)
   │    └─ SÍ → se pide la evidencia → si llega, sube a 🟦 Dato con su fuente
   │            si no llega en el ciclo → se queda 🟧 y no se publica
   ├─ ¿Es una lectura de mercado? ("a la gente de Miami le encanta esta zona")
   │    └─ baja a 🟨 Interpretación, reescrita sin cifras, como hipótesis de ángulo
   └─ ¿Es una proyección de ganancia? ("espero una valorización de tanto")
        └─ ⛔ se archiva como contexto interno. NO entra como claim.
           Se traduce en UNA PREGUNTA de soporte documental.
```

**La regla del "espero una valorización de tanto":**
1. **No se borra.** Queda en 🟧 con nombre y fecha.
2. **No se convierte en ángulo**, aunque sea el motivo real por el que el comercial lo vende.
3. **Se traduce en una pregunta:** *"Pendiente: ¿existe soporte documental de valorización para esta
   zona? (fuente, año, ciudad)"*.
4. **Si llega el soporte, cambia el tiempo verbal.** De *"va a valorizar un X%"* a *"según [fuente,
   año], los precios de vivienda nueva en [ciudad] variaron X% entre [periodo]"*. Pasado, con fuente,
   con ciudad. Eso sí es publicable.

**Por qué la capa 🟧 no se colapsa en 🟦:** el art. 29 de la Ley 1480 hace que lo anunciado obligue y
entre al contrato. Si el comercial se equivoca y la ficha lo publica, el error deja de ser una
opinión y pasa a ser **una obligación de Viventa frente al comprador**. La capa 🟧 es el cortafuegos.

---

## Fase 7 — Derivar exactamente 2 objeciones

Una ficha con 6 objeciones no se lee. **Dos, siempre dos.**

### Paso 1 — Leer los disparadores en los datos duros

| Si el dato dice… | Dispara |
|---|---|
| Entrega a más de 12 meses | *"¿Y si no entregan?"* → objeción **nueva, específica del proyecto** |
| Precio desde alto para el segmento | #2 (costo) y #3 (tasa) |
| Ciudad con narrativa de seguridad/política | #5 |
| Constructora poco conocida por el lead | *"¿Quién me responde si algo pasa?"* → se responde con datos 🟦, no con adjetivos |
| Proyecto VIS | Riesgo de omisión (Bolívar): la objeción real es *"nadie me dijo que era VIS"* — se previene diciéndolo |
| Sin dato de separación / cuota inicial | #2 + el segmento "sin cuota inicial" |

Las 6 objeciones canónicas del playbook (`Playbook comercial y objeciones/Manejo de Objeciones.docx`)
están resumidas en `references/objeciones-playbook.md`.

### Paso 2 — Ordenar por probabilidad **para este sub-segmento**
Una objeción de tasa pesa distinto para alguien de Madrid que para alguien de Tampa.

### Paso 3 — Instanciar, no copiar
No se pega el párrafo del playbook: se le mete el dato del proyecto adentro.
> *"La tasa en Colombia es más alta, sí. Pero en Santa Marta un apartamento de 62 m² cuesta $385
> millones — busca eso en Tampa."*

### Paso 4 — FILTRO LEGAL antes de escribir (el paso que casi nadie hace)

**El playbook es fuente de voz y de argumento, pero no fue escrito para publicidad.** Un LLM que lo
lea sin este gate copia argumentos de conversación privada a una pieza pautada. Ahí es exactamente
donde muerde Cossio.

Caso concreto: la objeción #3 apela a *"la valorización en Colombia es alta"*. Eso vive en una
llamada 1-a-1; en una pieza pautada sin fuente citada, no.

**Marca cada respuesta con una de dos etiquetas:**
- `✅ apta para pieza`
- `⚠ apta para llamada, no para pieza sin fuente` — cuando toca valorización, rentabilidad, tasa,
  cuota, plazo o aprobación de crédito.

---

## Fase 8 — Escribir la ficha

### Formato exacto — plantilla

```markdown
**FICHA DE PROYECTO — {Nombre}**
`Fuente: {sistema} – archivo "{nombre_archivo}" · Corte: {fecha} · Generada: {fecha de hoy}`

{si aplica: ⛔ FICHA BLOQUEADA — falta {campo}. No alimenta pieza publicitaria. Sin textos listos.}

**🟦 DATOS (copiados de la fuente)**

| | |
|---|---|
| Constructora | {literal} |
| Ubicación | {dirección exacta}, {ciudad}, {departamento} |
| Área privada construida | {literal} |
| Precio desde | {literal} COP (corte {fecha}) |
| Entrega estimada | {literal} — *fecha estimada, sujeta a cambio por fuerza mayor, hecho de un tercero o causas ajenas al constructor* |
| Estrato | {literal} |
| Administración aprox. | {literal} |
| Parqueaderos | {literal} |
| ¿VIS? | Sí / No / No informado |

**🟦 FALTA EN LA FUENTE — pedir antes de publicar**

| Falta | A quién | Qué se pide exactamente |
|---|---|---|
| {campo} | {persona/área} | "{el mensaje literal para mandar}" |

*{Una línea sobre la consecuencia del faltante más grave.}*

**🟨 A QUIÉN LE SIRVE (interpretación de marketing)**

Sub-segmento primario: **{segmento}**, {por qué, anclado en precio/separación/entrega}.
Sub-segmento secundario: **{segmento}**.

*No aplica bien a:* {quién y por qué}.

**🟨 3 ÁNGULOS**

1. **{Miedo}.** {Datos 🟦 que lo sostienen}. {Frase lista, entre comillas}.
2. **{Deseo}.** {Datos 🟦}. {Frase lista}.
3. **{Puerta de entrada}.** {Datos 🟦}. {Frase lista}.

**🟧 LO QUE DICE EL COMERCIAL** *(afirmación atribuida — no verificada, no publicable como hecho)*

> *"{verbatim literal}"*
> — Comercial {nombre}, sesión del {fecha}.

**Estado:** {✅ verificado y subido a 🟦 / ⏳ pendiente de evidencia / ⛔ no publicable}
- {qué tipo de afirmación es y qué se hace con ella}
- {la evidencia concreta que hay que pedir}

**🟨 2 OBJECIONES PROBABLES**

1. *"{objeción}"* ({qué dato la dispara}) → {respuesta instanciada}. `{✅ apta para pieza | ⚠ apta para llamada}`
2. *"{objeción}"* ({disparador}) → {respuesta instanciada}. `{etiqueta}`

**🟨 TEXTOS LISTOS** {omitir por completo si la ficha está bloqueada}

- **Titular:** {≤12 palabras, con un dato duro adentro}
- **Bajada:** {2 líneas: área privada, estrato, entrega estimada, dirección}
- **CTA:** {acción concreta, sin prometer aprobación}

**BLOQUE LEGAL OBLIGATORIO EN LA PIEZA**
*Precio de referencia a {fecha}, sujeto a cambio. Área privada construida. Fecha de entrega estimada,
sujeta a modificación. Proyecto de {Constructora}. Viventa no otorga crédito ni garantiza su
aprobación.*
```

### Techo de densidad
**~450 palabras de contenido** más la tabla de datos. Debe caber en una pantalla de Google Docs o en
un pantallazo de Slack. Si no se lee de un vistazo durante una llamada, no se usa.

**Techos duros:** 3 ángulos · 2 objeciones · 1 titular · 1 bajada · 1 CTA. Ni uno más.

---

## Ejemplo real recortado

> ⚠️ **ILUSTRATIVO — DATOS INVENTADOS.** No es un proyecto real de Vivehome. Existe para mostrar la
> forma. Ningún dato de aquí puede reusarse. Si aparece en una pieza, es un error.

**FICHA DE PROYECTO — Bahía Serena**
`Fuente: Vivehome – export "inventario_costa_2026-08-01.xlsx" · Corte: 01-ago-2026 · Generada: 06-ago-2026`

**🟦 DATOS**

| | |
|---|---|
| Constructora | Constructora Ejemplo S.A. |
| Ubicación | Cra. 1 # 12-45, Santa Marta, Magdalena |
| Área privada construida | 62 m² – 88 m² |
| Precio desde | $ 385.000.000 COP (corte 01-ago-2026) |
| Entrega estimada | Marzo 2027 — *fecha estimada, sujeta a cambio por fuerza mayor, hecho de un tercero o causas ajenas al constructor* |
| Estrato | 4 |
| Administración aprox. | $ 320.000 COP/mes |
| Parqueaderos | 1 cubierto por unidad, incluido |
| ¿VIS? | No |

**🟦 FALTA EN LA FUENTE**

| Falta | A quién | Qué se pide exactamente |
|---|---|---|
| Esquema de separación y cuota inicial | Comercial a cargo | "Monto de separación, % de cuota inicial y en cuántos meses se difiere" |
| Zonas comunes por etapa | Constructora Ejemplo (vía Comercial) | "¿Qué zonas comunes entran en la etapa 1 y cuáles en las siguientes?" |

*Sin el esquema de separación no se publica pieza de conversión: es el dato #1 que pregunta el lead.*

**🟨 A QUIÉN LE SIRVE**

Sub-segmento primario: **colombiano en Tampa Bay o Miami-Dade con familia en la costa**, que compra
pensando en tener a dónde llegar y en rentar mientras tanto. 62 m² es tamaño de dos alcobas: no
compite con la casa familiar, compite con seguir pagando renta allá y no tener nada acá.
Secundario: **segunda compra**, alguien que ya hizo el proceso con Viventa.

*No aplica bien a:* quien busca vivienda para vivirla ya (entrega 2027) ni a quien pregunta por VIS.

**🟨 3 ÁNGULOS**

1. **Miedo a comprar un inmueble que no es.** Dirección exacta, área privada y estrato en la pieza.
   *"Cra. 1 # 12-45, Santa Marta. 62 m² privados. Estrato 4. Puedes verificarlo antes de separar."*
2. **Deseo de tener a dónde llegar.** Entrega marzo 2027 = llaves en el viaje de fin de año de 2027.
   *"En diciembre de 2027 llegas a tu casa, no a la de tu hermana."*
3. **Puerta de entrada.** Precio desde $385 millones + acompañamiento. *"Te decimos qué necesitas
   para aplicar, desde donde estás."*

**🟧 LO QUE DICE EL COMERCIAL** *(atribuido — no publicable como hecho)*

> *"Está en primera línea de playa y espero una valorización de tanto."*
> — Comercial [nombre], sesión del [fecha].

**Estado: ⛔ no publicable.** Dos problemas separados:
- *"Primera línea de playa"* es un **hecho verificable pendiente de verificar**. Si el mapa lo
  confirma, sube a 🟦 con su fuente; si no, se cae. → pedir distancia real al mar y si el acceso a
  playa es público o del proyecto.
- *"Espero una valorización de tanto"* es una **proyección de ganancia**. No entra como claim ni con
  respaldo blando. Se archiva como contexto interno. → *Pendiente: ¿existe soporte documental de
  valorización para Santa Marta? (fuente, año, ciudad)*.

**🟨 2 OBJECIONES**

1. *"¿Y si la constructora no entrega en 2027?"* (la dispara la entrega a 19 meses) → Constructora
   Ejemplo S.A. con nombre propio, la fecha va con su advertencia legal y Viventa acompaña el
   proceso desde sus oficinas en 3 países. `✅ apta para pieza`
2. *"La tasa en Colombia está muy alta."* (playbook #3) → No la niegues: son economías distintas y
   en USA el down payment y el acceso al crédito son más duros.
   `⚠ apta para llamada, no para pieza sin fuente` — el playbook resuelve esta objeción apelando a
   valorización.

**🟨 TEXTOS LISTOS**

- **Titular:** Tu apartamento en Santa Marta, desde $385 millones.
- **Bajada:** 62 m² privados, estrato 4, entrega estimada en marzo de 2027. Cra. 1 # 12-45.
  Te acompañamos desde donde estás.
- **CTA:** Escríbenos y te decimos qué necesitas para aplicar al crédito.

**BLOQUE LEGAL OBLIGATORIO EN LA PIEZA**
*Precio de referencia a 01-ago-2026, sujeto a cambio. Área privada construida. Fecha de entrega
estimada, sujeta a modificación. Proyecto de Constructora Ejemplo S.A. Viventa no otorga crédito ni
garantiza su aprobación.*

---

## Checklist de autovalidación — las 12

Córrelo antes de entregar. **Cualquier fallo de 1 a 5 rechaza la ficha de plano: corrige y vuelve a
correr el checklist.**

**Bloqueantes**
- [ ] 1. **Trazabilidad.** Nombre del archivo fuente y fecha de corte en el encabezado.
- [ ] 2. **Cero invención.** Toma 3 datos 🟦 al azar y encuéntralos en la fuente pegada. Si uno no
      está, sale.
- [ ] 3. **Campos vacíos declarados.** Ningún campo lleva un valor que no esté en la fuente. Los
      faltantes traen las 3 columnas.
- [ ] 4. **Circular 004 cubierta.** Área privada construida, precio de referencia, ubicación exacta y
      VIS/No VIS están — o la ficha dice ⛔ BLOQUEADA y **no** trae textos listos.
- [ ] 5. **Semáforo respetado.** Cero proyecciones de valorización, rentabilidad, retorno o
      aprobación de crédito en lo publicable. Cero tasa, cuota mensual y plazo. Cero conversión a
      USD/EUR.

**De calidad**
- [ ] 6. **Capas visibles.** Un lector distingue 🟦 / 🟨 / 🟧 sin leer la leyenda. Ninguna oración
      mezcla dato e interpretación.
- [ ] 7. **Lo del comercial está y está atribuido**, con nombre, fecha y estado. Nada se descartó en
      silencio.
- [ ] 8. **Sub-segmento nombrado y justificado por puerta de entrada** (precio/separación/entrega),
      no por vibra. Incluye el "no aplica a".
- [ ] 9. **3 ángulos, uno de cada tipo:** miedo, deseo, puerta de entrada. Cada uno con su dato 🟦
      señalable.
- [ ] 10. **2 objeciones derivadas de los datos de este proyecto**, no del catálogo, instanciadas y
      con etiqueta de filtro legal.
- [ ] 11. **Voz.** Español de Colombia, tuteo, frases cortas, cero adjetivos de la lista negra, cero
      jerga financiera sin traducir.
- [ ] 12. **Densidad.** Cabe en una pantalla. ~450 palabras más la tabla.

**Prueba de fuego, una sola:** dásela a un comercial que no conoce el proyecto y a Manuela. Si el
comercial la usa en una llamada sin abrir el Excel, y Manuela produce una pieza sin escribirle a
nadie de ventas, cumpliste. Si alguno tiene que preguntar algo, ese es un faltante que la ficha
debió marcar.

---

## Anti-patterns — lo que vas a hacer mal si no te frenas

| # | Falla | Antídoto |
|---|---|---|
| 1 | Rellenar el campo vacío con un valor plausible | Faltante en 3 columnas. Los 4 bloqueantes detienen los textos |
| 2 | Redondear el precio ("$385.400.000" → "$385 millones") | Se copia carácter por carácter. Redondeo solo en el titular y **hacia abajo** |
| 3 | Precisar la granularidad de la fecha ("2027" → "diciembre 2027") | Se copia la granularidad de la fuente |
| 4 | Convertir el dicho del comercial en hecho | Capa 🟧 con nombre, fecha y estado |
| 5 | Prometer valorización | Semáforo. Futuro → 🔴. Pasado + fuente + ciudad → 🟢 |
| 6 | Adjetivos de folleto | Lista negra. Cada frase de ángulo se apoya en un dato 🟦 nombrable |
| 7 | Inferir estrato o VIS del precio | Prohibido. VIS solo Sí / No / No informado |
| 8 | Mezclar capas en el mismo párrafo | Bloques físicamente separados |
| 9 | Convertir COP a USD/EUR | Prohibido: la tasa cambia y la pieza queda expuesta |
| 10 | Meter tasa, cuota mensual o plazo | Regla Z. Solo precio desde y separación |
| 11 | Copiar el argumento del playbook tal cual | Filtro legal de la Fase 7 paso 4 |
| 12 | Buscar en internet lo que falta | Solo la fuente pegada. Lo demás es faltante |
| 13 | Devolver 6 objeciones y 8 ángulos | Techo duro: 3 y 2 |
| 14 | Omitir fecha de corte y archivo fuente | Encabezado de trazabilidad obligatorio |
| 15 | Leer el render o la foto como dato | Precedente Vavilco: la alusión gráfica también sanciona |

---

## Fronteras con otros skills

- **`viventa-match-proyecto-lead`** consume esta ficha; es 1-a-1 y personalizado. Esta ficha es
  1-a-muchos y **no conoce leads ni PII**.
- **`viventa-qa-marca`** valida piezas ya producidas. Este skill valida el **insumo** de la pieza. El
  bloque legal obligatorio es el punto de handoff.
- **Agente "Bibliotecario"** del POC (`02-Clientes/Viventa/HANDOFF.md`) es la versión de
  operaciones/inventario. Esta es la de marketing. Escopar contra él, no duplicarlo.
- **Chain `viventa-lead-caliente`:** `viventa-ficha-proyecto` → `viventa-match-proyecto-lead` →
  `viventa-reactivacion-lead`.

## References

- `references/semaforo-legal.md` — precedentes SIC, Circular 004, artículos de la Ley 1480 y el
  semáforo completo con los casos límite.
- `references/objeciones-playbook.md` — las 6 objeciones canónicas, su eje de respuesta y el
  filtro apta-para-pieza / apta-para-llamada de cada una.
