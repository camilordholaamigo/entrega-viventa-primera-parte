# Piso legal por canal y mercado — detalle

Referencia de consulta para `viventa-reactivacion-lead`. El resumen operativo está en la Fase 6 del
SKILL.md. Acá va el detalle y las decisiones ya tomadas, para no re-investigar.

> **Esto no es asesoría legal.** Es el piso operativo que el equipo de Growth aplica. Cualquier caso
> de borde escala a Daniel y, si hace falta, a legal.

---

## Tabla de decisión rápida

| Lead reside en | Canal | ¿Se puede? | Requisito |
|---|---|---|---|
| USA | Email | **Sí**, sin consentimiento previo | Opt-out + dirección física + baja 1 clic |
| USA | WhatsApp | **Sí, solo con opt-in** | Opt-in + plantilla aprobada fuera de la ventana de 24 h. **Bloqueado operativamente hoy** |
| USA | DM de IG | Sí, con límites de plataforma | Sin links en DM frío, sin palabras que activen spam |
| **España** | **Email** | **NO sin consentimiento previo registrado** | LSSI art. 21. El interés legítimo **no salva** |
| **España** | **WhatsApp** | **NO sin consentimiento previo registrado** | Mismo régimen |
| España | DM de IG | Zona gris; tratarlo como el resto | Escalar si es masivo |
| Colombia / otros | Email | Sí, con criterio | Aplicar el estándar más alto por defecto |

---

## USA — Email (CAN-SPAM)

**Modelo opt-out.** No hace falta consentimiento previo para enviar correo comercial, pero:

1. **Encabezados veraces** — el "De", "Para", el dominio de origen y la dirección de respuesta no
   pueden engañar sobre quién envía.
2. **Asunto veraz** — debe reflejar el contenido real del correo.
3. **Identificar el correo como comunicación comercial** — de forma clara y visible.
4. **Dirección física válida** — calle real, apartado postal registrado en USPS, o buzón privado de
   una agencia. No sirve una dirección inventada ni omitirla.
5. **Mecanismo de baja claro y visible.** El enlace debe funcionar **al menos 30 días** después del
   envío.
6. **Honrar la baja en ≤10 días hábiles.** No se puede cobrar, ni pedir más datos que el email, ni
   obligar a loguearse.
7. La responsabilidad **no se delega**: contratar a un tercero para enviar no exime.

**Multa: hasta $53.088 por correo.** Cada correo individual cuenta por separado.

### Los proveedores son más estrictos que la ley

Google y Yahoo (2024 en adelante) exigen a los remitentes masivos:

- **Baja en un clic** (`List-Unsubscribe` con `One-Click`), procesada en **≤2 días**.
- **Tasa de quejas de spam <0,1%.** Por encima de 0,3% el envío se degrada o se bloquea.
- Autenticación SPF, DKIM y DMARC.

**Por qué importa acá:** el dominio de Viventa **ya cae en spam** y la base es de 250K registros con
límite de envíos por calidad. Cada envío inútil de reactivación degrada la reputación del remitente
para toda la operación. Este es el argumento técnico detrás del tope de 3 intentos (Fase 5.2 del
SKILL.md).

**Pie de email obligatorio** — el skill lo incluye siempre en la ficha del mensaje:

```
Viventa — <dirección física completa, ciudad, estado, ZIP>
Recibís este correo porque dejaste tus datos con nosotros.
Si preferís no recibir más, dale de baja acá: <enlace de 1 clic>
```

---

## USA — WhatsApp (Meta / WhatsApp Business Platform)

**Modelo opt-in obligatorio.** Es al revés que el email y es el error más común del equipo.

- **Mostrar un número no es consentimiento.** Que alguien dé like, siga la cuenta o comente un post
  **no abre** la ventana de servicio de 24 h.
- La **ventana de 24 h** se abre solo cuando **la persona** escribe primero. Dentro de esa ventana
  se puede responder con texto libre.
- **Fuera de la ventana** solo se envía con **plantilla aprobada** por Meta. Las plantillas de
  categoría *marketing* deben llevar mecanismo de baja: botón de opt-out o palabra clave tipo STOP.
- Desde nov-2024 Meta acepta un **opt-in general**: basta con decir claramente que se recibirán
  mensajes por WhatsApp y nombrar al negocio. No hace falta opt-in por tipo de mensaje.
- **Bloqueos y reportes degradan el quality rating** del número. Suficientes reportes → limitación
  de mensajería o suspensión de la cuenta.

**Estado operativo hoy:** el envío por WhatsApp a USA está **bloqueado** — la verificación de Meta
fue rechazada y se está intentando la vía 10DLC + Twilio. **El skill redacta igual, pero nunca
afirma que se puede enviar ya.** El texto se guarda para cuando se destrabe, o se usa en Wati para
los mercados habilitados.

---

## 🚨 España — LSSI art. 21 + RGPD

**Es el escenario de mayor riesgo del skill.** Régimen opt-in, mucho más estricto que USA.

### Lo que exige el art. 21 de la LSSI

- **Consentimiento previo y expreso** para enviar comunicaciones comerciales por correo electrónico
  o cualquier medio de comunicación electrónica equivalente (incluye WhatsApp y SMS).
- El consentimiento debe ser **específico, informado e inequívoco**. Una casilla premarcada no vale.
- Debe ofrecerse un **procedimiento sencillo y gratuito de oposición**, tanto **en el momento de
  recoger el dato** como **en cada comunicación** que se envíe.
