---
name: viventa-guiones-evento
description: >-
  Escribe los 5 guiones de video de un evento Viventa en una sola pasada: cada uno
  con su ángulo asignado, hook de 3 segundos, guion con marcas de tiempo, shot list
  grabable, variantes USD/EUR y bloque de voz en off por ciudad y fecha.
  Cierra con la validación de palabras prohibidas y los claims que necesitan visto
  bueno de Crédito. Corre en dos tandas separadas — lanzamiento y optimización — y la
  de optimización exige los datos de qué ángulo rindió, no inventa creativo a ciegas.
  Úsalo en la preproducción, antes de agendar la grabación.
metadata:
  version: "1.0.0"
  domain: "produce"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-guiones-evento

Produce los **5 guiones de video** de un evento, listos para que Johana grabe en una sola
sesión y para que Daniel apruebe. Reemplaza el día de escritura de guiones más el medio
día de validar el brief del equipo de Ads.

**Este skill no aprueba, no publica y no activa pauta.** Termina en un documento para que
Daniel Vélez lo revise.

**Una sola pasada.** Sin research web, sin loops. Todo el insumo es local: el brief del
evento, el `references/voice-of-customer-90d.md` y el playbook comercial.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **Sin dirección exacta del evento, el skill bloquea.** Es la fricción #1 del Voice of
   Customer. No se escribe "este fin de semana" ni "en Miami". Se escribe calle, número,
   venue, ciudad. Si el brief no la trae, el output es el bloque `INPUTS REQUERIDOS` y nada más.
2. **Nunca tasa, cuota, plazo ni cuota inicial.** Son trigger terms regulados. Si el brief
   los exige, la línea va al bloque B (visto bueno de Crédito) y **no se graba** hasta el OK.
3. **Nunca prometer aprobación de crédito ni valorización.** "Te acompañamos en el proceso",
   no "te aprobamos".
4. **Cero invención.** Cifra sin fuente = se declara faltante con el dato a pedir y a quién.
   Testimonio no presente literal en el VOC = no se usa.
5. **Los 5 ángulos se asignan ANTES de escribir.** El modelo no elige el eje sobre la marcha.
   Ver `references/matriz-angulos.md`.
6. **Español de Colombia, tuteo.** Cero "vosotros", "vale", "coger", "guay", "tío".
7. **Ningún ángulo de "inversión inmobiliaria"** — Viventa habla de patrimonio y familia.
8. Los `[⚠ no verificado]` heredados se mantienen visibles en el output, no se limpian.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| Ciudad, país, **dirección completa**, venue, fecha(s), horario local | **Sí — bloqueante** | **Bloquea.** Pedir a quien armó el brief del evento (comercial / Johana) |
| Modalidad (Open House · ExpoColombia · Expo Casa · Viventa Más Cerca de Ti) | Sí | Pedir. Determina el registro del headline |
| Mercado y moneda (se **deriva del país**: USA/Canadá → USD · España/Francia → EUR · UK → GBP) | Derivado | No preguntar la moneda; preguntar el país |
| Consultoras asignadas | No para los guiones | Seguir; se resuelve en `viventa-pack-evento` |
| Recursos de grabación: nº de locaciones, cámaras, personas a cuadro | Sí | Asumir el mínimo (1/1/1) y declararlo como supuesto |
| Montos del brief (`{MONTO_USD}` / `{MONTO_EUR}`) | No | Usar la **línea agnóstica de moneda** (preferida). Nunca estimar un monto |
| Lista oficial de palabras prohibidas del manual de marca | No | Correr con la lista base de `references/palabras-prohibidas.md` y **declararlo en el output** |
| Días hasta el evento | Sí | Calcular. Si son < 45, advertencia visible en la cabecera. No bloquea |

---

## Workflow

### Fase 1 — Gate de inputs
Chequea la tabla de arriba. Si falta la dirección exacta, **detenete acá** y emití solo:

