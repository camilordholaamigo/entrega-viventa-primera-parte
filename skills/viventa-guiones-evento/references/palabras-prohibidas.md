# Palabras prohibidas y claims riesgosos — lista base

> La **lista oficial vive en el manual de marca**. El skill la pide como input al arrancar.
> Si no la tiene, corre con esta lista base y **lo declara explícitamente en el output**.

---

## Las 6 categorías

| # | Categoría | Frases prohibidas | Reformulación segura |
|---|---|---|---|
| **A** | **Promesa de aprobación** | "Te aprobamos el crédito" · "Aprobación garantizada" · "Sin importar tu historial" · "Aprobación asegurada" · "Todos califican" | *"Te acompañamos en todo el proceso del crédito"* · *"En el evento te decimos si calificas y qué te falta"* · *"Evaluamos tu perfil con nuestros 5 bancos aliados"* |
| **B** | **Tasa** | "Tasa del 8%" · "Tasa fija garantizada" · "La tasa más baja del mercado" · "Tasas preferenciales" | *"Trabajamos con 5 bancos: comparamos condiciones por ti."* Cualquier cifra de tasa → **visto bueno de Crédito, sin excepción** |
| **C** | **Trigger terms de cuota / plazo / inicial** | "Cuotas desde $X al mes" · "Solo 10% de cuota inicial" · "A 20 años" · "Sin cuota inicial" | Preferido: *"Hay opciones para presupuestos muy distintos."* Si el brief exige la cifra: mantenerla **con disclaimer igual de prominente en pantalla** ("Sujeto a evaluación crediticia. Condiciones en viventa.co") — no en letra chica al final |
| **D** | **Producto o cobertura no confirmada** | "Trabajamos con VA loan" · "Aceptamos ITIN" · "Financiamos vivienda usada" · "Aplicamos para Canadá / Puerto Rico" | **Bloqueante hasta confirmación del brief o de Crédito.** Alternativa: *"¿Eres veterano y tienes un VA loan? Ven al evento y te decimos exactamente qué aplica en tu caso."* (pregunta, no afirmación) |
| **E** | **Cifras de negocio y jerga** | "El mercado crece 42%" · mezclar CPL con CAC · confundir conversión a desembolso ([cifra interna]) con conversión a pago de servicio ([cifra interna]) · LTV, DTI, amortización, preaprobado, buró sin traducir | +42% = **participación del segmento no residentes**, nunca "crecimiento de mercado". Jerga: traducción funcional en la misma frase (*"DTI"* → *"cuánto de tu ingreso ya está comprometido en deudas"*) |
| **F** | **Voz de marca** (no legal, pero bloqueante para el aprobador de marca) | "unlock" · "leverage" · "solución integral" · "aliado estratégico" · "inversión inmobiliaria" · lenguaje de banco. Españolismos: "vosotros", "vale", "guay", "coger" (sentido peninsular), "tío/tía" | *patrimonio* en vez de *inversión*. Tuteo colombiano. Frases cortas. Prueba concreta antes que adjetivo |

---

## Arquitectura de 3 capas

1. **Lista negra literal** — grep determinista de A-F. Match = **FALLA automática**, no pasa a
   revisión humana con el error adentro. Reemplazo ya redactado en el output.
2. **Lista de disparo** — heurística. Números seguidos de `%`, `$`, `€`, `COP`, "millones";
   palabras `tasa · cuota · inicial · plazo · años · aprobación · califica · garantiza · desde`.
   Match = **bandera amarilla** → bloque B del output.
3. **Lista de marca** — juicio de tono. Jerga sin traducir, españolismos, adjetivos sin prueba,
   "inversión" en vez de "patrimonio".

## Siempre requiere visto bueno del área de Crédito

Cualquier cifra de tasa · cualquier cuota mensual · cualquier % o monto de cuota inicial ·
cualquier plazo en años · cualquier afirmación de que un producto o país está cubierto
(VA loan, ITIN, vivienda usada, Puerto Rico, Canadá) · cualquier afirmación sobre requisitos
de calificación.

---

## Marco regulatorio (contexto, no reemplaza a Legal)

**Meta — Special Ad Category.** Desde el 14-ene-2025 Meta reemplazó "Credit" por **"Financial
Products and Services"**, obligatoria desde el 21-ene-2025 para anunciantes en EE.UU. o que
targetean audiencia de EE.UU. Efecto: **sin segmentación por edad, género, código postal/radio,
lookalikes ni intereses financieros**. Meta aplica clasificadores de imagen (calculadoras de
préstamo, mockups de tarjeta) que activan la categoría automáticamente.
→ **Consecuencia de diseño: el hook sustituye al targeting.** Esta restricción **sí aplica
directo e inmediato**.

**EE.UU. — Regulation Z / TILA, §1026.24(d)(1).** Mencionar **cualquiera** de estos 4 elementos
obliga a divulgar información adicional **igual de prominente**:
1. Monto o % de la cuota inicial
2. Número de cuotas o plazo
3. Monto de cualquier cuota
4. Monto del cargo financiero

Si se menciona la cuota mensual, hay que divulgar total a pagar y plazo. "Tasa fija" no se
puede decir sin especificar el período de fijeza. **Un disclaimer en letra chica no lo cura.**

**España — Banco de España.** La publicidad de crédito hipotecario debe incluir la **TAE** de
forma clara si se menciona cualquier coste o condición financiera; no se puede publicitar un
tipo de interés aislado. Documentación precontractual (FIPRE, FEIN, FiAE) según Ley 5/2019.

> **`[⚠ no verificado]` — matiz jurídico importante.** Viventa **no es el acreedor**: es
> orquestador de crédito de bancos colombianos y sus clientes son no residentes. La
> aplicabilidad literal de Reg Z (EE.UU.) y de la Ley 5/2019 (España) a su publicidad **no está
> confirmada** y debe validarla el área Legal/Crédito del cliente. Tratar estos listados como
> **estándar prudencial** — la barra más alta, no la barra legal exacta.

**Regla operativa de Viventa:** el material de marketing entrega **precio de vivienda**; tasa,
cuota y plazo los da el asesor en llamada.

---

## Checklist fijo "lo que NO se puede decir en anuncios" (para la productora de video)

- [ ] Nada de tasa, cuota mensual, plazo ni cuota inicial.
- [ ] Nada de "te aprobamos", "aprobación garantizada", "todos califican".
- [ ] Nada de valorización ni rentabilidad prometida.
- [ ] Nada de VA loan / ITIN / vivienda usada / PR / Canadá como afirmación — solo como pregunta.
- [ ] Nada de jerga sin traducir en la misma frase.
- [ ] Nada de "$" sin marcar mercado. Se escribe USD / EUR / GBP, nunca "USA".
- [ ] Nada de españolismos ni "usted" formal.
- [ ] Nada de "inversión inmobiliaria" — es patrimonio.
- [ ] Nunca mezclar CPL con CAC.
- [ ] Ningún evento se anuncia sin dirección exacta.
