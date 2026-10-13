# Viventa · Skills para Claude — Entrega, primera parte

Las skills de Growth & Marketing de Viventa, construidas a partir de las entrevistas del 3 de agosto de 2026 a las seis personas del área y de la reunión del 29 de julio. Una skill es un manual de trabajo que Claude sigue cuando la tarea lo pide: no es un programa, no se conecta sola a ninguna plataforma y **no le envía nada a nadie**.

> **Actualizada el 13 de octubre de 2026:** suma las 10 skills nuevas y los 8 ajustes que salieron de la revisión del 7 de octubre, y lleva las 18 anteriores a su última versión. Si ya instalaron alguna, vuelvan a subirla: la versión nueva reemplaza a la anterior.

## Qué hay en este repositorio

| Carpeta o archivo | Qué tiene |
|---|---|
| [`GLOSARIO.md`](GLOSARIO.md) | **Las 28 skills disponibles**: qué hace cada una, qué le das, qué devuelve, quién la usa y cómo pedirla |
| [`DIAGNOSTICO.md`](DIAGNOSTICO.md) | Las personas, los procesos del área y qué skill cubre cada uno — y lo que falta |
| [`personas/`](personas/) | Una guía por persona: sus procesos, sus skills y por dónde empezar |
| [`skills/`](skills/) | Las 28 skills, cada una con su `SKILL.md` y sus `references/` |
| [`descargas/`](descargas/) | Un `.zip` por skill, listo para subir a Claude |
| [`presentacion/`](presentacion/) | La presentación de la entrega, con las 28 skills (PDF) |
| `instalar.sh` · `instalar.ps1` | Instalan las skills en Claude Code (Mac o Windows) |

## Por persona

| Persona | Cargo | Skills |
|---|---|---:|
| [Lizeth Henríquez](personas/lizeth-henriquez.md) | Gerente de Growth & Marketing | 18 |
| [Daniel Vélez](personas/daniel-velez.md) | Coordinador de marca | 10 |
| [Alejandra Moreno](personas/alejandra-moreno.md) | Analista de diseño gráfico | 8 |
| [Johana Osorio](personas/johana-osorio.md) | Productora de contenidos (video) | 8 |
| [Manuela Castaño](personas/manuela-castano.md) | Community manager | 7 |
| [Juan Camilo Usuga](personas/juan-camilo-usuga.md) | Especialista en email marketing | 8 |

## Cómo instalarlas

### A. Claude en la web o en la app de escritorio

1. Bajen de [`descargas/`](descargas/) los `.zip` de su guía personal (o los 28).
2. En Claude: **Configuración → Capacidades**. Si está apagada, activen *Ejecución de código y creación de archivos*.
3. En **Skills**, elijan *Subir skill* y seleccionen el `.zip`. Una vez por skill.
4. Listo. Claude la usa sola cuando la tarea coincide con su descripción, y también se puede pedir por nombre: *«usa viventa-qa-marca con esta pieza»*.

Si no aparece la sección Skills, la tiene que habilitar quien administra la cuenta de Claude de Viventa. En los planes de equipo esa persona también puede publicarlas para toda la organización, y así no las sube cada uno.

### B. Claude Code

Desde la carpeta del repositorio:

```powershell
# Windows — las 28, o solo las de una persona
powershell -ExecutionPolicy Bypass -File .\instalar.ps1
powershell -ExecutionPolicy Bypass -File .\instalar.ps1 lizeth-henriquez
```

```bash
# Mac o Linux
./instalar.sh
./instalar.sh daniel-velez
```

Copia las skills a `~/.claude/skills`. Después, reinicien Claude Code.

### C. El repositorio completo

En GitHub, **Code → Download ZIP**, o `git clone`.

> ⚠️ **Antes de usarlas: qué cuenta de Claude.** En las entrevistas nos contaron que la cuenta de Claude es compartida y a veces se queda sin créditos (hasta 4 horas de espera). Por eso todas las skills están hechas para resolver en **una sola pasada**, sin investigaciones largas. Aun así, si la cuenta se agota a mitad de semana, ninguna skill se puede usar: vale la pena revisar el plan antes de abrirlas a todo el equipo.

## Las 28 skills

El detalle de cada una está en el [glosario](GLOSARIO.md).

