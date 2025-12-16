-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== ACCIONES DE REFERENCIA ====================
-- Herencias (subclases dependen totalmente del padre) -> CASCADE
ALTER TABLE Cliente_vip     DROP CONSTRAINT fk_vip_cliente;
ALTER TABLE Cliente_vip     ADD  CONSTRAINT fk_vip_cliente
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE;

ALTER TABLE Cliente_regular DROP CONSTRAINT fk_reg_cliente;
ALTER TABLE Cliente_regular ADD  CONSTRAINT fk_reg_cliente
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE;

ALTER TABLE Gerente         DROP CONSTRAINT fk_gerente_empleado;
ALTER TABLE Gerente         ADD  CONSTRAINT fk_gerente_empleado
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado) ON DELETE CASCADE;

ALTER TABLE Mesero          DROP CONSTRAINT fk_mesero_empleado;
ALTER TABLE Mesero          ADD  CONSTRAINT fk_mesero_empleado
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado) ON DELETE CASCADE;

ALTER TABLE Seguridad       DROP CONSTRAINT fk_seguridad_empleado;
ALTER TABLE Seguridad       ADD  CONSTRAINT fk_seguridad_empleado
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado) ON DELETE CASCADE;

-- Venta -> Empleado: conservar la venta aunque se elimine el empleado
ALTER TABLE Venta DROP CONSTRAINT fk_venta_empleado;
ALTER TABLE Venta ADD  CONSTRAINT fk_venta_empleado
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado) ON DELETE SET NULL;

-- Producto y especializaciones
-- Producto -> Categoria: RESTRICT (sin cambio)
ALTER TABLE Bebida DROP CONSTRAINT fk_bebida_producto;
ALTER TABLE Bebida ADD  CONSTRAINT fk_bebida_producto
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;

ALTER TABLE Comida DROP CONSTRAINT fk_comida_producto;
ALTER TABLE Comida ADD  CONSTRAINT fk_comida_producto
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;

-- Dependientes de Producto
ALTER TABLE Inventario  DROP CONSTRAINT fk_inventario_producto;
ALTER TABLE Inventario  ADD  CONSTRAINT fk_inventario_producto
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;

ALTER TABLE Ingredientes DROP CONSTRAINT fk_ing_product;
ALTER TABLE Ingredientes ADD  CONSTRAINT fk_ing_product
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;

-- Atributos [0..*]
ALTER TABLE Observaciones  DROP CONSTRAINT fk_obs_reserva;
ALTER TABLE Observaciones  ADD  CONSTRAINT fk_obs_reserva
  FOREIGN KEY (idReserva)  REFERENCES Reserva(idReserva) ON DELETE CASCADE;

ALTER TABLE ZonasAsignadas DROP CONSTRAINT fk_za_seguridad;
ALTER TABLE ZonasAsignadas ADD  CONSTRAINT fk_za_seguridad
  FOREIGN KEY (idEmpleado) REFERENCES Seguridad(idEmpleado) ON DELETE CASCADE;

ALTER TABLE Descuento      DROP CONSTRAINT fk_desc_venta;
ALTER TABLE Descuento      ADD  CONSTRAINT fk_desc_venta
  FOREIGN KEY (idVenta)    REFERENCES Venta(idVenta) ON DELETE CASCADE;

-- Detalles
ALTER TABLE DetalleVentaProducto DROP CONSTRAINT fk_dvp_venta;
ALTER TABLE DetalleVentaProducto ADD  CONSTRAINT fk_dvp_venta
  FOREIGN KEY (idVenta) REFERENCES Venta(idVenta) ON DELETE CASCADE;
-- fk_dvp_producto queda RESTRICT (sin cambio)

ALTER TABLE DetalleCompraProducto DROP CONSTRAINT fk_dcp_compra;
ALTER TABLE DetalleCompraProducto ADD  CONSTRAINT fk_dcp_compra
  FOREIGN KEY (idCompra) REFERENCES Compra(idCompra) ON DELETE CASCADE;
-- fk_dcp_producto queda RESTRICT (sin cambio)

ALTER TABLE DetalleVentaEntrada DROP CONSTRAINT fk_dve_venta;
ALTER TABLE DetalleVentaEntrada ADD  CONSTRAINT fk_dve_venta
  FOREIGN KEY (idVenta)   REFERENCES Venta(idVenta)   ON DELETE CASCADE;

ALTER TABLE DetalleVentaEntrada DROP CONSTRAINT fk_dve_entrada;
ALTER TABLE DetalleVentaEntrada ADD  CONSTRAINT fk_dve_entrada
  FOREIGN KEY (idEntrada) REFERENCES Entrada(idEntrada) ON DELETE CASCADE;

ALTER TABLE DetalleCompraEntrada DROP CONSTRAINT fk_dce_compra;
ALTER TABLE DetalleCompraEntrada ADD  CONSTRAINT fk_dce_compra
  FOREIGN KEY (idCompra)  REFERENCES Compra(idCompra)  ON DELETE CASCADE;

ALTER TABLE DetalleCompraEntrada DROP CONSTRAINT fk_dce_entrada;
ALTER TABLE DetalleCompraEntrada ADD  CONSTRAINT fk_dce_entrada
  FOREIGN KEY (idEntrada) REFERENCES Entrada(idEntrada) ON DELETE CASCADE;

-- Tablas Ciclo2

-- EVENTO -> CLIENTE
-- Si se elimina un cliente, se eliminan también sus eventos
ALTER TABLE Evento DROP CONSTRAINT fk_evento_cliente;
ALTER TABLE Evento ADD CONSTRAINT fk_evento_cliente
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE;

-- EVALUACION -> CLIENTE
-- Si se elimina un cliente, se eliminan sus evaluaciones
ALTER TABLE Evaluacion DROP CONSTRAINT fk_evaluacion_cliente;
ALTER TABLE Evaluacion ADD CONSTRAINT fk_evaluacion_cliente
  FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE;

-- TURNO -> EMPLEADO
-- Si se elimina un empleado, se eliminan sus turnos
ALTER TABLE Turno DROP CONSTRAINT fk_turno_empleado;
ALTER TABLE Turno ADD CONSTRAINT fk_turno_empleado
  FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado) ON DELETE CASCADE;

-- RECETA -> PRODUCTO
-- Si se elimina un producto, se elimina su receta
ALTER TABLE Receta DROP CONSTRAINT fk_receta_producto;
ALTER TABLE Receta ADD CONSTRAINT fk_receta_producto
  FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) ON DELETE CASCADE;
