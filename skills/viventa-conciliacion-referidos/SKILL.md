---
name: viventa-conciliacion-referidos
description: >-
  Cruza referidos, cierres y pagos de los programas de referidos de Viventa (Referidores Pro y
  referidos de clientes) con los exports de Zoho para saber a quién se le debe, desde cuándo y por
  qué no se creó la tarea de pago. Deja cada caso con causa probable, acción y responsable. USA
  cuando: "a este referidor no le han pagado", "revisa los pagos pendientes de referidos", "¿el
  referido de este cliente convirtió?", "por qué no se creó la tarea de pago". Es la conciliación:
  viventa-ciclo-referidor le escribe al referidor y viventa-mapa-crm pide el arreglo a tecnología.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-conciliacion-referidos

Saca a la gerencia de revisar caso por caso los pagos de referidos, que hoy se atrasan y frenan el
crecimiento del programa (la fuerza comercial no trae más referidores mientras a los actuales no se
les pague). Tres invariantes: **el derecho a pago lo define el documento vigente de incentivos, no
el skill** (monto, etapa que causa el pago y plazo), **cada caso termina con una acción y un
responsable con nombre de área**, y **ningún dato bancario del referidor aparece en el output**:
solo si lo tiene o no.

## Cuándo usar

- Explícito: "a este referidor no le han pagado", "revisa los pagos pendientes de referidos", "¿el
  referido de este cliente convirtió?", "por qué no se creó la tarea de pago", "cómo va el plan de
  referidos".
- Implícito: un comercial reclama por un pago, o se quiere escalar el programa y hay que saber si
  está al día.
- Cadencia: quincenal, y cada vez que llega un reclamo puntual (modo caso).

## Cuándo NO usar

- Escribirle al referidor (resultados, reactivación) → `viventa-ciclo-referidor`.
- Dar de alta a un referidor nuevo → `viventa-kit-referidor`.
- Arreglar la automatización o pedir el permiso en Zoho → `viventa-mapa-crm`, con los casos de aquí como evidencia.
- Documentar desde cero cómo funciona el flujo de referidos → `process-decode` (conviene correrlo una vez antes).

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Documento vigente de incentivos | Gerencia de Growth | *"Pásame el documento vigente de incentivos: de ahí salen monto, etapa que causa el pago y plazo."* Sin él se concilian estados pero **no se calculan montos ni atrasos** |
| Export de referidores | Zoho (referidores pro y clientes referidores) | *"Exporta de Zoho los referidores con su código y si tienen información de pago cargada (sí/no)."* **Bloquea** |
| Export de referidos con su referidor | Zoho, candidatos con el campo de referidor o el código | *"Exporta los candidatos que tienen referidor o código de referido, con fecha de creación y consultor asignado."* **Bloquea** |
| Export de negocios con etapa y fecha | Zoho | *"Exporta los negocios de esos candidatos con etapa y fecha de cada cambio de etapa."* **Bloquea** |
| Tareas de pago y pagos hechos | Zoho (tareas) y finanzas | *"¿Me pasas las tareas de pago de referidos y la lista de pagos hechos de finanzas?"* Sin pagos de finanzas, el estado `pagado` sale `sin confirmar` |
| Modo | El pedido | Si nombra un referidor o un referido: modo caso. Si no: modo completo |

## Workflow

1. **Fijá las reglas del documento de incentivos**: qué etapa causa el pago (por ejemplo, pago del
   servicio o desembolso), monto por programa y plazo en días. Escribilas arriba del reporte tal
   como dice el documento. Si dos documentos dicen distinto, pará y preguntá cuál rige.
2. **Uní las piezas** por llaves, en este orden: código de referidor → candidato → negocio → tarea de
   pago → pago. Cada eslabón que no une se anota (es la pista de la causa).
3. **Determiná el estado de cada referido**:
   `sin convertir` · `causó pago` (llegó a la etapa) · `tarea creada` · `pagado` · `pagado sin confirmar`.
4. **Calculá el atraso** solo de los que causaron pago y no están pagados: días desde la fecha en que
   llegó a la etapa menos el plazo del documento.
5. **Asigná la causa probable** de cada caso atrasado, con la evidencia que la sostiene:
   - `sin información de pago` — el referidor no tiene datos de pago cargados.
   - `automatización no se disparó` — el negocio llegó a la etapa y no existe tarea; anotá si el campo
     de referidor estaba vacío al momento del cambio de etapa o si el negocio es anterior a la regla.
   - `referido sin asignar` — el candidato no tiene consultor o la regla de asignación del referidor no existe.
   - `tarea sin ejecutar` — hay tarea, no hay pago: está en finanzas o en aprobación.
   - `vínculo roto` — el referido entró sin código o con otro código; no se puede probar quién refirió.
   Si la evidencia no alcanza, `causa no determinada` con lo que falta para saberlo.
6. **Asigná acción y responsable** por causa: cargar datos de pago (mercadeo pide al referidor), crear
   la tarea a mano y reportar la falla (mercadeo + tecnología), crear la regla de asignación
   (comercial), ejecutar el pago (finanzas), decidir el vínculo roto (gerencia).
7. **Resumí lo sistémico**: causas ordenadas por cantidad de casos. Si una causa se repite tres o más
   veces, redactá en una línea el arreglo que hay que pedirle a tecnología y pasalo a `viventa-mapa-crm`.

## Reglas duras

- **Nunca escribe un monto, etapa o plazo** que no esté en el documento vigente de incentivos.
- **Nunca muestra datos bancarios** ni de contacto del referidor o del referido: los referidos van con
  el ID de Zoho y las iniciales.
- **Nunca marca `pagado` sin el registro de finanzas**: sin él es `pagado sin confirmar`.
- **Nunca le promete al referidor una fecha de pago**: eso lo confirma finanzas.
- **Nunca modifica el CRM**: el reporte dice qué corregir y quién.

## Output esperado

`salidas/viventa-conciliacion-referidos/<AAAA-MM-DD>.md` (o `-<referidor>.md` en
modo caso), pegable en Docs:

```
CONCILIACIÓN DE REFERIDOS — corte {fecha}
Reglas (documento de incentivos {versión}): paga en {etapa} · {monto} · plazo {n} días
Se debe a {n} referidores · {n} casos atrasados · el más antiguo: {n} días · total {monto o "sin documento"}

Casos atrasados (más antiguos primero)
| Referidor | Programa | Referido (ID) | Llegó a la etapa | Estado | Días de atraso | Causa probable | Acción | Responsable |

Lo sistémico
1. {causa} — {n} casos. Pedido a tecnología: "{arreglo en una línea}" → viventa-mapa-crm.

Sin convertir: {n} referidos (no generan pago todavía).
```

Al terminar, decí: *"Conciliación lista en `<ruta>`: {n} casos atrasados, {n} con causa sistémica.
Los avisos a los referidores salen con viventa-ciclo-referidor cuando finanzas confirme fecha."*

## Skills relacionados

- **Antes:** `process-decode`, una vez, para dejar escrito el flujo de referidos y sus reglas.
- **Después:** `viventa-mapa-crm` para pedir los arreglos de automatización; `viventa-ciclo-referidor`
  para avisarle al referidor el estado de su pago con la fecha que confirme finanzas.
- **Relacionado:** `viventa-kit-referidor` (alta del referidor, con el checklist de pagos al día).