**Eventos** — El motor operativo: 3+ eventos al mes, ~5 días de trabajo cada uno, y los eventos con aliados.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-brief-evento`](skills/viventa-brief-evento/SKILL.md) | Convierte el pedido suelto de un evento (WhatsApp, correo, nota) en el brief de 1 página que arranca la cadena: ficha, semáforo de los 45 días, metas con su supuesto, tamaño del pack y bloqueantes.. | Lizeth, Daniel, Johana, Alejandra | Lista · falta primera corrida con datos reales |
| [`viventa-guiones-evento`](skills/viventa-guiones-evento/SKILL.md) | Escribe los 5 guiones del evento: ángulo, hook de 3 segundos, tiempos, shot list, variantes USD/EUR y voz en off por ciudad y fecha.. | Johana, Daniel | Lista · falta primera corrida con datos reales |
| [`viventa-pack-evento`](skills/viventa-pack-evento/SKILL.md) | Convierte guiones y brief en la matriz de producción: una fila por archivo, copy final, nombre de archivo y el CSV que alimenta las plantillas maestras de Figma.. | Alejandra, Johana | Lista · falta primera corrida con datos reales |
| [`viventa-qa-marca`](skills/viventa-qa-marca/SKILL.md) | Pre-filtro de la revisión de marca: revisa una pieza, copy, guion, landing, correo o plantilla de WhatsApp en 5 capas (legal de crédito, cifras, palabras prohibidas, voz, reglas del cliente y del canal), entrega las correcciones redactadas y arma el resumen del día.. | Daniel, Alejandra, Johana, Manuela, Juan, Lizeth | Corrida con material real |
| [`viventa-monitor-evento`](skills/viventa-monitor-evento/SKILL.md) | Tablero diario de los eventos activos (proyección y hasta 3 acciones para la agencia) y ficha de cierre post-mortem: repetir, ajustar o descartar.. | Lizeth | Lista · falta primera corrida con datos reales |
| [`viventa-evento-aliado`](skills/viventa-evento-aliado/SKILL.md) | El runbook de un evento con aliados (networking con constructoras, taller o webinar con negocios o consulados, punto de activación): cronograma inverso de 4 a 6 semanas, responsables, checklist logístico, quién presenta qué, piezas en formato brief y seguimiento con meta de registros.. | Daniel, Lizeth | Nueva (8-oct) · sin corrida |

**Producción de piezas y video** — Del brief al archivo: el equipo pasa de producir desde cero a ajustar y aprobar.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-corte-video-pauta`](skills/viventa-corte-video-pauta/SKILL.md) | Arma el primer corte de los videos de pauta a partir del material grabado: elige la mejor toma de cada línea del guion, quita silencios, quema subtítulos y exporta en 9:16, 4:5 y 1:1 con la lista de decisiones de edición.. | Johana | Nueva (8-oct) · sin corrida |
| [`viventa-piezas-figma`](skills/viventa-piezas-figma/SKILL.md) | Produce en Figma el primer borrador de cada formato de un brief (feed, historia, carrusel, estático de pauta, correo, landing, impreso) con la librería de componentes y el manual de la marca, listo para que diseño ajuste y apruebe.. | Alejandra, Daniel | Nueva (8-oct) · sin corrida |
| [`viventa-versionador-piezas`](skills/viventa-versionador-piezas/SKILL.md) | Saca todas las versiones de una pieza maestra (flyer, video de primera etapa, carrusel, estática o pieza de proyecto) desde una tabla de datos variables (evento, ciudad, país, fecha, consultora, proyecto, precio) y verifica dato por dato.. | Johana, Alejandra | Nueva (8-oct) · sin corrida |

