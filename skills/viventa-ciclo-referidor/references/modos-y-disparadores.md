# Los 3 modos y sus disparadores

Referencia de `viventa-ciclo-referidor`, Fase 2.

---

## Por qué los modos no corren juntos

Cada modo tiene un destinatario y un momento distintos:

| Modo | Quién lo recibe | Cuándo |
|---|---|---|
| `parrilla` | El público del aliado | Mensual, planificado |
| `reactivacion` | El aliado | Disparado por inactividad |
| `resultados` | El aliado | Cierre de periodo |

Correrlos juntos produce un documento largo del que se usa un tercio. Y hay un motivo operativo:
las cuentas de IA del cliente son compartidas y se quedan sin créditos hasta 4 horas — una corrida
que produce tres cosas para usar una es una corrida desperdiciada.

---

## Modo `parrilla` — contenido del negocio aliado

### El principio que decide todo el copy

**El contenido lo publica el aliado, no Viventa.** Sus seguidores lo siguen a él: a la
inmobiliaria de barrio, a la asesora de seguros, al contador. Un copy que suena a comunicado
corporativo **no lo publica**, y una parrilla que no se publica no existe.

Prueba rápida antes de emitir: *¿este texto lo escribiría el dueño del negocio?* Si suena a
Viventa hablando en su nombre, se reescribe.

### Los 4 ángulos, uno por semana

| # | Ángulo | Qué hace | Trampa a evitar |
|---|---|---|---|
| 1 | **Servicio** | Qué resuelve Viventa para *sus* clientes | Enumerar features |
| 2 | **Prueba** | Un dato duro: bancos aliados, +20 constructoras, años de operación | Inventar cifras |
| 3 | **Objeción** | El miedo más común, respondido de frente | Minimizar el miedo |
| 4 | **Invitación** | Pedido directo, con disclosure | Omitir el disclosure |

### Los tres miedos de la categoría

Todo ángulo de objeción sale de acá. Son los de la categoría entera, no de Viventa:

1. **Ser estafado** — el más fuerte. Comprar a distancia, en otro país, sin ver.
2. **Perder la plata** — que el proyecto no se entregue.
3. **Comprar un inmueble que no es** — que no se parezca a lo prometido.

Se responden con **hechos verificables**, no con adjetivos. "Trabajamos con bancos vigilados por
la Superintendencia Financiera" funciona; "somos confiables" no.

### Cuidado con el ángulo saturado

**"Raíces", "volver a casa", "tu tierra"** están agotados: los ~8 brokers autorizados por
Bancolombia lo usan todos. Sirve como emoción de fondo, **no como ángulo principal de una pieza**.

---

## Modo `reactivacion` — el aliado que se enfrió

### La secuencia

| Correo | Disparador | Ángulo | Qué NO hace |
|---|---|---|---|
| **R1** | 30 días sin referir | Recordatorio útil. Algo que le sirve al aliado, no un pedido | Reprochar |
| **R2** | 60 días | Prueba social: qué lograron otros aliados | Comparar de forma humillante |
| **R3** | 90 días | Pregunta directa: qué lo frenó | Vender |

### Por qué R3 pregunta en vez de vender

A los 90 días, **la explicación más probable es que el programa le falló al aliado, no al revés.**
La causa documentada es el pago:

> *"se ha atrasado sobre todo la parte de pagos… la respuesta de los comerciales es 'cuando esto
> funcione, te busco más referidores'."* — coordinación del programa

Mandarle un correo de venta a alguien que no cobró lo que le deben quema el vínculo de forma
permanente. R3 abre conversación y **acepta que la respuesta puede ser un reclamo** — de hecho, si
lo es, el correo cumplió su función: hizo visible un problema que hoy nadie ve.

### Techo: 3 intentos, y se para

Después de R3 el aliado **sale de la secuencia automática** y se marca para conversación humana.

No hay R4. La queja del Voice of Customer es saturación:
*"siempre hay que colocar correo y luego te saturan."*

Un cuarto correo automático a alguien que ya ignoró tres es cómo se pierde a un aliado que todavía
podía volver.

### Espaciado

Mínimo **30 días** entre correos. Estos no son leads en un funnel de compra: son socios
comerciales. Una cadencia de días los trata como base de emailing y se nota.

---

## Modo `resultados` — el correo del consultor

### Estructura fija

1. **Saludo personal** — del consultor, con su nombre. No de "el equipo Viventa"
2. **Qué pasó en el periodo** — conteos, todos como `[dato: CRM]`
3. **Qué sigue** — el estado real de lo que está en proceso
4. **Disponibilidad** — cómo contactarlo, con nombre y canal

### Los datos van vacíos, a propósito

Cada dato sale así, con el campo nombrado:

```
Referidos que llegaron: [dato: CRM · campo "Referidos" filtrado por código de aliado]
En proceso: [dato: CRM · estado "En proceso"]
Cerrados: [dato: CRM · estado "Desembolsado"]
```

**Nunca se estima un conteo.** Un número inventado en un correo que habla de comisiones es un
problema comercial, no un error de redacción.

### Sobre los estados

- "En proceso" se escribe **"en proceso"**. No "próximo a cerrarse", no "casi listo".
- **No se anticipa un desembolso** ni se sugiere que la comisión está por llegar.
- Si el estado no está claro en el input, va como `[dato: CRM]` — no se interpreta.

Esto importa más de lo que parece: el problema vivo del programa son **pagos atrasados**. Un
correo que insinúa un pago que no está confirmado empeora exactamente el problema que hoy tiene
frenado al programa.

### Cero PII de los referidos

El correo habla de **conteos y estados**, nunca de los nombres de las personas referidas. El
aliado no tiene derecho a los datos de quien refirió una vez que esa persona es cliente.
