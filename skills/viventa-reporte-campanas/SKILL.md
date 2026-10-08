---
name: viventa-reporte-campanas
description: >-
  Consolida el desempeño de Growth & Marketing de Viventa (Zoho CRM, Meta, Google, email, GA4)
  en un reporte de 2 páginas con lectura en prosa, 3 hallazgos, 3 alertas y 3 recomendaciones
  con dueño. En modo mensual agrega rendimiento por formato y el insumo que alimenta la parrilla
  del mes siguiente. Toda cifra declara fuente, ventana y universo; lo que no cumple esas tres
  cosas no se emite y se lista en "Métricas NO emitidas y por qué". No lanza ni aprueba nada.
metadata:
  version: "1.0.0"
  domain: "analyze"
  client: "viventa"
  blueprint: "marketing"
  complexity: "complex"
---

# viventa-reporte-campanas

Convierte el export de datos del área en **una lectura**, no en una tabla. Semanal o mensual,
multicanal, consolidado.

**Frontera con `viventa-monitor-evento`:** ese skill es **diario y por evento** (umbrales,
proyección, veredicto de plaza, cortes T+0/30/90/180). Este es el **consolidado del área**. Aquí
**Eventos es una fila de la tabla**, no un objeto con lógica propia. Si te preguntan "¿cómo va
Tampa?" → eso es el otro skill; decilo y no lo hagas acá.

**Cómo se invoca:**
- Semanal → `/viventa-reporte-campanas semanal` (modo por defecto).
- Mensual → `/viventa-reporte-campanas mensual`.
Si no dicen cuál, asumí semanal y decilo en el encabezado.

**Restricciones que gobiernan todo:**
- **Una sola pasada.** Sin loops, sin research en tiempo de ejecución, sin llamadas externas.
  Las cuentas de IA son compartidas y con límite (hasta 4 horas de espera si se agotan créditos).
- **El reporte no lanza, no pausa, no aprueba nada.** Termina en un entregable para revisión
  humana. La cuenta de pauta la opera una agencia externa.
- **Español de Colombia, tuteo, frases cortas.** Prohibida la jerga de consultora: "solución
  integral", "aliado estratégico", "leverage", "unlock", "palanca", "accionable", "insight
  clave", "de cara a".
- Output en markdown con tablas, copiable a Google Sheets/Slides sin conversión.
- Los `[⚠ no verificado]` del input **sobreviven** al reporte como advertencia visible. No se
  limpian, no se redondean, no se convierten en afirmación.

**Referencias (cargar solo la que toque, no las dos de entrada):**
- `references/reglas-datos.md` — cifras canónicas, tabla de comparabilidad, fuente que manda por
  métrica, anti-patterns con antídoto.
- `references/plantillas.md` — plantilla exacta semanal y mensual + ejemplo recortado.

---

## LA REGLA NÚCLEO: fuente + ventana + universo

**Toda cifra del reporte declara tres cosas. Sin las tres, no se emite.**

| Componente | Qué declara | Ejemplo |
|---|---|---|
| **Fuente** | Qué sistema la produjo | Zoho CRM · Meta Ads Manager · Google Ads · Zoho Campaigns · GA4 · Wati |
| **Ventana** | Periodo **y criterio de fecha** | 27-jul a 2-ago, fechado por **creación del lead** (no por clic, no por cierre) |
| **Universo** | Qué población incluye | leads pagados · leads totales · cohorte de abril · leads de Crédito asignados a un gerente |

Sin universo declarado, dos cifras del mismo mes se ven como contradicción y no lo son: [cifra interna]
leads (cohorte total de abril) contra [cifra interna] (leads de Crédito asignados a un gerente) son
universos distintos, no un error.

**Quién manda cuando hay conflicto:**

| Tipo de dato | Fuente que manda |
|---|---|
| Leads, cierres, plata | **Zoho CRM** — única fuente de verdad del dinero |
| Inversión, impresiones, CTR, CPM, frecuencia | La plataforma (Meta / Google) |
| Tráfico y comportamiento en sitio | GA4 |

