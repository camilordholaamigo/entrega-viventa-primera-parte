---
name: viventa-match-proyecto-lead
description: >-
  Cruza los atributos de un lead de Viventa (formulario CC y resumen de Aircall, pegados) contra
  el inventario de Vivehome y entrega 2-3 proyectos ordenados por propósito de inversión, con el
  preaprobado como techo, más 3 correos que el asesor aprueba antes de enviar. USA cuando: "armá
  el match de este lead", "qué proyecto le sirve a este lead", "hazme los correos para este
  lead", "cruzá lo que dijo el lead contra el inventario", "a este lead qué le recomendamos". Es
  para un lead activo: viventa-reactivacion-lead reabre uno que se cayó y viventa-ficha-proyecto
  describe un proyecto sin lead.
metadata:
  version: "1.1.0"
  domain: "convert"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-match-proyecto-lead

Del formulario y la llamada de un lead a un documento de cuatro bloques —lectura del lead, ficha
de match, 3 correos, notas para el asesor— que un humano aprueba antes de enviar. Invariantes en
toda corrida: cada dato de proyecto se copia del inventario pegado o se marca como faltante; el
preaprobado es techo, no objetivo; los correos no llevan cifras de crédito ni revelan que se
analizó la llamada; sin las cuatro variables críticas no hay match, hay preguntas. El skill no
entra a Zoho, Aircall, Vivehome ni a la web: trabaja solo con lo pegado, en una pasada.

## Cuándo usar

- Explícito: "armá el match de este lead", "qué proyecto le sirve a este lead", "hazme los
  correos para este lead", "cruzá lo que dijo el lead contra el inventario", "a este lead qué le
  recomendamos".
- Implícito: entró un registro con formulario CC diligenciado (y quizá una primera llamada) y el
  asesor tiene que mandar la primera propuesta concreta.
- Cadencia: por lead, el mismo día que entra o que se hace la primera llamada.

## Cuándo NO usar

- **El lead ya se había caído del proceso** (formulario a medias, DM sin responder, no volvió
  después de hablar con el asesor) → `viventa-reactivacion-lead`.
- **Querés la ficha de un proyecto, sin un lead concreto** → `viventa-ficha-proyecto`.
- **Una secuencia masiva para una lista o un segmento** → `email-sequence`.

## Input del usuario

No usa conexiones: todo entra pegado como texto por el asesor.

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Nombre de pila | Formulario CC o el asesor | *"¿Cómo se llama el lead? Solo el nombre de pila."* |
| Residencia y vínculo colombiano (crítico) | Formulario CC | *"¿En qué país vive, y es colombiano o tiene cónyuge, padres o hijos colombianos?"* |
| Ciudad o zona de interés en Colombia (crítico) | Formulario CC | *"¿En qué ciudad de Colombia quiere comprar?"* — si el propósito es patrimonio familiar: *"¿Quién la va a habitar y en qué ciudad?"* |
| Propósito de la inversión (crítico) | Formulario CC o la llamada | *"¿La quiere para vivir, para rentar, para que la habite su familia, o una mezcla?"* — nunca se asume "inversión" |
| Techo: preaprobado o valor máximo de vivienda declarado (crítico) | Formulario CC | *"¿Tiene un preaprobado del banco? Si no, ¿hasta qué valor de vivienda está pensando?"* — un ingreso solo no sirve de techo (Paso 1) |
| Inventario de Vivehome de esa ciudad | El asesor pega las filas: proyecto, constructora, ciudad, precio desde, área y alcobas, entrega, esquema de separación | *"Pegame las filas de Vivehome de {ciudad}."* — sin inventario no hay match |
| Quién firma y disponibilidad | El asesor | *"¿Quién firma los correos, qué dos días le ofrezco para la llamada y qué dos horarios para la videollamada?"* |
| Testimonio de cliente | Solo de un caso en 🟢 (consentimiento escrito) producido por `viventa-caso-exito` | *"¿Hay un caso de éxito aprobado (🟢) que sirva para este lead?"* — sin él, el correo 2 va solo con la prueba concreta y se anota en D. Un verbatim del banco de voz o del VOC sin consentimiento no se usa |
| Horizonte (cuándo vuelve o cuándo quiere renta) | Formulario o llamada | No se pregunta: sin él no se filtra por entrega y se anota en D |
| Cuota inicial disponible | Formulario CC | No se pregunta: se corre el match y se marca como riesgo en D |
| Resumen de Aircall | El asesor | No se pregunta: secuencia neutra, anotada en D |
| Pareja o co-solicitante; primera o segunda vivienda | Formulario o llamada | No se pregunta: el correo 3 habla de "quien decide contigo", sin asumir pareja |