**Requerimientos y aprobación** — Que nada arranque con un pedido incompleto ni se apruebe tres veces.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-brief-requerimiento`](skills/viventa-brief-requerimiento/SKILL.md) | Convierte cualquier pedido a mercadeo (campaña 360, reel, landing, material comercial, impreso o pieza extra de un evento) en el formato único de brief, con aprobadores, plazos y cada dato con su fuente, o en máximo 5 preguntas para devolverle al solicitante.. | Alejandra, Daniel, Lizeth | Lista · falta primera corrida con datos reales |

**Inteligencia y dinero** — Saber de qué hablar antes de producir y cuánto se va a gastar antes de que pase.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-inteligencia-campana`](skills/viventa-inteligencia-campana/SKILL.md) | El insight de entrada de una campaña: target, dolores con verbatims y señales frescas (comentarios, llamadas, Instagram y TikTok), 3 ángulos y 5 hooks; y, si se pide, el brief creativo con el paquete estándar de piezas o el set de optimización.. | Lizeth, Daniel, Johana, Manuela | Lista · falta primera corrida con datos reales |
| [`viventa-forecast-pauta`](skills/viventa-forecast-pauta/SKILL.md) | Con los exports de Meta Ads, Zoho Expense y tarjetas corporativas proyecta cuánto va a cerrar el mes la pauta y todo el presupuesto de mercadeo por campaña y rubro, cuántos días quedan para corregir y, cuando llega la contabilidad, concilia. | Lizeth | Lista · falta primera corrida con datos reales |
| [`viventa-reporte-campanas`](skills/viventa-reporte-campanas/SKILL.md) | Consolida Zoho, Meta, Google, email, GA4 y los paneles de metas en un reporte de 2 páginas: meta contra real por proceso (reactivación, orgánico, pauta, referidos), 3 hallazgos, 3 alertas y 3 recomendaciones con dueño. | Lizeth | Lista · falta primera corrida con datos reales |
| [`viventa-radar-competencia`](skills/viventa-radar-competencia/SKILL.md) | El radar mensual: qué publicaron y pautaron los competidores, benchmark contra el sector y qué se dijo de Viventa. | Lizeth, Daniel, Manuela | Nueva (29-ago) · sin corrida |

**Ciclo de vida del lead** — El canal más barato: email y WhatsApp sobre la base que ya existe.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-match-proyecto-lead`](skills/viventa-match-proyecto-lead/SKILL.md) | Con el formulario CC y el resumen de llamada de un lead, propone 2-3 proyectos de Vivehome que le sirven (por propósito, con el preaprobado como techo) y 3 correos para que el asesor apruebe.. | Lizeth, Juan | Lista · falta primera corrida con datos reales |
| [`viventa-reactivacion-lead`](skills/viventa-reactivacion-lead/SKILL.md) | Mensajes 1 a 1 para retomar a quien se cayó: formulario a medias, DM sin responder, comentario «info», no-show, asesor sin cierre o frío. | Manuela, Juan | Lista · falta primera corrida con datos reales |
| [`viventa-ficha-proyecto`](skills/viventa-ficha-proyecto/SKILL.md) | Convierte una fila de Vivehome en la ficha de 1 página de un proyecto, para que comercial la use en llamada y redes la convierta en pieza sin pedirle datos a nadie.. | Manuela, Alejandra | Lista · falta primera corrida con datos reales |
| [`viventa-parrilla-base`](skills/viventa-parrilla-base/SKILL.md) | Sobre el export agregado de la base de Zoho: conteo por microsegmento (fase, engagement, propósito, presupuesto, país, señal de llamada), la parrilla del mes con correos redactados y proyectos de Vivehome sugeridos por segmento, el criterio de paso a comercial y a quién se impacta y a quién no.. | Juan, Lizeth | Nueva (29-ago) · sin corrida |

**Prueba social y comunicaciones** — Casos reales, cifras que se pueden publicar y la convocatoria completa de cada evento.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-caso-exito`](skills/viventa-caso-exito/SKILL.md) | Convierte clientes reales en casos de éxito: la guía de entrevista emocional o, con la entrevista hecha, el caso en 3 actos, un guion de 60-90 s y recortes para piezas.. | Lizeth, Daniel, Johana, Manuela | Lista · falta primera corrida con datos reales |
| [`viventa-datos-publicables`](skills/viventa-datos-publicables/SKILL.md) | La hoja mensual de datos comerciales y de proyectos que se pueden publicar (viviendas vendidas, negocios cerrados, precios y disponibilidad): cada dato con fuente, fecha de corte, vigencia, quién lo aprobó y para qué sirve. | Manuela, Lizeth | Nueva (8-oct) · sin corrida |
| [`viventa-comunicaciones-campana`](skills/viventa-comunicaciones-campana/SKILL.md) | La convocatoria completa de un evento por email y WhatsApp: 7 correos y 5 mensajes en 21 días, con onboarding por registro y segmentación que protege el dominio.. | Juan, Lizeth | Lista · falta primera corrida con datos reales |