Meta es **señal de optimización**, no reporte de resultados. Meta usa 7-día clic / 1-día view y
fecha por el **clic**; Zoho fecha por el **evento** y es last-touch. **Nunca van a cuadrar y eso
es normal.** La meta no es varianza cero: es varianza **estable y explicable**. Un delta
Meta-vs-Zoho estable (p.ej. Meta reporta 15-25% más, siempre) se reporta como normal. Un delta
que se sale de su rango histórico es **alerta de tracking**, no hallazgo de negocio.

Cuando dos fuentes discrepan: se muestran **las dos** con nombre y fecha, se declara **cuál
manda**, y se reporta el **delta en %**. Nunca se suman, nunca se promedian, nunca se elige una
en silencio.

### Qué se puede comparar con qué

| Comparación | ¿Válida? | Condición |
|---|---|---|
| Mismo canal, periodo vs periodo anterior, misma fuente | ✅ | Es la comparación base |
| CPL de dos canales pagados (Meta vs Google) | ✅ | Ambos con universo pagado limpio **y con la conversión al lado** |
| CPL de canal pagado vs canal sin pauta | ❌ | El de $0 pauta no tiene CPL. Se compara por CAC loaded |
| Leads de Meta Ads Manager vs leads de Zoho | ⚠ | Se muestran ambos, manda Zoho. **Nunca se suman** |
| CPL de Eventos vs CPL de Meta | ❌ hoy | Universo de Eventos mezclado — no emitible |
| Conversión a desembolso vs conversión a pago de servicio | ❌ | Dos KPIs distintos. Nunca se suman ni se intercambian |
| Mes actual vs mes anterior | ⚠ | Solo con días hábiles normalizados. Preferir mismo mes del año anterior |
| Blended CPL sobre leads totales | ❌ | El denominador es **solo leads pagados**, y se declara |

**Advertencia permanente:** el CPL **no ordena canales por valor**. Un canal a $20/lead que
cierra 4% cuesta $500 por venta; otro a $60/lead que cierra 15% cuesta $400. En Viventa es
literal: Meta trae ~43% del volumen y es el **peor** ROI del stack ([cifra interna] loaded), mientras Web
([cifra interna] loaded) convierte 4.19%.
→ **CPL sin conversión al lado está prohibido en página 1.**

---

## LAS 6 CONDICIONES DE NEGATIVA

Cuando se cumple **cualquiera**, la métrica **no se emite**. La casilla dice `no emitible`, con
una línea de causa y una línea de qué dato la desbloquea. Y la métrica entra en la sección
**"Métricas NO emitidas y por qué"**.

**Negarse a emitir es output válido, no es un error ni una falla del skill.** Esa sección es de
lectura obligatoria para gerencia: cada línea ahí es un pendiente de instrumentación.

| # | Condición | Se dispara cuando | Qué la desbloquea |
|---|---|---|---|
| 1 | **Universo mezclado** | El numerador o el denominador junta poblaciones distintas (caso Eventos) | Campo de origen en el CRM que separe los universos |
| 2 | **Ventanas incompatibles** | Las dos fuentes de un cociente usan criterios de fecha distintos con desfase mayor a la ventana de atribución declarada (inversión Meta fechada por clic ÷ leads Zoho fechados por creación) | Ventana de atribución configurada y declarada en Meta y Google |
| 3 | **Denominador chico** | Menos de **30 leads** para una tasa · menos de **10 cierres** para un CAC | Acumular periodo hasta llegar al piso |
| 4 | **Cohorte no madurada** | Se pide conversión o CAC en ventana semanal. El ciclo hipotecario supera la semana | Conversión solo **mensual y por cohorte**. Nunca semanal |
| 5 | **Fuente no declarable** | La cifra llegó sin sistema de origen identificable, o contradice `references/cifras-canonicas.md` | El export con fuente, o corrección de la cifra canónica |
| 6 | **Discrepancia fuera de rango** | El delta entre dos fuentes se salió de su rango histórico y nadie lo resolvió | Revisión de tracking. Se reporta como **alerta**, no como métrica |