## Workflow

### Paso 1 — Gate de suficiencia (antes de tocar el inventario)

1. Revisá las cuatro variables críticas: ciudad/zona, propósito, techo, elegibilidad.
2. **Techo.** Preaprobado → ese monto. Valor máximo declarado o rango → el extremo superior. Solo
   ingreso → no es techo (convertirlo en monto sería calcular crédito): cuenta como faltante.
3. **Elegibilidad (gate binario).** Pasa si es colombiano, o extranjero casado con colombiano, o
   con primer grado de consanguinidad, **y** reside en: EE. UU., Canadá, Puerto Rico, Panamá,
   Costa Rica, El Salvador, México, Chile, Perú, Reino Unido, España, Italia, Francia, Alemania,
   Suiza, Holanda, Bélgica, Australia, Nueva Zelanda o Emiratos Árabes. Si no pasa, decilo en
   una línea con el motivo y pará: no hay match.
4. Si falta cualquiera de las cuatro, el output es **solo** este bloque:

   ```
   No puedo armar un match honesto todavía. Falta:
   · {variable} — {por qué no está / dónde debería estar}
     → Se resuelve con una pregunta: "{pregunta literal de la tabla de Input}"
   Con eso vuelvo a correr el match.
   ```

   Nada de "tres de los más vendidos" para no entregar vacío: parece trabajo hecho y no lo es.
5. Si faltan el nombre de pila, el inventario o la firma y disponibilidad, pedilos con la
   pregunta de la tabla antes de seguir.

### Paso 2 — Filtrar el inventario

1. **Geografía.** Quedan los proyectos de la ciudad/zona pedida (patrimonio familiar: la de quien
   la va a habitar). Si ninguno está ahí, podés proponer otra ciudad solo declarándolo en A y en
   la ficha ("no hay proyectos en {ciudad}; esta es {otra}"), nunca en silencio.
2. **Techo.** Calculá `% del techo = precio desde / techo × 100`. Más de 100% no entra, ni
   "estirándose un poquito".
3. **Horizonte**, si lo hay: descartá lo que entrega después de cuando lo necesita (vivir: año de
   retorno; rentar: cuando quiere empezar a recibir renta). Sin horizonte, no filtres y anotalo en D.
4. **Cuota inicial**, si la hay y el inventario trae esquema de separación: si el esquema pide
   más de lo que declaró, el proyecto sigue pero su ficha lo dice como riesgo.
5. Si quedan **0** proyectos: no hay ficha ni correos. Entregá un bloque "Sin match en el
   inventario" con qué filtro dejó afuera a cada proyecto y la pregunta que lo destrabaría
   (ampliar zona, revisar techo con Crédito). Si queda **1**: seguí, con la justificación "fue el
   único que pasó los filtros" en la ficha.

### Paso 3 — Ordenar por propósito y elegir el mejor calce

1. Ordená por el atributo que maximiza el propósito (tabla completa en
   `references/proposito-inversion.md` §1): **vivir** → área, alcobas, barrio, entrega alineada al
   retorno · **rentar** → entrega pronta, unidad pequeña de alta rotación · **patrimonio
   familiar** → cercanía a quien la habita, accesibilidad si es persona mayor · **mixto** → el
   propósito de corto plazo, y se nombra la tensión con el de largo plazo. El precio no ordena.
2. Ubicá cada proyecto en su banda (heurística propia, no verificada — ver Reglas duras):

   | % del techo | Rol |
   |---|---|
   | 70 a 85 (incluidos) | Mejor calce por defecto |
   | más de 85 hasta 95 | Mejor calce solo si aporta un atributo que la banda baja no da; justificación escrita |
   | más de 95 hasta 100 | Se muestra para ver la banda completa, **nunca** como mejor calce; se dice por qué no |
   | menos de 70 | Legítimo si el propósito es rentar (el excedente es rentabilidad); con otro propósito, mejor calce solo con justificación por atributo |

3. El mejor calce por defecto es el primero por propósito dentro de 70-85 (si el propósito es
   rentar, <70 cuenta igual que 70-85). Uno de 85-95 le gana solo si ofrece un atributo del
   propósito que ninguno de la banda baja da (p. ej. el único que entrega a tiempo para rentar),
   y la ficha lo escribe. Sin ninguno en 70-85, el primero de 85-95 o de <70, con esa misma
   justificación. Si todos los que quedan están en 95-100, no hay mejor calce: tratalo como 0
   proyectos del Paso 2.5.
4. Elegí 2 o 3, comparables entre sí (misma ciudad, rango parecido). Nunca 4 o más.

