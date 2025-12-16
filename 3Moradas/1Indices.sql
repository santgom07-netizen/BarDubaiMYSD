-- =================================== PROYECTO BARDUBAI ====================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ======================================== INDICES =========================================

-- Cliente
CREATE INDEX ix_cliente_nombre
ON Cliente(nombre);

-- Empleado
CREATE INDEX ix_empleado_apellido
ON Empleado(apellido);

CREATE INDEX ix_empleado_turno
ON Empleado(turno);

-- Reserva
CREATE INDEX ix_reserva_idcliente
ON Reserva(idCliente);

CREATE INDEX ix_reserva_fecha
ON Reserva(fechaReserva);

-- Venta
CREATE INDEX ix_venta_idcliente
ON Venta(idCliente);

CREATE INDEX ix_venta_idempleado
ON Venta(idEmpleado);

CREATE INDEX ix_venta_fecha
ON Venta(fecha);

CREATE INDEX ix_venta_estado
ON Venta(estado);

-- Producto
CREATE INDEX ix_producto_nombre
ON Producto(nombre);

CREATE INDEX ix_producto_idcategoria
ON Producto(idCategoria);

-- DetalleVentaProducto
CREATE INDEX ix_dvp_idventa
ON DetalleVentaProducto(idVenta);

CREATE INDEX ix_dvp_idproducto
ON DetalleVentaProducto(idProducto);

-- Compra
CREATE INDEX ix_compra_idproveedor
ON Compra(idProveedor);

CREATE INDEX ix_compra_fecha
ON Compra(fechaCompra);

-- DetalleCompraProducto
CREATE INDEX ix_dcp_idcompra
ON DetalleCompraProducto(idCompra);

CREATE INDEX ix_dcp_idproducto
ON DetalleCompraProducto(idProducto);

-- Inventario
CREATE INDEX ix_inventario_idproducto
ON Inventario(idProducto);

-- Entrada
CREATE INDEX ix_entrada_fechavenc
ON Entrada(fechaVencimiento);

-- Tablas Ciclo2

-- Evento: búsquedas por cliente y fecha
CREATE INDEX ix_evento_idcliente
ON Evento(idCliente);

CREATE INDEX ix_evento_fecha
ON Evento(fechaEvento);

-- Evaluacion: búsquedas por cliente
CREATE INDEX ix_evaluacion_idcliente
ON Evaluacion(idCliente);

-- Turno: búsquedas por empleado y fecha
CREATE INDEX ix_turno_idempleado
ON Turno(idEmpleado);

CREATE INDEX ix_turno_fecha
ON Turno(fecha);

-- Receta: acceso rápido por producto
CREATE INDEX ix_receta_idproducto
ON Receta(idProducto);