Y la regla que las cubre a todas: **nunca estimar, promediar ni "aproximar" para llenar una
casilla.** Una cifra inventada es peor que una casilla vacía, porque se vuelve citable.

---

## PROTOCOLO DE LEADS DE EVENTO (4 pasos, obligatorio)

Este es el caso vivo de universo mezclado. Los leads de evento entran a un solo campo del CRM
mezclando **pauta**, **base propia** y **fuerza comercial**. Dividir la inversión entre todos da
un CPL falsamente bajo: ~**$4.83** implícito contra ~**[cifra interna]** de CPL Meta canónico. Es una
inconsistencia de **10x** y ninguna versión de ese número es publicable.

1. **Preguntá si el export separa el origen del lead de evento** (pauta / base propia / fuerza
   comercial / walk-in).
2. **¿Sí?** → calculá el CPL usando **solo el universo pagado** en numerador y denominador, y
   declaralo así: *"CPL Eventos (solo leads de pauta, n=X)"*.
3. **¿No?** → emitís **volumen** (los leads son reales, entraron) y en la casilla de CPL escribís
   literalmente **`no emitible — universo mezclado`**, con la causa y el dato que lo desbloquea.
4. **Nunca estimes el split.** Ni "aproximadamente la mitad", ni un promedio histórico, ni una
   regla de tres. Prohibido sin excepción.

**Rentabilidad de eventos: no calculable.** El CAC fully-loaded de evento es **[cifra interna]** y el ticket
del Servicio Viventa es **$480 USD** → [cifra interna] por cierre. Pero eso solo carga SV. Falta el
**valor promedio por operación de Vive Casas** y cómo se atribuye al canal. Hasta que ese dato
llegue, la fila Eventos dice **"rentabilidad no calculable"** — no "negativa", no "ruinosa", no
"rentable". Es un input de setup, no un cálculo.

---

## DE NÚMERO A LECTURA: la escalera de 4 niveles

El skill siempre sabe en qué escalón está parado y **redacta distinto en cada uno**.

| Nivel | Qué tenés | Cómo se redacta |
|---|---|---|
| **0 — Descripción** | El número cambió | **No se publica.** "Los leads bajaron 12%" no es un hallazgo |
| **1 — Localización** | Sabés **dónde** está la variación (canal, campaña, geo, segmento) | Afirmación directa: *"La caída está en Meta: explica 45 de los 54 leads perdidos"* |
| **2 — Descomposición** | Sabés si es **volumen o mezcla**, y qué se movió del otro lado | Afirmación directa: *"Mismo presupuesto, menos leads: el CPL subió de $43 a [cifra interna]"* |
| **3 — Causa** | Tenés antecedente + magnitud coherente + mezcla descartada | **Único nivel donde se puede afirmar causa.** Con la cifra citada al lado |

Todo hallazgo llega **mínimo a nivel 1**. Nivel 0 no se publica nunca.

### Antes de buscar causa: descomposición de mezcla (paradoja de Simpson)

**Obligatorio cuando cae una tasa agregada.** Una tasa global puede caer sin que **ningún canal
empeore**, solo porque cambió la proporción entre segmentos. Ejemplo Viventa: si el mes pasado
60% de los leads venían de Web (convierte 4.19%) y este mes 60% viene de Meta (convierte 0.64%),
la conversión global cae y **nadie empeoró**.

→ El reporte muestra **la mezcla al lado de la tasa**. Si la mezcla explica el movimiento, **ese
es el hallazgo**, y la redacción correcta es *"no empeoró ningún canal; cambió la mezcla hacia
canales de menor conversión"* — nunca *"cayó la conversión"*.

### Requisito para afirmar causa (las tres, sin excepción)

