-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== FORANEAS: DEFINICION DE CLAVES FORANEAS ====================

-- Herencia: subclases -> superclase
ALTER TABLE Cliente_vip     ADD CONSTRAINT fk_vip_cliente        FOREIGN KEY (idCliente)  REFERENCES Cliente(idCliente);
ALTER TABLE Cliente_regular ADD CONSTRAINT fk_reg_cliente        FOREIGN KEY (idCliente)  REFERENCES Cliente(idCliente);

ALTER TABLE Gerente         ADD CONSTRAINT fk_gerente_empleado   FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado);
ALTER TABLE Mesero          ADD CONSTRAINT fk_mesero_empleado    FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado);
ALTER TABLE Seguridad       ADD CONSTRAINT fk_seguridad_empleado FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado);

-- Relaciones entidad-entidad
ALTER TABLE Reserva         ADD CONSTRAINT fk_reserva_cliente    FOREIGN KEY (idCliente)  REFERENCES Cliente(idCliente);
ALTER TABLE Venta           ADD CONSTRAINT fk_venta_cliente      FOREIGN KEY (idCliente)  REFERENCES Cliente(idCliente);
ALTER TABLE Venta           ADD CONSTRAINT fk_venta_empleado     FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado);

ALTER TABLE Producto        ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria);
ALTER TABLE Bebida          ADD CONSTRAINT fk_bebida_producto    FOREIGN KEY (idProducto)  REFERENCES Producto(idProducto);
ALTER TABLE Comida          ADD CONSTRAINT fk_comida_producto    FOREIGN KEY (idProducto)  REFERENCES Producto(idProducto);

ALTER TABLE Inventario      ADD CONSTRAINT fk_inventario_producto FOREIGN KEY (idProducto) REFERENCES Producto(idProducto);
ALTER TABLE Ingredientes    ADD CONSTRAINT fk_ing_product        FOREIGN KEY (idProducto)  REFERENCES Producto(idProducto);

ALTER TABLE Compra          ADD CONSTRAINT fk_compra_proveedor   FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor);

-- Atributos [0..*]
ALTER TABLE Observaciones   ADD CONSTRAINT fk_obs_reserva        FOREIGN KEY (idReserva)   REFERENCES Reserva(idReserva);
ALTER TABLE ZonasAsignadas  ADD CONSTRAINT fk_za_seguridad       FOREIGN KEY (idEmpleado)  REFERENCES Seguridad(idEmpleado);
ALTER TABLE Descuento       ADD CONSTRAINT fk_desc_venta         FOREIGN KEY (idVenta)     REFERENCES Venta(idVenta);

-- Detalles (combinan claves de ambas entidades)
ALTER TABLE DetalleVentaProducto
  ADD CONSTRAINT fk_dvp_venta    FOREIGN KEY (idVenta)    REFERENCES Venta(idVenta);
ALTER TABLE DetalleVentaProducto
  ADD CONSTRAINT fk_dvp_producto FOREIGN KEY (idProducto) REFERENCES Producto(idProducto);

ALTER TABLE DetalleCompraProducto
  ADD CONSTRAINT fk_dcp_compra   FOREIGN KEY (idCompra)   REFERENCES Compra(idCompra);
ALTER TABLE DetalleCompraProducto
  ADD CONSTRAINT fk_dcp_producto FOREIGN KEY (idProducto) REFERENCES Producto(idProducto);

ALTER TABLE DetalleVentaEntrada
  ADD CONSTRAINT fk_dve_venta    FOREIGN KEY (idVenta)    REFERENCES Venta(idVenta);
ALTER TABLE DetalleVentaEntrada
  ADD CONSTRAINT fk_dve_entrada  FOREIGN KEY (idEntrada)  REFERENCES Entrada(idEntrada);

ALTER TABLE DetalleCompraEntrada
  ADD CONSTRAINT fk_dce_compra   FOREIGN KEY (idCompra)   REFERENCES Compra(idCompra);
ALTER TABLE DetalleCompraEntrada
  ADD CONSTRAINT fk_dce_entrada  FOREIGN KEY (idEntrada)  REFERENCES Entrada(idEntrada);

-- Tablas Ciclo2

-- EVENTO -> CLIENTE
ALTER TABLE Evento
    ADD CONSTRAINT fk_evento_cliente
        FOREIGN KEY (idCliente)
        REFERENCES Cliente(idCliente);

-- EVALUACION -> CLIENTE
ALTER TABLE Evaluacion
    ADD CONSTRAINT fk_evaluacion_cliente
        FOREIGN KEY (idCliente)
        REFERENCES Cliente(idCliente);

-- TURNO -> EMPLEADO
ALTER TABLE Turno
    ADD CONSTRAINT fk_turno_empleado
        FOREIGN KEY (idEmpleado)
        REFERENCES Empleado(idEmpleado);

-- RECETA -> PRODUCTO
ALTER TABLE Receta
    ADD CONSTRAINT fk_receta_producto
        FOREIGN KEY (idProducto)
        REFERENCES Producto(idProducto);
