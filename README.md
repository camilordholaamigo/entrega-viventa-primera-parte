# Viventa · Skills para Claude — Entrega, primera parte

Las skills de Growth & Marketing de Viventa, construidas a partir de las entrevistas del 3 de agosto de 2026 a las seis personas del área y de la reunión del 29 de julio. Una skill es un manual de trabajo que Claude sigue cuando la tarea lo pide: no es un programa, no se conecta sola a ninguna plataforma y **no le envía nada a nadie**.

## Qué hay en este repositorio

| Carpeta o archivo | Qué tiene |
|---|---|
| [`GLOSARIO.md`](GLOSARIO.md) | **Las 18 skills disponibles**: qué hace cada una, qué le das, qué devuelve, quién la usa y cómo pedirla |
| [`DIAGNOSTICO.md`](DIAGNOSTICO.md) | Las personas, los procesos del área y qué skill cubre cada uno — y lo que falta |
| [`personas/`](personas/) | Una guía por persona: sus procesos, sus skills y por dónde empezar |
| [`skills/`](skills/) | Las 18 skills, cada una con su `SKILL.md` y sus `references/` |
| [`descargas/`](descargas/) | Un `.zip` por skill, listo para subir a Claude |
| [`presentacion/`](presentacion/) | La presentación de la revisión de esta entrega (PDF) |
| `instalar.sh` · `instalar.ps1` | Instalan las skills en Claude Code (Mac o Windows) |

## Por persona

| Persona | Cargo | Skills |
|---|---|---:|
| [Lizeth Henríquez](personas/lizeth-henriquez.md) | Gerente de Growth & Marketing | 14 |
| [Daniel Vélez](personas/daniel-velez.md) | Coordinador de marca | 7 |
| [Alejandra Moreno](personas/alejandra-moreno.md) | Analista de diseño gráfico | 6 |
| [Johana Osorio](personas/johana-osorio.md) | Productora de contenidos (video) | 6 |
| [Manuela Castaño](personas/manuela-castano.md) | Community manager | 6 |
| [Juan Camilo Usuga](personas/juan-camilo-usuga.md) | Especialista en email marketing | 5 |

## Cómo instalarlas

### A. Claude en la web o en la app de escritorio

1. Bajen de [`descargas/`](descargas/) los `.zip` de su guía personal (o los 18).
2. En Claude: **Configuración → Capacidades**. Si está apagada, activen *Ejecución de código y creación de archivos*.
3. En **Skills**, elijan *Subir skill* y seleccionen el `.zip`. Una vez por skill.
4. Listo. Claude la usa sola cuando la tarea coincide con su descripción, y también se puede pedir por nombre: *«usa viventa-qa-marca con esta pieza»*.

Si no aparece la sección Skills, la tiene que habilitar quien administra la cuenta de Claude de Viventa. En los planes de equipo esa persona también puede publicarlas para toda la organización, y así no las sube cada uno.

### B. Claude Code

Desde la carpeta del repositorio:

```powershell
# Windows — las 18, o solo las de una persona
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

## Las 18 skills

El detalle de cada una está en el [glosario](GLOSARIO.md).

**Eventos** — El motor operativo: 3+ eventos al mes, ~5 días de trabajo cada uno.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-brief-evento`](skills/viventa-brief-evento/SKILL.md) | Convierte el pedido suelto de un evento (WhatsApp, correo, nota) en el brief de 1 página que arranca la cadena: modalidad, semáforo de los 45 días, metas y bloqueantes.. | Lizeth, Daniel, Johana, Alejandra | Lista · falta primera corrida con datos reales |
| [`viventa-guiones-evento`](skills/viventa-guiones-evento/SKILL.md) | Escribe los 5 guiones del evento: ángulo, hook de 3 segundos, tiempos, shot list, variantes USD/EUR y voz en off por ciudad y fecha.. | Johana, Daniel | Lista · falta primera corrida con datos reales |
| [`viventa-pack-evento`](skills/viventa-pack-evento/SKILL.md) | Convierte guiones y brief en la matriz de producción: una fila por archivo, copy final, nombre de archivo y el CSV que alimenta las plantillas maestras de Figma.. | Alejandra, Johana | Lista · falta primera corrida con datos reales |
| [`viventa-qa-marca`](skills/viventa-qa-marca/SKILL.md) | Pre-filtro de la revisión de marca: revisa una pieza, copy, guion o landing en 5 capas (legal de crédito, cifras, palabras prohibidas, voz, reglas) y entrega las correcciones redactadas.. | Daniel, Alejandra, Johana, Manuela, Juan, Lizeth | Corrida con material real |
| [`viventa-monitor-evento`](skills/viventa-monitor-evento/SKILL.md) | Tablero diario de los eventos activos (proyección y hasta 3 acciones para la agencia) y ficha de cierre post-mortem: repetir, ajustar o descartar.. | Lizeth | Lista · falta primera corrida con datos reales |

