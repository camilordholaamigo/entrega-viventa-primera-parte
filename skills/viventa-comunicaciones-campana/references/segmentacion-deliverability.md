# Segmentación y deliverability — tablas de referencia

> El dominio de Viventa **ya cae en spam** (el responsable de email marketing: *"la cantidad de mensajes que envío están
> llegando a spam"*). El problema no son los 250K registros: **es enviarles a los 250K.**
> Estas tablas no son buenas prácticas: deciden a cuánta gente se le escribe y qué se le escribe.

---

## 1. Las tres capas de segmentación (se cruzan, no se eligen)

### Capa 1 — Geografía

Solo contactos a **≤90 minutos de desplazamiento** de la ciudad del evento.

No es solo entregabilidad: es la fricción #3 del Voice of Customer, textual —
*"estos eventos siempre van a Miami y nunca he visto uno acá en Broward, como que si todos los
colombianos viviéramos en Miami-Dade"*. Invitar a alguien de Sevilla a un evento en Valencia
produce ese comentario **y** una queja de spam.

### Capa 2 — Engagement

| Tier | Definición | Qué recibe | Racional |
|---|---|---|---|
| **Tier 1 — Activo** | Abrió o clicó en los últimos **90 días** | Secuencia completa (E1, E2, E3, E4 + WhatsApp) | Es el segmento que **reconstruye** reputación |
| **Tier 2 — Tibio** | Abrió entre **91 y 180 días** atrás | **Solo E1 y E3** (2 toques máximo) | Se prueba si revive, sin insistir |
| **Tier 3 — Dormido** | **+180 días** sin abrir | **NADA de esta secuencia** | Cada envío a Tier 3 destruye lo que Tier 1 construye |
| **Tier 4 — Rebotó / se quejó** | Hard bounce o marcó spam | **Supresión permanente** | Innegociable |

**Qué se hace con Tier 3.** No se abandona: se trabaja **fuera de esta secuencia** —
campaña de re-permiso propia (un solo correo, *"¿seguimos escribiéndote?"*, en tandas pequeñas y
espaciadas) o **retargeting en Meta**, que no toca el dominio. Mezclar re-permiso con convocatoria
a evento quema las dos cosas a la vez.

### Capa 3 — Estado en el funnel

Registrados y no registrados **nunca** reciben lo mismo, en ningún momento.
Quien se registra sale de la convocatoria en ese instante y pasa al carril de registrados
(E0 → E4 → W3 → W4).

**Impacto esperado:** una convocatoria bien segmentada para una ciudad sale a
**2.000-6.000 contactos, no a 250.000** `[⚠ no verificado — estimación de orden de magnitud sobre
los 250K; el responsable de email marketing debe confirmarla contra Zoho]`. Menos volumen, más apertura, mejor
reputación y **más asistentes**, no menos.

---

## 2. Lista negra del asunto (gate duro — si aparece, se reescribe, no se advierte)

Prohibido en el asunto:

- **Mayúsculas sostenidas** y signos repetidos (`!!!`, `???`).
- **Emojis.** En cuerpo de WhatsApp sí; en asunto de email de un dominio tocado, no.
- **Urgencia artificial:** "última oportunidad", "solo hoy", "no te lo pierdas", "urgente",
  "cupos limitados", "corre", "quedan pocos" — salvo que los cupos sean **literalmente** limitados
  y el número esté verificado.
- **Vocabulario financiero-promocional:** "gratis", "100%", "aprobado", "preaprobado",
  "sin intereses", "oferta", "garantizado", "financiación fácil", "crédito fácil", "sin requisitos".
- **Signos de moneda y cifras de tasa** en el asunto (`$`, `€`, `10%`, "desde 280").
- **Promesa que el cuerpo no cumple.** Ilegal bajo CAN-SPAM y es el patrón que los filtros detectan
  comparando asunto contra cuerpo.

**Lo que sí funciona en esta base:** asuntos de **4-8 palabras**, minúscula natural, que suenan a
mensaje de una persona y no a campaña.
*"Comprar en Colombia sin tener que volver a viajar"* ·
*"Qué pasa exactamente el sábado 19 en Valencia"* ·
*"Lily compró desde España hace 10 años"*.

> `[⚠ no verificado]` No hay benchmark publicado que compare español neutro vs. español de Colombia
> en tasa de apertura para audiencias hispanas en USA/España. La regla de usar colombiano se
> sostiene en la voz de marca y el ICP, no en un dato. Si email marketing quiere el dato: A/B propio.

---

## 3. Reglas del cuerpo

- **Nunca un correo que sea una sola imagen.** Mínimo **60% texto**. El flyer del evento va como
  **enlace**, no como cuerpo.
- **Máximo 2-3 enlaces**, todos al dominio propio. **Cero acortadores** (bit.ly y similares
  arrastran reputación de terceros).
- **Versión en texto plano siempre.** Su ausencia es señal de spam.
- **Pie legal completo en todos:** razón social, **dirección postal física** y baja visible en un
  clic.
- **Cabecera `List-Unsubscribe`** además del enlace del pie — Gmail y Yahoo la exigen a remitentes
  masivos; el pie solo ya no alcanza.
- **Bajas procesadas** en ≤10 días (USA) y de inmediato en España.

**Marco legal aplicable:** CAN-SPAM para USA (multas de hasta **$53.088 por correo**);
LSSI + LOPDGDD para España, régimen de **opt-in explícito**, supervisor AEPD.

---

## 4. Frecuencia y orquestación de canal (cuatro reglas mecánicas)

1. **Escalonamiento, nunca simultaneidad.** Mínimo **48 h** entre un correo y el WhatsApp que lo
   sigue. Nunca el mismo día.
2. **WhatsApp es escalada, no difusión.** W1 y W2 solo a quien **abrió o clicó** el correo previo.
   WhatsApp en frío quema el canal. W3 y W4 solo a **registrados** — ahí ya es servicio.
3. **Supresión inmediata al convertir.** Quien se registra sale de convocatoria ese mismo momento.
   Seguir invitando a quien ya se inscribió es lo que produce *"me saturan"*.
4. **Tope global de frecuencia:** máximo **4 emails + 3 WhatsApp por persona en 21 días**, contando
   **todo** lo que Viventa le mande, incluidas otras campañas. El tope se aplica sobre el contacto,
   no sobre la campaña.

---

## 5. Las dos cosas que este skill NO puede arreglar (imprimir al final de cada paquete)

1. **SPF, DKIM, DMARC, rDNS y la separación de subdominio** (marketing desde `mail.viventa.co`,
   transaccional desde el dominio raíz) son trabajo de **TI**, no de un skill. Sin eso resuelto,
   **el mejor copy del mundo sigue cayendo en spam.**
   `[⚠ no verificado]` El estado exacto de la autenticación del dominio no fue auditado.
2. **La limpieza de los 250K registros** es higiene de datos. Este skill mitiga el síntoma al no
   enviarles; no cura la causa.

Texto exacto a imprimir:

```
⚠ ALCANCE — lo que este paquete no arregla
1. SPF / DKIM / DMARC / rDNS y la separación de subdominio de envío son trabajo de TI.
   Sin eso resuelto, el mejor copy sigue cayendo en spam.
2. La limpieza de los 250K registros es higiene de datos. Acá se mitiga el síntoma
   (no se les envía); la causa sigue abierta.
Este paquete requiere revisión humana antes de programar.
```

---

## 6. Ficha de canal — email vs. WhatsApp

| | **Email** | **WhatsApp** |
|---|---|---|
| **Trabajo** | Explicar, argumentar, probar | Empujar a **una** acción |
| **Extensión** | 150-280 palabras | **Máx. 40 palabras** |
| **Voz** | La marca ("el equipo de Viventa") | **Una persona con nombre** ("soy {consultora} de Viventa") |
| **Estructura** | Asunto + preheader + cuerpo + CTA + pie legal | Un bloque, **una** pregunta al final |
| **Contenido propio** | Testimonios, desglose del proceso, filosofía | Dirección, hora, mapa, confirmación |
| **Formato** | Viñetas y párrafos | Emojis funcionales (📍🕙🚇), nunca decorativos |
| **CTA** | Botón a landing de registro | Pregunta directa que se responde por chat |
| **Nunca lleva** | Emojis en el asunto | Argumentación, links múltiples |

---

## 7. CAC por canal — por qué el email es la palanca

| Canal | CAC fully-loaded |
|---|---|
| **Email** | **[cifra interna]** |
| **WhatsApp** | **[cifra interna]** |
| Instagram | [cifra interna] |
| Meta | [cifra interna] |
| Google | [cifra interna] |
| Eventos | [cifra interna] |

Email cuesta **9,9× menos que Meta** y **12,3× menos que un evento**. Cada evento de USA que sale
sin WhatsApp deja plata sobre la mesa en el segundo canal más barato que tiene la compañía.
