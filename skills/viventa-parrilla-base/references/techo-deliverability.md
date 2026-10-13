# Techo de deliverability

Referencia de `viventa-parrilla-base`, Fase 4.

---

## El problema, en una línea

**El dominio de Viventa ya cae en spam.** El responsable de email marketing, textual:
*"la cantidad de mensajes que envío están llegando a spam."*

Con ~250K registros sin limpiar, la tentación permanente es "mandarle a toda la base". Eso es
exactamente lo que produjo el problema. **El problema nunca fueron los 250K registros: fue
escribirles a los 250K.**

Por eso el techo no es una recomendación de buenas prácticas. Es la restricción de arquitectura
que decide cuánta parrilla cabe.

---

## Los 4 tiers de engagement

| Tier | Definición | Qué recibe |
|---|---|---|
| **Tier 1** | Abrió algo en los últimos **90 días** | Todo |
| **Tier 2** | Abrió entre **91 y 180 días** | Solo lo de mayor valor. Máximo 2 correos/mes |
| **Tier 3** | **+180 días** sin abrir | **Nada de esta parrilla.** Va a re-permiso o a Meta |
| **Tier 4** | Rebote duro o queja de spam | **Supresión permanente.** Nunca vuelve |

**Tier 3 es la regla que más se rompe y la que más cuesta.** Un contacto que no abre hace 6 meses
no es un contacto barato: es el que empuja el dominio a spam y arrastra la entregabilidad de los
tier 1, que sí convierten. Escribirle no es gratis — se paga con la apertura de todos los demás.

---

## Fórmula

```
Techo mensual = (tier 1 alcanzable × 4)
              + (tier 2 alcanzable × 2)
              − volumen comprometido por convocatorias de evento
```

**Alcanzable** = del tier, restando los que ya están en una supresión activa.

### Frecuencia máxima por contacto: 4 correos/mes

Cuenta **todo**: parrilla + convocatoria de evento + transaccionales de registro.

Un contacto que ya recibe 6 correos de una convocatoria **no entra en la parrilla del mes**. No se
le manda "uno más porque este es distinto".

La fricción está documentada en el Voice of Customer:
*"siempre hay que colocar correo y luego te saturan."*
**La queja es saturación, no silencio.**

### Prioridad: los eventos van primero

La convocatoria de un evento es **fechada e irreversible** — el evento tiene día. La parrilla vive
en el volumen que sobra después de restarla.

Si la parrilla deseada no cabe, **se recorta la parrilla**, nunca se sube el techo.

---

## Volumen sano por convocatoria

Una convocatoria de ciudad sale a **2.000-6.000 contactos, no a 250.000**.
`[⚠ no verificado — estimación de orden de magnitud; confirmar en Zoho]`

Menos volumen produce **más apertura, mejor reputación de dominio y más asistentes**, no menos.
Es contraintuitivo y es la razón por la que la regla se rompe.

---

## Higiene mínima antes de subir cualquier volumen

Si alguien pide ampliar el techo, estas son las condiciones previas — todas, no algunas:

1. **Limpieza de los 250K registros** — deduplicación, rebotes duros fuera, sintaxis inválida
   fuera. Está en el backlog de integración (#3).
2. **Autenticación del dominio** verificada: SPF, DKIM y DMARC.
3. **Warm-up progresivo** si el dominio estuvo en spam — subir volumen de golpe reinicia el
   problema.
4. **Tasa de rebote < 2 %** y tasa de queja < 0,1 % sostenidas, medidas, no supuestas.

Mientras no se cumplan, el techo es el que es. **Recomendar "mandar más correos" sin decir esto es
recomendar quemar el canal más barato de la compañía** — email tiene un CAC fully-loaded de [cifra interna]
contra [cifra interna] de Meta.

---

## Qué hacer con tier 3 en vez de escribirle

- **Campaña de re-permiso**, una sola vez: un correo que pide confirmación explícita de que
  quiere seguir recibiendo. Quien no responde, sale.
- **Audiencia de Meta** (custom audience): el contacto sigue siendo alcanzable por otro canal sin
  costo de dominio.

Ninguna de las dos es parrilla. Van al plan de impacto como decisión declarada, no como fila.