1. **Un dato del input que cambió antes o junto con el efecto** (subió la frecuencia, se pausó un
   ad set, cambió el presupuesto, entró una campaña de email, hubo un evento en la ciudad).
2. **Magnitud coherente** — el antecedente alcanza para explicar el tamaño del efecto.
3. **Mezcla descartada** y descartada la coincidencia con otras variaciones simultáneas.

Si falta una → es hipótesis. Sin excepción.

### Plantilla fija de hipótesis (tres partes, nunca menos)

> **Hipótesis:** [causa candidata, en una frase].
> **Qué la confirmaría:** [dato específico, con el corte y el umbral que la volvería afirmación].
> **Quién lo tiene:** [persona o sistema].

Si la **misma hipótesis aparece 3 periodos seguidos sin confirmarse**, se escala a **alerta de
instrumentación**: el problema ya no es la campaña, es que no tenemos el dato.

### 🚫 Lista negra: causas prohibidas sin evidencia

Estas son exactamente las que un LLM pone por defecto porque dominan su corpus, y las entrega
con **confianza alta** — el caso que los chequeos de confianza no atrapan.

**Ninguna de estas se puede afirmar sin una cifra del input al lado:**

- estacionalidad
- "cambió el algoritmo de Meta"
- fatiga / saturación de creativo
- saturación de audiencia
- "el mercado está lento"
- competencia
- cambios de privacidad de iOS

Todas son hipótesis legítimas. **Ninguna es una conclusión legítima** sin la cifra al lado. Si
vas a nombrarlas, van con la plantilla de hipótesis de arriba.

---

## FASES

### Fase 0 — Inputs (qué pedir y qué hacer si falta)

| Input | Obligatorio | Si falta |
|---|---|---|
| Export de Zoho CRM: leads por fuente + cierres, con fecha de creación | ✅ | **No se emite el reporte.** Sin Zoho no hay página 1. Pedilo y parás |
| Inversión por canal (Meta Ads Manager, Google Ads) | ✅ | Se emite volumen sin CPL. Toda casilla de costo → `no emitible — falta inversión` |
| Periodo y periodo de comparación | ✅ | Preguntá. **No lo asumas** por la fecha de hoy |
| Modo (semanal / mensual) | ⚠ | Asumí semanal y decilo en el encabezado |
| Email (Zoho Campaigns), GA4, Wati | ⚠ | Esa fila va como `sin dato este periodo`. No se estima |
| Rango de las últimas 6 semanas por canal | ⚠ | Sin él no podés decir "dentro del rango normal". Decí "sin referencia histórica" |
| **Split de origen del lead de evento** | ⚠ | Protocolo de 4 pasos → CPL Eventos `no emitible` |
| **Valor por operación de Vive Casas** | ⚠ | Eventos → **"rentabilidad no calculable"**. Es setup, no cálculo |
| Ventanas de atribución configuradas (Meta, Google) | ⚠ | Condición de negativa #2 en todo cociente cross-fuente |

**Los 3 inputs de setup** (campo de origen en Zoho · valor por operación de Vive Casas · ventanas
de atribución declaradas) se piden **una vez**, no cada periodo. Mientras falten, cada reporte
los repite en "Métricas NO emitidas y por qué" hasta que alguien los resuelva.

### Fase 1 — Normalizar y etiquetar
Para cada cifra del input, escribí su terna **fuente / ventana / universo**. La que no tenga las
tres, se marca candidata a no emitible. Esto se hace **antes** de calcular nada.

### Fase 2 — Correr las 6 condiciones de negativa
Sobre cada métrica derivada (CPL, CAC, conversión, blended). La que dispare cualquier condición
se saca de la tabla y entra a la lista de no emitidas con causa y desbloqueador.

### Fase 3 — Localizar y descomponer
Ubicá dónde está cada variación (nivel 1). Descomponé volumen vs mezcla (nivel 2). Si cayó una
tasa agregada, corré la descomposición de mezcla **antes** de pensar en causas.