- Excepción estrecha: relación contractual previa con productos o servicios **similares**. Un
  formulario abandonado **no es** una relación contractual previa.

### El interés legítimo NO salva

Es el error conceptual más caro. El RGPD permite invocar interés legítimo como base de tratamiento
en algunos supuestos, **pero la LSSI impone un requisito adicional propio** para la comunicación
comercial electrónica. La LSSI no queda desplazada por el RGPD: conviven, y hay que cumplir las dos.

### Lista Robinson (AEPD)

Si se invoca interés legítimo, hay que **comprobar previamente** que el destinatario no figure en la
**Lista Robinson**, el fichero de exclusión publicitaria gestionado bajo supervisión de la AEPD.
La consulta es un paso previo obligatorio, no opcional.

### Regla operativa para el skill

> **Un lead español que abandonó un formulario, sin consentimiento registrado, NO se puede reactivar
> por correo.**

Si el punto de abandono es **tipo 1** (formulario a medias) o **tipo 6** (frío) y el lead reside en
España, el skill:

1. **Se detiene** antes de redactar el mensaje comercial.
2. **Advierte** explícitamente en el output: *"⚠️ Lead en España sin consentimiento registrado —
   no se puede enviar comunicación comercial por correo (LSSI art. 21)."*
3. Propone, como alternativa, un **mensaje de re-consentimiento**: recordar de dónde salió el
   contacto y pedir permiso expreso para seguir escribiendo. Nada de oferta, nada de venta.
4. O recomienda directamente **no contactar**, si ni siquiera hay trazabilidad del origen del dato.

**Si no se sabe el país de residencia** y el canal es email, se aplica el régimen español por
defecto — es el más restrictivo.

---

## Instagram DM

No hay un régimen legal específico distinto; manda la política de plataforma.

- **Límites de envío:** el orden de magnitud manejado para DM proactivo vía Graph API es de ~200
  DM/hora, con recomendación de escalar gradualmente desde volúmenes bajos.
  `[⚠ cifras de vendors de automatización de DM, no de documentación oficial de Meta — tratar como
  orden de magnitud, no como umbral exacto]`
- **Palabras que activan filtros de spam:** "gratis", "oferta por tiempo limitado", "haz clic aquí",
  "última oportunidad". Todas ya están prohibidas por otras reglas del skill (R6).
- **Links en DM frío:** IG los penaliza. Evitarlos en el primer mensaje.
- **Message requests:** un DM a alguien que no sigue la cuenta cae en la carpeta de solicitudes y
  puede no verse nunca. No es motivo para insistir más — es motivo para escribir mejor el primero.

---

## Reg Z — 12 CFR 1026.24 (verificado, no re-investigar)

**Los *triggering terms*.** Si un anuncio de crédito al consumo menciona alguno de estos, se
disparan obligaciones de divulgación:

- monto o porcentaje de la **cuota inicial**
- número de pagos o **plazo**
- monto de cualquier **pago** o cuota
- monto de cualquier **cargo financiero**

Mencionar cualquiera obliga a divulgar, **en la misma pieza y con igual prominencia**, el APR y los
demás términos exigidos. **Un disclaimer no lo cura.** No hay forma de escribir un WhatsApp de 40
palabras que cumpla esto.

### Salida limpia y no negociable

> **El mensaje de reactivación no menciona ninguno de esos términos. Punto.**

**Bloqueo léxico duro.** Ninguna de estas palabras aparece en el output:

`tasa` · `interés` · `%` · `cuota` · `mensualidad` · `plazo` · `años para pagar` ·
`cuota inicial` · `financiación a X` · `pago inicial` · `abono mensual`

**Si el usuario del skill pide incluirlos:** el skill se **niega**, explica por qué en una frase, y
ofrece la alternativa que sí funciona: *"eso te lo explica una asesora en la llamada"*.

### La concreción va por otro lado

La guía de voz de `CONTEXT.md` pide "aterrizar en cifras concretas". **Para este skill esa
instrucción queda anulada.** La concreción se consigue con hechos no financieros y verificables:

- dirección física de la oficina (Miami · Madrid · Colombia)
- 20 años de track record
- 5 bancos y ~20 constructoras
- el nombre del proyecto por el que preguntó
- la ciudad y fecha del evento al que se registró

---

## FTC — dark patterns (Sección 5)

La FTC clasifica explícitamente como dark patterns perseguibles:

- **False Limited Time Message** — plazo o promoción que no existe.
- **False Low Stock Message** — escasez inventada ("últimos cupos", "últimas unidades").

Ya ha demandado por crear sensación falsa de escasez. Sobre una audiencia cuyo miedo declarado es
que la estafen, además de ilegal es **suicidio comercial**.

**Regla:** un plazo solo se usa si **existe y es verificable** — fecha real de un evento, fecha real
de cierre de inscripciones. Sin dato → sin plazo.

---

## Prohibiciones adicionales de Viventa (no legales, pero duras)

- **No prometer aprobación de crédito ni tasas específicas** sin validación del área de Crédito.
- **No anunciar un evento sin dirección y ciudad concretas** — fricción #1 del VOC.
- **No usar jerga financiera sin traducir** (LTV, DTI, amortización).
- **No hablar como banco.** Prohibidas: "unlock", "leverage", "solución integral", "aliado
  estratégico", "asesoría personalizada".
- **VA loan no financia propiedad fuera de EE.UU. ni de sus territorios.** Nunca insinuar lo
  contrario.
- **Ninguna campaña sale al aire sin revisión humana** (Daniel). Este skill termina en un entregable
  para aprobar, nunca en un envío.
