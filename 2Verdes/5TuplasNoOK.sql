-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== TuplasNoOK ====================
-- Cliente sin teléfono ni email (debe fallar chk_cliente_contacto_minuno)
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (51, 'Sin Contacto', NULL, NULL, SYSDATE, 0);

-- Bebida incoherente: tipoAlcohol=1 con grado 0 (debe fallar chk_beb_consistencia_alcohol)
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (850, 1, 0, '300 ml', 'Ambiente', 'Natural');

-- Entrada con vencimiento anterior a la entrada (debe fallar chk_ent_fechas_coherentes)
INSERT INTO Entrada (idEntrada, fechaEntrada, cantidadIngresada, tipo, fechaVencimiento)
VALUES (8501, DATE '2025-11-10', 5, 'Lote', DATE '2025-11-01');

-- Inventario con stockMinimo > cantidadStock (debe fallar chk_inv_min_leq_stock)
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9851, 850, 3, 5, SYSDATE);

-- Compra con total incorrecto (debe fallar chk_compra_total_calc)
INSERT INTO Compra (idCompra, fechaCompra, cantidad, precioUnitario, total, idProveedor)
VALUES (9501, SYSDATE, 4, 2.50, 11.00, 1);

-- Factura con total incorrecto (debe fallar chk_fact_total_eq)
INSERT INTO Factura (numeroFactura, fecha, subtotal, impuestos, total, metodoPago)
VALUES ('F-BAD-1', SYSDATE, 100, 16, 117, 'Tarjeta');
