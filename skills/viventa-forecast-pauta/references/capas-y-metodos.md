# Las 4 capas de gasto y los 3 métodos de proyección

Referencia de `viventa-forecast-pauta`, Fases 2 y 3.

---

## Por qué existen 4 capas y no un número

El dolor que ataca el skill es de **latencia, no de aritmética**: la información de gasto llega
20-25 días tarde, cuando la decisión ya se tomó. Lizeth, textual:

> *"estamos al 15 de junio y yo tengo la información hasta mayo… cuando llega la información de
> junio me doy cuenta que se sobre ejecutó."*

Un solo número de "gasto del mes" esconde exactamente lo que hace falta para decidir: **cuánto de
eso ya es irreversible**. Por eso se separan cuatro capas con reversibilidad distinta.

---

## Capa 1 — Ejecutado y facturado

**Origen:** contabilidad, o Zoho Expense con estado aprobado.
**Reversible:** no.
**Confianza:** alta. Es el único dato que no se discute.

Es también el más viejo: si contabilidad cierra con 20 días de rezago, la capa 1 al día 15 del mes
puede estar **casi vacía** y eso no significa que no se haya gastado nada.

⚠️ **Modo de falla:** leer capa 1 baja como "vamos bien de presupuesto". Es el error que produce la
sobre-ejecución que Lizeth describe. Si capa 1 es la única con datos, el forecast **no se emite**:
se emite el pedido del spend-to-date del Ads Manager.

---

## Capa 2 — Ejecutado sin facturar

**Origen:** spend-to-date del Ads Manager (Meta, Google).
**Reversible:** no — el dinero ya se gastó.
**Confianza:** alta para el monto, con la salvedad de la ventana.

**Es el ciego que este skill viene a cerrar.** Es plata real ya gastada que todavía no apareció en
ningún sistema contable. En un mes normal, al día 15, esta capa es la más grande de las cuatro.

⚠️ **Modo de falla:** confundirla con capa 4. El presupuesto diario de una campaña activa genera
las dos cosas — lo que ya corrió es capa 2, lo que va a correr es capa 4. Sumarlas dos veces
infla el cierre proyectado; omitir la 2 lo subestima.

⚠️ **La ventana importa más que el monto.** Un export "al 14-ago" en un corte al 17-ago deja
3 días de gasto invisible. Va a "Qué no sé", con el monto estimado por ritmo marcado
`[proyección]`, nunca sumado como `[dato]`.

---

## Capa 3 — Pendiente de legalizar

**Origen:** Zoho Expense, cargado y sin aprobar.
**Reversible:** no. Ya ocurrió; falta el trámite.
**Confianza:** media — el monto puede ajustarse en la aprobación.

Típicamente gastos de evento: catering, alquiler de salón, viáticos, impresión.

⚠️ **Modo de falla:** descartarla porque "todavía no está aprobada". Es gasto comprometido y
consumado; que el trámite falte no lo vuelve reversible.

---

## Capa 4 — Comprometido

**Origen:** presupuesto diario activo × días restantes · brief firmado con la agencia · retainer.
**Reversible:** **sí, parcialmente.** Es la única capa sobre la que se puede actuar.
**Confianza:** media — depende de que nadie toque los presupuestos diarios.

**Es la capa que hace útil el forecast.** Las otras tres describen el pasado; esta es la que
todavía se puede mover, y es el numerador del *monto influenciable* de la Fase 4.

⚠️ **Modo de falla:** meter acá la pauta de eventos dentro de la ventana de 45 días. Está
comprometida pero **no es tocable**: cortarla rompe la regla de anticipación y degrada el CPL del
evento entero. Va en capa 4 y se marca explícitamente como **QUÉ NO SE TOCA**.

---

## Regla de partición

**Cada peso cae en exactamente una capa.** Si un monto podría ir en dos, es señal de que la
ventana de los exports se solapa — se resuelve mirando fechas, nunca repartiendo a ojo.

`Capas 1 + 2 + 3 = posición devengada.` Subtotal siempre visible.

Las cuatro filas se muestran **aunque una vaya en cero**: `Eventos: comprometido $0` es
información, no una fila vacía.

---

## Los 3 métodos de proyección

Se corren **los tres, siempre**, y se comparan. No se elige uno de antemano.

### 1. Por compromisos — primario

```
Cierre = devengado + (presupuesto diario activo × días restantes) + compromisos fechados
```

El más confiable cuando las campañas están estables. Es el único que "sabe" que una campaña se
apaga el día 22 porque así está configurada.

**Falla cuando:** hay campañas que se van a crear y todavía no existen. Subestima.

### 2. Run-rate lineal

```
Cierre = gasto a la fecha ÷ % del mes transcurrido
```

Simple y transparente. Sirve de control de sanidad de los otros dos.

**Falla cuando:** el mes tiene un evento concentrado. Un evento el día 8 hace que el run-rate
proyecte una barbaridad. **Por eso los eventos salen del run-rate y entran como bloque fechado
en capa 4** — si no, el método es inservible en un mes con eventos, que en Viventa son casi todos.

### 3. Ventana de 3 días

```
Cierre = devengado + (promedio de gasto de los últimos 3 días × días restantes)
```

Capta cambios recientes de ritmo que el run-rate del mes entero diluye.

**Falla cuando:** los últimos 3 días son fin de semana o caen dentro de un pico de evento.
Revisar qué días son antes de usarlo.

---

## Qué hacer con la divergencia entre métodos

| Divergencia | Qué se emite |
|---|---|
| ≤ 5 % | **Punto.** Se reporta el valor del método por compromisos |
| > 5 % | **Banda,** no punto. Mínimo y máximo, con el método que produce cada extremo nombrado |
| > 20 % | Banda **+ una línea diciendo por qué divergen tanto.** Casi siempre es un evento mal clasificado o una ventana de export desalineada |

**Nunca se promedian los tres métodos.** Un promedio esconde la razón de la divergencia, que suele
ser el hallazgo más útil de la corrida.

**El supuesto de ritmo va escrito debajo del número, siempre.** Un forecast sin su supuesto no se
puede discutir, y si no se puede discutir no se puede usar para decidir.

---

## Sobre inferir leads desde el gasto

**No se hace.** El CAC ad-spend de Meta ([cifra interna] con [cifra interna] leads/6m) implica un CPL de ~$2.90,
incompatible con el CPL canónico de [cifra interna]. Los "leads de Meta" de esa fuente mezclan pagados con
orgánicos. `[⚠ no verificado]`

De ahí no se deriva nada: si falta el conteo de leads, se pide.
