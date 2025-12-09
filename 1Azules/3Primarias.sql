-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== PRIMARIAS: DEFINICION DE CLAVES PRIMARIAS ====================

-- Entidades base
ALTER TABLE Cliente            ADD CONSTRAINT pk_cliente              PRIMARY KEY (idCliente);
ALTER TABLE Reserva            ADD CONSTRAINT pk_reserva              PRIMARY KEY (idReserva);
ALTER TABLE Mesa               ADD CONSTRAINT pk_mesa                 PRIMARY KEY (numeroMesa);
ALTER TABLE Empleado           ADD CONSTRAINT pk_empleado             PRIMARY KEY (idEmpleado);
ALTER TABLE Venta              ADD CONSTRAINT pk_venta                PRIMARY KEY (idVenta);
ALTER TABLE Categoria          ADD CONSTRAINT pk_categoria            PRIMARY KEY (idCategoria);
ALTER TABLE Producto           ADD CONSTRAINT pk_producto             PRIMARY KEY (idProducto);
ALTER TABLE Inventario         ADD CONSTRAINT pk_inventario           PRIMARY KEY (idInventario);
ALTER TABLE Proveedor          ADD CONSTRAINT pk_proveedor            PRIMARY KEY (idProveedor);
ALTER TABLE Compra             ADD CONSTRAINT pk_compra               PRIMARY KEY (idCompra);
ALTER TABLE Entrada            ADD CONSTRAINT pk_entrada              PRIMARY KEY (idEntrada);
ALTER TABLE Factura            ADD CONSTRAINT pk_factura              PRIMARY KEY (numeroFactura);
ALTER TABLE Metodo_pago        ADD CONSTRAINT pk_metodo_pago          PRIMARY KEY (idTarjeta);

-- Herencia: PK de subclase = PK de superclase
ALTER TABLE Cliente_vip        ADD CONSTRAINT pk_cliente_vip          PRIMARY KEY (idCliente);
ALTER TABLE Cliente_regular    ADD CONSTRAINT pk_cliente_regular      PRIMARY KEY (idCliente);

ALTER TABLE Gerente            ADD CONSTRAINT pk_gerente              PRIMARY KEY (idEmpleado);
ALTER TABLE Mesero             ADD CONSTRAINT pk_mesero               PRIMARY KEY (idEmpleado);
ALTER TABLE Seguridad          ADD CONSTRAINT pk_seguridad            PRIMARY KEY (idEmpleado);

-- Atributos [0..*] modelados como tablas
-- Observaciones: PK compuesta (idReserva, observaciones)
ALTER TABLE Observaciones      ADD CONSTRAINT pk_observaciones        PRIMARY KEY (idReserva, observaciones);

-- ZonasAsignadas: PK compuesta (idEmpleado, zonasAsignadas)
ALTER TABLE ZonasAsignadas     ADD CONSTRAINT pk_zonas_asignadas      PRIMARY KEY (idEmpleado, zonasAsignadas);

-- Ingredientes: PK compuesta (idProducto, ingredientes)
ALTER TABLE Ingredientes       ADD CONSTRAINT pk_ingredientes         PRIMARY KEY (idProducto, ingredientes);

-- Descuento: PK compuesta (idVenta, descuento)
ALTER TABLE Descuento          ADD CONSTRAINT pk_descuento            PRIMARY KEY (idVenta, descuento);

-- Especializaciones de Producto
ALTER TABLE Bebida             ADD CONSTRAINT pk_bebida               PRIMARY KEY (idProducto);
ALTER TABLE Comida             ADD CONSTRAINT pk_comida               PRIMARY KEY (idProducto);

-- Tablas de detalle (PK = combinación de las PK referenciadas)
ALTER TABLE DetalleVentaProducto
  ADD CONSTRAINT pk_det_venta_producto PRIMARY KEY (idVenta, idProducto);

ALTER TABLE DetalleCompraProducto
  ADD CONSTRAINT pk_det_compra_producto PRIMARY KEY (idCompra, idProducto);

ALTER TABLE DetalleVentaEntrada
  ADD CONSTRAINT pk_det_venta_entrada PRIMARY KEY (idVenta, idEntrada);

ALTER TABLE DetalleCompraEntrada
  ADD CONSTRAINT pk_det_compra_entrada PRIMARY KEY (idCompra, idEntrada);
