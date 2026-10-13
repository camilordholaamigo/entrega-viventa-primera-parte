# Localización por territorio y antipatrones

## Prioridad 1 — obligatorio, bloquea la pieza

| Elemento | Regla |
|---|---|
| **Dirección física completa** | Calle, número, código postal, ciudad, estado/provincia + nombre del venue. En **toda** pieza: flyer, cierre de video, último slide de cada carrusel, estáticas. Es la fricción #1 del VOC, mencionada 3×: *"No entiendo por qué no pueden decir la ubicación donde van atender en Miami solo colocan 28 y 1 pero sin direccion"*. **Sin dirección, la fila no se genera.** |
| **Moneda** | Derivada del país. USA/Canadá → USD · España/Francia → EUR · Reino Unido → GBP. Se escribe **USD/EUR/GBP**, nunca "USA" (error real en el flyer de Tampa: *"Reserva desde 280 USA."*). El monto viene del input; **nunca se convierte automáticamente entre monedas** |
| **Fecha + horario** | Formato Colombia: "30 y 31 de mayo · 10:00 a.m. – 7:00 p.m." Si el evento es de 2 días, ambos días en toda pieza. Hora **local del evento**, nunca hora Colombia |
| **"Evento exclusivo para colombianos en {país}"** | Copy real del flyer. Cambia solo el país |

## Prioridad 2 — cambia el rendimiento, se adapta si hay insumo

Al menos **uno** de estos tiene que estar. Si no hay ninguno, la matriz se marca
`LOCALIZACIÓN SUPERFICIAL — revisar`.

- **Prueba social local.** Un testimonio de alguien que compró desde esa ciudad vale más que uno
  genérico. Tampa ya lo hace bien (`TESTIMONIOS OSCAR Y JENNY`, `Ana testimonio`,
  `Chela testimonio`). Si el input trae un testimonio de la ciudad, entra; si no, se usa el
  genérico y se marca como **oportunidad**.
- **Referencia de origen del comprador.** El VOC muestra demanda por **Pereira, Cali, Pasto,
  Bucaramanga, Ibagué, Cartagena** — no solo Medellín/Bogotá. Si la ciudad de destino tiene una
  colonia dominante conocida, nombrar la ciudad **colombiana** es más potente que nombrar la
  ciudad extranjera.
