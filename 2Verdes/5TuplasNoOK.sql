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

-- Tablas Ciclo2

-- 1) EVENTO: horaFin <= horaInicio (viola chk_evento_horas / trigger)
INSERT INTO Evento (idEvento, nombreEvento, descripcion,
                    fechaEvento, horaInicio, horaFin,
                    numeroPersonas, estado, idCliente)
VALUES (7002, 'Evento horas malas', 'Fin antes o igual al inicio',
        DATE '2025-11-15', 20, 18,
        5, 'Programado', 1);

-- 2) EVENTO: numeroPersonas <= 0 (viola chk_evento_cancelado_personas / trigger)
INSERT INTO Evento (idEvento, nombreEvento, descripcion,
                    fechaEvento, horaInicio, horaFin,
                    numeroPersonas, estado, idCliente)
VALUES (7003, 'Evento sin personas', 'Num personas no válido',
        DATE '2025-11-16', 18, 20,
        0, 'Programado', 1);

-- 3) EVALUACION: calificacionServicio fuera de rango 0–5
INSERT INTO Evaluacion (idEvaluacion, idCliente,
                        calificacionServicio, calificacionProducto,
                        calificacionAmbiente, comentario, fechaEvaluacion)
VALUES (8101, 1,
        7, 4, 5,
        'Servicio 7/5',          -- viola chk_eval_suma / trigger
        DATE '2025-11-17');

-- 4) TURNO: horaFin <= horaInicio
INSERT INTO Turno (idTurno, idEmpleado, tipo,
                   horaInicio, horaFin, fecha,
                   asistio, observaciones)
VALUES (9101, 100, 'Mañana',
        16, 8, DATE '2025-11-15',
        1, 'Rango horario inválido');

-- 5) TURNO: asistio no binario (≠ 0/1)
INSERT INTO Turno (idTurno, idEmpleado, tipo,
                   horaInicio, horaFin, fecha,
                   asistio, observaciones)
VALUES (9102, 100, 'Noche',
        18, 23, DATE '2025-11-16',
        3, 'Asistio = 3');

-- 6) RECETA: tiempoPreparacion <= 0 y porciones <= 0
INSERT INTO Receta (idReceta, idProducto, ingredientes,
                    instrucciones, tiempoPreparacion, porciones)
VALUES (11001, 201,
        'Pasta, crema',
        'Instrucciones inválidas',
        -10, 0);