### Fase 4 — Causa o hipótesis
Aplicá el requisito de las tres condiciones. Lo que no las cumple sale con plantilla de hipótesis.
Revisá la lista negra antes de escribir cualquier explicación.

### Fase 5 — Jerarquizar 3/3/3
Una métrica sube a página 1 solo si **su movimiento cambia una decisión del periodo entrante**:
mover plata, pausar algo, pedir un dato, activar una campaña. Si no cambia nada, va al anexo
aunque sea grande.

**Tope duro: máximo 3 hallazgos, 3 alertas, 3 recomendaciones.** Menos también es válido: una
semana plana puede tener 1 hallazgo. **Inventar el tercer hallazgo para llenar la plantilla es la
falla más cara de este skill.**

Cada recomendación lleva **verbo concreto + dueño sugerido + ejecutable en el periodo entrante**.
Dueños posibles: Alejandra · Lizeth · agencia de pauta · admin de CRM.
*"Revisar la estrategia de canales"* no es una recomendación.

### Fase 6 — Redactar y autovalidar
Armá el output con la plantilla de `references/plantillas.md` y corré el checklist de abajo antes
de entregar.

---

## OUTPUT: 2 páginas, estructura fija

**Página 1 — la lectura**
1. Encabezado: periodo · comparación · fecha de emisión · **fuentes** · cierre de datos.
2. **LO QUE PASÓ** — prosa, 4-6 líneas. Una lectura, no una lista de números.
3. **HALLAZGOS (máx. 3)** — cada uno con *Evidencia: [fuente, corte, periodo]*.
4. **ALERTAS (máx. 3)** — 🔴 bloquea / 🟠 hay que resolver / 🟡 vigilar.
5. **RECOMENDACIONES (máx. 3)** — tabla: qué hacer · por qué · dueño sugerido.
6. Recordatorio: *ninguna de estas acciones lanza pauta; todas terminan en revisión humana.*

**Página 2 — tabla y anexo**
7. **Tabla por canal**, con **columna de fuente por fila**: Canal · Leads · Δ · Inversión ·
   CPL (costo por lead) + conversión · Fuente.
8. **Nota del blended** — denominador explícito (solo leads pagados).
9. **Anexo** (no requiere lectura): impresiones, alcance, CTR, CPM, aperturas/clics de email,
   sesiones GA4, seguidores, detalle por ad set.
10. **MÉTRICAS NO EMITIDAS ESTA SEMANA Y POR QUÉ** — sección obligatoria. Si no hay ninguna,
    escribí *"Ninguna."* La sección **nunca se omite**.

**Variante mensual** — misma estructura, cinco diferencias:
1. Agrega **conversión por cohorte**: a desembolso ([cifra interna]) y a pago de servicio ([cifra interna]), en filas
   **separadas y etiquetadas**.
2. Agrega **CAC por canal vs baseline** y composición geográfica.
3. Compara contra **mismo mes del año anterior**. Si se usa mes anterior, se normaliza por días
   hábiles y se dice explícitamente.
4. Agrega **rendimiento por formato** (ver abajo).
5. Agrega **INSUMO PARA LA PARRILLA** (ver abajo). Es la única sección que mira hacia adelante.

Plantilla literal y ejemplo recortado: `references/plantillas.md`.

---

## RENDIMIENTO POR FORMATO (solo mensual)

Responde *"qué contenido funcionó"* sin caer en opinión de creativo. Corte por **formato**, no por
pieza: video vertical · video 1:1 · carrusel · estática · flyer por consultora · email · WhatsApp.

Tabla: Formato · Piezas activas · Leads · Δ vs mes anterior · CPL · Fuente.

Tres reglas propias, además de las generales:

1. **Se hereda el piso de volumen.** Ningún CPL por formato con menos de 30 leads. Un formato bajo
   el piso aparece en la tabla con `n/d (bajo piso)` — no se omite, porque su ausencia también
   es información.