**Referidores** — Activar, mantener vivos y pagar a tiempo a los aliados que refieren clientes.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-kit-referidor`](skills/viventa-kit-referidor/SKILL.md) | El alta de un Referidor Pro: texto del flyer, correo de bienvenida, 3 mensajes reenviables en su voz y el alta operativa: código, link con seguimiento, pedido de regla de asignación a comercial y tarea de seguimiento en el CRM.. | Lizeth, Alejandra | Funciona sin montos · falta documento del programa |
| [`viventa-ciclo-referidor`](skills/viventa-ciclo-referidor/SKILL.md) | Lo que pasa después de activar al referidor: su parrilla mensual, 3 correos para reactivarlo cuando deja de referir y el correo de resultados del consultor.. | Lizeth | Funciona sin montos · falta documento del programa |
| [`viventa-conciliacion-referidos`](skills/viventa-conciliacion-referidos/SKILL.md) | Cruza referidos, cierres y pagos de los programas de referidos con los exports de Zoho: a quién se le debe, desde cuándo y por qué no se creó la tarea de pago, con causa probable, acción y responsable por caso.. | Lizeth | Nueva (8-oct) · sin corrida |

**CRM, canales y compras** — Lo que hoy se hace a mano entre plataformas, con la evidencia para pedirle el arreglo a tecnología.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-mapa-crm`](skills/viventa-mapa-crm/SKILL.md) | El mapa vivo de las automatizaciones, campos, plantillas y reglas de Zoho que usa mercadeo: qué las dispara, qué hacen y quién es el dueño. | Lizeth, Juan | Nueva (8-oct) · sin corrida |
| [`viventa-puente-wati-zoho`](skills/viventa-puente-wati-zoho/SKILL.md) | Mientras la integración WATI–Zoho no funcione: toma el export de respuestas de una campaña de WhatsApp, clasifica quién se reactivó, marca duplicados contra Zoho y deja el archivo de carga al CRM con los campos mapeados, más el conteo del día.. | Juan | Nueva (8-oct) · sin corrida |
| [`viventa-registro-10dlc`](skills/viventa-registro-10dlc/SKILL.md) | Diagnostica por qué Twilio rechazó el registro 10DLC y rearma el expediente de marca y campaña para enviar SMS a Estados Unidos: caso de uso, mensajes de ejemplo, flujo de consentimiento y lo que tiene que estar publicado en la web.. | Juan | Nueva (8-oct) · sin corrida |
| [`viventa-compra-merchandising`](skills/viventa-compra-merchandising/SKILL.md) | Ordena una compra de merchandising: compara las cotizaciones en una sola tabla (precio unitario y total, entrega, calidad de la muestra, condiciones), lleva el estado de las muestras y arma el memo de aprobación para la dirección financiera con una recomendación.. | Daniel | Nueva (8-oct) · sin corrida |

## Skills que se encadenan

En esta parte se corren paso a paso: se le pide a Claude la primera y, con su resultado, la siguiente.

- **Evento completo:** `brief-evento` → `guiones-evento` → `pack-evento` → `qa-marca`. Del WhatsApp de comercial al pack revisado. El ciclo de ~5 días que se repite 3+ veces al mes.
- **Video de pauta:** `guiones-evento` → `corte-video-pauta` → `versionador-piezas` → `qa-marca`. De los guiones al primer corte y a las versiones por ciudad, revisadas antes de pasar a pauta.
- **Piezas gráficas:** `brief-requerimiento` → `piezas-figma` → `versionador-piezas` → `qa-marca`. Del pedido al borrador en Figma y a todas sus versiones: diseño ajusta y aprueba en vez de producir desde cero.
- **Cierre de evento:** `monitor-evento` → `forecast-pauta` → `reporte-campanas`. Si el evento valió la pena y qué significó para el presupuesto. Hoy ese cierre no existe.
- **Campaña con insight:** `brief-requerimiento` → `inteligencia-campana` → `qa-marca`. La fase de inteligencia antes de producir, la que hoy se salta por afán.
- **Lead caliente:** `ficha-proyecto` → `match-proyecto-lead` → `reactivacion-lead`. El canal más barato: email y WhatsApp sobre la base que ya existe.
- **Reactivación por WhatsApp:** `reactivacion-lead` → `puente-wati-zoho` → `reporte-campanas`. Los mensajes, la carga al CRM de los que respondieron y el conteo contra la meta.
- **Referidores al día:** `kit-referidor` → `conciliacion-referidos` → `mapa-crm`. Del alta al pago: qué se le debe a cada referidor, por qué no se creó la tarea de pago y qué pedirle a tecnología.

