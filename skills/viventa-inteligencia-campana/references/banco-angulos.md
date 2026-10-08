# Referencia — Banco de ángulos

Registro persistente + criterios de distinción para `viventa-inteligencia-campana`.

Existe porque hoy cada campaña arranca de cero y "qué ángulos ya usamos" vive en la memoria de
Lizeth. El banco convierte esa memoria en un archivo consultable.

---

## 1. El archivo

**Ruta:** `angulos-usados.md` (en la carpeta de la skill)

Si no existe, el skill lo crea con el encabezado de la tabla y sigue. **No bloquea la pasada.**

**Formato — una línea por ángulo propuesto:**

```
| fecha | territorio | sub-segmento | ángulo (una frase) | hook ganador | CPL | estado |
```

- `fecha` — `YYYY-MM-DD` del día en que se entregó el brief.
- `territorio` — ciudad o condado con nombre propio (`Broward FL`, no `USA`).
- `sub-segmento` — la situación, no la demografía (`vive en Broward, no maneja a Doral`).
- `ángulo` — una frase. Si necesitás dos, son dos ángulos.
- `hook ganador` — se llena **después**, cuando la agencia reporta. Al entregar va `—`.
- `CPL` — se llena después. Al entregar va `—`. **Nunca escribir CAC en esta columna.**
- `estado` — `sin probar` · `activo` · `quemado`.

**Ejemplo de fila:**

```
| 2026-08-06 | Broward FL | vive en Broward, no maneja a Doral | El evento que sí queda cerca de ti | — | — | sin probar |
```

---

## 2. Cómo lo usa el skill

**Antes de proponer (Fase 3):** leer el archivo y **descartar**
- todo lo marcado `quemado`, para ese territorio o para uno equivalente;
- todo lo marcado `activo` con fecha de menos de 30 días.

Lo descartado va al bloque 4 del entregable (**Ángulos a evitar**) con la razón: *"corrido en
Tampa el 12-jul, marcado quemado"*.

**Al entregar (Fase 6):** escribir una línea por cada uno de los 3 ángulos nuevos, estado
`sin probar`. Es un append, no una reescritura del archivo.

---

## 3. El join key — sin esto el banco no sirve

El banco solo se puede cruzar contra el reporte de pauta si el ángulo queda codificado en el
**nombre del anuncio**. Hoy conviven 5 convenciones de naming en un mismo mes, y eso ya rompe
el cruce.

El skill entrega, junto a cada ángulo, el **slug sugerido** para que la agencia lo use al nombrar
el anuncio:

```
VIV_{TERRITORIO}_{AAAAMM}_{ANGULO-SLUG}_{FORMATO}
ej.  VIV_BROWARD_202608_CERCA-DE-TI_9x16
```

Es una sugerencia al brief de la agencia, no una imposición operativa. Pero si no viaja, el CPL
por ángulo nunca se va a poder leer y el banco queda con la columna vacía para siempre.

---

## 4. Test de distinción — los 3 ángulos

Tres ángulos son **genuinamente distintos** solo si pasan las tres preguntas. El resultado del
test se **escribe en el entregable**, no se piensa en silencio.

### Pregunta 1 — ¿Enemigo distinto?
Cada ángulo pelea contra otra cosa: la distancia · la desconfianza · la aritmética.
**Si dos comparten enemigo, son uno solo.**

### Pregunta 2 — ¿Sub-segmento o nivel de awareness distinto?
Si los tres le hablan al mismo Solution Aware del mismo condado, son variantes del mismo ángulo.

### Pregunta 3 — ¿Prueba distinta?
Si los tres se sostienen con "20 años de experiencia", son el mismo ángulo con distinta primera
línea.

**Regla del oficio:** *si dos candidatos comparten el mismo frame y solo difieren en los
primeros 3 segundos, son un ángulo con dos hooks.* Los hooks-variante sirven para explotar un
ángulo ya ganador. Este skill produce **descubrimiento**, no explotación.

**Formato del resultado en el entregable:**

```
Test de distinción — A / B / C
· Enemigos: distancia · desconfianza · aritmética → PASA
· Sub-segmentos: Broward / el que pospone por miedo al "no" / el que piensa en cifras → PASA
· Pruebas: dirección concreta / 5 bancos + garantía / testimonios de recompra → PASA
```

Si alguna línea dice `FALLA`, el ángulo se reemplaza **antes** de entregar. No se entrega con un
FALLA escrito.

---

