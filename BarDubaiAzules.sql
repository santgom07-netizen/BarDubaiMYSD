-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================ CREACION DE TABLAS (28) =====================================

CREATE TABLE Cliente (
  idCliente NUMBER,
  nombre VARCHAR2(100),
  telefono VARCHAR2(15),
  email VARCHAR2(100),
  fechaRegistro DATE,
  totalCompras NUMBER
);

CREATE TABLE Cliente_vip (
  idCliente NUMBER,
  descuentoVip NUMBER,
  puntosAcumulados NUMBER,
  fechaMembresia DATE
);

CREATE TABLE Cliente_regular (
  idCliente NUMBER,
  limiteCompras NUMBER,
  descuentoRegular NUMBER
);

CREATE TABLE Reserva (
  idReserva NUMBER,
  fechaReserva DATE,
  horaReserva TIMESTAMP,
  numeroPersonas NUMBER,
  estado VARCHAR2(20),
  idCliente NUMBER
);

CREATE TABLE Observaciones (
  idReserva NUMBER,
  observaciones VARCHAR2(255)
);

CREATE TABLE Mesa (
  numeroMesa NUMBER,
  capacidad NUMBER,
  ubicacion VARCHAR2(50),
  estado VARCHAR2(20),
  reservada NUMBER(1)
);

CREATE TABLE Empleado (
  idEmpleado NUMBER,
  nombre VARCHAR2(100),
  apellido VARCHAR2(100),
  telefono VARCHAR2(15),
  email VARCHAR2(100),
  fechaIngreso DATE,
  salario NUMBER,
  turno VARCHAR2(20)
);

CREATE TABLE Gerente (
  idEmpleado NUMBER,
  nivelAutorizacion NUMBER,
  departamento VARCHAR2(50),
  bonoPorDesempeno NUMBER,
  fechaPromocion DATE
);

CREATE TABLE Mesero (
  idEmpleado NUMBER,
  zonaAsignada VARCHAR2(50),
  comisionVentas NUMBER,
  lugarTrabajo VARCHAR2(20),
  horarioTurno VARCHAR2(50)
);

CREATE TABLE Seguridad (
  idEmpleado NUMBER,
  turno VARCHAR2(20),
  licenciaSeguridadPrivada VARCHAR2(50),
  certificacionesVigentes DATE
);

CREATE TABLE ZonasAsignadas (
  idEmpleado NUMBER,
  zonasAsignadas VARCHAR2(255)
);

CREATE TABLE Venta (
  idVenta NUMBER,
  fecha DATE,
  hora TIMESTAMP,
  subtotal NUMBER,
  impuesto NUMBER,
  total NUMBER,
  estado VARCHAR2(20),
  idCliente NUMBER,
  idEmpleado NUMBER
);

CREATE TABLE Descuento (
  idVenta NUMBER,
  descuento NUMBER
);

CREATE TABLE Categoria (
  idCategoria NUMBER,
  nombre VARCHAR2(100),
  descripcion VARCHAR2(255)
);

CREATE TABLE Producto (
  idProducto NUMBER,
  nombre VARCHAR2(100),
  descripcion VARCHAR2(255),
  precio NUMBER,
  disponible NUMBER(1),
  idCategoria NUMBER
);

CREATE TABLE Bebida (
  idProducto NUMBER,
  tipoAlcohol NUMBER(1),
  gradoAlcoholico NUMBER,
  volumen VARCHAR2(20),
  temperatura VARCHAR2(20),
  marcaProductor VARCHAR2(100)
);

CREATE TABLE Comida (
  idProducto NUMBER,
  tiempoPreparacion NUMBER,
  tipoComida VARCHAR2(50),
  calorias NUMBER
);

CREATE TABLE Ingredientes (
  idProducto NUMBER,
  ingredientes VARCHAR2(255)
);

CREATE TABLE Inventario (
  idInventario NUMBER,
  idProducto NUMBER,
  cantidadStock NUMBER,
  stockMinimo NUMBER,
  fechaActualizacion DATE
);

CREATE TABLE Proveedor (
  idProveedor NUMBER,
  nombre VARCHAR2(100),
  telefono VARCHAR2(15),
  email VARCHAR2(100),
  direccion VARCHAR2(255),
  tiempoEntrega NUMBER
);

CREATE TABLE Compra (
  idCompra NUMBER,
  fechaCompra DATE,
  cantidad NUMBER,
  precioUnitario NUMBER,
  total NUMBER,
  idProveedor NUMBER
);