```
⛔ NO SE PUEDEN ESCRIBIR LOS GUIONES

INPUTS REQUERIDOS
- Dirección completa del venue en {ciudad} → pedir a: {quien armó el brief}
- {otros faltantes}

Motivo: sin dirección concreta ninguna pieza puede salir (fricción #1 del Voice of Customer).
```

Ese bloque **es un output válido**. No inventes un venue plausible.

### Fase 1.5 — Elegir la tanda: lanzamiento u optimización

El ciclo real de un evento tiene **dos tandas de video**, no una. El cliente las cuenta como
"10 videos de lanzamiento + 12 de optimización" — ojo, esos son **archivos**; en conceptos son
la tanda de lanzamiento (5) y la de optimización (los que pida el resultado).

**Corren en pasadas separadas. Nunca en la misma.**

| | Lanzamiento (default) | Optimización |
|---|---|---|
| Cuándo | Preproducción, antes de grabar | Con el evento en el aire, cuando el monitor marca caída |
| Input extra | — | **Obligatorio:** qué ángulo rindió y cuál no, de `viventa-monitor-evento` |
| Qué produce | Los 5 ángulos de la matriz | Guiones nuevos sobre lo que rindió + ángulos no probados |
| Prefijo | — | `OPT` en cada ficha, para que `pack-evento` no los mezcle |

**Reglas de la tanda de optimización:**

1. **Sin datos de rendimiento, no hay optimización.** Si te piden "más videos" sin decir qué
   funcionó, el output es el pedido de esos datos, no 5 guiones nuevos al azar. Producir más
   creativo a ciegas es exactamente lo que hoy quema las horas de la única productora.
2. **No se repite un ángulo quemado**, aunque haya rendido. Si un ángulo ya cansó a la audiencia
   (frecuencia alta, CTR cayendo), rendir en la ventana anterior no lo habilita.
3. **Un ángulo que rindió se profundiza, no se clona.** Variante de hook y de estructura
   narrativa; nunca el mismo guion con otras palabras — Meta lo trata como el mismo concepto.
4. **El tope de 5 conceptos aplica por tanda**, no al total del evento.

Si nadie dice qué tanda es, es **lanzamiento**.

### Fase 2 — Asignación de ángulos (antes de escribir una sola línea)
Cargá `references/matriz-angulos.md` y armá la **matriz de 5 filas** con: `# / ángulo /
sub-segmento ICP / dolor VOC (verbatim) / tipo de hook (Meta: value promise · curiosity ·
shock) / estructura narrativa / promesa / prueba / hipótesis que prueba`.

- Los ángulos 1, 2, 3 y 5 son fijos. El **ángulo 4 rota por evento** entre los 4 sub-segmentos
  desatendidos — elegí el que aplique al territorio y declaralo.
- Cada fila lleva una **estructura narrativa distinta**. Está prohibido repetir.
- Cada fila cita un **verbatim distinto** del VOC.

Esta matriz va **primero en el entregable**, antes de los guiones. Es el antídoto contra el
mode collapse: los 5 guiones tienen que ser 5 hipótesis que se ganan o se pierden por
separado, no 5 parafraseos.

### Fase 3 — Escritura de los 5 guiones
Cada guion lleva los **8 bloques**, en este orden:

1. **Ficha** — # · ángulo · sub-segmento · dolor VOC con verbatim · tipo de hook · estructura
   narrativa · duración objetivo (15-30s) · hipótesis.
2. **Hook 0:00-0:03** — literal, ≤12 palabras. Prohibido abrir con saludo, con el nombre de
   la marca o con logo. Mid-action: la acción ya empezó en el frame 1.
3. **Guion hablado con marcas de tiempo** — tabla `Tiempo | Línea | Nota de dirección`, con
   pattern interrupt marcado cada 5-8s.
4. **Shot list** — columnas fijas de `references/shot-list.md`. No exceder los recursos declarados.
5. **Texto en pantalla** por segmento, con nota de zona segura 9:16 vs 1:1.
6. **Variantes de cifra USD/EUR** — según la jerarquía de moneda de abajo.
7. **Bloque de VO por ciudad y fecha** — las frases aisladas que cambian por ciudad, listadas
   para grabar en tanda, un take por ciudad.
