# Umbrales, semáforo y matriz de divergencia

Referencia de `viventa-forecast-pauta`, Fases 4, 5 y 6.

---

## Días útiles — el número que decide si el forecast sirve

```
Días útiles = días calendario restantes
            − latencia de la agencia externa (~4-5 días)
            − días bloqueados por compromisos irreversibles
```

**Por qué se resta la latencia:** la pauta la ejecuta una agencia externa. Entre que se decide un
cambio y que el cambio corre, pasan ~4-5 días. Un forecast que dice "quedan 9 días para corregir"
cuando en realidad quedan 4 produce decisiones que llegan tarde — que es exactamente el problema
que el skill vino a resolver.

`[⚠ no verificado]` La latencia de 4-5 días es estimación del equipo, no un SLA documentado.
Si el cliente confirma otro número, se usa ese.

### La regla de corte

**Días útiles ≤ 0 → modo B y termina.** No se emiten alertas ni opciones.

Un forecast con cero días útiles no es accionable: es un reporte histórico. Emitir 3 opciones que
nadie puede ejecutar es peor que no emitir nada, porque simula que hay decisión donde no la hay.

El modo B dice qué pasó, cuánto cerró y qué aprender para el mes entrante. Nada más.

---

## Monto influenciable

Es el complemento en plata de los días útiles: cuánto del cierre proyectado todavía se puede mover.

```
Monto influenciable = capa 4 (comprometido) − compromisos irreversibles
```

**Compromisos irreversibles:**
- Todo lo devengado (capas 1, 2 y 3)
- **Pauta de eventos dentro de la ventana de 45 días**

Los dos números — días útiles y monto influenciable — van **arriba, en el titular**. Son la
respuesta a *"¿todavía puedo hacer algo?"*, y esa pregunta se contesta antes que ninguna otra.

---

## Semáforo de ejecución

**Doble condición: porcentaje Y monto.** Un desvío del 30 % sobre $200 no es una alerta; sobre
$20.000 sí. Pedir las dos evita el ruido que hace que se dejen de leer las alertas.

**Persistencia de 2 días.** Un pico de un día es varianza normal de subasta, no una tendencia.

| Estado | Condición | Qué significa |
|---|---|---|
| 🟢 Verde | Proyección dentro de ±10 % del presupuesto | En ritmo |
| 🟡 Ámbar | Desvío 10-20 % **y** monto material, 2 días seguidos | Vigilar, preparar opción |
| 🔴 Rojo | Desvío > 20 % **y** monto material, 2 días seguidos | Actuar en esta corrida |
| 🔵 Sub-ejecución | < 75 % de lo esperado al día 20 | **Alerta simétrica** |

### La alerta de sobrecosto exige las tres condiciones juntas

*"Esta campaña va a salir cara"* solo se emite si se cumplen **las tres**:

1. CPL real ≥ 20 % sobre objetivo
2. Sostenido ≥ 3 días
3. Quedan ≥ 5 días útiles

Si falta la tercera, la afirmación puede ser cierta pero es inútil: no hay ventana para corregir.
Va a la lectura del cierre, no a las alertas.

### Sub-ejecución también es alerta

**Presupuesto sin usar es mala planeación, no ahorro.** Menos de 75 % ejecutado al día 20 significa
que se dejó de comprar volumen que estaba presupuestado, y en un mes con eventos eso se paga en
leads que no entraron. Se reporta con la misma severidad que la sobre-ejecución.

---

## Matriz de divergencia gasto ↔ leads

El aporte real de esta matriz: hoy las cuatro celdas se llaman igual — *"nos sobre-ejecutamos"* —
y son **cuatro conversaciones distintas con cuatro dueños distintos**.

|  | Leads en ritmo | Leads atrasados |
|---|---|---|
| **Gasto en ritmo** | 🟢 Sano | 🔴 **EFICIENCIA** — el CPL se degradó |
| **Gasto atrasado** | 🟢 Mejor de lo planeado | 🟡 **ENTREGA** — el CPL está sano, no está gastando |
| **Gasto sobre-ejecutando** | 🟡 Volumen comprado, revisar el marginal | 🔴🔴 Peor cuadrante |

**Nombrá el cuadrante con su palabra: eficiencia o entrega.** No son sinónimos:

- **Eficiencia** — el creativo, el ángulo o la audiencia dejaron de rendir. Se arregla cambiando
  qué se dice. Dueño: contenido y agencia.
- **Entrega** — la campaña no está gastando lo presupuestado. Presupuesto mal configurado,
  audiencia chica, puja baja, aprobación pendiente. Se arregla en la plataforma. Dueño: agencia.

Confundirlas produce el clásico "hagamos creativos nuevos" cuando el problema era que la campaña
estaba pausada.

### Proyección de leads

```
Leads proyectados = leads a la fecha ÷ % del mes transcurrido
```

**Solo válido en régimen.** Si el gasto proyectado difiere > 20 % del ritmo actual, la proyección
de leads **se degrada a rango y se dice explícitamente**.

⚠️ **Al proponer subir gasto:** declarar que la extrapolación **no es válida hacia arriba**. La
curva de respuesta es en S — el inventario barato ya se agotó, y el lead marginal cuesta más que
el promedio. **Nunca prometer leads proporcionales al aumento.**

---

## Marco de reasignación

Al señalar dirección de reasignación se puede usar el CAC fully-loaded canónico como marco:

| Canal | CAC fully-loaded |
|---|---|
| Web | [cifra interna] |
| Email | [cifra interna] |
| WhatsApp | [cifra interna] |
| Instagram | [cifra interna] |
| Meta | [cifra interna] |
| Google | [cifra interna] |
| Eventos | [cifra interna] |

**Es un marco, no una promesa.** Mover presupuesto de Meta a email no produce leads a [cifra interna]: produce
leads a un costo desconocido, porque el canal barato ya está saturado con la base que hay. El
skill señala la dirección; no cuantifica el resultado de la reasignación.

⚠️ Y el techo real de email no es presupuestario: **el dominio ya cae en spam** y la base de 250K
está sin limpiar. Recomendar "mandar más correos" sin decir eso es recomendar quemar el canal más
barato de la compañía.