CREATE TABLE Entrada (
  idEntrada NUMBER,
  fechaEntrada DATE,
  cantidadIngresada NUMBER,
  tipo VARCHAR2(20),
  fechaVencimiento DATE
);

CREATE TABLE Factura (
  numeroFactura VARCHAR2(50),
  fecha DATE,
  subtotal NUMBER,
  impuestos NUMBER,
  total NUMBER,
  metodoPago VARCHAR2(50)
);

CREATE TABLE Metodo_pago (
  idTarjeta NUMBER,
  tipo VARCHAR2(50),
  descripcion VARCHAR2(255),
  requiereValidacion NUMBER(1)
);

CREATE TABLE DetalleVentaProducto (
  idVenta NUMBER,
  idProducto NUMBER,
  cantidad NUMBER,
  precioUnitario NUMBER,
  subtotal NUMBER
);

CREATE TABLE DetalleCompraProducto (
  idCompra NUMBER,
  idProducto NUMBER,
  cantidad NUMBER,
  precioUnitario NUMBER,
  subtotal NUMBER
);

CREATE TABLE DetalleVentaEntrada (
  idVenta NUMBER,
  idEntrada NUMBER,
  cantidadSalida NUMBER,
  fechaSalida DATE
);

CREATE TABLE DetalleCompraEntrada (
  idCompra NUMBER,
  idEntrada NUMBER,
  cantidadEntrada NUMBER,
  fechaEntrada DATE
);

-- ==================== ATRIBUTOS: RESTRICCIONES POR COLUMNA (28 TABLAS) ====================

-- CLIENTE
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_id_pos        CHECK (idCliente > 0);
ALTER TABLE Cliente MODIFY nombre VARCHAR2(100) NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_tel_format    CHECK (telefono IS NULL OR REGEXP_LIKE(telefono, '^[0-9]{7,15}$'));
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_email_format  CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_total_nonneg  CHECK (totalCompras >= 0);

-- CLIENTE_VIP
ALTER TABLE Cliente_vip ADD CONSTRAINT chk_vip_id_pos        CHECK (idCliente > 0);
ALTER TABLE Cliente_vip ADD CONSTRAINT chk_vip_desc_nonneg   CHECK (descuentoVip >= 0);
ALTER TABLE Cliente_vip ADD CONSTRAINT chk_vip_puntos_nonneg CHECK (puntosAcumulados >= 0);

-- CLIENTE_REGULAR
ALTER TABLE Cliente_regular ADD CONSTRAINT chk_reg_id_pos     CHECK (idCliente > 0);
ALTER TABLE Cliente_regular ADD CONSTRAINT chk_reg_lim_nonneg CHECK (limiteCompras >= 0);
ALTER TABLE Cliente_regular ADD CONSTRAINT chk_reg_desc_nonneg CHECK (descuentoRegular >= 0);

-- RESERVA
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_id_pos        CHECK (idReserva > 0);
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_personas_pos  CHECK (numeroPersonas > 0);
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_estado_len    CHECK (estado IS NULL OR LENGTH(estado) BETWEEN 1 AND 20);
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_cli_pos       CHECK (idCliente > 0);

-- OBSERVACIONES (atributo [0..*] de Reserva)
ALTER TABLE Observaciones ADD CONSTRAINT chk_obs_id_res_pos  CHECK (idReserva > 0);
ALTER TABLE Observaciones ADD CONSTRAINT chk_obs_texto_nn    CHECK (TRIM(observaciones) IS NOT NULL AND LENGTH(TRIM(observaciones)) > 0);

-- MESA
ALTER TABLE Mesa ADD CONSTRAINT chk_mesa_num_pos             CHECK (numeroMesa > 0);
ALTER TABLE Mesa ADD CONSTRAINT chk_mesa_cap_pos             CHECK (capacidad > 0);
ALTER TABLE Mesa ADD CONSTRAINT chk_mesa_reservada_bin       CHECK (reservada IN (0,1));

-- EMPLEADO
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_id_pos           CHECK (idEmpleado > 0);
ALTER TABLE Empleado MODIFY nombre  VARCHAR2(100) NOT NULL;
ALTER TABLE Empleado MODIFY apellido VARCHAR2(100) NOT NULL;
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_tel_format       CHECK (telefono IS NULL OR REGEXP_LIKE(telefono, '^[0-9]{7,15}$'));
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_mail_format      CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_salario_nonneg   CHECK (salario >= 0);