8. **CTA** — obligatorio con `{CIUDAD}` + `{DIRECCIÓN}` + `{FECHA}` + `{HORA}` ya resueltos
   con valor concreto.

### Fase 4 — Validación en la misma pasada
Corré las 3 capas de palabras prohibidas y los 12 tests. Ver secciones de abajo. Todo va en
el bloque de cierre del entregable.

---

## Jerarquía de escritura para moneda

El mismo video se graba en dólares y en euros. Escribir la cifra en labios obliga a
re-grabar el plano. De mejor a peor:

| # | Solución | Costo de producción |
|---|---|---|
| **1** | **Línea agnóstica de moneda (preferida).** No menciona cifra: *"Hay proyectos para presupuestos muy distintos — en el evento te decimos cuál te sirve."* | **1 toma sirve para los dos mercados.** Cero riesgo regulatorio |
| 2 | **Cifra en toma aislada.** La cifra vive en un plano de ≤2s (insert, texto en pantalla, VO sin cara). Se graban dos versiones de ese plano | 1 toma extra, no 1 video extra |
| 3 | **Cifra en el bloque de VO.** La moneda entra en la tanda de voz en off, igual que la ciudad | 1 take extra de audio |
| 4 | **Cifra en labios a cámara — evitar.** Solo si el brief lo exige explícitamente y está declarado | Re-grabación completa |

Reglas de escritura:
- Nunca convertir tipos de cambio en el guion. Cada mercado usa su cifra del brief.
- Nunca escribir `$` sin marcar mercado — es ambiguo entre USD y COP.
- Escribir **USD / EUR / GBP**, nunca "USA" (error real en el flyer de Tampa: *"Reserva desde 280 USA."*).
- Longitud fonética pareja: *"dólares"* (3 sílabas) vs *"euros"* (2) → si la cifra va en VO,
  escribí la línea EUR con una palabra más para que el corte no se rompa.
- Toda cifra usa `{MONTO_USD}` / `{MONTO_EUR}` del brief. **Nunca estimes un monto.**
- Mismo principio para **ciudad y fecha**: bloque de VO aislado, nunca en labios. Es lo que
  permite que 1 grabación cubra N ciudades.

---

## Sistema de palabras prohibidas — 3 capas, misma pasada

**Capa 1 · Lista negra literal** (determinista, sin juicio). Términos exactos de las
categorías A-D de `references/palabras-prohibidas.md`. Match = **FALLA automática**. El
reemplazo ya redactado va en el output; no pasa a revisión humana con el error adentro.

**Capa 2 · Lista de disparo** (heurística, bandera amarilla). Números seguidos de `%`, `$`,
`€`, `COP`, "millones"; y las palabras `tasa · cuota · inicial · plazo · años · aprobación ·
califica · garantiza · desde`. Match = va al **bloque B** con la pregunta exacta para Crédito.

**Capa 3 · Lista de marca** (juicio, tono). Jerga sin traducir (LTV, DTI, amortización,
preaprobado, buró), españolismos, adjetivos sin prueba, "inversión" donde va "patrimonio",
lenguaje de banco, "solución integral", "aliado estratégico", "unlock", "leverage".

**Siempre requiere visto bueno del área de Crédito:** cualquier cifra de tasa · cualquier
cuota mensual · cualquier % o monto de cuota inicial · cualquier plazo en años · cualquier
afirmación de que un producto o país está cubierto (VA loan, ITIN, vivienda usada, Puerto
Rico, Canadá) · cualquier afirmación sobre requisitos de calificación.

