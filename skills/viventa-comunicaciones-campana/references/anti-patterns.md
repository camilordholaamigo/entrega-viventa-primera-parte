# Anti-patterns — lo que un LLM hace mal acá, con antídoto

Tabla de gate. Antes de entregar, pasá el paquete por las 14. Cada falla tiene un antídoto
**mecánico**, no una recomendación.

| # | Falla | Cómo se ve | Antídoto (aplicar, no sugerir) |
|---|---|---|---|
| **1** | Cuatro correos que son el mismo con distinto asunto | E1-E4 abren con "¿Sabías que podés comprar vivienda en Colombia?" y repiten los mismos tres beneficios | Cada correo tiene **una P asignada y un argumento propio**. Validación mecánica: **el primer párrafo de un correo no comparte más de 5 palabras significativas con el de otro correo de la misma secuencia** |
| **2** | Asunto que dispara filtros | "🔥 ÚLTIMA OPORTUNIDAD: crédito 100% aprobado GRATIS!!!" | Lista negra de `references/segmentacion-deliverability.md` §2 como gate. Si aparece → **se reescribe**, no se entrega con advertencia |
| **3** | Plantilla corporativa | "Estimado cliente", "Nos complace invitarle", "aliado estratégico", "solución integral", "no dude en contactarnos" | Tuteo colombiano obligatorio. Test: **¿esta frase la diría una asesora de Viventa por teléfono?** Si no, se cae |
| **4** | Omitir la dirección | "Te esperamos en Valencia" · "Estaremos en el sur de la Florida" | **Gate bloqueante.** Sin calle, número, código postal, ciudad + hora de inicio y fin, **no se genera el paquete**. Fricción #1 del VOC, textual: *"no entiendo por qué no pueden decir la ubicación donde van a atender en Miami, solo colocan 28 y 1 pero sin dirección"* |
| **5** | Urgencia falsa | "¡Solo quedan 5 cupos!" con un salón de 200 sillas | Cupos solo si el número es **real y verificado**. Prohibido "última oportunidad" en eventos que se repiten todos los meses. La gente lo nota y erosiona justo la confianza que se está construyendo |
| **6** | Español neutro | "Coordinemos una cita", "diligencia tu formulario", registro mexicano o rioplatense | Español de Colombia, tuteo. Frases cortas. Léxico: "acá", "un abrazo", "sin afán", "hacer la vuelta". Nunca "ustedes" formal a un individuo |
| **7** | WhatsApp escrito como email | 120 palabras, tres párrafos, despedida formal | **Tope duro de 40 palabras, con el conteo impreso al lado de la pieza.** Una sola pregunta. Voz de persona con nombre |
| **8** | Prometer aprobación, tasa o cuota | "Te aprobamos el crédito", "tasas desde el 9%", "sin cuota inicial garantizado" | Prohibido sin validación del área de Crédito (Reg Z). Formulación permitida: *"revisás si calificás"*, *"qué figura aplica a tu caso"*. **"Mi Casa en Colombia" se nombra como programa existente, jamás como aprobación** |
| **9** | Escribirle a los 250K | "Enviar a toda la base" | El paquete **siempre** trae las 3 capas de segmentación explícitas y el conteo estimado. Sin criterio de segmento no hay entregable |
| **10** | Moneda o teléfono cruzados | "Reserva desde 280 USA" en Tampa · una consultora en el evento de **España** con teléfono **+1** | Errores reales de los assets de mayo. **`USD`, nunca "USA".** Moneda y prefijo se derivan del **país del evento**. Gate automático país↔moneda↔prefijo |
| **11** | Un solo correo post-evento para todos | "Gracias a todos los que nos acompañaron" enviado también a los que no fueron | Split obligatorio A/B por asistencia. Sin lista de asistentes → **bloqueante** |
| **12** | Personalización falsa | "Hola [Nombre], como colombiano en [Ciudad]…" con merge tags que no resuelven | Solo campos que existen y están poblados en Zoho. **Un correo sin nombre es mejor que uno que dice "Hola ,"**. La personalización real es de **segmento** (España habla con testimonios de España), no de merge tag |
| **13** | Copiar la cadencia de webinar | 7 correos en 14 días, recordatorio "1 hora antes" | Evento presencial: 1 correo cada **6-8 días** en convocatoria; último toque a las **08:00 del día del evento**, no a la hora de inicio. Quien no salió de la casa a las 9 no sale a las 9:50 |
| **14** | Nombrar el miedo | "No dejes que te estafen", "cuidado con los fraudes inmobiliarios" | **El miedo se desactiva con prueba, no se nombra.** Testimonios literales + 20 años + oficinas físicas + disposición a decir que no. Nombrarlo activa la sospecha |

---

## Por qué el miedo manda acá

En esta categoría no hay tanto dolor como miedo: miedo a **ser
estafado**, a **perder la plata**, a **comprar un inmueble que no es**.

Dos consecuencias de diseño:

1. **El Proof no es el correo débil de la secuencia: es el más importante**, y por eso va **justo
   antes del cierre de registro** (D-4), no enterrado en el medio.
2. **El miedo no se nombra, se desactiva** con lo que no se puede fingir: 20 años, testimonios
   literales con su geografía, oficinas físicas visitables, y la disposición a decir
   *"si hay algo que hoy no te deja avanzar, te lo decimos aunque no nos convenga"*.

## El Deseo, que no es una P

Dolor · Miedo · **Deseo** es la escala emocional; las 4 P son la estructura. El Deseo **no ocupa
correo propio** — se cuela como cierre en todos. Un correo entero de Deseo puro suena a folleto de
constructora y no mueve a nadie a un sábado.

## Frontera con los skills vecinos

| Skill | Qué hace | Diferencia |
|---|---|---|
| `viventa-match-proyecto-lead` | 1-a-1, personalizado por lead | Este es **a segmento** |
| `viventa-reactivacion-lead` | Recupera leads con proceso incompleto | Este **convoca** a un evento nuevo |
| `viventa-pack-evento` | Piezas gráficas y video | Este es **texto de canal directo** |
| `viventa-brief-evento` | Define el ángulo | Este **ejecuta** el ángulo ya definido |
