---
name: viventa-ficha-proyecto
description: >-
  Convierte una fila del inventario de Vivehome (y lo que dijo el comercial) en una
  ficha de 1 página para llamada y para producir pieza sin escribirle a ventas.
  Separa dato, interpretación y afirmación atribuida, y bloquea los textos publicables si falta un
  campo que la Circular 004 de 2024 de la SIC exige. USA cuando: "hazme la ficha del proyecto",
  "necesito la info de este proyecto para una pieza", "arma el battlecard de este proyecto", "qué
  ángulos uso para vender este proyecto". Es 1-a-muchos: viventa-match-proyecto-lead cruza
  proyectos con un lead y viventa-qa-marca revisa la pieza ya hecha.
metadata:
  version: "1.1.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-ficha-proyecto

Produce una ficha de 1 página por proyecto, en una sola pasada y solo con lo que el usuario pegó.
Hace tres cosas que el Excel de inventario no hace: marca lo que falta y a quién pedírselo, traduce
atributos en ángulos, y separa el dato del dicho. Invariantes de toda corrida: los campos duros se
copian carácter por carácter, lo que dijo un comercial queda atribuido y nunca pasa a hecho, sin los
4 campos de la Circular 004 no hay textos publicables, y ninguna frase promete valorización,
rentabilidad ni aprobación de crédito.

## Cuándo usar

- Explícito: "hazme la ficha del proyecto", "necesito la info de este proyecto para una pieza",
  "pásame los datos del proyecto en limpio", "arma el battlecard de este proyecto", "qué ángulos
  uso para vender este proyecto", "ficha de proyecto Viventa", "esto que me pasó ventas está flojo,
  organízamelo".
- Implícito: marketing tiene que producir una pieza de un proyecto y solo tiene una fila del
  inventario o un Excel con precio; o un comercial contó en sesión por qué vende un proyecto.
- Cadencia: por proyecto, y de nuevo cada vez que cambia la fecha de corte del inventario.

## Cuándo NO usar

- Elegir qué 2-3 proyectos le sirven a un lead concreto y escribirle → `viventa-match-proyecto-lead`
  (consume esta ficha; esta ficha no conoce leads).
- Revisar una pieza ya producida contra el manual y la ley → `viventa-qa-marca`.
- El pedido es una campaña o un material sin objetivo definido → `viventa-brief-requerimiento`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Fuente tabular del proyecto (fila o export de Vivehome o del Excel de inventario) | El usuario la pega como texto, tabla o archivo | *"Pégame la fila del proyecto tal como sale de Vivehome (o el export del inventario), y dime el nombre del archivo y la fecha de corte. Sin eso no puedo hacer la ficha: cualquier dato que ponga sería inventado."* Sin fuente, para |
| Nombre del archivo fuente y fecha de corte | El usuario | Se preguntan en una línea. Si no los tiene: `Fuente: no declarada` / `Corte: no declarado` y la ficha queda **no apta para pieza pagada** |
| Verbatims del comercial, con nombre y fecha de la sesión | El usuario | Opcional. Si vienen sin nombre o fecha, se piden una vez; si siguen sin venir: `Comercial [nombre no declarado] — sesión [fecha no declarada]`, capa 🟧 no publicable. Sin verbatims: bloque 🟧 vacío con la línea de pedido del Output |
| Sub-segmento objetivo ya decidido | El usuario | Opcional. Si no viene, se elige en el Paso 3 |

No se busca en internet ni se leen renders o fotos como dato: lo que no está en la fuente pegada es
un faltante.

## Workflow

### Paso 1 — Copiar los 10 campos duros (🟦)

1. Copiá literal, una celda por campo: nombre · constructora · ciudad + dirección exacta (barrio ≠
   dirección) · área privada construida (con rango si lo hay) · precio desde en COP con fecha de
   corte · fecha estimada de entrega (misma granularidad) · estrato · cuota de administración
   aproximada · parqueaderos (cuántos, propios o comunes, si cuestan aparte) · ¿es VIS? (Sí / No /
   No informado).
