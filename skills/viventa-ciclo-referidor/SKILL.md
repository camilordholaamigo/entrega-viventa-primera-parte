---
name: viventa-ciclo-referidor
description: >-
  Redacta, para un negocio aliado ya activo del programa Referidores Pro de Viventa, una de tres
  piezas: la parrilla mensual de contenidos, el correo de reactivación que toca según los días sin
  referir (máximo 3), o el correo de resultados del consultor con los datos del CRM marcados. Sin
  documento vigente del programa no escribe montos. USA cuando: "parrilla de contenidos del
  referidor", "qué le publicamos este mes al negocio aliado", "el aliado dejó de mandar referidos",
  "correo de resultados para el consultor". Es sostener, no activar: viventa-kit-referidor arma el
  kit del referidor nuevo y viventa-reactivacion-lead reabre leads, no aliados.
metadata:
  version: "1.1.0"
  domain: "acquire"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-ciclo-referidor

Produce lo que pasa después de la bienvenida del referidor: el contenido mensual del negocio
aliado, los correos que lo reactivan cuando se enfría y el reporte que le manda su consultor. En
toda corrida preserva tres cosas: **ninguna cifra de incentivo sin documento vigente**, **ningún
dato de resultados estimado** y **nada se envía ni se publica** — termina en un documento que la
coordinación del programa revisa. Un modo por corrida, una sola pasada, sin research.

**Qué no arregla.** El programa no falla en la activación sino en el sostenimiento (k-factor de
referidos en [cifra interna] contra un benchmark de 15-30 %, ver `references/cifras-canonicas.md`), y la
causa raíz documentada son los **pagos atrasados** por deuda técnica del CRM, no el contenido. Este
skill quita trabajo repetitivo; no resuelve el pago y no se presenta como si lo hiciera.

## Cuándo usar

- Explícito: "parrilla de contenidos del referidor", "qué le publicamos este mes al negocio
  aliado", "contenido mensual del negocio referidor", "el aliado dejó de mandar referidos",
  "correos para reactivar un aliado que no refiere", "correo de resultados para el consultor".
- Implícito: cierre de mes (parrilla o resultados) o un aliado que cruzó 30, 60 o 90 días sin
  referir.

## Cuándo NO usar

- **Referidor nuevo, sin kit todavía** → `viventa-kit-referidor` (flyer, bienvenida, mensajes).
- **Un lead que se cayó del proceso** (no un aliado) → `viventa-reactivacion-lead`.
- **Comunicaciones de la base propia de Viventa** → `viventa-parrilla-base`.
- **Calcular o pagar comisiones** → no es de ningún skill: es el CRM (Zoho).

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Modo: `parrilla` · `reactivacion` · `resultados` | El pedido del usuario | *"¿Qué necesitás: la parrilla del mes, un correo de reactivación o el correo de resultados?"* Uno solo por corrida |
| Nombre y rubro del negocio aliado | El usuario o la ficha del aliado | *"¿Cómo se llama el negocio aliado y a qué se dedica?"* — **bloqueante en los tres modos** (Paso 1) |
| Documento vigente del programa (incentivos, montos, momento de pago) | Comercial / coordinación del programa | *"¿Tenés el documento vigente de Referidores Pro?"* — si no, se sigue con montos marcados (Paso 2) |
| **Parrilla:** ciudad y país del negocio | El usuario | *"¿En qué ciudad y país está el negocio?"* — bloqueante: sin esto no se localiza el contenido |
| **Parrilla:** público del negocio | El usuario | *"¿Quiénes son sus clientes?"* — si no lo sabe, se usa el ICP de `references/contexto-viventa.md` y se declara el supuesto |
| **Parrilla:** mes y frecuencia | El usuario | *"¿Para qué mes y cuántas piezas?"* — si no responde, mes siguiente y 4 piezas, declarado |
| **Reactivación:** días sin referir | CRM o el usuario | *"¿Cuántos días lleva sin mandar un referido?"* — bloqueante: define el correo |
| **Reactivación:** último correo de reactivación que recibió (ninguno, R1, R2, R3) | El usuario | *"¿Ya le mandaron alguno de los correos de reactivación? ¿Cuál y cuándo?"* — si no sabe, se asume ninguno y se declara |
| **Resultados:** periodo | El usuario | *"¿Qué periodo cubre el reporte?"* — si no responde, el mes cerrado anterior, declarado en la primera línea del correo |
| **Resultados:** nombre y canal del consultor que firma | El usuario | *"¿Quién firma el correo y por qué canal lo contactan?"* — si falta, `⛔ INPUT REQUERIDO` en firma y disponibilidad |

