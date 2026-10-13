---
name: viventa-mapa-crm
description: >-
  Mantiene el mapa vivo de las automatizaciones, campos, plantillas y reglas de Zoho que usa mercadeo
  en Viventa: qué las dispara, qué hacen y quién es el dueño. Registra cada ajuste en una bitácora,
  diagnostica por qué no se disparó una automatización y redacta la solicitud a tecnología con el
  cambio o permiso exacto y su impacto. USA cuando: "¿qué automatización crea la tarea de pago del
  referido?", "documenta el cambio que hice en el CRM", "¿por qué no se disparó esta automatización?",
  "pídele a tecnología el permiso". Es el mapa: viventa-conciliacion-referidos y viventa-puente-wati-zoho
  traen la evidencia.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-mapa-crm

Deja por escrito lo que hoy vive en la cabeza de una o dos personas: qué automatizaciones de Zoho
sostienen los procesos de mercadeo y qué pasa cuando una falla. No reemplaza los permisos que
tecnología no ha dado; reduce la dependencia y deja trazabilidad. Tres invariantes: **el mapa solo
registra lo que alguien vio en Zoho** (con fecha y quién lo vio), **cada cambio entra a la bitácora
antes de cerrar la conversación**, y **toda solicitud a tecnología dice el cambio exacto, el motivo
y el impacto**, nunca "revisen el CRM".

## Cuándo usar

- Explícito: "¿qué automatización crea la tarea de pago del referido?", "pídele a tecnología el
  permiso para ver las reglas de asignación", "documenta el cambio que hice en el CRM", "¿qué
  plantillas usan el campo motivadores de compra?", "¿por qué no se disparó esta automatización?".
- Implícito: se creó o se cambió un campo, una plantilla o un flujo en Zoho; o un proceso de mercadeo
  dejó de funcionar sin que nadie sepa por qué.

## Cuándo NO usar

- Conciliar caso por caso los pagos de referidos → `viventa-conciliacion-referidos`.
- Cargar al CRM los reactivados por WhatsApp → `viventa-puente-wati-zoho`.
- Documentar un proceso de negocio completo (no solo su automatización) → `process-decode` o `document-processes`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| El mapa actual | `salidas/viventa-mapa-crm/mapa.md` | No se pregunta: si no existe, se crea vacío con la estructura del Output |
| Qué se quiere (consultar, registrar, diagnosticar, pedir) | El pedido | *"¿Quieres consultar el mapa, registrar un cambio, diagnosticar una falla o pedirle algo a tecnología?"* |
| Evidencia de Zoho | Captura o texto de la regla de flujo, el criterio, el campo o la plantilla; o el historial del registro | *"Pégame la configuración que ves en Zoho (o una captura) y, si es una falla, el ID de un registro donde no funcionó."* Sin evidencia, lo nuevo entra como `sin verificar` |
| Quién hizo el cambio y cuándo | El usuario | *"¿Quién hizo el cambio y qué día?"* |

## Workflow

### Modo consulta
1. Buscá en el mapa por proceso, módulo, campo o plantilla. Respondé con la ficha y la fecha en que se
   verificó por última vez. Si tiene más de 90 días o está `sin verificar`, decilo.

### Modo registrar
1. Armá o actualizá la ficha de la automatización (ver Output) con lo que el usuario pegó.
2. Agregá la línea a la bitácora: fecha, quién, qué cambió, antes → después, motivo, registro de prueba.
3. Revisá dependencias: si el cambio toca un campo, listá las plantillas, flujos y reportes del mapa
   que usan ese campo y marcalos `revisar por cambio del {fecha}`.

### Modo diagnosticar ("no se disparó")
Revisá, en este orden, con el historial del registro que falló:
1. **Disparador**: ¿la regla corre al crear, al editar o al cambiar un campo específico? ¿El registro
   pasó por ese evento después de que la regla existía?
2. **Criterio**: ¿el registro cumplía cada condición en el momento del evento (campo vacío, valor
   escrito distinto, dueño distinto)?
3. **Acción**: ¿la acción existe y está activa? ¿Usa un campo o una plantilla que cambió?
4. **Ejecución**: ¿el registro de ejecución de la regla muestra error o límite alcanzado?
5. **Permisos**: ¿el usuario que lo dispara tiene permiso sobre el módulo destino?
Entregá la causa más probable con la evidencia, lo que no se pudo verificar y el arreglo.

### Modo pedir a tecnología
1. Redactá la solicitud con: qué se necesita (cambio o permiso exacto, con nombre del módulo, campo,
   regla o perfil), por qué (proceso afectado y evidencia: IDs de registros, casos), impacto si no se
   hace (en casos o leads por semana, si se sabe), urgencia y quién valida que quedó.
2. Anotá la solicitud en el mapa como `pendiente con tecnología desde {fecha}`.

## Reglas duras

- **Nunca registra como verificado algo que nadie vio en Zoho**: lo deducido va `sin verificar`.
- **Nunca pide credenciales** ni las guarda en el mapa, ni copia tokens o claves de una integración.
- **Nunca cambia el CRM**: documenta, diagnostica y redacta; los cambios los hace quien tiene permiso.
- **Nunca copia datos de clientes** al mapa: los ejemplos van con el ID del registro.
- **Nunca manda la solicitud**: queda redactada para que la envíe la persona.

## Output esperado

Un solo archivo vivo, `salidas/viventa-mapa-crm/mapa.md`:

```
MAPA DE AUTOMATIZACIONES DE MERCADEO EN ZOHO — actualizado {fecha}

## {Proceso} (ej. Referidos · pago al referidor)
### {Nombre de la regla o flujo}
- Módulo: {módulo} · Tipo: {regla de flujo | blueprint | regla de asignación | plantilla | campo}
- Se dispara: {evento} · Criterio: {condiciones}
- Hace: {acciones}
- Usa: {campos, plantillas}
- Dueño: {área} · Verificado: {fecha}, {quién} | sin verificar
- Estado: activa | con falla conocida | pendiente con tecnología desde {fecha}

## Pendientes con tecnología
| Desde | Solicitud | Proceso | Impacto | Estado |

## Bitácora
| Fecha | Quién | Qué cambió | Antes → después | Motivo | Registro de prueba |
```

En modo diagnosticar o pedir, además se entrega el texto (diagnóstico o solicitud) en la conversación,
listo para pegar en el correo o el ticket. Al terminar, decí: *"Mapa actualizado en `<ruta>` ({qué
cambió}). {Solicitud redactada, pendiente de que la envíes | Sin pendientes nuevos}."*

## Skills relacionados

- **Antes:** `viventa-conciliacion-referidos` y `viventa-puente-wati-zoho` traen los casos que
  sirven de evidencia de una falla.
- **Después:** tecnología aplica el cambio; se vuelve a este skill para registrarlo en la bitácora.
- **En vez de este:** `process-decode` cuando hace falta entender el proceso completo, no solo su automatización.