2. La fecha de entrega va siempre con: *"fecha estimada, sujeta a cambio por fuerza mayor, hecho de
   un tercero o causas ajenas al constructor"*.
3. Estos 10 salen de la Circular Externa 004 de 2024 de la SIC (detalle en
   `references/semaforo-legal.md`): sin ellos, la pieza que salga de la ficha nace incumpliendo.

### Paso 2 — Marcar faltantes y decidir si la ficha se bloquea

1. Todo faltante va en tres columnas: qué falta · a quién (comercial a cargo, constructora vía
   comercial) · el mensaje literal para pedirlo.
2. **Bloquean** los textos publicables: área privada construida · precio de referencia con fecha de
   corte · ubicación exacta · ¿es VIS? (la omisión del VIS le costó a una constructora una sanción de
   la SIC de $1.306 millones: la omisión sanciona igual que la mentira).
3. Si falta cualquiera de los 4: encabezado `⛔ FICHA BLOQUEADA — no alimenta pieza publicitaria` y
   el bloque de Textos listos no se escribe; en su lugar, lo que hay que conseguir. El resto de la
   ficha sí sale: sirve para la llamada. Los otros 6 faltantes degradan pero no bloquean.

### Paso 3 — Elegir el sub-segmento por puerta de entrada

1. El precio desde y el esquema de separación filtran el segmento antes que la narrativa: un
   proyecto de $600 millones no le habla a "sin cuota inicial".
2. Sub-segmentos vivos: USA (Miami-Dade, Broward, Tampa Bay, NJ) · España (Madrid, Valencia,
   Alicante) y Reino Unido · Puerto Rico · vivienda usada / segunda compra · sin cuota inicial
   ahorrada (programa "Mi Casa en Colombia" del FNA, enunciable como programa existente, nunca como
   aprobación).
3. Escribí primario, secundario y **"no aplica bien a:"** (obligatorio).
4. Si falta el precio, el sub-segmento se escribe como hipótesis 🟨 marcada `sin precio: no filtra`.

### Paso 4 — De atributo a ángulo

1. Clasificá cada dato 🟦 en un rol: **reduce miedo** (dirección, estrato, constructora, área:
   verificable a distancia) · **habilita el deseo** (m², alcobas, zonas comunes, ciudad) · **define la
   puerta de entrada** (precio desde, separación, entrega, VIS).
2. Escribí exactamente 3 ángulos, uno por rol, cada uno en 4 eslabones: atributo 🟦 → qué hace → qué
   significa para él → prueba. Nunca tres de deseo: el territorio emocional de "raíces" está
   saturado entre los brokers del sector.
3. Si no podés señalar el dato 🟦 de un ángulo, el ángulo se cae y se dice por qué.

### Paso 5 — Aplicar el semáforo legal

Aplicalo a todo lo publicable (ángulos, titular, bajada, CTA, respuestas de objeción) con la tabla
completa de `references/semaforo-legal.md`:

| 🟢 Se puede decir | 🟡 Exige respaldo en la ficha | 🔴 Prohibido |
|---|---|---|
| "El precio de referencia es $X a fecha Y" | Valorización **histórica** con fuente, año y ciudad en la pieza (DANE, Camacol) | Cualquier valorización o rentabilidad **futura** |
| "Es un proyecto VIS" / "No es VIS", copiado de la fuente | Rentabilidad propia de Viventa con metodología, muestra y periodo | "Se paga solo con el arriendo", "inversión segura" |
| "Tu ingreso en dólares rinde distinto en pesos", como hecho de hoy | Arriendo promedio de la zona con fuente y fecha | Proyectar retorno en USD/EUR por tasa de cambio · inferir VIS del precio |

- Nunca insinuar retracto ("si te arrepientes, te devuelven la plata"): no aplica a vivienda sobre
  planos, y la publicidad recibida obliga y entra al contrato (art. 29, Ley 1480).
- Si la pieza se pauta a USA, nunca se combina precio con condiciones de financiación (Regla Z).

### Paso 6 — Procesar lo que dijo el comercial (🟧)