## 5. Tipos de callout que funcionan

Recordatorio: el ángulo ES el targeting. El callout va en las **primeras 8 palabras** y describe
**una situación, no una demografía**.

| Tipo | Cómo se ve | Por qué funciona |
|---|---|---|
| **Lugar con nombre propio + fricción real** | *"Vives en Broward y todos los eventos son en Miami."* | La persona se reconoce en el hecho |
| **Tiempo transcurrido** | *"Llevas 8 años mandando plata a Colombia."* | Auto-selecciona por historia, no por edad |
| **Frase que ya se dijo a sí misma** | *"'Es que en Colombia todo es robo.'"* | Es un verbatim literal del VOC; imposible de ignorar |

**Torpe:** *"¿Eres colombiano de 35 a 50 años en Florida?"* — es un formulario, y además es
exactamente lo que la Special Ad Category ya no deja segmentar. Nombrar la demografía en el copy
no recupera el targeting perdido: solo suena mal.

---

## 6. Ángulos permanentemente vetados

Estos no entran nunca. Van directo al bloque 4 del entregable si alguien los propone.

| Ángulo vetado | Razón |
|---|---|
| **"Raíces" / "vuelve a tus raíces"** | Saturado en toda la categoría. Los ~8 brokers autorizados por Bancolombia lo usan — Colombia Raíz, Colraíces, Casa Propia Colombia, Casa en Casa, Unión Andina, Interimage, Suvivienda. Se ve hasta en los nombres de marca. No diferencia nada. |
| **"Cumple tu sueño" / "haz realidad tu sueño"** | Genérico, sin enemigo, no auto-selecciona a nadie. En un auction saturado paga el volumen sin traer intención. |
| **Cualquier promesa de aprobación** | Regla durable de marca + riesgo de rechazo con Meta Financial Services. |
| **Tasa, cuota o plazo con cifra** | Triggering terms de Reg Z (12 CFR 1026.24). Mencionar uno obliga a disclosear APR y el resto con igual prominencia, y **un disclaimer no lo cura**. El marketing entrega precio de vivienda; tasa, cuota y plazo los da el asesor en llamada. |
| **Proyección de valorización o rentabilidad garantizada** | Promesa no sostenible. Si Lizeth entrega datos reales de rentabilidad, se enuncian como histórico con fuente, nunca como proyección. |
| **Evento sin dirección concreta** | Reactiva la fricción #1 del VOC. Un evento sin dirección no se anuncia. |
| **"Usá tu VA loan en Colombia"** | Falso. El VA loan no financia propiedad fuera de EE.UU. ni sus territorios. Ver `dolores-y-verbatims.md` §5.1. |

---

## 7. Ángulos semilla — punto de partida, no catálogo

Sirven para arrancar cuando el banco está vacío. **Hay que reanclarlos al territorio y al
verbatim de la campaña concreta antes de usarlos.** Copiarlos tal cual es exactamente el
anti-pattern de "copiar el brief de otra ciudad".

| Ángulo semilla | Enemigo | Prueba | Auto-selecciona a |
|---|---|---|---|
| **El evento que sí queda cerca de ti** | La distancia | Dirección, fecha y hora concretas en el creativo | Quien vive en el condado desatendido |
| **Saber si calificas no te compromete a nada** | El miedo al "no" | Revisión de perfil con 5 bancos + garantía de devolución si no hay aprobación | El que lleva años posponiendo |
| **Tu quincena en dólares rinde distinto allá** | La aritmética mal hecha | Testimonios de recompra (*"Ya tengo 2 y vamos por la 3ra"*) | Quien piensa en cifras, no en emoción |
| **No necesitas venir a Colombia** | La idea de que hay que estar presente | Oficinas físicas en 3 países, proceso a distancia documentado | El que no puede viajar |
| **"Es que en Colombia todo es robo"** | La desconfianza | 20 años, 5 bancos aliados, ~20 constructoras con nombre | El desconfiado que aún así está mirando |
| **Sin un peso ahorrado también arranca** | La creencia de que hace falta la cuota inicial | Programa FNA / "Mi Casa en Colombia" enunciado como programa existente | El que cree que no le alcanza |

Ángulo pendiente de explorar, señalado por Lizeth: **retorno de inversión con la bajada del
dólar**. Ella tiene datos de rentabilidad. Hasta que esos datos entren al skill con fuente y
fecha, el ángulo se enuncia en el bloque 6 como pregunta abierta, no como ángulo.