## Workflow

1. **Chequeá el modo y el negocio.** Si el pedido mezcla modos, preguntá cuál va primero: cada
   modo tiene destinatario y momento distintos (ver `references/modos-y-disparadores.md`). Si
   falta nombre o rubro del aliado, o un dato marcado bloqueante del modo, detenete y devolvé solo:

   ```
   ⛔ NO SE PUEDE GENERAR — {modo}
   INPUTS REQUERIDOS
   - {dato} → pedir a: {quién}
   Motivo: sin el negocio concreto solo sale una plantilla intercambiable.
   ```

2. **Chequeá el documento del programa, antes de escribir nada.**
   - Está en el input → los montos se toman **solo** de ahí, citando la sección.
   - No está → la primera línea del entregable es:
     ```
     ⚠️ SIN DOCUMENTO VIGENTE DEL PROGRAMA REFERIDORES PRO
     Todos los montos de incentivo salen como [falta: documento del programa].
     No se escribió ninguna cifra. Pedir el documento a: coordinación del programa / Comercial.
     ```
     y todo monto queda `[falta: documento del programa]`. Los valores que circulan en el
     diagnóstico son recomendación, no política: no se usan "por esta vez".

3. **Ejecutá el modo pedido.**

   **`parrilla`** — una fila por pieza: fecha · formato · ángulo · copy completo · CTA · notas.
   - Ángulos en este orden, uno por pieza, y se repite el ciclo si hay más de 4 (con menos de 4 se
     toman los primeros; heurística propia, ajustable): **Servicio** (qué resuelve Viventa para
     *sus* clientes) · **Prueba** (un dato de `references/cifras-canonicas.md`; si no está ahí, no
     va) · **Objeción** (uno de los tres miedos de la categoría, respondido con un hecho
     verificable) · **Invitación directa** (con disclosure de comisión).
   - Escribí desde el negocio aliado, localizado a su ciudad y público. Prueba antes de emitir:
     *¿esto lo escribiría el dueño del negocio?* Si suena a comunicado de Viventa, reescribilo.
   - "Raíces / volver a casa" solo como emoción de fondo, nunca como ángulo principal.

   **`reactivacion`** — elegí el correo por días sin referir:

   | Días sin referir | Correo | Ángulo |
   |---|---|---|
   | < 30 | ninguno | No toca reactivar: decilo y no redactes |
   | 30-59 | R1 | Recordatorio útil para el aliado. Sin reproche |
   | 60-89 | R2 | Qué lograron otros aliados — solo con datos del input o `[dato: CRM]` |
   | ≥ 90 | R3 | Pregunta directa: qué lo frenó. No vende |

   Los límites caen en el tramo siguiente (30 → R1, 60 → R2, 90 → R3). Si el correo que toca ya
   se le mandó, o pasaron menos de 30 días desde el último, no redactes y decí cuándo corresponde.
   Si ya recibió R3, **sale de la secuencia**: entregá solo la marca `→ conversación humana` y no
   redactes un R4. R3 acepta que la respuesta sea un reclamo por pagos: el correo no se defiende
   ni promete fechas de pago.

   **`resultados`** — estructura fija: saludo del consultor con su nombre · qué pasó en el
   periodo · qué sigue · disponibilidad (nombre y canal). El skill no accede al CRM: **todo** dato
   duro sale vacío como `[dato: CRM · campo "…"]`, con el campo nombrado (p.ej. `estado
   "Desembolsado"`), para llenarse a mano o por merge — aunque el usuario dicte un número en el
   chat. "Qué sigue" describe los estados tal cual ("en proceso" es "en proceso"): no se anticipa
   desembolso ni comisión.

