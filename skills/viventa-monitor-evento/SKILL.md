---
name: viventa-monitor-evento
description: >-
  Monitorea las campañas de eventos de Viventa en dos modos: diario (tablero de eventos activos,
  4 gates de evidencia, proyección con curva back-loaded y máximo 3 acciones reenviables a la
  agencia de Ads) y cierre (ficha post-mortem en cortes T+0/T+30/T+90/T+180 con veredicto repetir,
  ajustar o no repetir). No ejecuta nada y "esperar" es una recomendación válida. USA cuando: "cómo
  van los eventos", "el CPL de Alicante se disparó, ¿toca hacer algo?", "sacá el cierre del evento
  de Tampa", "¿repetimos esa plaza?". Es por evento: viventa-reporte-campanas consolida todo el
  área y viventa-forecast-pauta proyecta el gasto del mes.
metadata:
  version: "1.1.0"
  domain: "analyze"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-monitor-evento

Un skill, dos modos que nunca corren juntos: **diario**, para quien sigue la pauta cada mañana
mientras la campaña está al aire, y **cierre**, para la gerencia después del evento. Invariantes de
toda corrida: ninguna cifra sin etiqueta de naturaleza, CPL y CAC nunca en la misma tabla, ningún
faltante se estima, máximo 3 acciones con sus 5 campos, y el skill no pausa, no ajusta ni publica:
la cuenta de Meta la opera una agencia externa.

## Cuándo usar

- Explícito: "cómo van los eventos", "revisá las campañas de los eventos activos", "el CPL de
  Alicante se disparó, ¿toca hacer algo?", "hacé el monitor diario de eventos", "sacá el cierre del
  evento de Tampa", "necesito el post-mortem del evento", "¿el evento sí se pagó o no?",
  "¿repetimos esa plaza?".
- Implícito: llega el export de Meta Ads de un evento al aire; o se cumplen 0, 30, 90 o 180 días de
  un evento ya hecho.
- Cadencia: diario todas las mañanas con pauta al aire; cierre en T+0, T+30, T+90 y T+180.

## Cuándo NO usar

- Reporte del desempeño de todo Growth & Marketing, no de un evento → `viventa-reporte-campanas`.
- Proyección de cuánto va a cerrar el gasto de pauta del mes → `viventa-forecast-pauta`.
- Escribir los videos nuevos que pide una caída → `viventa-guiones-evento` (tanda de optimización),
  con el rendimiento por ángulo que sale de acá.

## Input del usuario

**Setup — se carga una vez y no se infiere nunca**

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Valor económico por operación Vive Casas | La gerencia `[⚠ no verificado — no está en las cifras canónicas]` | *"¿Cuánto vale para Viventa una operación Vive Casas cerrada?"* Si no lo tienen: rentabilidad `no calculable` y veredicto `no emitible — falta valor Vive Casas` |
| Cómo se identifica en Zoho qué lead vino de pauta | Ops/data | *"¿Con qué campo de Zoho separo los leads de pauta de los demás?"* Sin esto: `CPL no emitible` (regla de universos) |
| Curva de referencia de registros calibrada | Histórico de eventos | No se pregunta: se usa la curva provisional de `references/umbrales-diario.md`, marcada `[⚠ no verificado]` en el output |
| CPL objetivo por plaza | La gerencia | *"¿Cuál es el CPL objetivo de {plaza}?"* Si no lo hay: semáforo de CPL ⚪ `sin objetivo`. El CPL Meta canónico ~[cifra interna] aparece solo como referencia rotulada `[referencia, no objetivo]`, nunca como umbral |

**Modo diario — por evento activo**

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Fecha, ciudad y dirección del evento | Brief del evento | Sin dirección: advertencia `⚠ sin dirección — fricción #1 del VOC` en cabecera |
| Meta de leads y presupuesto de pauta aprobado | Brief del evento | *"¿Cuál es la meta de leads y el presupuesto aprobado de {evento}?"* Sin meta no hay % de avance ni semáforo de volumen |
| Fecha de inicio de la pauta | Agencia de Ads | Sin ella no se proyecta (no hay % de calendario) |
| Export de Meta Ads: leads, gasto, impresiones **por día y por ad set**, con nombre exacto del ad set | Agencia de Ads | *"Pasame el export diario por ad set, no el acumulado."* Solo acumulado: ninguna acción se emite (gate 2) |
| Registros de Zoho con país de origen | Zoho | Columna `% USA` = `[n/d]`, sin semáforo de composición |
| Fecha del último cambio significativo por ad set | Agencia de Ads | Se asume ad set en aprendizaje: no se recomienda editarlo |

