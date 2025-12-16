-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== TUPLAS: RESTRICCIONES MULTI-ATRIBUTO ====================

-- Cliente: al menos un medio de contacto
ALTER TABLE Cliente
  ADD CONSTRAINT chk_cliente_contacto_minuno
  CHECK (telefono IS NOT NULL OR email IS NOT NULL);

-- Bebida: consistencia entre tipoAlcohol y gradoAlcoholico
ALTER TABLE Bebida
  ADD CONSTRAINT chk_beb_consistencia_alcohol
  CHECK (
    (tipoAlcohol = 0 AND gradoAlcoholico = 0)
    OR
    (tipoAlcohol = 1 AND gradoAlcoholico > 0 AND gradoAlcoholico <= 1)
  );

-- Entrada: vencimiento no anterior a la entrada
ALTER TABLE Entrada
  ADD CONSTRAINT chk_ent_fechas_coherentes
  CHECK (fechaVencimiento IS NULL OR fechaVencimiento >= fechaEntrada);

-- Inventario: minimo no mayor al stock actual
ALTER TABLE Inventario
  ADD CONSTRAINT chk_inv_min_leq_stock
  CHECK (stockMinimo <= cantidadStock);

-- Compra: total = cantidad * precioUnitario
ALTER TABLE Compra
  ADD CONSTRAINT chk_compra_total_calc
  CHECK (total = cantidad * precioUnitario);

-- Factura: total = subtotal + impuestos
ALTER TABLE Factura
  ADD CONSTRAINT chk_fact_total_eq
  CHECK (total = subtotal + impuestos);

-- Venta: total = subtotal + impuesto
ALTER TABLE Venta
  ADD CONSTRAINT chk_venta_total_eq
  CHECK (total = subtotal + impuesto);

-- DetalleVentaProducto: subtotal = cantidad * precioUnitario
ALTER TABLE DetalleVentaProducto
  ADD CONSTRAINT chk_dvp_subtotal_calc
  CHECK (subtotal = cantidad * precioUnitario);

-- DetalleCompraProducto: subtotal = cantidad * precioUnitario
ALTER TABLE DetalleCompraProducto
  ADD CONSTRAINT chk_dcp_subtotal_calc
  CHECK (subtotal = cantidad * precioUnitario);

-- Metodo_pago: relacion tipo vs validacion (ajusta los tipos si usas otros)
ALTER TABLE Metodo_pago
  ADD CONSTRAINT chk_mp_tipo_vs_validacion
  CHECK (
    (tipo <> 'Tarjeta'  OR requiereValidacion = 1) AND
    (tipo <> 'Efectivo' OR requiereValidacion = 0)
  );

-- Tablas Ciclo2

-- EVENTO: horaFin debe ser > horaInicio
ALTER TABLE Evento
  ADD CONSTRAINT chk_evento_horas
  CHECK (horaFin > horaInicio);

-- EVENTO: si estado = 'Cancelado', numeroPersonas debe ser 0
ALTER TABLE Evento
  ADD CONSTRAINT chk_evento_cancelado_personas
  CHECK (estado <> 'Cancelado' OR numeroPersonas = 0);

-- EVALUACION: promedio coherente (suma de 3 entre 0 y 15)
ALTER TABLE Evaluacion
  ADD CONSTRAINT chk_eval_suma
  CHECK (calificacionServicio    BETWEEN 0 AND 5
     AND  calificacionProducto   BETWEEN 0 AND 5
     AND  calificacionAmbiente   BETWEEN 0 AND 5
     AND (calificacionServicio + calificacionProducto + calificacionAmbiente) BETWEEN 0 AND 15);

-- TURNO: horaFin mayor que horaInicio en la misma fecha
ALTER TABLE Turno
  ADD CONSTRAINT chk_turno_rango_horas
  CHECK (horaFin > horaInicio);

-- RECETA: tiempoPreparacion proporcional a porciones (> 0 ambas)
ALTER TABLE Receta
  ADD CONSTRAINT chk_receta_tiempo_porciones
  CHECK (tiempoPreparacion > 0 AND porciones > 0);
