---
name: viventa-ciclo-referidor
description: >-
  Cubre el ciclo de vida del referidor que kit-referidor deja abierto: aquel activa a un aliado
  nuevo y ahí termina. Este produce la parrilla de contenidos mensual del negocio aliado, la
  secuencia de 3 correos que lo reactiva cuando deja de referir, y el correo de resultados que el
  consultor le manda con lo que sus referidos generaron. Hereda el gate de kit-referidor: sin
  documento vigente del programa, ninguna cifra de incentivo se escribe.
metadata:
  version: "1.0.0"
  domain: "acquire"
  client: "viventa"
  blueprint: "marketing"
  complexity: "medium"
---

# viventa-ciclo-referidor

Produce **lo que pasa después de la bienvenida**: el contenido mensual del negocio aliado, los
correos que lo reactivan cuando se enfría, y el reporte que su consultor le manda.

**Quién lo usa:** Lizeth Henríquez, que hoy hace estas tres cosas a mano y sola.

**La regla que gobierna todo:** este skill **redacta**. No envía, no publica, no calcula
comisiones y no accede al CRM. Termina en un documento que un humano revisa.

**Una sola pasada.** Cuentas compartidas, créditos limitados. Sin loops, sin research.

---

## Por qué este skill existe

`viventa-kit-referidor` activa a un referidor nuevo: flyer, correo de bienvenida, 3 mensajes
reenviables. Y ahí termina. **El programa Referidores Pro no falla en la activación — falla en
el sostenimiento.**

Los números lo dicen: el **k-factor de referidos está en [cifra interna] contra un benchmark de 15-30 %**.
No es un problema de captar aliados; es que dejan de referir.

⚠️ **Y la causa raíz no es contenido.** Lizeth, textual:

> *"se ha atrasado sobre todo la parte de pagos… la respuesta de los comerciales es 'cuando esto
> funcione, te busco más referidores'."*

