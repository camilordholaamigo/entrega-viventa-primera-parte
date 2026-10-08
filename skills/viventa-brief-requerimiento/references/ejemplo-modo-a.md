# Ejemplo completo — MODO A

Referencia de `viventa-brief-requerimiento`. Caso de solicitud que **sí** pasa la regla de corte.

## Solicitud recibida

> *WhatsApp de comercial:* «Lizeth, necesitamos empujar Vive Casas en Florida este mes. La meta
> del equipo son 300 leads y el CPL no puede pasar de 40 dólares. Arrancamos el 20 de agosto, va
> por Meta. Ya tenemos el proyecto de Santa Marta y el de Barranquilla. ¿Me ayudan con creativos?»

## Chequeo

- Objetivo: 300 leads · CPL ≤ USD 40 · desde el 20-ago → **pasa las 4 preguntas**.
- P0 presentes: objetivo ✅ · audiencia ✅ (Florida, Vive Casas) · entregables ⚠ (no dice cuántos)
  · canal ✅ (Meta) · aprobador paso 1 ✅ (el solicitante).
- Falta **exactamente 1** P0 (entregables) y **hay precedente citable**: campañas Meta previas de
  Vive Casas Florida → **MODO A** con ese campo marcado.

## Output

```markdown
# BRIEF — Campaña Meta · Vive Casas Florida
Solicitante: Andrés Gil (Comercial USA) · Recibido: 6-ago · Necesidad: 20-ago
Tipo: campaña de ads · Estado: COMPLETO — se puede arrancar

## 1. Objetivo de negocio
300 leads de Vive Casas desde Florida (USA) a un CPL ≤ USD 40, entre el 20-ago
y el 20-sep. Es CPL (costo por lead), no CAC (costo por cierre) — no mezclar.
Traducción a negocio: 300 leads × [cifra interna] ≈ 7 pagos de Servicio Viventa
(ticket USD 480). [SUPUESTO: conversión canónica del área, confirmar si aplica
a este sub-segmento]

## 2. Audiencia
Colombianos en Florida (Miami-Dade, Broward, Tampa Bay), ingresos en USD,
envían remesas, familia en Colombia. Bloqueo real: no saben si califican
para el crédito ni cómo hacerlo sin volver.
Sub-segmento del ICP: comprador de obra nueva, primera compra.

## 3. Mensaje principal (uno solo)
Puedes comprar tu casa en Colombia sin volver y sin quedar solo en el proceso.
Prueba: 20 años · 5 bancos · oficinas en USA, España y Colombia.
NO decir: aprobación de crédito garantizada, ni tasas específicas, sin visto
bueno del área de Crédito.

## 4. Entregables y especificaciones
| Pieza | Cantidad | Formato | Canal |
|---|---|---|---|
| Video vertical | 3 | 9:16 | Meta feed/reels |
| Estática | 2 | 4:5 (Meta ya recomienda 4:5 sobre 1:1) | Meta feed |
| Landing de captura | 1 | Zoho Landing | destino de los anuncios |
[SUPUESTO: cantidades tomadas del pack estándar de campañas Meta previas de
Vive Casas Florida] Confirmar antes de producir.
Moneda de las cifras en pieza: USD.

## 5. Aprobadores (secuencial, un dueño por paso)
1. Contenido y oferta — Andrés Gil (solicitante) · 24 h hábiles
2. Marca y palabras prohibidas — Daniel Vélez · 24 h hábiles
3. Claims financieros (cuota, tasa, "calificas") — área de Crédito · 48 h hábiles
Consolidador único de observaciones: Andrés Gil. Canal único: el hilo del brief.
Máximo 2 rondas de revisión.
Congelamiento: aprobado el paso 2, todo cambio de texto, imagen o lineamiento
entra como SOLICITUD NUEVA, no como observación.
Si un aprobador no responde en su plazo: la entrega se corre 1 día hábil por
cada día de silencio y se escala a Lizeth. El silencio NO aprueba.
[⚠ no verificado] Plazos y orden pendientes de ratificar por Alejandra, Daniel
y Lizeth.

## 6. Fechas
Necesidad declarada: 20-ago. Ruta crítica: 3 aprobaciones (hasta 4 días
hábiles) + producción. ⚠ La fecha de entrega la confirma Alejandra — este
brief no la compromete.

## 7. Referencias
Piezas previas de Vive Casas Florida + `Playbook comercial y objeciones/`.
```

## Qué mirar de este ejemplo

- El presupuesto de pauta **no aparece inventado**: la solicitud dio CPL objetivo, no monto.
- La traducción a negocio usa [cifra interna] (pago de SV), **no** [cifra interna] (desembolso), y va marcada.
- El 4:5 **fuerza la decisión** en vez de dejar el 1:1 por inercia.
- El paso 4 (presupuesto) **no se activó** porque el solicitante no declaró inversión.
- La fecha de entrega no está comprometida.