4. **Autovalidá** contra la lista de abajo y corregí antes de emitir.
   - Montos: cero cifras de incentivo sin documento; ninguna "deducida" del diagnóstico ni de una
     corrida anterior; el aviso del Paso 2 en la primera línea si aplica.
   - Datos: cero conteos estimados; cero nombres de personas referidas; nada "en proceso"
     descrito como cerrado.
   - Contenido: un modo; parrilla atada al negocio; disclosure en toda invitación; reactivación
     con su tramo declarado.
   - Legal: cero tasa, cuota, plazo o cuota inicial; cero promesa de aprobación; el aliado nunca
     suena a asesor financiero.

5. **Entregá** el documento (ver Output esperado) y cerrá con lo que falta pedir y a quién.

## Reglas duras

- **Nunca escribe una cifra de incentivo** que no salga del documento vigente del programa. Sin
  documento, `[falta: documento del programa]` y el aviso en la primera línea.
- **Nunca escribe un conteo ni un estado de referidos**: queda `[dato: CRM · campo]` para llenar desde el CRM.
- **Nunca nombra a una persona referida.** Solo conteos y estados.
- **Nunca menciona tasa, cuota, plazo ni cuota inicial** (triggering terms de Reg Z) y nunca
  promete aprobación de crédito.
- **Nunca omite el disclosure de comisión** en una pieza donde el aliado invita a alguien. Sin
  monto, igual va: *"recibo una comisión por cada persona que llega por mi recomendación."*
- **Nunca deja un placeholder suelto en el copy.** Solo valen tres marcas: `[falta: documento del
  programa]`, `[dato: CRM · campo]` y `⛔ INPUT REQUERIDO: {qué} → pedir a: {quién}`. Permitido:
  `Cerrados: [dato: CRM · estado "Desembolsado"]`. Prohibido: `Hola {nombre}`, `XXX`, `[insertar dato]`.
- **Nunca redacta un cuarto correo de reactivación.**
- **Nunca envía, publica ni aprueba**, ni presenta este skill como la solución del programa.
  Español de Colombia, tuteo.

## Output esperado

Un Markdown en `salidas/viventa-ciclo-referidor/{modo}-{slug-del-aliado}-{AAAA-MM}.md`,
mostrado también en la conversación:

```
# {Modo} — {Negocio aliado} · {mes o periodo}

{aviso del Paso 2, si aplica — primera línea}

## Parrilla | Correo R{n} (disparador: {días} días sin referir) | Correo de resultados
{tabla de piezas, o asunto + cuerpo del correo}

## Supuestos declarados
{público por ICP, frecuencia por defecto, "sin correos previos", etc. — o "ninguno"}

## Qué falta
{cada marca pendiente → a quién pedírsela — o "nada"}
```

Si el Paso 1 detiene la corrida, no se escribe archivo: se devuelve solo el bloque `⛔`. Al
terminar, decile al usuario: *"Quedó en {ruta}. Revisalo antes de mandarlo o publicarlo; faltan
{n} datos, listados al final."*

## Skills relacionados

- **Antes:** `viventa-kit-referidor` activa al referidor; este lo sostiene.
- **Después:** `viventa-qa-marca` para pasar la parrilla por la revisión legal y de marca antes de
  que el aliado la publique.
- **En vez de este:** `viventa-reactivacion-lead` si quien se enfrió es un lead, no un aliado;
  `viventa-parrilla-base` para las comunicaciones de la base propia de Viventa.

Referencias: `references/modos-y-disparadores.md` (detalle de los modos y por qué el techo es 3),
`references/cifras-canonicas.md` (fuente de todo número), `references/contexto-viventa.md` (ICP y
contexto), `references/voice-of-customer-90d.md` (verbatims). Las tres últimas las agrega el
empaquetado del plugin del cliente.
