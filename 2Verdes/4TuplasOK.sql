-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== TuplasOK ====================
-- Cliente con al menos un medio de contacto
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (50, 'Contacto OK', '3008887777', NULL, SYSDATE, 0);

-- Bebida coherente: no alcohólica con grado 0
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (850, 'Jugo Manzana', '300 ml', 5.00, 1, 1);
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (850, 0, 0, '300 ml', 'Ambiente', 'Natural');

-- Entrada con fechas coherentes
INSERT INTO Entrada (idEntrada, fechaEntrada, cantidadIngresada, tipo, fechaVencimiento)
VALUES (8500, DATE '2025-11-05', 10, 'Lote', DATE '2026-01-01');

-- Inventario con mínimo <= stock
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9850, 850, 10, 2, SYSDATE);

-- Compra con total = cantidad * precioUnitario
INSERT INTO Compra (idCompra, fechaCompra, cantidad, precioUnitario, total, idProveedor)
VALUES (9500, SYSDATE, 4, 2.50, 10.00, 1);

-- Factura total = subtotal + impuestos
INSERT INTO Factura (numeroFactura, fecha, subtotal, impuestos, total, metodoPago)
VALUES ('F-OK-1', SYSDATE, 100, 16, 116, 'Tarjeta');

-- Venta con totales iguales a subtotal+impuesto (se permite, luego triggers recalculan)
INSERT INTO Venta (idVenta, fecha, hora, subtotal, impuesto, total, estado, idCliente, idEmpleado)
VALUES (9400, SYSDATE, SYSTIMESTAMP, 0, 0, 0, 'Pendiente', 50, NULL);

-- DetalleVentaProducto con subtotal = cantidad * precio
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9400, 201, 1, 18.00, 18.00);

-- Tablas Ciclo2

-- 1) EVENTO: horaFin > horaInicio y numeroPersonas > 0
INSERT INTO Evento (idEvento, nombreEvento, descripcion,
                    fechaEvento, horaInicio, horaFin,
                    numeroPersonas, estado, idCliente)
VALUES (7001, 'Cumpleaños infantil', 'Evento en sala A',
        DATE '2025-11-15', 16, 19,
        8, 'Programado', 1);

-- 2) EVALUACION: calificaciones entre 0 y 5, comentario opcional
INSERT INTO Evaluacion (idEvaluacion, idCliente,
                        calificacionServicio, calificacionProducto,
                        calificacionAmbiente, comentario, fechaEvaluacion)
VALUES (8100, 1,
        5, 4, 5,
        'Muy buena atención y comida',
        DATE '2025-11-16');

-- 3) TURNO: horaFin > horaInicio, asistio 0/1
INSERT INTO Turno (idTurno, idEmpleado, tipo,
                   horaInicio, horaFin, fecha,
                   asistio, observaciones)
VALUES (9100, 100, 'Mañana',
        8, 16, DATE '2025-11-15',
        1, 'Turno cubierto completo');

-- 4) RECETA: tiempoPreparacion > 0 y porciones > 0
INSERT INTO Receta (idReceta, idProducto, ingredientes,
                    instrucciones, tiempoPreparacion, porciones)
VALUES (11000, 201,
        'Pasta, crema, queso parmesano',
        'Cocer pasta y mezclar con salsa Alfredo',
        20, 2);