> `[⚠ no verificado]` Viventa **no es el acreedor** — es orquestador de crédito de bancos
> colombianos. La aplicabilidad literal de Reg Z (EE.UU.) y de la Ley 5/2019 (España) a su
> publicidad no está confirmada y debe validarla Legal/Crédito. Tratá estos listados como
> **estándar prudencial**, la barra más alta y no la barra legal exacta. La restricción de
> Meta (Special Ad Category "Financial Products and Services") **sí aplica directo**: elimina
> segmentación por edad, género y código postal → **el hook sustituye al targeting**, por eso
> el callout explícito ("Si te fuiste de Colombia hace años y…") no es recurso creativo sino
> el reemplazo funcional de la segmentación.

**Frontera con `viventa-qa-marca`:** este skill valida sus propios guiones antes de grabar
(pre-filtro barato). `viventa-qa-marca` audita cualquier pieza contra el manual completo.

---

## Formato exacto del entregable

Markdown copiable a Google Docs / CapCut. Plantilla:

```markdown
# Guiones — {MODALIDAD} · {CIUDAD}, {PAÍS}

**Dirección:** {venue}, {calle y número}, {ciudad}, {estado/CP}
**Fecha:** {fecha(s)} · **Horario:** {hora inicio}–{hora fin} (hora local)
**Consultoras:** {lista o "pendiente"}
**Mercado:** {país} → {USD|EUR|GBP} · **Formatos:** 9:16 + 1:1
**Semáforo 45 días:** {N} días hasta el evento — {✅ / ⚠ por debajo de 45, la pauta no alcanza a pasar aprendizaje}
**Palabras prohibidas:** {lista oficial del manual / ⚠ corriendo con lista base del skill}
**Recursos declarados:** {N} locación · {N} cámara · {N} personas a cuadro

## Matriz de ángulos
| # | Ángulo | Sub-segmento ICP | Dolor VOC (verbatim) | Tipo de hook | Estructura narrativa | Promesa | Prueba | Qué se aprende si gana |
|---|---|---|---|---|---|---|---|---|

## Guion 1 — {ángulo}
**FICHA** · … 
**HOOK (0:00-0:03)** · …
**GUION HABLADO** | Tiempo | Línea | Nota de dirección |
**SHOT LIST** | # | A/B | Encuadre (zona segura 9:16) | Ángulo | Movimiento | Dur. | VO/línea | Texto en pantalla | Audio | Locación/Prop | ✓ |
> Recursos: … · 1:1: re-encuadrar tomas …
**VARIANTES DE CIFRA — USD / EUR** | Mercado | Línea grabada | Nota |
**BLOQUE VO POR CIUDAD Y FECHA** (tanda, un take por ciudad)
**CTA** — {CIUDAD} · {DIRECCIÓN} · {FECHA} · {HORA}

## Guion 2..5 — idéntica estructura

## BLOQUE DE VALIDACIÓN
### A. Palabras prohibidas detectadas
| Guion | Tiempo | Cita textual | Regla que incumple | Reemplazo redactado |

### B. Requiere visto bueno de Crédito ← estas líneas NO se graban hasta el OK
| Guion | Claim | Categoría | A quién se pregunta | Qué se pregunta exactamente |

### C. Checklist de lo que NO se puede decir en anuncios
(fijo, para Johana)

### D. Tests automáticos
| # | Test | PASA/FALLA |

**APROBACIÓN DE MARCA: pendiente — Daniel Vélez**
```

---

## Ejemplo real (recortado) — Guion #3, ángulo trust

> Evento: Viventa Más Cerca de Ti — Valencia, España · sábado 27 de septiembre, 10:00-18:00

**FICHA** — Ángulo: objeción de trust · Sub-segmento: migrante de 2ª compra, ya vio ofertas y
desconfía · Dolor VOC: *"Eso realmente es algo de confianza? Porque es que colombia todo es
robo."* · Hook: shock · Estructura: objeción → refutación con prueba dura → invitación ·
24s · Hipótesis: atacar la desconfianza de frente convierte mejor que la aspiración.

**HOOK (0:00-0:03)** — *"«Es que en Colombia todo es robo.» Me lo escribieron ayer."*
(11 palabras. Cara a cámara, contacto visual directo, ya está mirando el celular y levanta la
vista. Sin logo, sin "hola a todos".)

