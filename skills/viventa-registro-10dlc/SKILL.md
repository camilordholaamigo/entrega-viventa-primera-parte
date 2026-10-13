---
name: viventa-registro-10dlc
description: >-
  Diagnostica por qué Twilio rechazó el registro 10DLC de Viventa y rearma el expediente de marca y
  campaña para enviar SMS a EE. UU.: caso de uso, descripción, mensajes de ejemplo, flujo de
  consentimiento y lo que tiene que estar publicado en la web (consentimiento, privacidad, términos).
  Uso ocasional. USA cuando: "nos rechazaron otra vez el 10DLC", "hay que habilitar SMS para Estados
  Unidos", "qué pide Twilio para aprobar la campaña", "por qué no pasa la verificación". Es el
  expediente: viventa-mapa-crm registra el estado y viventa-reactivacion-lead escribe los mensajes.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-registro-10dlc

Desbloquea el canal de SMS hacia EE. UU., que importa porque los mensajes de marketing por WhatsApp a
números de EE. UU. no están disponibles y sin SMS no se cumple la meta de reactivación de ese país.
Cada reenvío del registro cuesta plata y semanas. Tres invariantes: **el diagnóstico parte del texto
exacto del rechazo**, no de suposiciones; **el expediente describe lo que Viventa realmente hace**
(nada de disfrazar el caso de uso para que pase); y **lo que depende de reglas de Twilio o de los
operadores se verifica en la documentación vigente** antes de reenviar, porque esas reglas cambian.

## Cuándo usar

- Explícito: "nos rechazaron otra vez el 10DLC", "hay que habilitar SMS para Estados Unidos", "qué
  pide Twilio para aprobar la campaña", "por qué no pasa la verificación".
- Implícito: llegó un correo de Twilio con el estado `FAILED` o `REJECTED` de la marca o la campaña.

## Cuándo NO usar

- Escribir los mensajes de reactivación que se van a mandar por SMS → `viventa-reactivacion-lead`.
- Problemas de entregabilidad de correo (spam, dominio) → `viventa-parrilla-base` y el equipo de TI.
- Registrar en el mapa del CRM el estado del canal o pedir cambios a tecnología → `viventa-mapa-crm`.

## Conexiones

| Conexión | Para qué | Si falta |
|---|---|---|
| Búsqueda web | Confirmar en la documentación vigente de Twilio y de The Campaign Registry los requisitos del caso de uso, el formato del consentimiento y los motivos de rechazo | Degrada: el expediente sale con cada requisito marcado `[verificar en la documentación de Twilio antes de reenviar]` y no se recomienda reenviar hasta revisarlo |

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Texto exacto del rechazo | Correo o consola de Twilio | *"Pégame el texto exacto del rechazo (con el código si viene)."* **Bloquea**: sin él solo se puede hacer revisión general |
| Lo que se envió | Formulario de marca y de campaña enviado | *"Pásame lo que se llenó: datos de la marca, caso de uso, descripción, mensajes de ejemplo y flujo de consentimiento."* |
| Cómo se obtiene el consentimiento hoy | Formularios de Zoho, landing, eventos | *"¿Dónde aceptan las personas recibir SMS? Pásame el link del formulario o una captura."* |
| Páginas publicadas | Web de Viventa | *"¿Cuál es el link de la política de privacidad y de los términos?"* |
| Qué mensajes se quieren mandar | Equipo de reactivación | *"¿Qué se va a mandar: recordatorios de eventos, seguimiento a quien se registró, reactivación?"* |

## Workflow

1. **Leé el rechazo** y clasificalo en una o más causas:
   - consentimiento no verificable o incompleto (no se ve dónde y cómo la persona acepta SMS);
   - política de privacidad sin la cláusula de no compartir datos móviles con terceros para marketing;
   - términos sin las condiciones del programa de SMS;
   - web caída, sin coincidencia con la marca registrada o sin los datos de la empresa;
   - datos de la marca que no coinciden con el registro tributario (nombre legal, identificación, dirección);
   - mensajes de ejemplo sin el nombre de la marca, sin opción de baja o que no coinciden con el caso de uso;
   - descripción de la campaña vaga o distinta de lo que muestran los ejemplos;
   - contenido restringido: créditos de terceros y generación de leads compartidos son categorías
     sensibles para los operadores. **Revisá si este es el motivo**: Viventa acompaña la compra y el
     crédito, pero los bancos otorgan el crédito.
