---
name: viventa-puente-wati-zoho
description: >-
  Puente mientras la integración WATI–Zoho no funcione: toma el export de respuestas de una campaña
  de WhatsApp en WATI, clasifica quién se reactivó, marca duplicados contra Zoho y deja el archivo de
  carga al CRM con los campos mapeados, más el conteo del día. Procesa local, no imprime datos de
  contacto. USA cuando: "pasa a Zoho los que respondieron en WATI", "cuántos se reactivaron hoy por
  WhatsApp", "arma el archivo para subir los reactivados al CRM". Es la carga: viventa-reactivacion-lead
  redacta los mensajes y viventa-mapa-crm documenta la integración pendiente.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-puente-wati-zoho

Reemplaza la digitación uno a uno de los reactivados por WhatsApp mientras tecnología conecta la
integración nativa. Tres invariantes: **los datos de contacto nunca salen del equipo de quien lo
corre** (se procesan en archivos locales y en la conversación solo aparecen conteos y teléfonos
enmascarados), **una baja nunca entra como reactivado**, y **el skill no carga nada al CRM**: deja
el archivo para que la especialista lo importe y revise.

Antes de la primera corrida, la gerencia de Growth tiene que autorizar el uso con datos de la base
(regla del equipo: los datos personales de clientes no se automatizan sin control). El skill lo
pregunta una vez y lo deja anotado en el mapeo.

## Cuándo usar

- Explícito: "pasa a Zoho los que respondieron en WATI", "cuántos se reactivaron hoy por WhatsApp",
  "carga las respuestas de la campaña de WhatsApp de España", "arma el archivo para subir los
  reactivados al CRM".
- Implícito: terminó un envío de plantillas de reactivación por WATI y hay respuestas sin pasar al CRM.
- Cadencia: diaria, de lunes a viernes, después del pico de respuestas.

## Cuándo NO usar

- Redactar la plantilla o el mensaje de reactivación → `viventa-reactivacion-lead`.
- Diagnosticar por qué la integración nativa no conecta, o pedir el permiso a tecnología → `viventa-mapa-crm`.
- Reactivar por correo una base completa → `viventa-parrilla-base`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Export de la campaña en WATI | CSV del reporte del broadcast o de contactos con respuestas | *"Exporta el reporte de la campaña desde WATI (con la columna de respuesta) y dime dónde quedó."* **Bloquea** |
| Export de Zoho para cruzar duplicados | Vista de candidatos con teléfono y correo | *"Exporta de Zoho los candidatos de los últimos 12 meses con teléfono y correo; con eso marco duplicados."* Sin él, todos salen como `sin cruzar` |
| Mapeo de campos de Zoho | Plantilla de importación de Zoho o la lista de campos | Solo la primera vez: *"Pásame la plantilla de importación de Zoho; dejo el mapeo guardado y no te lo vuelvo a pedir."* |
| País y plantilla de la campaña | El nombre de la campaña en WATI | *"¿Para qué país fue y con qué plantilla?"* si el nombre no lo dice |
| Autorización de la gerencia | Gerencia de Growth & Marketing | Solo la primera vez: *"¿La gerencia autorizó procesar estos datos con este skill? Lo dejo anotado."* **Bloquea** hasta que sea sí |

## Workflow

1. **Cargá el mapeo guardado** de `salidas/viventa-puente-wati-zoho/mapeo.json`.
   Si no existe, armalo con la plantilla de importación y guardalo (campo de WATI → campo de Zoho,
   más la fecha de la autorización de la gerencia).
2. **Normalizá teléfonos a formato internacional** (+país, sin espacios) en los dos exports. Un número
   sin prefijo toma el del país de la campaña y se marca `prefijo inferido`.
3. **Clasificá cada respuesta** en una de cinco clases, con reglas simples y visibles:
   - `interesado` — pide información, pregunta por proyectos, comparte datos, responde con el CTA.
   - `pregunta` — duda puntual sin señal clara de interés (cuenta como reactivado solo si la
     especialista lo confirma).
   - `no interesado` — lo dice explícito.
   - `baja` — pide no recibir más mensajes (STOP, "no me escriban", "sáquenme").
   - `número equivocado` — dice no ser la persona.
   Las dudosas van a `revisar a mano`, no se adivinan.
4. **Cruzá contra Zoho** por teléfono normalizado y, si hay, por correo:
   - existe en Zoho → `actualizar` (el registro existente se marca reactivado; no se crea otro);
   - no existe → `crear`;
   - coincide por correo pero no por teléfono → `revisar a mano`.
5. **Generá tres archivos**:
   - `carga-zoho.csv` — solo `interesado` y las `pregunta` confirmadas, con los campos del mapeo, la
     fuente `WhatsApp – reactivación`, el país, la plantilla, la campaña y la fecha de reactivación.
   - `bajas.csv` — las bajas, para la lista de no contactar en WATI y en Zoho. Se cargan **el mismo día**.
   - `revisar.csv` — lo que no se pudo decidir.
6. **Contá el día**: enviados, respondieron, reactivados, bajas, duplicados, por país y por
   plantilla. Si existe el panel de metas de reactivación, decí cuánto suma contra la meta diaria.
7. **Cuando la integración nativa funcione**, cambiá a modo auditoría: compará los que respondieron
   en WATI contra los reactivados en Zoho y listá solo los que la integración no pasó.

## Reglas duras

- **Nunca imprime en la conversación** un teléfono, correo o nombre completo: solo conteos y
  teléfonos enmascarados (`+57 *** *** 4521`).
- **Nunca sube los archivos a un servicio externo** ni los manda por correo o chat: quedan en la
  carpeta local de quien lo corre.
- **Nunca carga ni modifica el CRM** directamente: entrega el archivo de importación.
- **Nunca pasa una baja ni un número equivocado a `carga-zoho.csv`.**
- **Nunca crea un candidato nuevo si ya existe** por teléfono: lo marca para actualizar.
- **Nunca corre sin la autorización de la gerencia** anotada en el mapeo.

## Output esperado

En `salidas/viventa-puente-wati-zoho/<AAAA-MM-DD>-<campaña>/`:
`carga-zoho.csv`, `bajas.csv`, `revisar.csv` y `RESUMEN.md`:

```
REACTIVACIÓN WHATSAPP — {campaña} · {país} · {fecha}
Enviados {n} · Respondieron {n} · Reactivados {n} (crear {n} · actualizar {n}) · Bajas {n} · Revisar {n}
Contra la meta diaria de reactivación: {n} de {meta} | sin dato de meta

Antes de importar
1. Importa carga-zoho.csv con «actualizar si existe» por teléfono.
2. Carga bajas.csv hoy en la lista de no contactar de WATI y de Zoho.
3. Decide las {n} filas de revisar.csv.
Después de importar, borra la carpeta: los datos quedan en Zoho.
```

Al terminar, decí: *"Archivos listos en `<ruta>`. {n} reactivados para cargar, {n} bajas que hay que
aplicar hoy y {n} para revisar. No cargué nada al CRM."*

## Skills relacionados

- **Antes:** `viventa-reactivacion-lead` redacta las plantillas que se envían por WATI.
- **Después:** `viventa-reporte-campanas` suma los reactivados por WhatsApp a la meta del proceso.
- **Relacionado:** `viventa-mapa-crm` registra la integración WATI–Zoho pendiente y la solicitud a
  tecnología; cuando quede conectada, este skill pasa a modo auditoría.