**Modo cierre — por evento** (todo lo del diario, cerrado, más:)

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Corte (T+0, T+30, T+90, T+180) | El usuario | *"¿Qué corte es: T+0, T+30, T+90 o T+180?"* Se pregunta antes de calcular; no se deduce por la fecha |
| Costo total cargado (pauta + producción + logística) | La gerencia `[input]` | Sin él no hay bloque C |
| Asistentes, citas agendadas, SV pagados, operaciones Vive Casas cerradas, leads en gestión | Zoho / consultoras | Cada faltante queda `[n/d]` y lo que depende de él `no emitible` |
| Meta de negocio del evento (SV + Vive Casas) | Brief del evento | Sin ella la columna "Meta evento" queda `[n/d]` |
| Cortes previos ya emitidos | El usuario | Se declara `sin cortes previos` |

## Workflow

### Paso 1 — Identificar modo y corte

1. Leé la invocación. Sin modo → **diario**. "Cierre" sin corte → preguntar el corte y esperar.
2. Cargá solo la referencia del modo: diario → `references/umbrales-diario.md`; cierre →
   `references/cortes-cierre.md`.
3. Listá los eventos en alcance: diario, todos los activos con pauta al aire; cierre, uno solo.

### Paso 2 — Validar inputs y declarar faltantes

1. Recorré las tablas de Input. Por cada faltante, aplicá su columna "si falta" **antes** de
   calcular.
2. Escribí la lista de faltantes con a quién pedírselos; va al pie del output.

### Paso 3 — Modo diario: los 4 gates en cascada

Aplicá `references/umbrales-diario.md` en orden. Una alerta existe solo si pasa los cuatro; lo que
muere en un gate va a **NO SE REPORTA HOY** con su motivo.

1. **Muestra** — n ≥ 30 y desviación > `2/√n`. Si no: `muestra insuficiente`, sin juicio.
2. **Persistencia** — 3 días consecutivos en el mismo sentido, o 4 de 5 del mismo lado, o salto
   > 50 % con n ≥ 30. Un solo día nunca dispara nada. Excepción: entrega en cero (gasto 0 o 0
   impresiones) se reporta de inmediato.
3. **Learning phase** — ad set con < 50 conversiones en 7 días o < 7 días desde el último cambio: no
   se recomienda editarlo. Solo se permite agregar creativo, mover presupuesto a nivel campaña,
   ampliar la ventana de atribución del reporte, o esperar.
4. **Ventana de acción** — por días restantes: > 30 cualquier cambio · 14 a 30 solo presupuesto y
   creativos · 7 a 14 solo presupuesto · < 7 ninguna edición de Meta, solo acciones no-Meta.
   Un borde cae en la banda más restrictiva: 30 → 14-30, 14 → 7-14, 7 → 7-14.

### Paso 4 — Modo diario: proyección y semáforos

1. Proyectá con la curva back-loaded: `leads_proyectados = leads_actuales / %_curva_esperada_hoy`.
   Nunca pacing lineal.
2. Confianza: **alta** (n ≥ 100 y ≥ 50 % del calendario) → punto · **media** (n ≥ 30) → banda
   ± 20 % · **insuficiente** (n < 30 o < 20 % del calendario) → no se proyecta, estado ⚪.
3. Pintá tres semáforos independientes con las tablas de la referencia: volumen, CPL, composición.
   Sin CPL objetivo cargado, el de CPL es ⚪ `sin objetivo` y no genera acciones.
   Nunca se promedian. Con composición 🔴, ninguna acción de volumen puede ser prioridad ALTA.
4. Si un evento está 🟢 en los tres, su recomendación es **no tocar**, y se escribe.

### Paso 5 — Modo cierre: cortes y veredicto

1. Declará el corte en cabecera y qué cortes previos existen.
2. Llená los bloques sin mezclarlos: A adquisición (cerrada en T+0) · B conversión (madura hasta
   T+180) · C eficiencia económica (solo desde T+90).