2. **Verificá cada requisito** en la documentación vigente (búsqueda web) y anotá la fuente y la fecha.
3. **Rearmá el expediente**:
   - **Marca**: nombre legal exacto como en el registro tributario, identificación, dirección, web,
     contacto. Si la empresa que envía no es la entidad de EE. UU., decilo y verificá qué aplica a
     marcas fuera de EE. UU.
   - **Caso de uso**: el que corresponde a lo que se manda (por ejemplo, recordatorios de eventos y
     seguimiento a personas que se registraron con Viventa). Si hay mezcla, el que la cubre.
   - **Descripción**: quién envía, a quién, por qué la persona lo recibe, qué tipo de mensajes y con qué frecuencia.
   - **Flujo de consentimiento**: dónde acepta (formulario, evento, palabra clave), el texto exacto que
     ve (marca, tipo de mensajes, frecuencia, "pueden aplicar tarifas de mensajes y datos", STOP para
     salir, HELP para ayuda, links a privacidad y términos), casilla **no** marcada por defecto y no
     obligatoria para registrarse.
   - **Mensajes de ejemplo** (3 a 5): con "Viventa:" al inicio, uno con la instrucción de baja, sin
     tasa, cuota, plazo ni aprobación de crédito, sin acortadores de link públicos.
   - **Respuestas a palabras clave**: STOP, HELP y alta, con su texto.
4. **Armá el checklist web**: qué tiene que estar publicado antes de reenviar, página por página.
5. **Recomendá** reenviar solo cuando el checklist esté completo. Si el rechazo fue por contenido
   restringido, presentá las alternativas a evaluar (otro caso de uso honesto, número toll-free
   verificado) con lo que se sabe de cada una y la recomendación de consultarlo con Twilio.

## Reglas duras

- **Nunca recomienda describir un caso de uso distinto del real** para que el registro pase.
- **Nunca reenvía ni llena el formulario en Twilio**: entrega el expediente para que lo envíe la persona.
- **Nunca pide ni guarda credenciales** de la cuenta de Twilio.
- **Nunca pone en los mensajes de ejemplo tasa, cuota, plazo ni aprobación de crédito.**
- **Nunca presenta un requisito como vigente sin fuente y fecha**: lo no verificado queda marcado.

## Output esperado

`salidas/viventa-registro-10dlc/<AAAA-MM-DD>.md`:

```
REGISTRO 10DLC — diagnóstico y expediente · {fecha}
Rechazo: "{texto exacto}" → causa(s): {lista}
Recomendación: {reenviar cuando el checklist esté completo | consultar con Twilio antes: contenido restringido}

1. Diagnóstico (causa, evidencia, qué cambia)
2. Expediente corregido
   Marca · Caso de uso · Descripción · Flujo de consentimiento (texto exacto) · Mensajes de ejemplo ·
   Respuestas STOP / HELP / alta
3. Checklist web
   [ ] Formulario con casilla de SMS no marcada y opcional, con el texto de consentimiento
   [ ] Política de privacidad con la cláusula de datos móviles
   [ ] Términos con las condiciones del programa de SMS
   [ ] Datos de la empresa visibles y coincidentes con la marca registrada
4. Fuentes verificadas (link y fecha) · Pendientes [verificar]
```

Al terminar, decí: *"Expediente en `<ruta>`. Antes de reenviar: {n} cambios en la web. {Alerta de
contenido restringido, si aplica}."*

## Skills relacionados

- **Después:** `viventa-reactivacion-lead` escribe los SMS de reactivación una vez aprobado el registro;
  `viventa-mapa-crm` deja anotado el estado del canal y las solicitudes a tecnología.
- **Relacionado:** `viventa-qa-marca` revisa los mensajes de ejemplo antes de enviarlos en el expediente.