### Paso 4 — Leer la señal de Aircall

La señal cambia el **ángulo** de los correos, nunca el **proyecto**. Aplicá la tabla de
`references/aircall-senal-angulo.md`: desconfianza → el correo 2 va primero con prueba concreta;
pregunta repetida → se responde por escrito, en el asunto si hace falta; comparó tasas con EE. UU.
→ correo 3 con la objeción #3; mencionó a la pareja → correo 3 con los dos; preguntó si debía
viajar → una línea en el correo 2 (se firma con poder); sin ahorro para la inicial → solo en D,
para validar "Mi Casa en Colombia" con Crédito; urgencia → espaciado 1-2-4 días. Sin resumen, o
ambiguo, contradictorio o muy corto: ignorá la señal y anotalo en D.

### Paso 5 — Redactar la ficha de match (bloque B)

Por proyecto: los campos copiados del inventario, "por qué calza" citando un criterio que **el
lead dijo** (no adjetivos), la objeción que va a poner y con qué se responde (prueba del
playbook, nunca "la constructora es seria"). El margen contra el techo se nombra con destino:
*"te deja $21 millones de margen, y ese margen es tuyo"*, nunca *"$21M menos"* ni *"se ajusta a tu
presupuesto"*. El caro se muestra y se explica por qué no. Guion de encuadre en
`references/proposito-inversion.md` §3.

### Paso 6 — Redactar los 3 correos (bloque C)

Orden oferta → confianza → decisión. Mapa de objeciones en `references/objeciones-playbook.md`.