3. En T+0 y T+30 **no hay veredicto** y están bloqueadas las palabras *fracaso, no funcionó,
   descartar, no rentable*. Si el negocio va bajo meta: *"resultado de negocio parcial — la ventana
   de conversión de este evento cierra el {fecha T+90}"*.
4. En T+90 y T+180 aplicá la matriz de veredicto de `references/cortes-cierre.md`. Un valor justo en
   el límite cae en la banda superior (0.6x → 0.6-1.0x). Si la combinación de retorno y proyección
   no está en la matriz: `veredicto no emitible — combinación fuera de matriz` y se explica cuál es.
5. El veredicto nombra siempre la capa que falló: adquisición, conversión o estructura de costo.
6. Veredicto de plaza solo con ≥ 2 eventos de la misma ciudad con T+90 completo; con uno solo,
   `veredicto de plaza no emitible`. Antes de un 🔴 de plaza, aplicá la salvaguarda de 2x de la
   referencia.
7. Contrastá el costo por SV contra el CAC fully-loaded de eventos ([cifra interna] por cierre) y agendá el
   recierre T+180 con fecha.

### Paso 6 — Las acciones (los dos modos)

1. Máximo 3, priorizadas ALTA / MEDIA / BAJA. Si hay más problemas, decí cuáles quedaron fuera.
2. Cada acción lleva 5 campos: ad set o campaña con nombre exacto · variable que cambia · de X a Y
   con número · a quién se le pide (agencia de Ads, gerencia, producción, consultoras) · fecha de
   verificación. Si falta uno, en lugar de la acción va la pregunta que falta responder.
3. El texto para la agencia va entre comillas, listo para reenviar.
4. "Esperar" es una acción válida: se escribe con la fecha de la próxima revisión.

### Paso 7 — Secciones de disciplina y chequeo

1. Escribí **NO SE REPORTA HOY** (diario), **NO SE RECOMIENDA, aunque aparezca tentador** (1-2
   líneas, los dos modos) y **DATOS QUE FALTAN**.
2. Revisá: toda cifra con etiqueta; CPL con `$/lead` y CAC con `$/cierre`; ninguna proyección con
   n < 30; ninguna acción de un solo día; ≤ 3 acciones con 5 campos. Corregí antes de entregar.

## Reglas duras

- **Nunca pausa, ajusta, aprueba ni publica nada.** Toda acción es un mensaje para un humano.
- **Nunca pone CPL y CAC en la misma tabla** ni sin su unidad (`$/lead`, `$/cierre`).
- **Nunca suma ni promedia** conversión a desembolso ([cifra interna]) y a pago de servicio ([cifra interna]), ni dice
  "la conversión" sin decir cuál. Ingreso SV = n × USD 480; nunca 495.
- **Nunca calcula CPL mezclando universos.** Solo pauta ÷ leads de pauta. Base propia, walk-ins,
  consultoras y referidos van en renglón aparte. Si no se pueden separar: `CPL no emitible —
  universo pagado no separable`; nunca se estima el split.
- **Nunca suma la comisión del asesor al costo del evento**: es cost-to-serve, no CAC.
- **Nunca deja una cifra desnuda**: `[dato]` (Meta/Zoho) · `[proyección]` (la calculó el skill) ·
  `[input]` (la cargó un humano) · `[n/d]` (falta).
- **Nunca declara diferencia entre canales dentro de ± 20 %** de costo por SV: es empate, porque la
  asignación de costo de equipo es declarada, no medida.
- **Nunca rellena un faltante** con supuesto, proxy o estimado. Nunca convierte `[n/d]` en número.
- **Nunca escribe más decimales que el dato**: leads enteros, CPL con 1 decimal como máximo,
  porcentajes enteros.
- **Nunca usa las fórmulas vagas** "optimizar la pauta", "revisar la segmentación", "mejorar el
  creativo", "ajustar la estrategia" como acción.
- **Nunca emite veredicto antes de T+90** ni veredicto de plaza con un solo evento.

## Output esperado

No escribe archivos. Devuelve en la conversación markdown y tablas pegables en Sheets o Slides.

**Modo diario**

