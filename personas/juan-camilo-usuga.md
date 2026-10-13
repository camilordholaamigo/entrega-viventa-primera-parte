# Juan Camilo Usuga · Especialista en email marketing

Tu kit: **8 skills**. Para instalar solo las tuyas en Claude Code: `./instalar.sh juan-camilo-usuga` (Mac) o `.\instalar.ps1 juan-camilo-usuga` (Windows). En Claude web, sube los `.zip` de [descargas/](../descargas/).

## Lo que nos contaste

Opera la reactivación de leads por varios canales: correo, WhatsApp y SMS para EE. UU., este último todavía en habilitación. Responde por la meta de reactivación y la sigue a diario en un dashboard.

### Tus procesos

| Proceso | Frecuencia | Dónde duele |
|---|---|---|
| Reactivación de leads por correo | diaria | Los correos llegan a spam por problemas del dominio. Eso obliga a revisarlo constantemente y le impide cumplir la meta. |
| Reactivación de leads por WhatsApp | diaria | El ingreso al CRM es manual: existe una integración, pero no ha logrado conectarla. Además hay un límite de envíos según el tamaño de la base, y ese límite se reduce cuando baja la calidad. |
| Diseño, revisión y envío de plantillas de correo y WhatsApp | diaria | La cuenta de Claude es corporativa y compartida, y a veces se queda sin créditos. Entonces hay que esperar unas cuatro horas hasta que se restablezcan. |
| Creación y actualización de plantillas en el CRM | diaria |  |
| Seguimiento de la meta de reactivación | diaria |  |
| Integraciones y soporte técnico del CRM | desconocida | No tiene permisos en el CRM para revisar reglas, asignaciones de candidatos y otros elementos. Esos permisos dependen del área de tecnología. |
| Habilitación de SMS para Estados Unidos | ocasional | El rechazo de la verificación ha generado costos y demoras, y no ha podido cumplir la meta de Estados Unidos. |

### Lo que elegiste mejorar este trimestre

1. Mejorar el diseño y el contenido de las plantillas de correo (del CRM y de la plataforma de email) y limpiar la base actual.
2. Integrar WhatsApp con Zoho CRM para que la reactivación quede registrada directamente y no a mano.
3. Conseguir permisos en el CRM para revisar reglas y asignaciones de candidatos. Depende del área de tecnología.

## Tus skills

| Skill | Para qué | Estado |
|---|---|---|
| [`viventa-qa-marca`](../skills/viventa-qa-marca/SKILL.md) | Pre-filtro de la revisión de marca: revisa una pieza, copy, guion, landing, correo o plantilla de WhatsApp en 5 capas (legal de crédito, cifras, palabras prohibidas, voz, reglas del cliente y del canal), entrega las correcciones redactadas y arma el resumen del día. | Corrida con material real |
| [`viventa-match-proyecto-lead`](../skills/viventa-match-proyecto-lead/SKILL.md) | Con el formulario CC y el resumen de llamada de un lead, propone 2-3 proyectos de Vivehome que le sirven (por propósito, con el preaprobado como techo) y 3 correos para que el asesor apruebe. | Lista · falta primera corrida con datos reales |
| [`viventa-reactivacion-lead`](../skills/viventa-reactivacion-lead/SKILL.md) | Mensajes 1 a 1 para retomar a quien se cayó: formulario a medias, DM sin responder, comentario «info», no-show, asesor sin cierre o frío. En modo lista arma la tanda del día de registros incompletos con el dato que falta y variantes que no se repiten. | Lista · falta primera corrida con datos reales |
| [`viventa-parrilla-base`](../skills/viventa-parrilla-base/SKILL.md) | Sobre el export agregado de la base de Zoho: conteo por microsegmento (fase, engagement, propósito, presupuesto, país, señal de llamada), la parrilla del mes con correos redactados y proyectos de Vivehome sugeridos por segmento, el criterio de paso a comercial y a quién se impacta y a quién no. | Nueva (29-ago) · sin corrida |
| [`viventa-comunicaciones-campana`](../skills/viventa-comunicaciones-campana/SKILL.md) | La convocatoria completa de un evento por email y WhatsApp: 7 correos y 5 mensajes en 21 días, con onboarding por registro y segmentación que protege el dominio. | Lista · falta primera corrida con datos reales |
| [`viventa-mapa-crm`](../skills/viventa-mapa-crm/SKILL.md) | El mapa vivo de las automatizaciones, campos, plantillas y reglas de Zoho que usa mercadeo: qué las dispara, qué hacen y quién es el dueño. Lleva la bitácora de cambios, diagnostica por qué no se disparó una automatización y redacta la solicitud a tecnología con el cambio o permiso exacto. | Nueva (8-oct) · sin corrida |
| [`viventa-puente-wati-zoho`](../skills/viventa-puente-wati-zoho/SKILL.md) | Mientras la integración WATI–Zoho no funcione: toma el export de respuestas de una campaña de WhatsApp, clasifica quién se reactivó, marca duplicados contra Zoho y deja el archivo de carga al CRM con los campos mapeados, más el conteo del día. | Nueva (8-oct) · sin corrida |
| [`viventa-registro-10dlc`](../skills/viventa-registro-10dlc/SKILL.md) | Diagnostica por qué Twilio rechazó el registro 10DLC y rearma el expediente de marca y campaña para enviar SMS a Estados Unidos: caso de uso, mensajes de ejemplo, flujo de consentimiento y lo que tiene que estar publicado en la web. | Nueva (8-oct) · sin corrida |

## Por dónde empezar

1. **`viventa-parrilla-base`** — Con el export agregado de la base (sin datos personales): conteo por segmento y la parrilla del mes con asuntos y CTAs redactados.
2. **`viventa-puente-wati-zoho`** — Con el export de respuestas de WATI: «pasa a Zoho los que respondieron en WATI». Te deja el archivo de carga con duplicados marcados y el conteo del día. Corre en Claude Code.
3. **`viventa-registro-10dlc`** — Con el motivo del rechazo de Twilio: «nos rechazaron otra vez el 10DLC». Te explica el rechazo y rearma el expediente completo.

## Lo que todavía no resolvemos para ti

La integración WATI ↔ Zoho y los permisos del CRM siguen siendo de tecnología, y la entregabilidad del dominio es configuración. Mientras tanto, `viventa-puente-wati-zoho` arma la carga y `viventa-mapa-crm` deja redactada la solicitud.
