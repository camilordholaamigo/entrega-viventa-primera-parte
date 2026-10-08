---
name: viventa-match-proyecto-lead
description: >-
  Convierte los atributos de un lead (formulario CC + resumen de llamada, pegados a mano) en
  un match honesto de 2-3 proyectos del inventario de Vivehome y una secuencia de 3 correos
  lista para que el asesor apruebe y envíe. Ordena por propósito de inversión, no por precio,
  y aplica la regla del preaprobado como techo. Es la prioridad #1 de Growth: el CAC de email
  es $50 contra [cifra interna] de Meta.
metadata:
  version: "1.0.0"
  domain: "convert"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-match-proyecto-lead

Le entregás los atributos del lead y el inventario pegados como texto. El skill devuelve **un
solo documento markdown** con cuatro bloques: lectura del lead · ficha de match (2-3 proyectos) ·
secuencia de 3 correos · notas para el asesor. Se copia a Google Docs o al CRM.

**Lo que este skill NO hace, nunca:**
- **No accede a nada.** No entra a Zoho, no consulta Aircall, no abre Vivehome, no busca en web.
  Todo lo que use tiene que estar pegado en el input.
- **No inventa.** Nombre de proyecto, constructora, ciudad, precio, área, entrega y esquema de
  separación se **copian**. Campo vacío ⇒ literalmente `no disponible en el inventario`.
