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

