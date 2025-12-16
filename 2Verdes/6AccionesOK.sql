-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== AccionesOK (pruebas ON DELETE) ====================
-- Crear datos de prueba mínimos
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (60, 'Cliente Acciones', '3007776666', 'acc@ok.com', SYSDATE, 0);
INSERT INTO Reserva (idReserva, fechaReserva, horaReserva, numeroPersonas, estado, idCliente)
VALUES (9600, SYSDATE, SYSTIMESTAMP, 2, 'Confirmada', 60);
INSERT INTO Observaciones (idReserva, observaciones) VALUES (9600, 'Auto-delete prueba');

INSERT INTO Empleado (idEmpleado, nombre, apellido, telefono, email, fechaIngreso, salario, turno)
VALUES (8600, 'Emp', 'Borrar', '3113334444', 'emp.del@rest.com', SYSDATE, 1000, 'Dia');
INSERT INTO Venta (idVenta, fecha, hora, subtotal, impuesto, total, estado, idCliente, idEmpleado)
VALUES (9601, SYSDATE, SYSTIMESTAMP, 0, 0, 0, 'Pendiente', 60, 8600);

-- Probar ON DELETE SET NULL (Venta->Empleado)
DELETE FROM Empleado WHERE idEmpleado = 8600;
-- Esperado: Venta 9601 queda con idEmpleado = NULL

-- Probar ON DELETE CASCADE en atributo [0..*] (Observaciones->Reserva)
DELETE FROM Reserva WHERE idReserva = 9600;
-- Esperado: Observaciones de 9600 eliminadas automáticamente

-- Tablas Ciclo2

-- 1) EVENTO y EVALUACION ligados a un cliente
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (70, 'Cliente Eventos/Evals', '3009990000', 'cli.ev@ok.com', SYSDATE, 0);

INSERT INTO Evento (idEvento, nombreEvento, descripcion,
                    fechaEvento, horaInicio, horaFin,
                    numeroPersonas, estado, idCliente)
VALUES (9700, 'Evento prueba cascade', 'Se borrará con el cliente',
        DATE '2025-11-20', 18, 20, 4, 'Programado', 70);

INSERT INTO Evaluacion (idEvaluacion, idCliente,
                        calificacionServicio, calificacionProducto,
                        calificacionAmbiente, comentario, fechaEvaluacion)
VALUES (9800, 70, 4, 5, 5, 'Cliente 70 será borrado',
        DATE '2025-11-21');

-- Borrar cliente 70
DELETE FROM Cliente WHERE idCliente = 70;
-- Esperado:
--   - Evento 9700 se elimina automáticamente (ON DELETE CASCADE en fk_evento_cliente)
--   - Evaluacion 9800 se elimina automáticamente (ON DELETE CASCADE en fk_evaluacion_cliente)


-- 2) TURNOS ligados a un empleado
INSERT INTO Empleado (idEmpleado, nombre, apellido, telefono, email, fechaIngreso, salario, turno)
VALUES (8700, 'Emp Turnos', 'Cascade', '3115556666', 'emp.turno@rest.com', SYSDATE, 1200, 'Dia');

INSERT INTO Turno (idTurno, idEmpleado, tipo,
                   horaInicio, horaFin, fecha,
                   asistio, observaciones)
VALUES (9900, 8700, 'Mañana',
        8, 16, DATE '2025-11-22',
        1, 'Turno de prueba cascade');

-- Borrar empleado 8700
DELETE FROM Empleado WHERE idEmpleado = 8700;
-- Esperado:
--   - Turno 9900 se elimina automáticamente (ON DELETE CASCADE en fk_turno_empleado)


-- 3) RECETA ligada a un producto
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (8800, 'Producto con Receta', 'Prueba cascade', 10, 1, 2);

INSERT INTO Receta (idReceta, idProducto, ingredientes,
                    instrucciones, tiempoPreparacion, porciones)
VALUES (12000, 8800,
        'Ing prueba', 'Instrucciones prueba', 15, 1);

-- Borrar producto 8800
DELETE FROM Producto WHERE idProducto = 8800;
-- Esperado:
--   - Receta 12000 se elimina automáticamente (ON DELETE CASCADE en fk_receta_producto)