- **Sub-segmento no atendido.** Si el evento es en USA, hay dos preguntas repetidas en
  comentarios que hoy nadie responde en pieza: **VA loan para veteranos** e **ITIN sin
  documentación tradicional**. Un carrusel de 5 slides que las nombre es localización real.
  **Ojo:** se nombran como **pregunta** ("¿Eres veterano y tienes un VA loan? Ven y te decimos
  qué aplica en tu caso"), nunca como afirmación de cobertura — eso requiere visto bueno de
  Crédito. `[⚠ no verificado]` la cobertura real de VA loan, ITIN, vivienda usada, Puerto Rico
  y Canadá: el VOC prueba que **preguntan**, no que Viventa lo ofrezca.
- **Modalidad.** *ExpoColombia* (hotel, escala) admite headline de escala. *Viventa Más Cerca de
  Ti* (punto de información propuesto por la consultora) es de proximidad.

## Contexto: por qué la localización cosmética no sirve

El fracaso documentado se llama **"Latino coating"**: meter una persona latina o unas palabras
en español sin adaptar nada más se lee como performativo. El contra-ejemplo es Target
*"Sin Traducción"*, construido sobre el insight de la biculturalidad y no sobre traducción.

> **Honestidad:** `[⚠ no verificado]` no existe publicado un test controlado que aísle "cambiar
> solo el nombre de la ciudad" vs. control. Es un vacío real de la literatura. La jerarquía de
> arriba es un juicio de diseño anclado en el Voice of Customer de Viventa, no en un benchmark.

---

## Antipatrones con antídoto

| # | Falla típica | Por qué duele en Viventa | Antídoto |
|---|---|---|---|
| 1 | **Matriz con placeholders** — `[ciudad]`, `[fecha]` | La diseñadora tiene que completar 57 archivos a mano. El skill no ahorró nada | **Ningún corchete en la salida.** Si falta un dato obligatorio, emitir bloque `INPUTS REQUERIDOS` y no producir la matriz. Ese bloque es un output válido |
| 2 | **Localización cosmética** — cambiar "Miami" por "Tampa" | Es exactamente el gap que declaró la gerencia. Meta puede leer variantes estructuralmente similares como el mismo concepto para fatiga | Capa local con **6 campos obligatorios** + **al menos 1 elemento de prioridad 2**. Si no hay ninguno → `LOCALIZACIÓN SUPERFICIAL — revisar` |
| 3 | **Inventar la conversión de moneda** | Publicar "desde 280 EUR" en Tampa, o convertir 280 USD → 258 EUR con una tasa inventada | Moneda **derivada del país** por tabla fija. Monto **siempre del input**. Cero conversión automática |
| 4 | **Sobreproducción** — 40 filas de video "por si acaso" | Una sola editora, 3+ eventos/mes, cuentas de IA con límite. Una matriz de 200 filas no se ejecuta | Tope duro: **5 conceptos de video, 3 carruseles, 2 estáticas**. Si el input pide más, advertir y pedir priorizar |
| 5 | **Ignorar límites de caracteres y safe zones** | El copy se corta en "ver más" justo antes de la dirección. El CTA queda debajo de la UI de Reels | Cada celda de copy Meta lleva su conteo. Notas de composición con la regla 14/35/6 en toda fila 9:16 |
| 6 | **Traducir al inglés/francés en Londres y París** | La audiencia es colombiana migrante. El inglés rompe la conexión | **Español de Colombia en todos los territorios**, congelado |
| 7 | **Inventar precios, tasas o condiciones de crédito** | Riesgo regulatorio y contradicción con Crédito | Lista blanca: solo cifras presentes en el input o en el máster aprobado. Cualquier otra → INPUT REQUERIDO |
| 8 | **Un nombre de archivo distinto en cada fila** | Se pierde el join key entre pieza y reporte de pauta. Ya está pasando | Convención única emitida por el skill, versión de dos dígitos |
| 9 | **Generar la matriz sin dirección "porque todavía no la confirman"** | Fricción #1 del VOC, mencionada 3× | **La dirección es gate bloqueante.** Sin ella solo se emite el bloque de INPUTS REQUERIDOS |
| 10 | **Decir "listo para publicar"** | Regla durable #1 del CONTEXT: ninguna campaña sale al aire sin revisión humana | Cierre con `APROBACIÓN DE MARCA: pendiente — aprobador de marca`. El skill **nunca** publica, sube ni activa |
| 11 | **Redactar el mismo copy dos veces para 9:16 y 1:1** | Duplica la salida, y las dos versiones divergen con las correcciones | `COPY_ID` compartido. La fila del segundo formato referencia, no repite |
| 12 | **Empezar a redactar sin verificar el margen de 45 días** | La pauta necesita 45 días para pasar aprendizaje y llegar a CPL sano | Primera línea de la salida: días hasta el evento + advertencia si son < 45. **Advierte, no bloquea** |

---

## La aritmética honesta

```
ARCHIVOS  = (5 guiones × 2 formatos)
          + (3 carruseles × ~5 slides × 2 formatos)
          + (2 estáticas × 2 formatos)
          + 1 flyer general A3
          + (3 superficies × N consultoras)

COPY      = 5 (video) + 3 (carruseles) + 2 (estáticas) + 1 (flyer) + N (bloques de contacto)
```

Medición real: **ExpoColombia Tampa (N=4) = 57 archivos, 15 unidades de copy** con la fórmula de arriba (la VO va dentro de cada unidad de video).
Alicante (N=3): ~13 piezas comerciales + Meta. París (N=2): 6 piezas por consultora.

El trabajo intelectual está en las 15 — ahí se van los 2-3 días. Los otros 42 son export y merge.