```
MONITOR DE EVENTOS ACTIVOS · {día} {fecha} · corte {hora} COT
Fuente: {origen y timestamp del export}
{⚠ campaña lanzada a N días — el CPL no es comparable contra el objetivo · ⚠ sin dirección}

| Evento | Ciudad | Fecha | Días rest. | Leads pauta | Meta | % avance | Curva esperada | CPL actual ($/lead) | CPL obj. | % USA | 🚦 |
Leads no pagados (base, walk-in, consultoras): {n} [dato] — no entran en el CPL

Proyección al día del evento [proyección]
| Evento | Leads proyectados | vs meta | Confianza | Inversión proyectada vs presupuesto |

Lectura en una línea: {2-4 frases: volumen, CPL o composición}

ACCIONES RECOMENDADAS — máximo 3
1. [ALTA] {Evento} — {problema en una frase}
   Qué pasa: {evidencia con etiqueta y n} · A quién: {destinatario}
   Qué pedir, textual: "{mensaje reenviable con ad set, variable y magnitud}"
   Por qué así: {gate que lo justifica} · Verificar el: {fecha}

NO SE REPORTA HOY · NO SE RECOMIENDA, aunque aparezca tentador · DATOS QUE FALTAN
```

Ejemplo de acción (cifras ilustrativas): *"En la campaña de Alicante, bajar el presupuesto diario
del ad set `ALC_ES_Broad_25-55` de USD 180 a USD 60 y mover los USD 120 al ad set
`ALC_US_Colombianos_FL-NJ`. No tocar creativos ni pujas."* — composición 38 % USA contra 85 %, 26
días restantes (gate 4 lo permite), verificar en 4 días.

**Modo cierre**

```
FICHA DE CIERRE · {evento} · evento {fechas}
Corte T+{0|30|90|180} ({fecha}) — {OPERACIÓN | LECTURA PARCIAL | VEREDICTO | RECIERRE}
Cortes previos: {…} · Próximo: T+{n} ({fecha})

A. Adquisición — cerrada desde T+0 [dato]
   leads de pauta · no pagados · composición USA · CPL de pauta ($/lead) · inversión · costo total · asistentes
B. Conversión y negocio a T+{n} [dato] + [proyección]
   SV pagados · ingreso SV = n × USD 480 · operaciones Vive Casas · ingreso Vive Casas [input] · pipeline vivo
C. Eficiencia económica [proyección] — solo desde T+90
   costo por SV ($/cierre) vs CAC loaded eventos [cifra interna] · conversión lead pagado → SV vs [cifra interna] · retorno vs 1.0x
D. VEREDICTO — solo desde T+90 (antes: "Sin veredicto en este corte — resultado de negocio parcial")
   {🟢 REPETIR | 🟠 AJUSTAR | 🔴 NO REPETIR ESTE MODELO} · capa que falló · veredicto de plaza · recierre T+180

Las 3 acciones · NO SE RECOMIENDA · DATOS QUE FALTAN
```

La contradicción que hay que saber decir: CPL mejor que el objetivo y conversión al doble del canal,
y aun así retorno 0.47x a T+90 → 🟠 **AJUSTAR — la capa que falló es la estructura de costo, no la
adquisición**: con SV solos, un CAC de [cifra interna] contra un ticket de USD 480 no se paga.

Al terminar se le dice al usuario: diario → *"Monitor listo: {n} acciones para reenviar, {n}
eventos sin juicio hoy. Faltan {n} datos."*; cierre → *"Ficha T+{n} lista. Próximo corte: T+{n} el
{fecha}."*

## Skills relacionados

- **Antes:** `viventa-brief-evento` (meta, fecha, dirección) y la pauta que arma la agencia con el
  material de `viventa-pack-evento`.
- **Después:** `viventa-guiones-evento` en tanda de optimización, con el rendimiento por ángulo;
  `viventa-caso-exito` cierra la cadena con la prueba social del evento.
- **En vez de este:** `viventa-reporte-campanas` para el área completa; `viventa-forecast-pauta`
  para el gasto del mes.
- **Referencias:** `references/umbrales-diario.md` (gates, curva, semáforos) ·
  `references/cortes-cierre.md` (cortes, bloques, matriz de veredicto).