| Tiempo | Línea | Nota de dirección |
|---|---|---|
| 0:00-0:03 | *"«Es que en Colombia todo es robo.» Me lo escribieron ayer."* | Hook. Corte seco desde negro |
| 0:03-0:08 | *"Y lo entiendo. Comprar a 8.000 kilómetros, sin ver, sin estar… da miedo."* | Validación. Bajar el ritmo |
| 0:08-0:13 | *"Por eso Viventa no es una inmobiliaria. Llevamos 20 años, trabajamos con 5 bancos y tenemos oficina física en Colombia, Estados Unidos y España."* | ⚡ Pattern interrupt: B-roll de fachada + overlay de los 3 países |
| 0:19-0:24 | **[BLOQUE VO — CIUDAD/FECHA]** *"Este sábado 27 de septiembre estamos en Valencia. Te esperamos en {DIRECCIÓN}, de 10 de la mañana a 6 de la tarde."* | CTA. Card final con dirección grande |

**Variantes de cifra:** este guion **no lleva cifra** — decisión deliberada del ángulo trust,
cero riesgo regulatorio. La línea neutra *"Hay proyectos para presupuestos muy distintos"*
sirve para los dos mercados con una sola toma.

**Validación de este guion:** palabras prohibidas 0 · claims para Crédito 0 · cifras usadas
20 años / 5 bancos / 3 países, todas de `references/cifras-canonicas.md` · ⚠ si se agrega "miles de
familias", marcarlo `[⚠ verificar con el cliente antes de grabar]`.

---

## Checklist de autovalidación (12 tests, corren en la misma pasada)

**Diversidad — es lo que más falla**
1. Los 5 hooks no comparten verbo inicial ni estructura sintáctica de apertura.
2. Las 5 estructuras narrativas son distintas; ninguna secuencia de beats coincide en >3 de 5 posiciones.
3. Los 5 guiones citan 5 verbatims distintos del VOC.
4. Test de intercambiabilidad: con la ficha tapada, cada hook es asignable a su ángulo.

**Compliance**
5. Cero matches de la lista negra literal (categorías A-D).
6. Todo claim de tasa, cuota, inicial, plazo o cobertura de producto está en el bloque B con la pregunta exacta para Crédito.
7. Cero jerga financiera sin traducción funcional adyacente.
8. Toda cifra es rastreable a `references/cifras-canonicas.md`, al brief o al VOC — o está marcada `[⚠ verificar antes de grabar]`.

**Producibilidad**
9. Los 5 tienen shot list completo y no exceden locaciones / cámaras / personas del brief.
10. Cada CTA tiene ciudad + dirección + fecha + hora concretas.
11. Las líneas de moneda existen en USD y EUR y están fuera de labios a cámara, salvo excepción declarada.
12. Existe el bloque de VO por ciudad/fecha, aislado y grabable en tanda.

Si un test falla, arreglalo antes de entregar. Si no se puede arreglar sin un dato que no
tenés, marcalo como faltante en el bloque de validación.

---

## Referencias

- `references/matriz-angulos.md` — matriz canónica de los 5 ángulos, sub-segmentos desatendidos, verbatims del VOC y reglas de no-colapso.
- `references/palabras-prohibidas.md` — las 6 categorías de claim riesgoso con reformulación segura, y el marco Meta / Reg Z / Banco de España.
- `references/shot-list.md` — columnas fijas, zona segura 9:16, convenciones de rodaje y anatomía del hook de 3 segundos.

**Fuentes locales obligatorias:** `references/contexto-viventa.md` ·
`references/voice-of-customer-90d.md` · `references/cifras-canonicas.md` ·
`.../Marca/` (manual y lista oficial de palabras prohibidas) ·
`.../Playbook comercial y objeciones/Guion de llamada inicial - SV.docx` (few-shot de voz).

**Frontera:** este skill produce el material fuente. `viventa-pack-evento` lo multiplica a
todas las piezas. `viventa-qa-marca` audita cualquier pieza contra el manual completo.
