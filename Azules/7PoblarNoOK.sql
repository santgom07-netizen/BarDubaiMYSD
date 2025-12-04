-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== PoblarNoOK ====================

-- 1) PK duplicada (Cliente.idCliente ya existe)
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (1, 'Duplicado', '3009998888', 'dup@example.com', SYSDATE, 0);

-- 2) UNIQUE violado (email de Cliente repetido)
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (10, 'Correo Repetido', '3002223333', 'ana.perez@example.com', SYSDATE, 0);

-- 3) UNIQUE violado (teléfono de Empleado repetido)
INSERT INTO Empleado (idEmpleado, nombre, apellido, telefono, email, fechaIngreso, salario, turno)
VALUES (200, 'Tel Rep', 'Emp', '3110001111', 'tel.rep@rest.com', SYSDATE, 1500, 'Dia');

-- 4) CHECK enumerado inválido (turno no permitido)
INSERT INTO Empleado (idEmpleado, nombre, apellido, telefono, email, fechaIngreso, salario, turno)
VALUES (201, 'Turno', 'Invalido', '3119997777', 'turno.bad@rest.com', SYSDATE, 1500, 'Tarde');

-- 5) CHECK formato teléfono inválido (no solo dígitos)
INSERT INTO Proveedor (idProveedor, nombre, telefono, email, direccion, tiempoEntrega)
VALUES (2, 'Proveedor Tel Malo', '30A-111', 'prov.bad@prove.com', 'Calle', 5);

-- 6) CHECK email inválido
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (11, 'Email Malo', '3001234567', 'correo_sin_arroba', SYSDATE, 0);

-- 7) NOT NULL indirecto por MODIFY nombre NOT NULL en Cliente
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (12, NULL, '3007654321', 'null.nombre@example.com', SYSDATE, 0);

-- 8) FK inexistente (Reserva.idCliente no existe)
INSERT INTO Reserva (idReserva, fechaReserva, horaReserva, numeroPersonas, estado, idCliente)
VALUES (3999, SYSDATE, SYSTIMESTAMP, 2, 'Confirmada', 9999);

-- 9) CHECK binario inválido (Mesa.reservada fuera de 0/1)
INSERT INTO Mesa (numeroMesa, capacidad, ubicacion, estado, reservada)
VALUES (99, 4, 'Sala X', 'Disponible', 2);

-- 10) CHECK rango negativo (precio > 0)
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (999, 'Prod Neg', 'Precio negativo', -1, 1, 1);

-- 11) FK a categoría inexistente
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (998, 'Sin Categoria', 'No existe categoría 9999', 10, 1, 9999);

-- 12) Bebida con volumen mal formateado (no cumple regex)
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (101, 0, 0, '500ml', 'Fria', 'X'); -- falta espacio entre número y unidad

-- 13) CHECK temperatura inválida
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (102, 0, 0, '250 ml', 'Helada', 'Y');

-- 14) Comida con tipo no permitido
INSERT INTO Comida (idProducto, tiempoPreparacion, tipoComida, calorias)
VALUES (201, 10, 'Snack', 100);

-- 15) Inventario duplicado por UNIQUE (un registro por producto)
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9004, 101, 5, 1, SYSDATE);

-- 16) Detalle con FK venta inexistente
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9999, 201, 1, 18, 18);

-- 17) Detalle compra con FK producto inexistente
INSERT INTO DetalleCompraProducto (idCompra, idProducto, cantidad, precioUnitario, subtotal)
VALUES (5001, 7777, 1, 2, 2);

-- 18) ZonasAsignadas con empleado que no es de Seguridad (id inexistente en Seguridad)
INSERT INTO ZonasAsignadas (idEmpleado, zonasAsignadas)
VALUES (1000, 'Zona Fantasma');

-- 19) Observaciones con idReserva inexistente
INSERT INTO Observaciones (idReserva, observaciones)
VALUES (8888, 'Obs sin reserva');

-- 20) Descuento fuera de rango 0..1
INSERT INTO Descuento (idVenta, descuento) VALUES (4001, 1.5);

-- 21) Violación de PK compuesta (repetir par idVenta,idProducto)
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (4001, 201, 1, 18, 18);