| # | Trabajo (excluyente) | CTA único | Forma |
|---|---|---|---|
| 1 | El proyecto concreto con cifras; nombrar el techo primero (párrafo 3): "el banco te aprobó **hasta**…" | Llamada, con los dos días de la tabla de Input | ≤ ~180 palabras, precio en el asunto o el primer párrafo |
| 2 | Confianza con prueba concreta: 20 años, oficinas físicas en EE. UU., España y Colombia, 5 bancos, ~20 constructoras, garantía de devolución del servicio (objeción #1) + el recorte textual de un caso 🟢 de `viventa-caso-exito`, si lo hay | Mirar la cuota juntos | No repite las cifras del 1 |
| 3 | Decisión compartida + objeción financiera (#3 por defecto; #4 o #5 si la señal marcó miedo migratorio o político, #4 solo si él lo sacó) + salida digna: *"si este no es el momento, dímelo sin pena"* | Videollamada de 15 min con los dos horarios de la tabla de Input: con la pareja o el co-solicitante si el input lo trae; si no, con él y "quien decida contigo" | No repite la prueba social del 2 |

- Español de Colombia, tuteo, cálido; el lead es el héroe y Viventa el guía. Texto plano,
  legible en móvil, firma de quien firma.
- Sin jerga sin traducir (LTV, DTI, amortización), sin "solución integral" ni "aliado
  estratégico", sin emojis de relleno, sin el ángulo de "raíces" (lo usan todos los brokers).
- Prueba de intercambio: si el cuerpo del 1 cambia por el del 3 y el sentido no se rompe, reescribí.
- Espaciado por defecto 0 / 3 / 6-7 días; la secuencia se detiene si responde.

### Paso 7 — Redactar la lectura del lead (A) y las notas del asesor (D)

- **A:** 5-7 líneas en prosa: qué dijo, qué quiere, su techo, su bloqueo real, qué dato falta y
  qué puede tumbar la recomendación. Sin datos personales.
- **D:** qué no se dijo en los correos y por qué (típicamente la cuota mensual) · campos vacíos
  del input y cuál puede mover la recomendación · campos vacíos del inventario · de dónde salió el
  ángulo o "se corrió sin señal" · qué validar con Crédito (cuota, "Mi Casa en Colombia" como
  programa existente, nunca como aprobación) · las dos marcas `[⚠ no verificado]` (cortes de
  banda y Reg Z).

### Paso 8 — Autovalidar y entregar

Pasá el checklist; cualquier ✗ se corrige antes de entregar, no se entrega anotado.

- Cada dato de proyecto está literal en el inventario; los vacíos dicen `no disponible en el
  inventario` y están en D; si la fuente dice "desde", el entregable dice "desde".
- 2-3 proyectos (1 solo con la justificación del Paso 2.5), ninguno sobre 100%, mejor calce según
  el Paso 3.3, orden por propósito.
- Correos: tres trabajos distintos, un CTA cada uno, nada de la lista negra, nada de datos
  personales fuera de lo permitido, ninguna mención de la llamada.

Guardá el documento y cerrá con la frase de Output esperado.

## Reglas duras

- **Nunca escribe un dato de proyecto que no esté en el inventario pegado.** Vacío →
  `no disponible en el inventario`. Nunca *aproximadamente, alrededor de, cerca de, estimado*
  sobre precio, área o fecha.
- **Nunca pone tasa, cuota mensual, plazo, ni monto o porcentaje de cuota inicial en un correo**
  (Regulation Z, 12 CFR 1026.24: con residentes en EE. UU. un disclaimer no lo cura). Precio de
  vivienda sí. Permitido: *"te deja $21 millones de margen, para escrituras o para no quedar
  apretado"*. Prohibido: *"te quedan $21 millones para la cuota inicial"*. `[⚠ no verificado]` la
  aplicabilidad exacta de Reg Z a este caso; validar con legal antes de escalar volumen.
- **Nunca promete aprobación, tasa ni rentabilidad.** Lista negra literal: "ya calificás",
  "seguro te aprueban", "con tu perfil no hay problema", cualquier tasa numérica, "tasa fija
  garantizada", "la mejor tasa del mercado", rentabilidad que el inventario no traiga como campo.
- **Nunca expone datos personales.** Del lead, en los correos, solo nombre de pila, ciudad de
  interés y propósito. Ni teléfono, email, residencia, documento, empleador ni ingreso: *"tu
  hora"* sí, *"hora de Florida"* no. El entregable no sale del equipo comercial (Ley 1581/2012,
  finalidad).
- **Nunca revela que se analizó la llamada.** Permitido: *"preguntaste qué pasa si no sale el
  crédito"*, *"me diste a entender…"*. Prohibido: *"en la llamada del martes"*, *"te quedó una
  pregunta de la llamada"*, *"noté que estabas preocupado"*, parafrasear la transcripción.
- **Nunca inventa un testimonio ni asume una pareja** que el input no trae, y **nunca pega un verbatim sin consentimiento escrito**: solo recortes de casos 🟢 de `viventa-caso-exito`.
- **Nunca recomienda un proyecto sobre el 100% del techo, ni uno de 95-100% como mejor calce, ni
  más de 3.** Los cortes 70/85/95 son heurística propia, no verificada: calibrarlos con Crédito
  contra el histórico de aprobaciones y desistimientos. La marca sobrevive en D.
- **Nunca entrega un match si falla el gate del Paso 1.** Solo el bloque "Qué falta".
- **Nunca envía.** Todo termina en algo que el asesor aprueba.

## Output esperado

Archivo `salidas/viventa-match-proyecto-lead/AAAA-MM-DD-{nombre-de-pila}-{ciudad}.md`,
el mismo contenido en la conversación, para copiar a Google Docs o al CRM. Si corrió el gate
(Paso 1) o no hubo match (Paso 2.5), no se escribe archivo: solo ese bloque en la conversación.

```markdown
## A. Lectura del lead
{5-7 líneas en prosa}

## B. Ficha de match
**★ Mejor calce — {Proyecto}** · {Constructora} · {Ciudad} · {x}% del techo
| Campo | Dato |
|---|---|
| Precio desde | {copiado} |
| Área | {copiado} |
| Entrega estimada | {copiado} |
| Esquema de separación | {copiado o `no disponible en el inventario`} |
| Cuota mensual estimada | **no disponible** — la calcula tu asesor con la tasa vigente al desembolso |
**Por qué calza con lo que dijo:** … **Objeción que va a poner:** *"…"* **Con qué se responde:** …
**Opción 2 — …** / **Opción 3 — …** (misma estructura; si está en 95-100%: **Por qué NO es el mejor calce:** …)

## C. Secuencia de 3 correos
Espaciado: … · Si responde en cualquier punto, la secuencia se detiene y entra el asesor.
**Correo 1 — El proyecto concreto** · *Asunto:* … · {cuerpo sin placeholders, con firma}
**Correo 2 — La confianza** · …
**Correo 3 — La decisión compartida** · …

## D. Para el asesor
{los puntos del Paso 7}
```

Ejemplo completo con datos ficticios: `references/ejemplo-completo.md`.

Al terminar: *"Listo el match de {nombre}: mejor calce {proyecto} ({x}% del techo). Revisá el
bloque D antes de aprobar; los correos no se enviaron."*

## Skills relacionados

- **Antes:** `viventa-ficha-proyecto` si la fila de Vivehome llegó cruda y hay que limpiarla.
- **Después:** `viventa-qa-marca` para revisar los correos antes de que el asesor los mande.
- **En vez de este:** `viventa-reactivacion-lead` si el lead se cayó del proceso;
  `email-sequence` para una secuencia a una lista.
