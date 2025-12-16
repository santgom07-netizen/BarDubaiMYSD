-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== DisparadoresOK ====================
-- Asegurar inventario del producto 201 (si no existe, lo crea el trigger de producto)
MERGE INTO Inventario i
USING (SELECT 201 idProducto FROM dual) s
ON (i.idProducto = s.idProducto)
WHEN NOT MATCHED THEN
  INSERT (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
  VALUES ((SELECT NVL(MAX(idInventario),0)+1 FROM Inventario), s.idProducto, 5, 1, SYSDATE);

-- Crear venta y detalle: debe descontar stock y recalcular totales vía triggers
INSERT INTO Venta (idVenta, fecha, hora, subtotal, impuesto, total, estado, idCliente, idEmpleado)
VALUES (9700, SYSDATE, SYSTIMESTAMP, 0, 0, 0, 'Pendiente', 1, NULL);

INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9700, 201, 1, 18.00, 18.00);
-- Esperado: Inventario de 201 baja en 1; Venta 9700 recalculada

-- Insertar descuento y validar recálculo
INSERT INTO Descuento (idVenta, descuento) VALUES (9700, 0.10);
-- Esperado: prc_recalcular_venta ajusta subtotal/impuesto/total de Venta 9700

-- Compras: sumar stock y ajustar al actualizar
INSERT INTO DetalleCompraProducto (idCompra, idProducto, cantidad, precioUnitario, subtotal)
VALUES (5001, 201, 2, 10, 20);
UPDATE DetalleCompraProducto SET cantidad = 3 WHERE idCompra = 5001 AND idProducto = 101;

-- Tablas Ciclo2

-- 1) Evento con horas y personas coherentes
INSERT INTO Evento (idEvento, nombreEvento, descripcion,
                    fechaEvento, horaInicio, horaFin,
                    numeroPersonas, estado, idCliente)
VALUES (7300, 'Evento trigger OK', 'Horas y cupos válidos',
        DATE '2025-11-25', 18, 21,
        5, 'Programado', 1);
-- Esperado: pasa porque horaFin > horaInicio y numeroPersonas > 0

-- 2) Evaluación con calificaciones válidas y comentario normalizado
INSERT INTO Evaluacion (idEvaluacion, idCliente,
                        calificacionServicio, calificacionProducto,
                        calificacionAmbiente, comentario, fechaEvaluacion)
VALUES (8300, 1,
        4, 5, 5,
        '  Muy buena experiencia  ',
        DATE '2025-11-26');
-- Esperado: trigger limpia espacios del comentario y valida 0..5 en todas las notas

-- 3) Turno con rango horario correcto y asistio binario
INSERT INTO Turno (idTurno, idEmpleado, tipo,
                   horaInicio, horaFin, fecha,
                   asistio, observaciones)
VALUES (9300, 100, 'Noche',
        16, 23, DATE '2025-11-27',
        1, 'Turno completo sin novedades');
-- Esperado: pasa porque horaFin > horaInicio y asistio = 1

-- 4) Receta con tiempo y porciones positivos
INSERT INTO Receta (idReceta, idProducto, ingredientes,
                    instrucciones, tiempoPreparacion, porciones)
VALUES (13000, 201,
        'Pasta, crema, queso, mantequilla',
        'Preparar salsa, cocer pasta y mezclar',
        25, 3);
-- Esperado: pasa porque tiempoPreparacion > 0 y porciones > 0


