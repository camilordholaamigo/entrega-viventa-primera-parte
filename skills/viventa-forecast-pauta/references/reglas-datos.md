# Reglas de datos y anti-patterns

Referencia de `viventa-forecast-pauta`. Aplica a toda cifra que salga en la ficha.

---

## Las 10 reglas canónicas

1. **Toda cifra lleva etiqueta de origen.** `[dato]` · `[proyección]` · `[input]` · `[derivado]` ·
   `[n/d]`. Una cifra sin etiqueta no sale. Es la regla que hace auditable la ficha: quien la lee
   tiene que poder distinguir en un vistazo qué se midió de qué se supuso.

2. **CPL ≠ CAC.** CPL es costo por lead; CAC es costo por cierre. Los encabezados dicen la palabra
   completa la primera vez. **Nunca una columna llamada solo "costo".**

3. **Conversión a desembolso ≠ conversión a pago de servicio.** Son [cifra interna] y [cifra interna], dos KPIs
   distintos. Van en filas separadas y etiquetadas, o no van.

4. **Presupuesto aprobado y CPL objetivo son INPUT, nunca inferidos.** Si no los dan, se piden. Un
   forecast contra un presupuesto inventado no dice nada, y peor: parece que dice algo.

5. **Ticket de Servicio Viventa = $480.** No $495.

6. **El +42 % es crecimiento de la participación del segmento de no residentes** (8.8 % → 12.5 %,
   Camacol), **no crecimiento del mercado.** El mercado total crece 5-12 %.

7. **Cero conversión automática de moneda.** Si el export está en EUR y el presupuesto en USD, se
   reportan separados y se pide la tasa que usa contabilidad. Nunca se convierte a ojo.

8. **Ninguna proyección sin su supuesto escrito debajo.**

9. **Los `[⚠ no verificado]` heredados del input se mantienen visibles** en el output. No se
   limpian, no se ascienden a dato.

10. **Si dos fuentes discrepan, se muestran las dos**, se dice cuál manda y se reporta el delta en
    porcentaje. Elegir una en silencio es la manera más rápida de perder la confianza en la ficha.

---

## Los 14 anti-patterns

Cada uno con la razón, porque sin la razón se vuelven a cometer.

### Sobre las capas

1. **Sumar capa 2 y capa 4 sobre la misma campaña.** El presupuesto diario genera las dos: lo
   corrido es 2, lo que falta es 4. Sumarlas duplica el cierre proyectado.

2. **Leer capa 1 baja como "vamos bien".** Contabilidad cierra tarde. Capa 1 vacía al día 15 es lo
   normal, no una buena noticia. **Es el origen literal de la sobre-ejecución que reportó la gerente de Growth.**

3. **Descartar capa 3 porque "no está aprobada".** Ya se gastó; falta el trámite.

4. **Meter la pauta de eventos a ≤45 días en el monto influenciable.** Está comprometida y no es
   tocable. Ofrecerla como palanca es ofrecer romper el evento.

### Sobre la proyección

5. **Promediar los tres métodos.** Esconde la razón de la divergencia, que suele ser el hallazgo
   más útil de la corrida.

6. **Dejar los eventos dentro del run-rate.** Un evento el día 8 hace que el método proyecte una
   barbaridad. Salen del run-rate y entran fechados en capa 4.

7. **Emitir punto cuando los métodos difieren > 5 %.** Se emite banda.

8. **Prometer leads proporcionales al aumento de gasto.** La curva es en S: el inventario barato ya
   se agotó y el lead marginal cuesta más que el promedio.

9. **Proyectar leads fuera de régimen.** Si el gasto proyectado difiere > 20 % del ritmo actual, la
   proyección de leads se degrada a rango.

### Sobre las alertas

10. **Alertar por porcentaje sin mirar el monto.** 30 % sobre $200 no es una alerta. El ruido hace
    que se dejen de leer las que sí importan.

11. **Alertar por un pico de un día.** Varianza normal de subasta. Persistencia mínima: 2 días.

12. **Emitir "va a salir cara" sin días útiles.** Puede ser cierto y ser inútil: si no hay ventana
    para corregir, es historia, no alerta.

13. **Tratar la sub-ejecución como ahorro.** Presupuesto sin usar es volumen que no se compró; en
    un mes con eventos se paga en leads que no entraron.

### Sobre el alcance

14. **Aprobar, pausar o mover algo.** El skill **alerta y recomienda**. El gasto significativo lo
    aprueba dirección financiera, y la ejecución en plataforma es de la agencia. Toda opción sale
    rotulada *"requiere aprobación de dirección financiera"*. Es regla durable del cliente.

---

## Sobre el ROI de evento — por qué no se calcula

Va acá porque va a ser pedido y la respuesta correcta es no darlo.

**Hoy nadie puede afirmar si un evento gana o pierde plata.** Los números disponibles:

| Concepto | Valor |
|---|---|
| Ticket Servicio Viventa | $480 |
| CAC de evento | [cifra interna] |
| **Margen por cierre solo con SV** | **[cifra interna]** |

Los eventos solo cierran en negro cargando **Vive Casas**, y el **valor por operación de Vive
Casas no existe en las cifras canónicas**.

Por lo tanto:

- **El skill no calcula ROI de evento.** Emite `[n/d]` y nombra el dato que falta.
- **No dice "el evento es rentable" ni "no es rentable".** Dice **"rentabilidad no calculable"**,
  que es distinto y es lo cierto.
- Estimar el valor de Vive Casas para completar la cuenta sería inventar el número que decide la
  conclusión entera.

Conseguir ese dato vale más que cualquier mejora al skill.