**Este skill no arregla el programa.** Arregla las tres tareas repetitivas que hoy consumen a
Lizeth. El cuello — pagos atrasados por deuda técnica del CRM — está en el backlog de integración
(#4) y **no se resuelve con IA**. Decir lo contrario sería vender humo.

---

## Reglas duras (si una se rompe, el entregable no sale)

1. **Gate 0.1, heredado de `viventa-kit-referidor`, sin excepción:** no existe documento vigente
   del programa Referidores Pro. **Prohibido absoluto escribir cifras de incentivo.** Los $200 y
   $500 que circulan son **recomendación del diagnóstico, no política vigente**. Si el documento
   no está en el input, todo monto sale como `[falta: documento del programa]` y el entregable lo
   dice arriba, en la primera línea.
2. **Los datos de resultados salen del CRM, no del skill.** El correo al consultor se entrega con
   los huecos marcados `[dato: CRM]`. **Nunca se estima cuántos referidos trajo alguien.**
3. **Cero PII de los referidos.** El correo al consultor habla de conteos y estados, nunca de los
   nombres de las personas referidas.
4. **Nunca tasa, cuota, plazo ni cuota inicial** (Reg Z). Nunca prometer aprobación de crédito.
   El aliado no es asesor financiero y su contenido no puede sonar a que lo es.
5. **Disclosure de comisión obligatorio** en toda pieza donde el referidor invite a alguien. Si
   el monto no se puede escribir (regla 1), el disclosure igual va: *"recibo una comisión por cada
   persona que llega por mi recomendación."*
6. **Cero placeholders en copy.** Dato que falta → `⛔ INPUT REQUERIDO: {qué} → pedir a: {quién}`.
7. **La parrilla se dimensiona al negocio concreto,** no es una plantilla genérica. Si no hay
   datos del negocio, el skill los pide en vez de producir contenido intercambiable.
8. **Español de Colombia, tuteo.**
9. El skill **no aprueba, no publica y no envía**.

---

## Input del usuario

| Input | Obligatorio | Si falta |
|---|---|---|
| **Modo**: `parrilla` · `reactivacion` · `resultados` | **Sí** | Preguntar. Los tres no corren juntos |
| Nombre y rubro del negocio aliado | **Sí — bloqueante** | **PARAR.** Sin esto solo sale plantilla genérica |
| **Documento vigente del programa** (incentivos, montos, momento de pago) | No, pero **condiciona todo** | Se produce con montos en `[falta: documento del programa]` y aviso arriba |
| Ciudad y país del negocio | Sí | Bloquea la localización del contenido |
| Público del negocio aliado | No | Usar el ICP Viventa y declarar el supuesto |
| **Modo parrilla:** mes objetivo y frecuencia | Sí | Asumir 4 piezas/mes y decirlo |
| **Modo reactivación:** días sin referir | Sí | **PARAR.** Define cuál de los 3 correos aplica |
| **Modo resultados:** referidos, estado y periodo | No | Se entrega la plantilla con `[dato: CRM]` |

---

## Workflow

### Fase 1 — Gate

Chequeá el modo y el negocio. Si falta el nombre o el rubro, **detenete**:

```
⛔ NO SE PUEDE GENERAR — {modo}

INPUTS REQUERIDOS
- Nombre y rubro del negocio aliado → pedir a: Lizeth
- {otros faltantes}

Motivo: sin el negocio concreto solo sale una plantilla intercambiable, que es lo que ya existe.
```

### Fase 1.5 — Chequeo del documento del programa

**Antes de escribir nada**, verificá si el documento vigente está en el input.

Si **no está**, el entregable arranca con:

```
⚠️ SIN DOCUMENTO VIGENTE DEL PROGRAMA REFERIDORES PRO
Todos los montos de incentivo salen como [falta: documento del programa].
No se escribió ninguna cifra. Pedir el documento a: Lizeth / Comercial.
```

Y **todo monto** queda así. No hay excepción "por esta vez", ni "usando el del diagnóstico".

### Fase 2 — Ejecutar el modo

Los tres modos **nunca corren juntos**. Uno por corrida.

#### Modo `parrilla`

Contenido mensual para el negocio aliado. Default: **4 piezas/mes**.

Cada fila: fecha · formato · ángulo · copy completo · CTA · notas de pieza.

Reparto de ángulos, uno por semana:
1. **Servicio** — qué resuelve Viventa para los clientes del aliado
2. **Prueba** — un caso o dato duro (bancos, años, constructoras)
3. **Objeción** — el miedo más común, respondido
4. **Invitación directa** — con disclosure de comisión

**El contenido habla desde el negocio aliado, no desde Viventa.** Un cliente del aliado lo sigue
a él, no a nosotros. Un copy que suena a marca corporativa no lo publica.

#### Modo `reactivacion`

3 correos escalonados, cada uno con su disparador declarado:

| Correo | Disparador | Ángulo |
|---|---|---|
| R1 | 30 días sin referir | Recordatorio útil. Sin reproche |
| R2 | 60 días | Prueba: qué lograron otros aliados |
| R3 | 90 días | Pregunta directa: qué lo frenó |

**R3 pregunta, no insiste.** A los 90 días la respuesta más probable es que el programa le falló
—típicamente el pago—, y un correo de venta ahí quema el vínculo. R3 abre conversación.

**Techo: 3 intentos.** Después, el aliado sale de la secuencia. Se marca para conversación humana.

#### Modo `resultados`

Correo del consultor a su referidor con lo que trajeron sus referidos.

Estructura fija: saludo · qué pasó en el periodo · qué sigue · disponibilidad del consultor.

Todos los datos duros salen como `[dato: CRM]` con el nombre exacto del campo, para que se llene
a mano o por merge. **Nunca se estima un conteo.**

Si el estado del referido es "en proceso", se dice "en proceso" — **no se anticipa un desembolso**
ni se sugiere que la comisión está por llegar.

### Fase 3 — Autovalidación

Corré el checklist. Si algo falla, corregilo antes de emitir.

---

## Formato del entregable

```
# {Modo} — {Negocio aliado} · {mes o periodo}

{aviso del Gate 1.5 si aplica}

## {Bloque según modo}
...

## Qué falta
{inputs pendientes con a quién pedírselos}
```

---

## Fronteras

| Este skill | El otro |
|---|---|
| Sostiene al referidor ya activo | `viventa-kit-referidor` lo **activa** (flyer, bienvenida, mensajes) |
| Contenido del **negocio aliado** | `viventa-parrilla-base` planifica la base de **Viventa** |
| No calcula ni promete comisiones | Eso es Zoho, y hoy está roto (backlog #4) |

---

## Checklist de autovalidación

**A · El gate**
- [ ] Verifiqué si el documento vigente del programa está en el input
- [ ] Si no está, el aviso está en la **primera línea** del entregable
- [ ] **Cero cifras de incentivo escritas.** Ningún $200, ningún $500, ningún porcentaje
- [ ] Ningún monto se "dedujo" del diagnóstico ni de una corrida anterior

**B · Datos**
- [ ] Todo dato de resultados sale como `[dato: CRM]` con el campo nombrado
- [ ] Cero conteos de referidos estimados
- [ ] Cero PII de personas referidas
- [ ] Ningún referido "en proceso" descrito como cerrado

**C · Contenido**
- [ ] Un solo modo por corrida
- [ ] La parrilla está dimensionada al negocio concreto, no es genérica
- [ ] El copy habla desde el aliado, no desde Viventa
- [ ] Disclosure de comisión en toda pieza de invitación
- [ ] Reactivación: máximo 3 correos, con disparador declarado en cada uno
- [ ] R3 pregunta qué lo frenó; no vende

**D · Legal**
- [ ] Cero tasa, cuota, plazo, cuota inicial
- [ ] Cero promesa de aprobación de crédito
- [ ] El aliado no aparece dando asesoría financiera

**E · Alcance**
- [ ] El entregable no envía, no publica y no aprueba
- [ ] No se prometió que este skill resuelve el programa de referidores

---

## Referencias

- `references/modos-y-disparadores.md` — los 3 modos en detalle, la secuencia de reactivación y
  por qué el techo es 3
- `references/cifras-canonicas.md` — fuente de verdad de todo número
- `references/contexto-viventa.md` — contexto del cliente
- `references/voice-of-customer-90d.md` — verbatims
