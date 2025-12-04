-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== PoblarOK ====================

-- Categorías
INSERT INTO Categoria (idCategoria, nombre, descripcion) VALUES (1, 'Bebidas', 'Bebidas varias');
INSERT INTO Categoria (idCategoria, nombre, descripcion) VALUES (2, 'Platos',  'Comidas principales');

-- Productos base
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (101, 'Agua mineral 500', 'Botella 500 ml', 3.50, 1, 1);
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (102, 'Café americano', 'Taza 250 ml', 4.00, 1, 1);
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (201, 'Pasta Alfredo', 'Plato fuerte', 18.00, 1, 2);

-- Especializaciones
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (101, 0, 0, '500 ml', 'Fria', 'Crystal');
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (102, 0, 0, '250 ml', 'Caliente', 'Casa');
INSERT INTO Comida (idProducto, tiempoPreparacion, tipoComida, calorias)
VALUES (201, 20, 'Plato Fuerte', 750);

-- Ingredientes de platos
INSERT INTO Ingredientes (idProducto, ingredientes) VALUES (201, 'Pasta');
INSERT INTO Ingredientes (idProducto, ingredientes) VALUES (201, 'Crema');
INSERT INTO Ingredientes (idProducto, ingredientes) VALUES (201, 'Queso');

-- Proveedores
INSERT INTO Proveedor (idProveedor, nombre, telefono, email, direccion, tiempoEntrega)
VALUES (1, 'Proveedor Uno', '3001112233', 'prov1@prove.com', 'Calle 1 #2-3', 3);

-- Compras y entradas
INSERT INTO Compra (idCompra, fechaCompra, cantidad, precioUnitario, total, idProveedor)
VALUES (5001, DATE '2025-11-01', 100, 1.50, 150.00, 1);
INSERT INTO Entrada (idEntrada, fechaEntrada, cantidadIngresada, tipo, fechaVencimiento)
VALUES (7001, DATE '2025-11-02', 60, 'Lote', DATE '2026-01-01');
INSERT INTO DetalleCompraProducto (idCompra, idProducto, cantidad, precioUnitario, subtotal)
VALUES (5001, 101, 60, 1.50, 90.00);
INSERT INTO DetalleCompraEntrada (idCompra, idEntrada, cantidadEntrada, fechaEntrada)
VALUES (5001, 7001, 60, DATE '2025-11-02');

-- Inventario
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9001, 101, 60, 10, SYSDATE);
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9002, 201, 15, 5, SYSDATE);

-- Clientes
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (1, 'Ana Pérez', '3015557777', 'ana.perez@example.com', DATE '2025-10-20', 0);
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (2, 'Luis Mora', '3024446666', 'luis.mora@example.com', DATE '2025-10-22', 0);

-- Cliente VIP / Regular (herencia)
INSERT INTO Cliente_vip (idCliente, descuentoVip, puntosAcumulados, fechaMembresia)
VALUES (1, 0.10, 200, DATE '2025-11-01');
INSERT INTO Cliente_regular (idCliente, limiteCompras, descuentoRegular)
VALUES (2, 500.00, 0.02);

-- Mesas
INSERT INTO Mesa (numeroMesa, capacidad, ubicacion, estado, reservada)
VALUES (10, 4, 'Sala A', 'Disponible', 0);
INSERT INTO Mesa (numeroMesa, capacidad, ubicacion, estado, reservada)
VALUES (11, 2, 'Sala B', 'Disponible', 0);

-- Empleados + subclases
INSERT INTO Empleado (idEmpleado, nombre, apellido, telefono, email, fechaIngreso, salario, turno)
VALUES (100, 'María', 'Gómez', '3110001111', 'maria.gomez@rest.com', DATE '2024-06-01', 2000, NULL);
INSERT INTO Empleado (idEmpleado, nombre, apellido, telefono, email, fechaIngreso, salario, turno)
VALUES (101, 'Jorge', 'Lopez', '3110002222', 'jorge.lopez@rest.com', DATE '2024-07-15', 2200, 'Dia');
INSERT INTO Mesero   (idEmpleado, zonaAsignada, comisionVentas, lugarTrabajo, horarioTurno)
VALUES (100, 'A', 0.05, 'Mesa', '8-16');
INSERT INTO Seguridad(idEmpleado, turno, licenciaSeguridadPrivada, certificacionesVigentes)
VALUES (101, 'Noche', 'LIC-2025-XYZ', DATE '2026-12-31');

-- Zonas asignadas [0..*]
INSERT INTO ZonasAsignadas (idEmpleado, zonasAsignadas) VALUES (101, 'Parqueadero');
INSERT INTO ZonasAsignadas (idEmpleado, zonasAsignadas) VALUES (101, 'Acceso Principal');

-- Reservas + observaciones [0..*]
INSERT INTO Reserva (idReserva, fechaReserva, horaReserva, numeroPersonas, estado, idCliente)
VALUES (3001, DATE '2025-11-02', SYSTIMESTAMP, 2, 'Confirmada', 1);
INSERT INTO Observaciones (idReserva, observaciones) VALUES (3001, 'Mesa cerca a ventana');

-- Venta con detalle
INSERT INTO Venta (idVenta, fecha, hora, subtotal, impuesto, total, estado, idCliente, idEmpleado)
VALUES (4001, DATE '2025-11-02', SYSTIMESTAMP, 22.00, 3.52, 25.52, 'Pendiente', 1, 100);
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (4001, 201, 1, 18.00, 18.00);
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (4001, 102, 1, 4.00, 4.00);
INSERT INTO Descuento (idVenta, descuento) VALUES (4001, 0.00);