1. Cada verbatim queda en 🟧 con cita, nombre, fecha y estado. Nada se descarta en silencio.
2. Clasificalo:
   - **Hecho verificable** (distancia al mar, colegio cerca, acabados) → se pide la evidencia; si
     llega, sube a 🟦 con su fuente; si no, queda 🟧 y no se publica.
   - **Lectura de mercado** ("a la gente de Miami le encanta esta zona") → baja a 🟨, sin cifras,
     como hipótesis de ángulo.
   - **Proyección de ganancia** ("espero una valorización de tanto") → ⛔ contexto interno. No es
     ángulo. Se traduce en una pregunta: *"Pendiente: ¿existe soporte documental de valorización
     para esta zona? (fuente, año, ciudad)"*. Si llega el soporte, se reescribe en pasado y con
     fuente.
3. Nunca un dato 🟦 y una lectura 🟨 en la misma oración.

### Paso 7 — Derivar exactamente 2 objeciones

1. Leé los disparadores en los datos: entrega a más de 12 meses → *"¿y si no entregan?"* · precio
   alto para el segmento → costo y tasa · ciudad con narrativa de seguridad → objeción de contexto
   país · constructora poco conocida → *"¿quién me responde?"* · VIS → *"nadie me dijo que era VIS"*
   · sin dato de separación → costo y "sin cuota inicial".
2. Ordená por probabilidad para el sub-segmento primario y quedate con las 2 primeras.
3. Instanciá la respuesta con un dato del proyecto; no pegues el párrafo del playbook
   (`references/objeciones-playbook.md`).
4. Etiquetá cada respuesta: `✅ apta para pieza` o `⚠ apta para llamada, no para pieza sin fuente`
   (cuando toca valorización, rentabilidad, tasa, cuota, plazo o aprobación).

### Paso 8 — Escribir y chequear

1. Llená la plantilla del Output esperado. Techos: ~450 palabras más la tabla · 3 ángulos · 2
   objeciones · 1 titular · 1 bajada · 1 CTA.
2. Chequeá, y si falla uno de los 5 primeros, corregí antes de entregar: (1) archivo y corte en el
   encabezado · (2) 3 datos 🟦 al azar están en la fuente · (3) ningún campo con valor que no esté en
   la fuente · (4) los 4 campos de la Circular están o la ficha dice BLOQUEADA sin textos · (5) cero
   futuro, tasa, cuota, plazo o conversión de moneda en lo publicable · (6) capas separadas · (7)
   todo lo del comercial atribuido · (8) sub-segmento con "no aplica a" · (9) un ángulo por rol con
   su dato · (10) 2 objeciones etiquetadas · (11) sin adjetivos de la lista negra · (12) cabe en una
   pantalla.

## Reglas duras