**Requerimientos y aprobación** — Que nada arranque con un pedido incompleto ni se apruebe tres veces.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-brief-requerimiento`](skills/viventa-brief-requerimiento/SKILL.md) | Convierte cualquier pedido que no es evento (campaña, kit comercial, landing, presentación, impreso) en un brief listo para producir, o en máximo 5 preguntas para devolverle al solicitante.. | Alejandra, Daniel, Lizeth | Lista · falta primera corrida con datos reales |

**Inteligencia y dinero** — Saber de qué hablar antes de producir y cuánto se va a gastar antes de que pase.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-inteligencia-campana`](skills/viventa-inteligencia-campana/SKILL.md) | El insight de entrada de una campaña: target, 5-7 dolores con verbatims reales, 3 ángulos y 5 hooks listos para probar. | Lizeth, Daniel, Johana, Manuela | Lista · falta primera corrida con datos reales |
| [`viventa-forecast-pauta`](skills/viventa-forecast-pauta/SKILL.md) | Con los exports de Meta Ads y Zoho Expense dice cuánto va a cerrar el mes en pauta, cuántos días quedan para corregir y qué 3 cosas mover. | Lizeth | Lista · falta primera corrida con datos reales |
| [`viventa-reporte-campanas`](skills/viventa-reporte-campanas/SKILL.md) | Consolida Zoho, Meta, Google, email y GA4 en un reporte de 2 páginas: 3 hallazgos, 3 alertas y 3 recomendaciones con dueño. | Lizeth | Lista · falta primera corrida con datos reales |
| [`viventa-radar-competencia`](skills/viventa-radar-competencia/SKILL.md) | El radar mensual: qué publicaron y pautaron los competidores, benchmark contra el sector y qué se dijo de Viventa. | Lizeth, Daniel, Manuela | Nueva (29-ago) · sin corrida |

**Ciclo de vida del lead** — El canal más barato: email y WhatsApp sobre la base que ya existe.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-match-proyecto-lead`](skills/viventa-match-proyecto-lead/SKILL.md) | Con el formulario CC y el resumen de llamada de un lead, propone 2-3 proyectos de Vivehome que le sirven (por propósito, con el preaprobado como techo) y 3 correos para que el asesor apruebe.. | Lizeth, Juan | Lista · falta primera corrida con datos reales |
| [`viventa-reactivacion-lead`](skills/viventa-reactivacion-lead/SKILL.md) | Mensajes 1 a 1 para retomar a quien se cayó: formulario a medias, DM sin responder, no-show de evento, frío de 3-6 meses. | Manuela, Juan | Lista · falta primera corrida con datos reales |
| [`viventa-ficha-proyecto`](skills/viventa-ficha-proyecto/SKILL.md) | Convierte una fila de Vivehome en la ficha de 1 página de un proyecto, para que comercial la use en llamada y redes la convierta en pieza sin pedirle datos a nadie.. | Manuela, Alejandra | Lista · falta primera corrida con datos reales |
| [`viventa-parrilla-base`](skills/viventa-parrilla-base/SKILL.md) | Sobre el export agregado de la base de Zoho: conteo por segmento (fase × ciudad × inversión × ingresos), la parrilla de envíos del mes redactada y a quién se impacta y a quién no.. | Juan, Lizeth | Nueva (29-ago) · sin corrida |

**Prueba social y comunicaciones** — Casos reales y la convocatoria completa de cada evento.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-caso-exito`](skills/viventa-caso-exito/SKILL.md) | Convierte clientes reales en casos de éxito: la guía de entrevista emocional o, con la entrevista hecha, el caso en 3 actos, un guion de 60-90 s y recortes para piezas.. | Lizeth, Daniel, Johana, Manuela | Lista · falta primera corrida con datos reales |
| [`viventa-comunicaciones-campana`](skills/viventa-comunicaciones-campana/SKILL.md) | La convocatoria completa de un evento por email y WhatsApp: 7 correos y 5 mensajes en 21 días, con onboarding por registro y segmentación que protege el dominio.. | Juan, Lizeth | Lista · falta primera corrida con datos reales |

