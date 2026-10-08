# Anti-patterns — `viventa-kit-referidor`

Cada uno con la razón por la que pasa y el antídoto ejecutable. Consultar cuando un kit generado
"se siente raro" y no está claro por qué.

| # | Anti-pattern | Por qué pasa | Antídoto ejecutable |
|---|---|---|---|
| 1 | **Mensajes que suenan a marca.** El WhatsApp arranca con "En Viventa te acompañamos en cada paso de tu sueño…" | El LLM unifica el tono del documento, y en el prompt hay contexto de marca | Lista negra de vocabulario de marca activa **solo en Bloque C**. Largo máx. 4 líneas. Test del reenvío antes de entregar |
| 2 | **Inventar la comisión.** El correo dice "ganás $300 USD por referido cerrado" | Hay un número plausible flotando en el diagnóstico ($200-$500) y el LLM rellena huecos | El skill **para** si no tiene el documento de incentivos. Placeholders `[MONTO — pendiente de política]` + kit marcado **NO ENVIABLE**. La cifra del diagnóstico está prohibida por nombre en el SKILL.md |
| 3 | **Claims financieros.** Aparece "tasas desde", "cuotas bajas" o "se valoriza" para hacer el flyer más atractivo | Es lo que hace toda la publicidad inmobiliaria colombiana; el training data está lleno | Checklist de salida contra las 7 categorías. Si aparece cualquiera → **bloqueo, no advertencia**. Reg Z: el disclaimer no cura |
| 4 | **Olvidar el disclosure**, o ponerlo solo en uno de los tres mensajes | El disclosure "estorba" a la fluidez que el modelo optimiza | Validación de conteo: 3 mensajes = 3 disclosures. Verificar quién / qué recibo / cuándo en cada uno |
| 5 | **Disclosure en jerga legal.** "El remitente mantiene una relación material con Viventa S.A.S." | Es el registro por defecto para contenido legal | Vocabulario prohibido/permitido tabulado. Primera persona, al final, mismo registro que el resto del mensaje |
| 6 | **Kit genérico intercambiable.** Cambiás nombre y código y sirve para cualquiera | Sin inputs de contexto no hay nada que personalizar | Los 6 inputs son obligatorios. **Test de intercambiabilidad**: si tapás nombre y código y sirve igual → rechazar. Ciudad, relación con Viventa y perfil de audiencia deben aparecer materialmente |
| 7 | **Rellenar los corchetes.** El LLM "ayuda" completando `[LO QUE MÁS TE SIRVIÓ A VOS]` con "el acompañamiento personalizado" | Un output con huecos se siente incompleto | Regla explícita: los corchetes salen **vacíos y visibles**. Es la única parte que el referidor escribe, y es la que lo hace suyo. Además es lo que mueve el skill de "generar" a "editar" — el moderador que atenúa el castigo por autoría IA |
| 8 | **Prometer que el skill arregla el programa.** El kit se entrega sin la advertencia de pagos | Es más cómodo entregar un output limpio | Bloque D obligatorio en **todos** los outputs, incluso en modo escalado |
| 9 | **Empujar a que el referidor mande datos de terceros** en vez del link: "pasame el número de tu primo y yo lo llamo" | Es el flujo que hoy hace Lizeth a mano | Link único como vía primaria en los 3 mensajes. Si se pasan datos, el correo instruye avisar al titular primero (Ley 1581) |
| 10 | **Tres variantes del mismo registro.** Tres mensajes casi iguales con sinónimos distintos | Es el output por defecto de "dame 3 versiones" | Los tres registros están definidos por función: ya-preguntó / frío-cercano / grupo. Canal, largo y apertura distintos |
| 11 | **Perfección sospechosa.** Ortografía impecable, sin muletillas, estructura simétrica | El modelo optimiza pulido | Una imperfección deliberada por mensaje. El efecto de autoría-IA se dispara por **percepción**, no por autoría real |

## Dos anti-patterns adicionales de este cliente

| # | Anti-pattern | Antídoto |
|---|---|---|
| 12 | **Escribir "USA" donde va "USD".** Error real detectado en el flyer de Tampa: *"Reserva desde 280 USA"* | Chequeo de moneda en el checklist. Y ese ejemplo específico además viola la prohibición de cuota inicial: doble error |
| 13 | **Mezclar el benchmark 15-30% de k-factor con el rango público 0,04-0,45.** No son la misma unidad | Nunca presentarlos juntos. Si se cita alguno, va con su `[⚠ no verificado]` |
