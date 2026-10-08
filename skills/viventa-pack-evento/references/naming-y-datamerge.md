# Naming y bloque de data merge

> El nombre de archivo es el **join key** entre la pieza producida y su fila en el reporte de
> pauta. Hoy no existe: conviven 5 convenciones en un mismo mes.

---

## 1. El problema real (mayo 2026)

En una sola carpeta de mes conviven:

```
Cuando algo importa - LANZ - 1.1.mov      ← guiones separados por guiones y espacios
1 LANZAROTE 1.1_1.jpg                     ← numeración de exportación
A3.pdf                                    ← sin evento ni versión
PIEZAS REDESMesa de trabajo 1_3.jpg       ← nombre de artboard de Illustrator sin renombrar
CAROLINA FLYRES A3 ALICANTE.pdf           ← typo, y orden invertido
```

Más `MISSISAUGA` vs `MISSISAGUA II` para el mismo evento. Resultado: **no se puede cruzar un
archivo con su fila de reporte de pauta.**

---

## 2. Convención única — la emite el skill, no la recuerda una persona

```
{CIUDAD3}_{tipo}_{concepto|carruselN|superficie}_{formato}_{vNN}[_{Consultora}].{ext}
```

Ejemplos reales:

```
TP_video_TrabajasParaEsto_9x16_v01.mov
TP_video_TrabajasParaEsto_1x1_v01.mov
TP_carrusel_C1_s03_9x16_v01.jpg
TP_estatica_RespaldoBancos_1x1_v01.jpg
TP_flyer_A3_general_v01.pdf
TP_flyer_A4_v01_DianaBarcenas.pdf
TP_redes_1x1_v01_DianaBarcenas.jpg
```

Reglas:

| Campo | Regla |
|---|---|
| `CIUDAD3` | 2-4 letras, mayúsculas, una sola forma por ciudad. Se declara en la cabecera de la matriz. `TP` Tampa · `ALI` Alicante · `LANZ` Lanzarote · `PAR` París · `VAL` Valencia · `MIS` Misisauga |
| `tipo` | `video` · `carrusel` · `estatica` · `flyer` · `redes` |
| `formato` | `9x16` · `1x1` · `4x5` · `A3` · `A4`. Sin dos puntos ni comas |
| `vNN` | **Dos dígitos siempre** (`v01`, no `v1` — `v10` ordena mal). El bump de versión encodea **qué** cambió: nuevo hook, nuevo ratio, nueva oferta. Nunca `final`, nunca `final_final` |
| `Consultora` | CamelCase sin espacios ni tildes: `DianaBarcenas`, `CarolinaRonderos`. Solo en piezas de capa persona |
| General | Sin espacios · sin tildes · sin `ñ` · sin `#` ni `&` |

---

## 3. Tabla país → moneda (fija, no se negocia)

| País del evento | Moneda | Se escribe |
|---|---|---|
| Estados Unidos · Canadá · Puerto Rico · Panamá | USD | `USD` |
| España · Francia · Italia · Alemania · Holanda · Bélgica | EUR | `EUR` |
| Reino Unido | GBP | `GBP` |

- **La moneda se deriva del país. Nunca es un eje independiente.** Ningún evento de mayo 2026
  tuvo versión USD *y* EUR simultánea.
- **El monto siempre viene del input. Cero conversión automática** entre monedas.
- Se escribe `USD` / `EUR` / `GBP`, **nunca "USA"** — error real en el flyer de Tampa:
  *"Reserva desde 280 USA."*
- Nunca `$` a secas: es ambiguo entre USD y COP.

---

## 4. Bloque CSV de consultoras — alimenta el data merge de Figma

Se pega en Google Sheets y se conecta como fuente de las **plantillas maestras que Alejandra ya
tiene en Figma** (variables / plugin de data merge). Es lo que evita 12 ediciones a mano.

### Esquema — columnas exactas, en este orden