## Reglas que respetan todas

Salen textualmente de sus entrevistas y son límites que el equipo puso:

1. **Ninguna campaña sale al aire sin revisión humana.** Ninguna skill publica, lanza ni activa pauta: todas terminan en un entregable para aprobar.
2. **La dirección creativa no se delega a la IA.** Las skills producen ejecución y variantes; el concepto lo define el equipo de marca.
3. **Los datos personales de los clientes no se tocan.** Ninguna skill pide, mueve ni exporta teléfonos, correos o nombres de clientes: trabajan con atributos y conteos.
4. **La estrategia de marca, el arquetipo, el pitch comercial y la propuesta de valor son confidenciales.** Se usan como insumo interno y nunca se reproducen en algo que salga de la empresa.
5. **Nada de aprobar gasto.** El forecast alerta y recomienda; pausar o recortar pauta lo decide una persona con aprobación de la dirección financiera.

Y una de comunicación: el material de marketing habla de **precio de vivienda**, nunca de tasa, cuota o plazo (en Estados Unidos mencionar uno obliga a publicar todos los términos del crédito). Eso lo da el asesor en la llamada.

## Lo que hay que saber

- **Este repositorio es público, así que no lleva datos internos de Viventa.** En cada skill, `references/cifras-canonicas.md`, `references/contexto-viventa.md` y `references/voice-of-customer-90d.md` traen solo un aviso, las cifras internas (CAC, revenue, funnel, comisiones) aparecen como `[cifra interna]` y las cuentas de clientes, como `@cliente`. La versión completa de esos tres archivos se la pasamos por un canal privado: se copian en `references/` con el mismo nombre. Mientras no estén, la skill marca esos datos como `⚠ VERIFICAR` y no los inventa.
- **Cuatro skills hacen más con Claude Code o con el conector de Figma.** `viventa-corte-video-pauta` corre en Claude Code con ffmpeg (en el chat solo da la lista de decisiones de edición) y `viventa-puente-wati-zoho` procesa los exports en el computador, también en Claude Code. `viventa-piezas-figma` y `viventa-versionador-piezas` necesitan el conector de Figma; sin él entregan la especificación o el CSV para armarlo a mano. Las demás funcionan igual en la web, en la app y en Claude Code.
- **Las que guardan archivos los dejan en `salidas/<nombre-de-la-skill>/`** dentro de la carpeta donde se trabaja. En Claude web los entregan para descargar.
- **Salvo `viventa-qa-marca`, ninguna se ha corrido todavía con datos reales de ustedes**, tampoco las 10 nuevas. Esta parte es para eso: lo que salga mal o raro, nos lo cuentan y lo ajustamos.
- **Cada skill dice lo que todavía es supuesto** (umbrales, tiempos, criterios). Vale la pena leer esa sección antes de la primera corrida.
- **`viventa-kit-referidor` y `viventa-ciclo-referidor` escriben sin montos de incentivo** hasta que tengamos el documento vigente del programa Referidores Pro. Es a propósito: preferimos un espacio en blanco declarado a un número inventado.
- **Las skills redactan, no envían.** Los correos, mensajes de WhatsApp y piezas los aprueba y los sube una persona.

## Lo que necesitamos de ustedes

1. **El documento vigente del programa Referidores Pro** (incentivos, montos, momento de pago). Destraba dos skills completas.
2. **El valor por operación de Vive Casas.** Sin ese dato nadie puede decir si un evento gana o pierde plata.
3. **¿Son 4 bancos o 5?** Las piezas muestran cuatro logos y el material dice cinco.
4. **Cómo etiqueta Zoho el origen del lead.** De eso depende separar pagado de orgánico en el reporte de campañas.
5. **Un export real de Meta Ads y de Zoho Expense** para la primera corrida de `viventa-forecast-pauta`.
6. **El conector de Figma habilitado en la cuenta de Claude** para `viventa-piezas-figma` y `viventa-versionador-piezas`, con la librería de componentes de la marca compartida.

---

Entrega preparada por ensō · 13 de octubre de 2026.
