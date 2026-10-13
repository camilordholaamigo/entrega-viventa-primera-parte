---
name: viventa-compra-merchandising
description: >-
  Ordena una compra de merchandising de Viventa: normaliza y compara las cotizaciones de proveedores
  (precio unitario y total, tiempo de entrega, calidad de la muestra, condiciones), lleva el estado de
  las muestras y arma el memo de aprobación para la dirección financiera con una recomendación. USA
  cuando: "cotiza el merchandising para el evento", "compara estos proveedores", "arma la aprobación
  para finanzas", "en qué va la muestra". Es la compra: vendor-negotiation-playbook prepara la
  negociación si el monto lo justifica.
metadata:
  version: "1.0.0"
  domain: "operate"
  client: "viventa"
  blueprint: "marketing"
  complexity: "standalone"
---

# viventa-compra-merchandising

Saca del correo y de la memoria de la coordinación de marca un proceso que puede tomar más de un mes:
cotizar, pedir muestras, decidir y pedir aprobación. Tres invariantes: **las cotizaciones se comparan
en la misma unidad** (precio unitario con impuestos y envío, a la misma cantidad), **la calidad de la
muestra la califica una persona**, no el skill, y **ninguna compra se aprueba ni se ordena aquí**: la
inversión significativa la aprueba la dirección financiera.

## Cuándo usar

- Explícito: "cotiza el merchandising para el evento", "compara estos proveedores", "arma la
  aprobación para finanzas", "en qué va la muestra".
- Implícito: hay un evento o una campaña que necesita material físico y llegaron cotizaciones.

## Cuándo NO usar

- Preparar una negociación de precio o condiciones con un proveedor → `vendor-negotiation-playbook`.
- Revisar el contrato o las condiciones legales del proveedor → `contract-reviewer`.
- Diseñar la pieza que va impresa en el producto → `viventa-piezas-figma`.

## Input del usuario

| Campo | De dónde sale | Si falta, preguntar |
|---|---|---|
| Qué se compra y para qué | El pedido | *"¿Qué producto, cuántas unidades y para qué evento o campaña?"* **Bloquea** |
| Fecha en que se necesita en sitio | El evento | *"¿Para qué fecha tiene que estar en el lugar del evento?"* Si el evento es fuera de Colombia, también el tiempo de envío |
| Cotizaciones | PDF, correo o texto de cada proveedor | *"Pásame las cotizaciones que tengas."* Con una sola, se dice que no hay comparación |
| Presupuesto aprobado | Gerencia | *"¿Cuánto hay aprobado para esto?"* Sin él, el memo lo deja como dato a completar |
| Estado y calificación de muestras | Coordinación de marca | *"¿Llegaron las muestras? Califica cada una de 1 a 5 en calidad y fidelidad de marca."* |
| Umbral de aprobación financiera | Dirección financiera | Solo si no está guardado: *"¿Desde qué monto la compra necesita aprobación de la dirección financiera?"* |

## Workflow

1. **Normalizá cada cotización** a la misma cantidad: precio unitario, impuestos, envío (al lugar del
   evento si es en el exterior), costo de muestra, anticipo, tiempo de producción y de entrega,
   validez de la oferta. Lo que la cotización no dice va `no informado`, no se supone.
2. **Calculá el costo total puesto en sitio** por proveedor y la fecha estimada de llegada contra la
   fecha en que se necesita. Si no llega a tiempo, el proveedor queda `fuera de plazo` aunque sea el más barato.
3. **Registrá las muestras**: pedida, recibida, calificada (con la nota y el comentario de quien la vio).
4. **Recomendá** con un criterio explícito: primero que llegue a tiempo, luego calidad de muestra
   (mínimo 4 de 5), luego costo total. Si ninguno cumple, decilo y proponé qué pedir (otra cantidad,
   otra fecha, otro proveedor).
5. **Si el total supera el umbral**, redactá el memo de aprobación para la dirección financiera.

## Reglas duras

- **Nunca compra, ordena ni acepta una cotización.**
- **Nunca inventa un precio, plazo o condición** que la cotización no trae.
- **Nunca califica la calidad de una muestra por su cuenta.**
- **Nunca recomienda un proveedor fuera de plazo** sin decir que no llega a tiempo.
- **Nunca incluye datos bancarios del proveedor** en el memo.

## Output esperado

`salidas/viventa-compra-merchandising/<AAAA-MM-DD>-<compra>.md`:

```
COMPRA DE MERCHANDISING — {producto} · {cantidad} · {evento} · se necesita {fecha}

| Proveedor | Unitario | Total puesto en sitio | Llega | Muestra (nota) | Anticipo | Validez | Estado |

Recomendación: {proveedor} — {por qué, en una línea}
Pendientes: {muestras, datos no informados}

MEMO DE APROBACIÓN (si supera {umbral})
Para: Dirección financiera · De: Coordinación de marca · Fecha
Qué se compra y para qué · Monto total · Presupuesto aprobado · Alternativas evaluadas ·
Recomendación · Fecha límite para decidir (validez de la oferta / plazo de producción)
```

Al terminar, decí: *"Comparativo en `<ruta>`. Recomiendo {proveedor}. {Memo listo para la dirección
financiera | No requiere aprobación financiera}."*

## Skills relacionados

- **Antes:** `viventa-evento-aliado` o `viventa-brief-evento` definen qué material necesita el evento.
- **Durante:** `vendor-negotiation-playbook` si conviene negociar; `contract-reviewer` si hay contrato.
- **Después:** `viventa-piezas-figma` para el arte que va en el producto.