**Referidores** — Activar y mantener vivos a los aliados que refieren clientes.

| Skill | Para qué | Quién | Estado |
|---|---|---|---|
| [`viventa-kit-referidor`](skills/viventa-kit-referidor/SKILL.md) | El kit de activación de un Referidor Pro: texto del flyer, correo de bienvenida y 3 mensajes reenviables en la voz del referidor. | Lizeth, Alejandra | Funciona sin montos · falta documento del programa |
| [`viventa-ciclo-referidor`](skills/viventa-ciclo-referidor/SKILL.md) | Lo que pasa después de activar al referidor: su parrilla mensual, 3 correos para reactivarlo cuando deja de referir y el correo de resultados del consultor.. | Lizeth | Funciona sin montos · falta documento del programa |

## Skills que se encadenan

En esta parte se corren paso a paso: se le pide a Claude la primera y, con su resultado, la siguiente.

- **Evento completo:** `brief-evento` → `guiones-evento` → `pack-evento` → `qa-marca`. Del WhatsApp de comercial al pack revisado. El ciclo de ~5 días que se repite 3+ veces al mes.
- **Cierre de evento:** `monitor-evento` → `forecast-pauta` → `reporte-campanas`. Si el evento valió la pena y qué significó para el presupuesto. Hoy ese cierre no existe.
- **Campaña con insight:** `brief-requerimiento` → `inteligencia-campana` → `qa-marca`. La fase de inteligencia antes de producir, la que hoy se salta por afán.
- **Lead caliente:** `ficha-proyecto` → `match-proyecto-lead` → `reactivacion-lead`. El canal más barato: email y WhatsApp sobre la base que ya existe.

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
- **Salvo `viventa-qa-marca`, ninguna se ha corrido todavía con datos reales de ustedes.** Esta parte es para eso: lo que salga mal o raro, nos lo cuentan y lo ajustamos.
- **Cada skill dice lo que todavía es supuesto** (umbrales, tiempos, criterios). Vale la pena leer esa sección antes de la primera corrida.
- **`viventa-kit-referidor` y `viventa-ciclo-referidor` escriben sin montos de incentivo** hasta que tengamos el documento vigente del programa Referidores Pro. Es a propósito: preferimos un espacio en blanco declarado a un número inventado.
- **Las skills redactan, no envían.** Los correos, mensajes de WhatsApp y piezas los aprueba y los sube una persona.

## Lo que necesitamos de ustedes

1. **El documento vigente del programa Referidores Pro** (incentivos, montos, momento de pago). Destraba dos skills completas.
2. **El valor por operación de Vive Casas.** Sin ese dato nadie puede decir si un evento gana o pierde plata.
3. **¿Son 4 bancos o 5?** Las piezas muestran cuatro logos y el material dice cinco.
4. **Cómo etiqueta Zoho el origen del lead.** De eso depende separar pagado de orgánico en el reporte de campañas.
5. **Un export real de Meta Ads y de Zoho Expense** para la primera corrida de `viventa-forecast-pauta`.

---

Entrega preparada por ensō · 7 de octubre de 2026.
