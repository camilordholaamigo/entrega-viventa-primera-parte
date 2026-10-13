---
name: viventa-evento-aliado
description: >-
  Planea y sigue un evento de Viventa con aliados —networking con constructoras, taller o webinar con
  negocios o consulados, punto de activación— con su runbook: cronograma inverso de 4 a 6 semanas,
  responsables, checklist logístico, quién presenta qué, piezas en formato brief y plan de seguimiento
  con meta de registros. USA cuando: "tenemos evento con constructoras en un mes", "armemos el taller
  con el consulado", "montemos un punto de activación en Bogotá", "qué falta para el evento del
  jueves". Es el evento con aliado: viventa-brief-evento arma los eventos propios de Viventa.
metadata:
  version: "1.0.0"
  domain: "acquire"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-evento-aliado

Pone orden en los eventos que no son los propios de Viventa: los que se hacen **con** alguien
(constructoras, negocios del exterior, consulados) para abrir un canal de adquisición o de
referidos. Tres invariantes: **todo evento tiene una meta de registros y un plan de seguimiento
antes de confirmarse**, **cada tarea del runbook tiene responsable y fecha**, y **nada con la marca
del aliado sale sin su aprobación escrita**. El skill planea y hace seguimiento; no convoca, no
compra ni publica.

## Cuándo usar

- Explícito: "tenemos evento con constructoras en un mes", "armemos el taller con el consulado",
  "montemos un punto de activación en Bogotá", "qué falta para el evento del jueves", "webinar con un
  negocio aliado para que nos refieran clientes".
- Implícito: alianzas o la gerencia de consultores en el exterior cerró una fecha con un aliado.
- Modos: **planear** (crea el runbook) y **seguimiento** (lee el runbook, dice qué está atrasado y qué sigue).

## Cuándo NO usar

- Open House, Expo Colombia, Expo Casa o Viventa Más Cerca de Ti → `viventa-brief-evento` y su cadena.
- Diseñar el contenido del taller o webinar (agenda, ejercicios, guion) → `workshop-designer`.
- Las secuencias de correo y WhatsApp para convocar → `viventa-comunicaciones-campana`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Tipo de evento | El pedido | *"¿Es networking con constructoras, taller o webinar con un aliado, o punto de activación?"* **Bloquea** |
| Aliado y contacto responsable de su lado | Alianzas o comercial | *"¿Con quién es y quién es el contacto del aliado?"* **Bloquea** |
| Fecha, ciudad y lugar (o plataforma si es virtual) | El aliado / alianzas | *"¿Qué fecha, ciudad y lugar? Si es webinar, ¿en qué plataforma?"* Sin fecha no hay cronograma |
| Objetivo y meta | Gerencia de Growth | *"¿Qué se busca: registros, referidos o acuerdos con constructoras? ¿Cuántos?"* Si no hay meta, se propone una con su supuesto y queda `propuesta` |
| Quién presenta | Comercial / alianzas | *"¿Quién presenta por Viventa y quién por el aliado?"* |
| ¿Lleva pauta? | El pedido | *"¿Vamos a pautar para convocar?"* Si sí y faltan menos de 45 días, se advierte |

## Workflow

1. **Calculá el margen**: días entre hoy y el evento. Con pauta, menos de 45 días es `margen corto`:
   decilo arriba y proponé convocar solo por canales propios y del aliado.
2. **Armá el cronograma inverso** (T = día del evento), ajustado al margen real:
   - T-42 a T-35: acuerdo con el aliado por escrito (qué pone cada uno, uso de marcas, meta, datos que se comparten).
   - T-35: brief de piezas y de pauta (si aplica) → `viventa-brief-requerimiento`.
   - T-28: contenido del taller o agenda del networking listo para revisión → `workshop-designer`.
   - T-21: piezas aprobadas por marca y por el aliado; convocatoria arranca.
   - T-14: QR y link de registro con seguimiento por aliado probados; impresos enviados (si el evento es
     fuera de Colombia, el envío internacional va antes: preguntá el tiempo de entrega).
   - T-7: confirmación de lugar, presentadores, ensayo y lista de asistentes.
   - T-1: material en sitio, QR impresos verificados, responsables del registro en la puerta.
   - T+2: mensaje a asistentes y registrados que no fueron; leads asignados a comercial.
   - T+14 y T+30: corte de resultados contra la meta.
3. **Checklist logístico por tipo**:
   - Networking con constructoras: lista de invitados, agenda, qué presenta Viventa (ecosistema de
     bancos, cómo refiere una constructora), acuerdo de siguiente paso con cada constructora.
   - Taller o webinar con negocio o consulado: plataforma o salón, inscripción, presentador, material,
     grabación (con permiso), y para consulados: uso de su logo solo con autorización escrita, sin
     contenido político.
   - Punto de activación: permiso del lugar, pieza física con QR, impresión y envío, quién atiende y
     en qué horario, cómo se registra a quien pasa.
4. **Definí el seguimiento**: link o QR con el código del aliado, meta de registros, quién llama o
   escribe en 48 horas, cómo se le cuenta al aliado lo que generó.
5. **Modo seguimiento**: leé el runbook, marcá lo vencido y lo que vence en 7 días, y devolvé las
   tres próximas acciones con responsable.

## Reglas duras

- **Nunca usa la marca o el logo del aliado** en una pieza sin aprobación escrita del aliado.
- **Nunca promete al aliado** comisiones, montos ni condiciones: eso sale del documento de su programa
  o de la gerencia.
- **Nunca pone tasa, cuota, plazo ni aprobación de crédito** en el material del evento.
- **Nunca confirma un evento sin meta de registros y sin plan de seguimiento** escritos.
- **Nunca compra, contrata ni convoca**: deja las tareas con responsable.

## Output esperado

`salidas/viventa-evento-aliado/<AAAA-MM-DD>-<aliado>.md`:

```
EVENTO CON ALIADO — {tipo} · {aliado} · {ciudad} · {fecha}
Meta: {n registros | n referidos | n acuerdos} ({confirmada | propuesta: supuesto})
Margen: {n} días {· ⚠ margen corto para pauta}

Cronograma inverso
| Fecha | Tarea | Responsable | Estado |

Checklist logístico ({tipo})
[ ] …

Quién presenta: Viventa {nombre/rol} · {aliado} {nombre/rol} — qué cuenta cada uno
Piezas requeridas (van a brief): {lista}
Seguimiento: link/QR {código del aliado} · 48 h: {quién} · corte T+14 y T+30
```

En modo seguimiento, la salida es corta: vencido, vence en 7 días y las 3 próximas acciones.
Al terminar, decí: *"Runbook en `<ruta>`. Lo próximo: {acción} ({responsable}, {fecha})."*

## Skills relacionados

- **Antes:** acuerdo con el aliado; si es un Referidor Pro nuevo, `viventa-kit-referidor`.
- **Durante:** `viventa-brief-requerimiento` (piezas), `workshop-designer` (contenido del taller),
  `viventa-comunicaciones-campana` (convocatoria por correo y WhatsApp), `viventa-qa-marca` (revisión).
- **Después:** `viventa-reporte-campanas` suma los registros del evento a la meta del canal de alianzas.
