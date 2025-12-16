-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== DisparadoresNoOK ====================
-- Intentar vender más de lo que hay (debe fallar por trg_dvp_chk_stock_bi)
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9700, 201, 9999, 18.00, 179982.00);

-- Intentar actualizar detalle de venta para dejar stock negativo (debe fallar)
UPDATE DetalleVentaProducto
   SET cantidad = cantidad + 10000
 WHERE idVenta = 9700 AND idProducto = 201;

-- Intentar borrar detalle de compra dejando stock negativo (debe fallar por -20003)
DELETE FROM DetalleCompraProducto
 WHERE idCompra = 5001 AND idProducto = 201 AND cantidad = 3;

-- Tablas Ciclo2

-- 1) EVENTO: horas incoherentes (fin <= inicio)
-- Debe fallar por trg_evento_validaciones_bi
INSERT INTO Evento (idEvento, nombreEvento, descripcion,
                    fechaEvento, horaInicio, horaFin,
                    numeroPersonas, estado, idCliente)
VALUES (7400, 'Evento disparador malo', 'Fin antes que inicio',
        DATE '2025-11-28', 20, 18,
        5, 'Programado', 1);


-- 2) EVALUACION: calificación fuera de rango 0..5
-- Debe fallar por trg_eval_normaliza_bi
INSERT INTO Evaluacion (idEvaluacion, idCliente,
                        calificacionServicio, calificacionProducto,
                        calificacionAmbiente, comentario, fechaEvaluacion)
VALUES (8400, 1,
        10, 5, 5,
        'Servicio 10/5', DATE '2025-11-29');


-- 3) TURNO: asistio no binario
-- Debe fallar por trg_turno_validaciones_bi
INSERT INTO Turno (idTurno, idEmpleado, tipo,
                   horaInicio, horaFin, fecha,
                   asistio, observaciones)
VALUES (9400, 100, 'Mañana',
        8, 16, DATE '2025-11-30',
        3, 'Asistio = 3');


-- 4) RECETA: tiempoPreparacion <= 0
-- Debe fallar por trg_receta_validaciones_bi
INSERT INTO Receta (idReceta, idProducto, ingredientes,
                    instrucciones, tiempoPreparacion, porciones)
VALUES (14000, 201,
        'Pasta, crema',
        'Texto cualquiera',
        0, 2);