- **Nunca estima, promedia, redondea ni completa un campo duro.** Vacío en la fuente = vacío en la
  ficha. Única excepción: el titular puede redondear el precio hacia abajo ($385.400.000 → "desde
  $385 millones"); la tabla, nunca.
- **Nunca infiere** estrato del precio, precio del área, ni VIS del precio. VIS solo Sí / No / No
  informado.
- **Nunca cambia la granularidad de la fecha** ("2027" no pasa a "diciembre 2027").
- **Nunca convierte COP a USD o EUR.**
- **Nunca promete valorización, rentabilidad, retorno ni aprobación de crédito**, ni menciona tasa,
  cuota mensual o plazo. Solo precio desde y valor de separación.
- **Nunca usa un render o una foto como fuente de dato**: la SIC sancionó también la alusión gráfica.
- **Nunca busca en internet.**
- **Nunca publica como hecho algo que dijo un comercial**: queda en 🟧 con nombre, fecha y estado.
- **Nunca escribe Textos listos en una ficha bloqueada.**
- **Nunca usa** *exclusivo, único, de ensueño, oportunidad irrepetible, aliado estratégico, solución
  integral, inversión segura*, ni jerga financiera sin traducir (LTV, DTI, amortización).

## Output esperado

No escribe archivos. Devuelve la ficha en la conversación, en markdown pegable en Google Docs o en
un mensaje:

```markdown
**FICHA DE PROYECTO — {Nombre}**
`Fuente: {sistema} – archivo "{nombre_archivo}" · Corte: {fecha} · Generada: {hoy}`
{si aplica: ⛔ FICHA BLOQUEADA — falta {campo}. No alimenta pieza publicitaria. Sin textos listos.}

**🟦 DATOS (copiados de la fuente)**
| Constructora | Ubicación | Área privada construida | Precio desde (COP, corte) | Entrega estimada + advertencia | Estrato | Administración aprox. | Parqueaderos | ¿VIS? |

**🟦 FALTA EN LA FUENTE — pedir antes de publicar**
| Falta | A quién | Qué se pide exactamente |
*{consecuencia del faltante más grave}*

**🟨 A QUIÉN LE SIRVE** — primario · secundario · *No aplica bien a:* {…}
**🟨 3 ÁNGULOS** — 1. Miedo · 2. Deseo · 3. Puerta de entrada (cada uno: datos 🟦 + frase lista)
**🟧 LO QUE DICE EL COMERCIAL** *(atribuido — no publicable como hecho)*
> *"{verbatim}"* — Comercial {nombre}, sesión del {fecha}. Estado: {✅ subido a 🟦 | ⏳ pendiente | ⛔ no publicable}
{sin verbatims: Sin verbatims del comercial. Pedir a {comercial a cargo}: "¿por qué vendes este proyecto y qué le dices al cliente?"}
**🟨 2 OBJECIONES PROBABLES** — objeción (disparador) → respuesta instanciada · `{etiqueta}`
**🟨 TEXTOS LISTOS** {omitido si está bloqueada} — Titular (≤ 12 palabras, con un dato duro) · Bajada (2 líneas) · CTA (sin prometer aprobación)

**BLOQUE LEGAL OBLIGATORIO EN LA PIEZA**
*Precio de referencia a {fecha}, sujeto a cambio. Área privada construida. Fecha de entrega estimada,
sujeta a modificación. Proyecto de {Constructora}. Viventa no otorga crédito ni garantiza su aprobación.*
```

Ejemplo recortado (**ilustrativo, datos inventados**; no reusar en ninguna pieza): "Bahía Serena",
Constructora Ejemplo S.A., Cra. 1 # 12-45, Santa Marta · 62-88 m² · desde $385.000.000 COP (corte
01-ago-2026) · entrega marzo 2027 · estrato 4 · No VIS.

- Ángulo de deseo: 62 m² privados en Santa Marta (datos 🟦) → la vida que va a tener → *"62 m²
  tuyos en Santa Marta, para cuando vuelvas."*
- Ángulo de puerta de entrada: entrega estimada marzo 2027 → fecha con nombre propio → *"En marzo de
  2027 recibes tu casa (fecha estimada, sujeta a cambio)."*
- 🟧 *"Está en primera línea de playa y espero una valorización de tanto."* → ⛔ no publicable: "primera
  línea" es hecho por verificar (pedir distancia real al mar); "valorización" es proyección (pregunta
  de soporte documental).
- Objeción 2: *"La tasa en Colombia está muy alta"* → `⚠ apta para llamada, no para pieza sin
  fuente`: el playbook la resuelve apelando a valorización.
- Titular: *"Tu apartamento en Santa Marta, desde $385 millones."*

Al terminar se le dice al usuario: *"Ficha lista{, BLOQUEADA por {campo}}. {n} datos por pedir antes
de publicar; el bloque legal va en toda pieza."* La prueba: un comercial la usa en llamada sin abrir
el Excel y diseño produce la pieza sin escribirle a ventas.

## Skills relacionados

- **Después:** `viventa-match-proyecto-lead` cruza esta ficha con un lead y redacta los correos;
  `viventa-qa-marca` valida la pieza producida (el bloque legal es el punto de entrega).
- **Antes:** `viventa-brief-requerimiento` si el pedido de pieza llega sin objetivo.
- **Referencias:** `references/semaforo-legal.md` (Circular 004, precedentes SIC, Ley 1480, casos
  límite) · `references/objeciones-playbook.md` (6 objeciones canónicas y su filtro legal).