| Columna | Contenido | Origen |
|---|---|---|
| `consultora` | Clave de la fila, nombre completo | input |
| `nombre_impreso` | Nombre tal cual va en la pieza, con tildes | input |
| `cargo` | `Experta en crédito y compra de vivienda` (o `Experto`) | **congelado** |
| `email` | `{iniciales}.consultor@viventa.co` | input; si se deriva → `⚠ verificar` |
| `telefono` | Con prefijo de país, con espacios: `+1 786 4722511` | **input duro, nunca derivado** |
| `foto` | Nombre del archivo del asset o `⛔ INPUT REQUERIDO` | input |
| `archivo_A3` | Nombre según §2 | generado |
| `archivo_A4` | Nombre según §2 | generado |
| `archivo_redes` | Nombre según §2 | generado |
| `estado` | `✅ completo` · `⛔ bloqueado: {campo faltante}` · `⚠ verificar: {qué}` | generado |

### Ejemplo (Tampa, datos reales de la pieza impresa de mayo)

```csv
consultora,nombre_impreso,cargo,email,telefono,foto,archivo_A3,archivo_A4,archivo_redes,estado
Diana Bárcenas,Diana Bárcenas,Experta en crédito y compra de vivienda,db.consultor@viventa.co,+1 786 4722511,diana_barcenas.jpg,TP_flyer_A3_v01_DianaBarcenas.pdf,TP_flyer_A4_v01_DianaBarcenas.pdf,TP_redes_1x1_v01_DianaBarcenas.jpg,✅ completo
Marcela Estrada,Marcela Estrada,Experta en crédito y compra de vivienda,⛔ INPUT REQUERIDO,⛔ INPUT REQUERIDO,⛔ INPUT REQUERIDO,TP_flyer_A3_v01_MarcelaEstrada.pdf,TP_flyer_A4_v01_MarcelaEstrada.pdf,TP_redes_1x1_v01_MarcelaEstrada.jpg,⛔ bloqueado: email + teléfono + foto
```

La fila del bloqueado **existe igual**: el copy fijo ya está resuelto y solo falta el dato que la
máquina no tiene derecho a inventar. **Un teléfono inventado en un A3 se imprime 500 veces.**

---

## 5. Reglas de la capa persona

1. **Nombre completo, con tildes correctas.** "Diana Bárcenas", no "Diana B.". Bárcenas, Díaz,
   Cárdenas, Guzmán.
2. **Cargo congelado.** `Experta en crédito y compra de vivienda`. Si el asignado es hombre
   (caso real: Wilson Gaviria en Lanzarote) → `Experto`. Es la única flexión permitida.
3. **Email: se propone, no se afirma.** El patrón `{iniciales}.consultor@viventa.co` se observó
   en **2 de 2** flyers leídos — `[⚠ 2 de 2 muestras]`, insuficiente para tratarlo como regla.
   El skill lo deriva y lo marca `⚠ verificar`. Nunca lo da por bueno.
4. **Teléfono: dato duro, siempre input.** Nunca derivado, nunca inferido. Con prefijo de país.
5. **Chequeo de prefijo vs país del evento.** Caso real: Carolina Ronderos aparece en el flyer de
   **Alicante (España)** con teléfono **+1 (USA)**. Puede ser correcto (consultora radicada en
   USA que atiende el evento) o arrastre de una versión anterior. Cuando el prefijo no coincida
   con el país del evento, el skill emite `⚠ verificar prefijo` **sin asumir cuál de las dos es**.
6. **Rango realista: 1-4 consultoras por evento.** Observado: Alicante 3 · Valencia 3 · París 2 ·
   Tampa 4 · Lanzarote 1 · Misisauga 1. Si el input trae **más de 6**, advertir antes de generar.
7. Estos datos **no son PII de cliente** — son contactos comerciales ya impresos públicamente.
   El skill **no toca ninguna base de leads**.