2. **Formato ≠ ángulo ≠ creativo.** Este corte dice qué **envase** rindió. Por qué rindió es
   hipótesis, y va con la plantilla de hipótesis como cualquier otra causa. Prohibido escribir
   *"el video funciona mejor"* como conclusión cerrada sobre 1 mes.
3. **Meta Special Ad Category cambia la lectura.** Desde el 14-ene-2025 no hay segmentación por
   edad, género ni código postal en productos financieros: el hook sustituye al targeting. Una
   diferencia entre formatos puede ser diferencia de hook, no de envase. Si no se puede separar,
   se dice.

---

## INSUMO PARA LA PARRILLA (solo mensual)

**La razón por la que existe esta sección:** hasta ahora el reporte producía recomendaciones y ahí
moría. Nada devolvía el aprendizaje del mes a la planificación del mes siguiente. Este bloque es
esa bisagra, y su consumidor es `viventa-parrilla-base`.

Máximo 5 líneas. Cada una con esta forma exacta:

> **{segmento o formato}** — {qué hizo} · Evidencia: [fuente, corte, periodo] · **Para la parrilla:**
> {subir / sostener / bajar / probar} — {qué cambio concreto}

Reglas, todas bloqueantes:

1. **Solo entra lo que ya pasó las 6 condiciones de negativa.** Una línea que no sobrevivió el
   filtro de la Fase 2 no puede reaparecer acá con otro nombre. Esta sección no es una segunda
   oportunidad para métricas que no calificaron.
2. **"Sin señal suficiente" es una salida válida y frecuente.** Si el mes no produjo nada que
   cambie la parrilla, la sección dice literalmente *"Sin señal suficiente para modificar la
   parrilla de {mes entrante}. Se sostiene la vigente."* **Inventar una señal para llenar este
   bloque es la misma falla que inventar el tercer hallazgo, y cuesta más caro: acá se propaga
   a la planificación.**
3. **No propone piezas ni copies.** Dice qué mover; el qué escribir es de `viventa-parrilla-base`.
4. **No reemplaza las recomendaciones.** Aquellas son acciones del periodo entrante con dueño;
   esto es insumo de planificación. Pueden coincidir, y si coinciden se dice.
5. **Se etiqueta el alcance.** Una señal de un solo canal se marca como tal — no se generaliza a
   la base entera.

---

## REGLAS DE DATOS — no negociables

Si se rompe una, el reporte **no pasa QA**. Detalle completo en `references/reglas-datos.md`.

1. **CPL ≠ CAC.** CPL = costo por **lead**. CAC = costo por **cierre**. Etiquetados siempre en el
   encabezado de columna: `CPL (costo por lead)`, `CAC (costo por cierre)`. **Nunca** una columna
   llamada solo "costo". El lead de Meta cuesta [cifra interna]; el **cierre** de Meta cuesta ~[cifra interna]
   (ad-spend) / **[cifra interna]** (fully-loaded).
2. **Las dos conversiones son dos KPIs.** Conversión a **desembolso = [cifra interna]** ([cifra interna] cierres).
   Conversión a **pago de servicio = [cifra interna]** (939 pagos). Nunca se suman, nunca se intercambian,
   nunca "conversión global" sin decir cuál.
3. **El +42% es participación del segmento no residentes** (Camacol: 8.8% → 12.5% de las ventas).
   **NO es crecimiento de mercado** — el mercado total crece 5-12%. Prohibido escribir "el
   mercado crece 42%".
4. **Ticket Servicio Viventa = $480 USD.** No $495.
5. **Ningún canal sin pauta muestra CPL $0.** Web e Instagram orgánico tienen $0 de inversión
   pero CAC loaded de [cifra interna] y [cifra interna]. Su casilla de CPL dice **`n/a (sin pauta)`**.
6. **El blended divide solo entre leads pagados**, con nota explícita del denominador. Dividir la
   inversión total entre los leads totales da un número falso y citable.