-- GERENTE (herencia)
ALTER TABLE Gerente ADD CONSTRAINT chk_ger_id_pos            CHECK (idEmpleado > 0);
ALTER TABLE Gerente ADD CONSTRAINT chk_ger_nivel_nonneg      CHECK (nivelAutorizacion >= 0);
ALTER TABLE Gerente ADD CONSTRAINT chk_ger_bono_nonneg       CHECK (bonoPorDesempeno >= 0);

-- MESERO (herencia)
ALTER TABLE Mesero ADD CONSTRAINT chk_mes_id_pos             CHECK (idEmpleado > 0);
ALTER TABLE Mesero ADD CONSTRAINT chk_mes_comision_nonneg    CHECK (comisionVentas >= 0);

-- SEGURIDAD (herencia)
ALTER TABLE Seguridad ADD CONSTRAINT chk_seg_id_pos          CHECK (idEmpleado > 0);

-- ZONAS ASIGNADAS (atributo [0..*] de Seguridad)
ALTER TABLE ZonasAsignadas ADD CONSTRAINT chk_za_emp_pos     CHECK (idEmpleado > 0);
ALTER TABLE ZonasAsignadas ADD CONSTRAINT chk_za_texto_nn    CHECK (TRIM(zonasAsignadas) IS NOT NULL AND LENGTH(TRIM(zonasAsignadas)) > 0);