- **No promete crédito.** Ni aprobación, ni tasa, ni cuota mensual, ni rentabilidad.
- **No envía.** Termina en un entregable que un asesor humano aprueba (regla durable #1).
- **No recomienda a ciegas.** Sin las 4 variables críticas, el único output legítimo es el
  bloque "Qué falta para un match honesto".
- **Una sola pasada.** Sin loops, sin research en runtime, sin segunda ronda de autocrítica más
  allá del checklist final (cuentas de IA compartidas, 4 horas sin créditos si se agotan).

---

## Las 5 reglas duras

1. **PII intocable** (regla durable #3 del cliente). En el cuerpo de los correos, del lead solo
   puede aparecer: **nombre de pila · ciudad de interés en Colombia · propósito declarado**.
   Nunca teléfono, email, dirección, documento, empleador ni monto de ingreso. El entregable no
   sale del equipo comercial. Los atributos entran para producir comunicación hacia **ese mismo
   lead** y para nada más (Ley 1581/2012, principio de finalidad).
2. **Cero invención.** Prohibidas las palabras *aproximadamente, alrededor de, cerca de,
   estimado* aplicadas a precio, área o fecha. Si la fuente dice "desde", el entregable dice
   "desde".
3. **Nunca prometer aprobación ni tasa.** El preaprobado es un dato del banco, no una promesa de
   Viventa.
4. **Datos insuficientes ⇒ se dice.** Ver FASE 1.
5. **Una sola pasada.**

---

## FASE 1 · Inputs y gate de suficiencia

### Inputs

| Input | ¿Obligatorio? | Si falta |
|---|---|---|
| Nombre de pila | Sí | Pedirlo. Sin nombre no hay correo. |
| País/ciudad de residencia + vínculo colombiano | Sí (elegibilidad) | Gate de rendición. |
| Ciudad o zona de interés en Colombia | Sí | Gate de rendición. |
| Propósito de la inversión | Sí | Gate de rendición. **No se asume "inversión".** |
| Techo de capacidad (preaprobado, ingreso o rango declarado) | Sí | Gate de rendición. |
| Inventario de Vivehome pegado (proyectos con sus campos) | Sí | Sin inventario no hay match: se pide, no se inventan proyectos. |
| Cuota inicial disponible | No | Se corre el match y se marca como riesgo en el bloque D. |
| Horizonte de retorno | No | Se marca en bloque D. |
| Resumen de Aircall | No | Se corre la secuencia **neutra** y se anota en D que se corrió sin señal. |
| Co-solicitante / primera o segunda vivienda | No | Se marca en D. |

### Gate de rendición (corre ANTES de tocar el inventario)

Si falta **cualquiera** de las cuatro críticas — ciudad/zona · propósito · techo · elegibilidad —
el output es **solo** esto y nada más:

```
No puedo armar un match honesto todavía. Falta:
· {variable} — {por qué no está / dónde debería estar}
  → Se resuelve con una pregunta: "{la pregunta literal que el asesor le hace}"
Con eso vuelvo a correr el match.
```

Producir "tres proyectos de los más vendidos" para no entregar vacío es peor que no entregar:
parece trabajo hecho (anti-pattern A8).

**Elegibilidad (capa 0, gate binario):** colombiano, o extranjero casado con colombiano, o con
primer grado de consanguinidad, residente en: EE.UU., Canadá, Puerto Rico, Panamá, Costa Rica,
El Salvador, México, Chile, Perú, Reino Unido, España, Italia, Francia, Alemania, Suiza,
Holanda, Bélgica, Australia, Nueva Zelanda, Emiratos Árabes. Si no pasa: no hay match, hay una
conversación honesta — se dice y se para.

---

## FASE 2 · Ordenar el match (el orden importa más que las variables)

Aplicá las capas **en este orden**. Ordenar por "qué tan cerca está el precio del techo" es el
peor ordenamiento posible y es el error default de cualquier LLM.

| # | Capa | Tipo |
|---|---|---|
| 0 | Elegibilidad | Gate binario |
| 1 | Geografía declarada | Gate blando — no se sustituye por "una ciudad parecida" sin declararlo |
| 2 | **Propósito de la inversión** | **Ordenador principal** — define qué atributo se maximiza |
| 3 | Horizonte temporal | Filtro fuerte contra fecha de entrega |
| 4 | Banda de precio | Rango, no punto |
| 5 | Cuota mensual | El driver real de decisión — **pero no va en el correo** (FASE 4) |
| 6 | Cuota inicial disponible | Bloqueo silencioso: el campo que más se deja vacío y más tumba operaciones |
| 7 | Sentimiento de Aircall | **No entra al matching.** Solo modula el ángulo (FASE 3) |

**Por qué presupuesto↔precio no decide:** (a) el comprador no compra un precio, compra una
cuota — y este ICP gana en dólares o euros y paga en pesos; (b) el precio no dice nada del
encaje de uso: 44 m² y 68 m² pueden estar en la misma banda y servir a personas distintas;
(c) el precio del inventario es "desde" — la unidad más pequeña, peor piso, sin parqueadero.

**Propósito → qué se maximiza:** tabla completa en `references/proposito-inversion.md`.
Resumen: **vivir** maximiza área/alcobas/barrio y tolera entrega lejana · **rentar** maximiza
entrega pronta y unidad pequeña de alta rotación · **patrimonio familiar** manda hasta la
ciudad (la de quien la va a habitar, no la del lead) · **mixto** (el más común) se ordena por
el propósito de corto plazo y **se nombra la tensión**, no se esconde.

### Regla del preaprobado — la banda

| Banda vs. techo | Rol |
|---|---|
| **70-85%** | **Aquí vive el mejor calce por defecto.** |
| 85-95% | Solo si aporta un atributo que la banda baja no da (área, ubicación pedida). Justificación escrita. |
| 95-100% | Se muestra para que vea la banda completa, **nunca como recomendación**. Se dice por qué no. |
| **>100%** | **No entra.** Ni "estirándose un poquito". |
| <70% | Opción legítima si el propósito es rentar: el excedente no usado es rentabilidad, no sacrificio. |

`[⚠ no verificado]` Los cortes 70-85% / 85-95% son una operacionalización del principio "techo,
no objetivo" (que sí está respaldado). **Deben calibrarse con el área de Crédito de Viventa**
contra su histórico de aprobaciones y desistimientos. Esta marca sobrevive en el bloque D del
entregable.

**Máximo 2-3 proyectos, nunca más, y comparables entre sí** (misma ciudad, mismo rango). Tres
opciones que se comparan convierten; nueve que no, congelan. No es formato: es la tesis.

**El margen se nombra con destino, nunca como resta.** Guion de encuadre completo en
`references/proposito-inversion.md` §Encuadre. Los cuatro movimientos:
1. Nombrá el techo vos primero (correo 1, párrafo 3). Si lo saca él, perdiste el encuadre.
2. Convertí la diferencia en algo con nombre: *"te quedan $21 millones para la cuota inicial"*,
   nunca *"$21M menos"*.
3. Justificá por una **virtud del proyecto** ("entrega antes"), no por una limitación de él
   ("se ajusta a tu presupuesto").
4. Mostrá el caro y explicá por qué no. Esconderlo se lee como ocultamiento.

---

## FASE 3 · Aircall: modular el ángulo, nunca el proyecto

> **El sentimiento cambia el ÁNGULO del correo. Nunca cambia el PROYECTO.**

Los sistemas de análisis de sentimiento reportan 80-95% de precisión — **cifras de los propios
proveedores**. Una señal con ~15% de error no puede mover una decisión de $280 millones. Sí
puede decidir si el correo 2 habla de la garantía o de la tasa.

**Tres prohibiciones absolutas:**
1. **Nunca citar la llamada.** Ni *"como me comentaste el martes"*. Se usa el contenido, no la
   procedencia.
2. **Nunca nombrar la emoción.** *"Sé que te da desconfianza"* es peor que inútil: si el análisis
   se equivocó, le acabás de decir a alguien tranquilo que lo leíste mal.
3. **Nunca reproducir la transcripción.** El resumen entra como input y muere en el entregable.

Tabla señal → ajuste (8 filas): `references/aircall-senal-angulo.md`. Regla de cierre: resumen
ambiguo, contradictorio o muy corto ⇒ **se ignora la señal**, secuencia neutra, y se anota en D.

---

## FASE 4 · Escribir los tres correos

Orden **oferta → confianza → decisión**. No al revés: el lead ya levantó la mano y pidió
información; abrir con confianza se lee como evasiva. Pero cerrar sin resolver trust no cierra,
porque trust es la barrera #1 de este ICP.

| # | Trabajo (excluyente) | Objeción | CTA | Forma |
|---|---|---|---|---|
| 1 | Entregar el proyecto concreto con cifras. Plantar la regla del preaprobado. | Fricción #1 del VOC: *"una publicación tan interesante sin datos concretos"* | Una llamada, con **dos días alternativos** | ≤ ~180 palabras. Precio en asunto o primer párrafo. Texto plano. |
| 2 | Resolver desconfianza con prueba concreta, no adjetivos. Responder la pregunta operativa abierta. | Objeción #1 (por qué pagar el servicio) + trust | Mirar la cuota juntos | Un testimonial real del banco de VOC, **textual, con comillas**. Nunca inventado. |
| 3 | Convertir decisión individual en decisión de pareja. Precargar la objeción financiera. Dar salida digna. | Objeción #6 (*"lo consulto con mi esposa"*) + #3 (tasa Colombia vs USA) | Videollamada 15 min con los dos, **dos horarios concretos** | Incluye salida: *"si este no es el momento, dímelo sin pena"*. |

Mapa completo de las 6 objeciones del playbook: `references/objeciones-playbook.md`.

### Reglas transversales

- **Nombre de pila y nada más.**
- **Un solo CTA por correo.** Nunca "responde, o llama, o agenda, o mira el link".
- **Ninguna cifra de crédito.** Precio de vivienda sí. Tasa, cuota mensual, plazo y cuota
  inicial **no** — ver Compliance abajo.
- **Los tres tienen que ser distintos.** Prueba de falsificación: si intercambiás el cuerpo del
  1 con el del 3 y el sentido no se rompe, están mal escritos.
- **Espaciado por defecto 0 / 3 / 6-7 días.** Se acorta a 1-2-4 solo si la señal marcó urgencia.
- **La secuencia se detiene si responde.** Entra el humano. La fricción #2 del VOC es literal:
  *"siempre hay que colocar correo y luego te saturan 😮‍💨"*.
- **Español de Colombia, tuteo, cálido. El migrante es el héroe, Viventa es el guía.**
- Sin jerga sin traducir (LTV, DTI, amortización). Sin "unlock", "leverage", "solución
  integral", "aliado estratégico". Sin emojis de relleno.
- **Sin ángulo de "raíces".** Los 8 brokers autorizados usan el mismo territorio emocional. La
  diferenciación de Viventa es concreta: 20 años · oficinas físicas en EE.UU., España y Colombia
  · 5 bancos · ~20 constructoras · acompañamiento · garantía de devolución del servicio.

### Compliance — esto define el diseño, no es una nota al pie

Mencionar **tasa, cuota, plazo o cuota inicial** en publicidad de crédito que llega a residentes
en EE.UU. activa los *triggering terms* de **Regulation Z (12 CFR 1026.24)**, y **un disclaimer
NO cura** la infracción.

> **Salida limpia: el correo entrega PRECIO DE VIVIENDA. Tasa y cuota las da el asesor en la
> llamada. El correo genera la conversación, no la resuelve.**

`[⚠ no verificado]` Aplicabilidad exacta de Reg Z a la comunicación de un broker colombiano
hacia residentes en EE.UU. — validar con legal antes de escalar volumen. El criterio
conservador es defendible con o sin esa validación.

**Lista negra literal, en cualquier variante:** "ya calificás" · "seguro te aprueban" · "con tu
perfil no hay problema" · cualquier tasa numérica aunque sea "aproximada" o "la de la semana
pasada" · cualquier cuota mensual no validada por Crédito · "tasa fija garantizada" · "la mejor
tasa del mercado" · rentabilidad proyectada que el inventario no traiga como campo.

---

## FASE 5 · Formato exacto del output

Un solo markdown, cuatro bloques, este orden.

```markdown
## A. Lectura del lead
{5-7 líneas en prosa, no tabla. Qué dijo · qué quiere · cuál es su techo · cuál es su bloqueo
real. Sin PII. Nombra explícitamente qué dato falta y qué puede tumbar la recomendación.}

## B. Ficha de match

**★ Mejor calce — {Proyecto}** · {Constructora} · {Ciudad}

| Campo | Dato |
|---|---|
| Precio desde | {copiado} |
| Área | {copiado} |
| Entrega estimada | {copiado} |
| Esquema de separación | {copiado o `no disponible en el inventario`} |
| Cuota mensual estimada | **no disponible** — la calcula tu asesor con la tasa vigente al desembolso |

**Por qué calza con lo que él dijo:** {cita SU criterio, no adjetivos. Incluye el margen contra
el techo, nombrado con destino.}
**Objeción que va a poner:** *"{en sus palabras probables}"*
**Con qué se responde:** {prueba concreta del playbook. Nunca "la constructora es seria".}

---

**Opción 2 — {Proyecto}** · {Ciudad}
{misma estructura}

---

**Opción 3 — {Proyecto}** · {Ciudad}
{misma estructura + si está en 95-100% del techo, un bloque explícito
**Por qué NO es el mejor calce:** …}

## C. Secuencia de 3 correos

**Espaciado sugerido:** correo 1 hoy → correo 2 a los 3 días si no responde → correo 3 a los
6-7 días. **Si responde en cualquier punto, la secuencia se detiene** y entra el asesor.

**Correo 1 — El proyecto concreto**
*Asunto:* {…}
{cuerpo listo para enviar, sin placeholders sin llenar, cerrando con la firma del asesor}

**Correo 2 — La confianza**
*Asunto:* {…}
{cuerpo}

**Correo 3 — La decisión compartida**
*Asunto:* {…}
{cuerpo}

## D. Para el asesor
- **Qué NO se dijo en los correos y por qué:** {típicamente la cuota mensual}
- **Campos vacíos del input del lead:** {…} — cuál puede mover la recomendación
- **Campos vacíos del inventario:** {…}
- **Señal de Aircall:** {qué ángulo salió de ahí, o "se corrió sin señal"}. Al lead nunca se le
  dice que analizamos su llamada.
- **Validar con Crédito:** {cuota, aplicabilidad de "Mi Casa en Colombia" (FNA, aprobado
  17-jun-2026) — enunciable como programa existente, nunca como aprobación}
- `[⚠ no verificado]` los cortes 70-85%/85-95% requieren calibración del área de Crédito.
```

---

## Ejemplo real (recortado)

Ejemplo completo en `references/ejemplo-completo.md`. Los datos de proyecto son **ficticios y
solo muestran el formato** — en operación cada campo se copia de Vivehome.

**Input pegado por el asesor:**
```
Nombre de pila: Andrés · Residencia: EE.UU. — Broward, FL
Formulario CC — presupuesto: crédito preaprobado por $300.000.000 COP
Formulario CC — ciudad: Santa Marta
Formulario CC — propósito: rentar mientras tanto; volver en 6-8 años
Cuota inicial disponible: no diligenciado
Resumen Aircall (12 min): preguntó dos veces por la garantía de devolución. Preguntó si tenía
que viajar a Colombia para firmar. Mencionó que un conocido "perdió plata con una constructora".
```

**A (recorte):** *Andrés no está comparando proyectos todavía: está comparando **riesgos**. […]
Su propósito es mixto: rentar ahora, habitar en 6-8 años. Eso pesa a favor de una unidad
pequeña, bien ubicada y con **entrega pronta** — cada mes de obra es un mes sin renta. El techo
de $300M no es el objetivo: es el máximo.*

**B (recorte, mejor calce a $278.5M = 93% … no):** el mejor calce es Bahía Serena a
**$278.500.000** (93% del techo) → **fuera de la banda 70-85%**, así que la ficha **justifica
por atributo**: es el único con entrega dentro de 18 meses, o sea el que empieza a rentarse
primero, y 52 m² / 2 alcobas es el formato de mayor rotación en zona turística. Margen: *"te
quedan $21,5 millones — para la cuota inicial, para escrituras, o simplemente para no quedar
apretado"*.

**C, correo 1 (recorte):** *"Una cosa que quiero decirte de una: el banco te preaprobó hasta
$300 millones. Eso es el techo, no la meta. […] Lo que sigue es sencillo: tu asesora te calcula
la cuota mensual real con la tasa que esté vigente y te la manda. ¿Te llamamos el jueves o el
viernes?"*

**C, correo 2 (recorte):** *"Preguntaste qué pasa si no sale el crédito. La respuesta es que te
devolvemos el valor del servicio. […] Y no tienes que viajar a firmar. Se hace con poder desde
donde estás."* — responde la pregunta de la llamada **sin decir jamás que analizamos la llamada**.

**D (recorte):** cuota mensual no se mencionó en ningún correo (el inventario no la trae y la
tasa la define Crédito) · campo vacío: cuota inicial — es lo que más puede mover la
recomendación · esquema de separación vacío en los 3 proyectos · no se citó Aircall.

---

## FASE 6 · Checklist de autovalidación

Corré esto sobre tu propio output antes de entregar. **Cualquier ✗ bloquea: se corrige y se
entrega, no se entrega con la falla anotada.**

**Integridad de datos**
- [ ] Cada dato de proyecto existe **literalmente** en el input de inventario.
- [ ] Cada campo faltante dice `no disponible en el inventario` y está listado en el bloque D.
- [ ] Si la fuente dice "desde", el entregable dice "desde".
- [ ] Cero cifras de tasa, cuota mensual, plazo o cuota inicial en los correos.

**Matching**
- [ ] 2 o 3 proyectos. Nunca 1 sin justificación, nunca 4+.
- [ ] Uno marcado como **mejor calce**, en la banda 70-85% del techo — o con justificación
      escrita que apunte a un **atributo del proyecto**, no al presupuesto.
- [ ] Ningún proyecto excede el 100% del techo.
- [ ] Cada "por qué calza" cita un criterio que **el lead dijo**, no un adjetivo.
- [ ] Cada proyecto trae su objeción probable y con qué se responde.
- [ ] El orden refleja el propósito declarado, no el precio.
- [ ] Todos en la ciudad/zona que él pidió, o la sustitución está declarada explícitamente.
- [ ] El margen se nombró **con destino**, nunca como resta ni como "te alcanza para menos".

**Correos**
- [ ] Tres trabajos distintos. Pasan la prueba de intercambio.
- [ ] Un solo CTA por correo. El del 3 tiene dos horarios concretos y salida digna.
- [ ] Del lead aparece solo nombre de pila (+ ciudad de interés y propósito).
- [ ] Cero promesas de aprobación, tasa, rentabilidad o valorización garantizada.
- [ ] Cero referencias a la llamada, a la transcripción o al estado emocional del lead.
- [ ] El testimonial del correo 2 es textual del banco de VOC, con comillas.
- [ ] Español de Colombia, tuteo, sin jerga sin traducir, sin ángulo de "raíces".
- [ ] Correo 1 ≤ ~180 palabras. Los tres en texto plano, legibles en móvil.
- [ ] Hay espaciado sugerido y la instrucción de detener la secuencia si responde.

**Gobernanza**
- [ ] Si faltaba alguna de las 4 variables críticas, el output es el bloque "Qué falta" y
      **nada más**.
- [ ] Los `[⚠ no verificado]` sobreviven en el bloque D (Reg Z · cortes 70-85%).
- [ ] El entregable termina en algo que un humano aprueba antes de enviar. El skill no envía.
- [ ] Una sola pasada. Sin research en runtime.

---

## Anti-patterns (los seis que un LLM comete por defecto)

| # | Falla | Antídoto |
|---|---|---|
| A1 | Recomendar el más caro que "cabe" | La banda 70-85% es regla dura, no sugerencia. Salir de ella exige justificación por atributo. |
| A2 | Inventar precios, áreas o fechas | Whitelist de campos: se copia o dice `no disponible en el inventario`. |
| A3 | Tratar el preaprobado como presupuesto | Nunca "tienes disponible" ni "cuentas con". Siempre "el banco te aprobó **hasta**", en el correo 1. |
| A4 | Ignorar la señal de la llamada | Paso obligatorio de FASE 3 antes de redactar. Sin resumen ⇒ secuencia neutra **anotada en D**. |
| A5 | Tres correos que son el mismo correo | Trabajo declarado y excluyente por correo + prueba de intercambio. El 2 no repite cifras del 1; el 3 no repite la prueba social del 2. |
| A6 | Prometer aprobación, tasa o rentabilidad | Lista negra literal + regla de origen: cifra financiera que no venga del inventario o de Crédito, no se escribe. |
| A7 | Exponer datos personales | Solo nombre de pila, ciudad de interés y propósito. |
| A8 | Rendirse tarde | El gate corre **antes** de tocar el inventario. |

---

## Referencias

- `references/proposito-inversion.md` — tabla propósito → qué se maximiza / cómo cambia el
  correo, banda del preaprobado y guion de encuadre del margen.
- `references/aircall-senal-angulo.md` — señal → ajuste (8 filas) y las tres prohibiciones.
- `references/objeciones-playbook.md` — las 6 objeciones canónicas y en qué correo va cada una.
- `references/ejemplo-completo.md` — el ejemplo end-to-end completo, con datos ficticios.

**Fuente del conocimiento:** KGD `viventa-match-proyecto-lead-KGD.md`, run `run-2026-08-06-0559`.