7. **Ninguna tasa con menos de 30 leads. Ningún CAC con menos de 10 cierres.**
8. **Conversión: solo mensual y por cohorte.** Nunca semanal.
9. **Si dos fuentes discrepan: las dos, cuál manda, y el delta %.**
10. **El reporte no lanza nada.** Termina en un entregable para aprobar.
11. **Ninguna cifra puede contradecir `references/cifras-canonicas.md`.** Si el input la contradice, se
    muestran las dos y se declara que manda la canónica.

---

## CHECKLIST DE AUTOVALIDACIÓN

Corré esto **antes** de entregar. Un `no` = no se entrega.

**Estructura**
- [ ] Cabe en 2 páginas. Página 1 se lee sin ir a la tabla.
- [ ] Máximo 3 hallazgos, 3 alertas, 3 recomendaciones. No inventé ninguno para llenar.
- [ ] Cada recomendación tiene verbo concreto, dueño y es ejecutable en el periodo entrante.
- [ ] Existe la sección **"Métricas NO emitidas y por qué"** (aunque diga "Ninguna").
- [ ] No hay lógica de evento individual (umbrales diarios, veredicto de plaza) — eso es
      `viventa-monitor-evento`. Eventos es **una fila**.

**Datos**
- [ ] Toda cifra declara **fuente**. Sin excepción.
- [ ] Toda cifra declara **ventana** (periodo + criterio de fecha) y **universo**.
- [ ] Encabezados dicen "CPL (costo por lead)" y "CAC (costo por cierre)". No hay columna "costo".
- [ ] Las dos conversiones están en filas separadas y etiquetadas, o no aparecen.
- [ ] El blended divide solo entre leads pagados y lo declara en nota.
- [ ] Ningún canal sin pauta muestra CPL $0 — muestra `n/a (sin pauta)`.
- [ ] Eventos: o tiene split de universo, o su CPL dice `no emitible`. **No estimé el split.**
- [ ] Eventos dice "rentabilidad no calculable", no "negativa".
- [ ] Ninguna tasa con <30 leads. Ningún CAC con <10 cierres.
- [ ] Si dos fuentes discrepan: aparecen las dos + cuál manda + delta %.
- [ ] Ninguna cifra contradice `references/cifras-canonicas.md`.
- [ ] Ticket SV = $480. El +42% está descrito como participación del segmento, no como mercado.
- [ ] Los `[⚠ no verificado]` del input siguen visibles en el output.

**Mensual — rendimiento por formato e insumo para la parrilla**
- [ ] (Mensual) Existe la tabla de rendimiento por formato, y los formatos bajo el piso de 30
      leads dicen `n/d (bajo piso)` en vez de estar omitidos.
- [ ] (Mensual) No afirmé que un formato "funciona mejor" como conclusión cerrada sobre 1 mes.
- [ ] (Mensual) Existe la sección **INSUMO PARA LA PARRILLA**, aunque diga "sin señal suficiente".
- [ ] (Mensual) Cada línea del insumo pasó las 6 condiciones de negativa. **No recuperé ninguna
      métrica que la Fase 2 ya había descartado.**
- [ ] (Mensual) Máximo 5 líneas, y cada una trae evidencia con fuente, corte y periodo.
- [ ] (Mensual) El insumo dice qué mover, no qué escribir. No propuse copies ni piezas.
- [ ] (Mensual) Una señal de un solo canal está etiquetada como tal, no generalizada.

**Lectura**
- [ ] Ningún hallazgo se quedó en nivel 0 (puro número).
- [ ] Toda afirmación causal cita una cifra del input.
- [ ] Toda hipótesis dice "Hipótesis", trae "qué la confirmaría" y "quién lo tiene".
- [ ] Ninguna causa de la lista negra aparece **afirmada**.
- [ ] Si cayó una tasa agregada, revisé y reporté la mezcla antes de buscar causa.
- [ ] CPL nunca aparece en página 1 sin su conversión al lado.
- [ ] Sin jerga de consultora. Español de Colombia, tuteo, frases cortas.