-- VENTA
ALTER TABLE Venta ADD CONSTRAINT chk_venta_id_pos            CHECK (idVenta > 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_subtotal_nonneg   CHECK (subtotal >= 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_impuesto_nonneg   CHECK (impuesto >= 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_total_nonneg      CHECK (total >= 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_estado_len        CHECK (estado IS NULL OR LENGTH(estado) BETWEEN 1 AND 20);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_cli_pos           CHECK (idCliente > 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_emp_pos           CHECK (idEmpleado IS NULL OR idEmpleado > 0);

-- DESCUENTO (atributo [0..*] de Venta; rango 0..1)
ALTER TABLE Descuento ADD CONSTRAINT chk_desc_venta_pos      CHECK (idVenta > 0);
ALTER TABLE Descuento ADD CONSTRAINT chk_desc_valor_01       CHECK (descuento >= 0 AND descuento <= 1);

-- CATEGORIA
ALTER TABLE Categoria ADD CONSTRAINT chk_cat_id_pos          CHECK (idCategoria > 0);
ALTER TABLE Categoria MODIFY nombre VARCHAR2(100) NOT NULL;

-- PRODUCTO
ALTER TABLE Producto ADD CONSTRAINT chk_prod_id_pos          CHECK (idProducto > 0);
ALTER TABLE Producto MODIFY nombre VARCHAR2(100) NOT NULL;
ALTER TABLE Producto ADD CONSTRAINT chk_prod_precio_pos      CHECK (precio > 0);
ALTER TABLE Producto ADD CONSTRAINT chk_prod_disp_bin        CHECK (disponible IN (0,1));
ALTER TABLE Producto ADD CONSTRAINT chk_prod_cat_pos         CHECK (idCategoria > 0);

-- BEBIDA (herencia)
ALTER TABLE Bebida ADD CONSTRAINT chk_beb_id_pos             CHECK (idProducto > 0);
ALTER TABLE Bebida ADD CONSTRAINT chk_beb_tipo_bin           CHECK (tipoAlcohol IN (0,1));
ALTER TABLE Bebida ADD CONSTRAINT chk_beb_grado_01           CHECK (gradoAlcoholico >= 0 AND gradoAlcoholico <= 1);

-- COMIDA (herencia)
ALTER TABLE Comida ADD CONSTRAINT chk_com_id_pos             CHECK (idProducto > 0);
ALTER TABLE Comida ADD CONSTRAINT chk_com_tiempo_nonneg      CHECK (tiempoPreparacion >= 0);
ALTER TABLE Comida ADD CONSTRAINT chk_com_cal_nonneg         CHECK (calorias >= 0);

-- INGREDIENTES (atributo [0..*] de Producto/Comida)
ALTER TABLE Ingredientes ADD CONSTRAINT chk_ing_prod_pos     CHECK (idProducto > 0);
ALTER TABLE Ingredientes ADD CONSTRAINT chk_ing_texto_nn     CHECK (TRIM(ingredientes) IS NOT NULL AND LENGTH(TRIM(ingredientes)) > 0);

-- INVENTARIO
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_id_pos         CHECK (idInventario > 0);
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_prod_pos       CHECK (idProducto > 0);
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_stock_nonneg   CHECK (cantidadStock >= 0);
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_min_nonneg     CHECK (stockMinimo >= 0);

-- PROVEEDOR
ALTER TABLE Proveedor ADD CONSTRAINT chk_prov_id_pos         CHECK (idProveedor > 0);
ALTER TABLE Proveedor MODIFY nombre VARCHAR2(100) NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT chk_prov_tel_format     CHECK (telefono IS NULL OR REGEXP_LIKE(telefono, '^[0-9]{7,15}$'));
ALTER TABLE Proveedor ADD CONSTRAINT chk_prov_mail_format    CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));

-- COMPRA
ALTER TABLE Compra ADD CONSTRAINT chk_compra_id_pos          CHECK (idCompra > 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_cant_nonneg     CHECK (cantidad >= 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_pu_pos          CHECK (precioUnitario > 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_total_nonneg    CHECK (total >= 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_prov_pos        CHECK (idProveedor > 0);

-- ENTRADA
ALTER TABLE Entrada ADD CONSTRAINT chk_ent_id_pos            CHECK (idEntrada > 0);
ALTER TABLE Entrada ADD CONSTRAINT chk_ent_cant_nonneg       CHECK (cantidadIngresada >= 0);
ALTER TABLE Entrada ADD CONSTRAINT chk_ent_tipo_len          CHECK (tipo IS NULL OR LENGTH(tipo) BETWEEN 1 AND 20);

-- FACTURA
ALTER TABLE Factura ADD CONSTRAINT chk_fac_num_len           CHECK (LENGTH(numeroFactura) BETWEEN 1 AND 50);
ALTER TABLE Factura ADD CONSTRAINT chk_fac_sub_nonneg        CHECK (subtotal >= 0);
ALTER TABLE Factura ADD CONSTRAINT chk_fac_imp_nonneg        CHECK (impuestos >= 0);
ALTER TABLE Factura ADD CONSTRAINT chk_fac_tot_nonneg        CHECK (total >= 0);

-- METODO_PAGO
ALTER TABLE Metodo_pago ADD CONSTRAINT chk_mp_id_pos         CHECK (idTarjeta > 0);
ALTER TABLE Metodo_pago ADD CONSTRAINT chk_mp_req_bin        CHECK (requiereValidacion IN (0,1));

-- DETALLE VENTA PRODUCTO
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_idv_pos   CHECK (idVenta > 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_idp_pos   CHECK (idProducto > 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_cant_nonneg CHECK (cantidad >= 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_pu_pos    CHECK (precioUnitario > 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_sub_nonneg CHECK (subtotal >= 0);

-- DETALLE COMPRA PRODUCTO
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_idc_pos   CHECK (idCompra > 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_idp_pos   CHECK (idProducto > 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_cant_nonneg CHECK (cantidad >= 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_pu_pos    CHECK (precioUnitario > 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_sub_nonneg CHECK (subtotal >= 0);

-- DETALLE VENTA ENTRADA
ALTER TABLE DetalleVentaEntrada ADD CONSTRAINT chk_dve_idv_pos     CHECK (idVenta > 0);
ALTER TABLE DetalleVentaEntrada ADD CONSTRAINT chk_dve_ide_pos     CHECK (idEntrada > 0);
ALTER TABLE DetalleVentaEntrada ADD CONSTRAINT chk_dve_cant_nonneg CHECK (cantidadSalida >= 0);

-- DETALLE COMPRA ENTRADA
ALTER TABLE DetalleCompraEntrada ADD CONSTRAINT chk_dce_idc_pos    CHECK (idCompra > 0);
ALTER TABLE DetalleCompraEntrada ADD CONSTRAINT chk_dce_ide_pos    CHECK (idEntrada > 0);
ALTER TABLE DetalleCompraEntrada ADD CONSTRAINT chk_dce_cant_nonneg CHECK (cantidadEntrada >= 0);

-- ==================== TIPOS ENUMERADOS  =======================

-- Turno (Empleado y Seguridad)
ALTER TABLE Empleado  ADD CONSTRAINT chk_emp_turno          CHECK (turno IN ('Dia','Noche','Mixto'));
ALTER TABLE Seguridad ADD CONSTRAINT chk_seg_turno_enum     CHECK (turno IN ('Dia','Noche','Mixto'));

-- Temperatura (Bebida)
ALTER TABLE Bebida    ADD CONSTRAINT chk_beb_temperatura    CHECK (temperatura IN ('Fria','Caliente','Ambiente'));

-- Tipo de comida (Comida)
ALTER TABLE Comida    ADD CONSTRAINT chk_com_tipo_enum      CHECK (tipoComida IN ('Entrada','Plato Fuerte','Postre','Acompanamiento'));

-- Lugar de trabajo (Mesero)
ALTER TABLE Mesero    ADD CONSTRAINT chk_mes_lugar_enum     CHECK (lugarTrabajo IN ('Mesa','Barra'));

-- Volumen con unidad (Bebida)  ej: "500 ml" o "1.5 litros"
ALTER TABLE Bebida    ADD CONSTRAINT chk_beb_volumen_fmt    CHECK (REGEXP_LIKE(volumen, '^[0-9]+(\.[0-9]+)? (ml|litros)$'));

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

-- ==================== UNICAS: DEFINICION DE CLAVES UNICAS ====================

-- Cliente
ALTER TABLE Cliente  ADD CONSTRAINT uq_cliente_email    UNIQUE (email);
ALTER TABLE Cliente  ADD CONSTRAINT uq_cliente_telefono UNIQUE (telefono);

-- Empleado
ALTER TABLE Empleado ADD CONSTRAINT uq_empleado_email    UNIQUE (email);
ALTER TABLE Empleado ADD CONSTRAINT uq_empleado_telefono UNIQUE (telefono);

-- Proveedor
ALTER TABLE Proveedor ADD CONSTRAINT uq_proveedor_telefono UNIQUE (telefono);

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

-- ==================== XPoblar: Eliminación de datos ====================

-- Detalles de ventas y compras
DELETE FROM DetalleCompraEntrada;
DELETE FROM DetalleVentaEntrada;
DELETE FROM DetalleCompraProducto;
DELETE FROM DetalleVentaProducto;

-- Atributos [0..*]
DELETE FROM Descuento;
DELETE FROM Ingredientes;
DELETE FROM ZonasAsignadas;
DELETE FROM Observaciones;

-- Especializaciones de producto
DELETE FROM Bebida;
DELETE FROM Comida;

-- Movimientos e inventario
DELETE FROM Inventario;
DELETE FROM Entrada;
DELETE FROM Compra;

-- Relaciones principales
DELETE FROM Venta;
DELETE FROM Reserva;

-- Entidades dependientes
DELETE FROM Mesero;
DELETE FROM Gerente;
DELETE FROM Seguridad;
DELETE FROM Empleado;

DELETE FROM Cliente_vip;
DELETE FROM Cliente_regular;
DELETE FROM Cliente;

-- Productos y categorías
DELETE FROM Producto;
DELETE FROM Categoria;

-- Proveedores y mesas
DELETE FROM Proveedor;
DELETE FROM Mesa;

-- Opcional: Facturación y métodos de pago (si los usaste)
DELETE FROM Factura;
DELETE FROM Metodo_pago;

-- ==================== XTablas: Eliminación de tablas ====================
DROP TABLE DetalleCompraEntrada   CASCADE CONSTRAINTS;
DROP TABLE DetalleVentaEntrada    CASCADE CONSTRAINTS;
DROP TABLE DetalleCompraProducto  CASCADE CONSTRAINTS;
DROP TABLE DetalleVentaProducto   CASCADE CONSTRAINTS;

DROP TABLE Descuento              CASCADE CONSTRAINTS;
DROP TABLE Ingredientes           CASCADE CONSTRAINTS;
DROP TABLE ZonasAsignadas         CASCADE CONSTRAINTS;
DROP TABLE Observaciones          CASCADE CONSTRAINTS;

DROP TABLE Bebida                 CASCADE CONSTRAINTS;
DROP TABLE Comida                 CASCADE CONSTRAINTS;

DROP TABLE Inventario             CASCADE CONSTRAINTS;
DROP TABLE Entrada                CASCADE CONSTRAINTS;
DROP TABLE Compra                 CASCADE CONSTRAINTS;
DROP TABLE Proveedor              CASCADE CONSTRAINTS;

DROP TABLE Producto               CASCADE CONSTRAINTS;
DROP TABLE Categoria              CASCADE CONSTRAINTS;

DROP TABLE Venta                  CASCADE CONSTRAINTS;
DROP TABLE Reserva                CASCADE CONSTRAINTS;
DROP TABLE Mesa                   CASCADE CONSTRAINTS;

DROP TABLE Gerente                CASCADE CONSTRAINTS;
DROP TABLE Mesero                 CASCADE CONSTRAINTS;
DROP TABLE Seguridad              CASCADE CONSTRAINTS;
DROP TABLE Empleado               CASCADE CONSTRAINTS;

DROP TABLE Cliente_vip            CASCADE CONSTRAINTS;
DROP TABLE Cliente_regular        CASCADE CONSTRAINTS;
DROP TABLE Cliente                CASCADE CONSTRAINTS;

DROP TABLE Factura                CASCADE CONSTRAINTS;
DROP TABLE Metodo_pago            CASCADE CONSTRAINTS;

-- ==================== CONSULTAS: Incluir identificador (Comentadas) ====================

-- 1) Estado de mesas (idMesa)
-- SELECT m.numeroMesa AS idMesa, m.capacidad, m.ubicacion, m.estado,
--        CASE m.reservada WHEN 1 THEN 'SI' ELSE 'NO' END AS reservada
-- FROM Mesa m
-- ORDER BY m.numeroMesa;

-- 2) Mesas disponibles por capacidad (idMesa)
-- -- &p_personas para ejecutar como Script (F5)
-- SELECT m.numeroMesa AS idMesa, m.capacidad, m.ubicacion
-- FROM Mesa m
-- WHERE m.reservada = 0 AND m.capacidad >= &p_personas
-- ORDER BY m.capacidad, m.numeroMesa;

-- 3) Tiempo estimado de entrega (idVenta)
-- -- &p_idventa
-- SELECT v.idVenta,
--        NVL(SUM(c.tiempoPreparacion * d.cantidad), 0) AS minutos_estimados
-- FROM Venta v
-- LEFT JOIN DetalleVentaProducto d ON d.idVenta = v.idVenta
-- LEFT JOIN Comida c              ON c.idProducto = d.idProducto
-- WHERE v.idVenta = &p_idventa
-- GROUP BY v.idVenta;

-- 4) Ventas pendientes por preparar (idVenta)
-- SELECT v.idVenta, v.fecha, v.estado, SUM(d.cantidad) AS total_platos
-- FROM Venta v
-- JOIN DetalleVentaProducto d ON d.idVenta = v.idVenta
-- JOIN Comida c              ON c.idProducto = d.idProducto
-- WHERE v.estado = 'Pendiente'
-- GROUP BY v.idVenta, v.fecha, v.estado
-- ORDER BY v.fecha, v.idVenta;

-- 5) Productos solicitados en compras pendientes (idCompra, idProducto)
-- -- &p_idproveedor
-- WITH ordered AS (
--   SELECT dc.idCompra, dc.idProducto, SUM(dc.cantidad) AS qty_ordered
--   FROM DetalleCompraProducto dc
--   GROUP BY dc.idCompra, dc.idProducto
-- ),
-- received AS (
--   SELECT dce.idCompra, SUM(dce.cantidadEntrada) AS qty_received
--   FROM DetalleCompraEntrada dce
--   GROUP BY dce.idCompra
-- )
-- SELECT c.idCompra, p.idProducto, p.nombre AS producto,
--        o.qty_ordered, NVL(r.qty_received, 0) AS qty_received,
--        (o.qty_ordered - NVL(r.qty_received, 0)) AS qty_pendiente
-- FROM ordered o
-- JOIN Compra   c ON c.idCompra   = o.idCompra
-- JOIN Producto p ON p.idProducto = o.idProducto
-- LEFT JOIN received r ON r.idCompra = o.idCompra
-- WHERE NVL(r.qty_received, 0) < o.qty_ordered
--   AND c.idProveedor = &p_idproveedor
-- ORDER BY c.idCompra, p.idProducto;

-- 6) Historial de entregas del proveedor (idProveedor, idCompra, idEntrada)
-- -- &p_idproveedor
-- SELECT pr.idProveedor, c.idCompra, e.idEntrada, e.fechaEntrada, dce.cantidadEntrada
-- FROM Proveedor pr
-- JOIN Compra c               ON c.idProveedor = pr.idProveedor
-- JOIN DetalleCompraEntrada dce ON dce.idCompra   = c.idCompra
-- JOIN Entrada e              ON e.idEntrada       = dce.idEntrada
-- WHERE pr.idProveedor = &p_idproveedor
-- ORDER BY e.fechaEntrada DESC, e.idEntrada;

