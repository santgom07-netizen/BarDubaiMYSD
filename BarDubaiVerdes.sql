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

-- ==================== TUPLAS: RESTRICCIONES MULTI-ATRIBUTO ====================

-- Cliente: al menos un medio de contacto
ALTER TABLE Cliente
  ADD CONSTRAINT chk_cliente_contacto_minuno
  CHECK (telefono IS NOT NULL OR email IS NOT NULL);

-- Bebida: consistencia entre tipoAlcohol y gradoAlcoholico
ALTER TABLE Bebida
  ADD CONSTRAINT chk_beb_consistencia_alcohol
  CHECK (
    (tipoAlcohol = 0 AND gradoAlcoholico = 0)
    OR
    (tipoAlcohol = 1 AND gradoAlcoholico > 0 AND gradoAlcoholico <= 1)
  );

-- Entrada: vencimiento no anterior a la entrada
ALTER TABLE Entrada
  ADD CONSTRAINT chk_ent_fechas_coherentes
  CHECK (fechaVencimiento IS NULL OR fechaVencimiento >= fechaEntrada);

-- Inventario: minimo no mayor al stock actual
ALTER TABLE Inventario
  ADD CONSTRAINT chk_inv_min_leq_stock
  CHECK (stockMinimo <= cantidadStock);

-- Compra: total = cantidad * precioUnitario
ALTER TABLE Compra
  ADD CONSTRAINT chk_compra_total_calc
  CHECK (total = cantidad * precioUnitario);

-- Factura: total = subtotal + impuestos
ALTER TABLE Factura
  ADD CONSTRAINT chk_fact_total_eq
  CHECK (total = subtotal + impuestos);

-- Venta: total = subtotal + impuesto
ALTER TABLE Venta
  ADD CONSTRAINT chk_venta_total_eq
  CHECK (total = subtotal + impuesto);

-- DetalleVentaProducto: subtotal = cantidad * precioUnitario
ALTER TABLE DetalleVentaProducto
  ADD CONSTRAINT chk_dvp_subtotal_calc
  CHECK (subtotal = cantidad * precioUnitario);

-- DetalleCompraProducto: subtotal = cantidad * precioUnitario
ALTER TABLE DetalleCompraProducto
  ADD CONSTRAINT chk_dcp_subtotal_calc
  CHECK (subtotal = cantidad * precioUnitario);

-- Metodo_pago: relacion tipo vs validacion (ajusta los tipos si usas otros)
ALTER TABLE Metodo_pago
  ADD CONSTRAINT chk_mp_tipo_vs_validacion
  CHECK (
    (tipo <> 'Tarjeta'  OR requiereValidacion = 1) AND
    (tipo <> 'Efectivo' OR requiereValidacion = 0)
  );

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

-- ==================== DISPARADORES ====================

-- Soporte: procedimiento para recalcular totales de una venta
CREATE OR REPLACE PROCEDURE prc_recalcular_venta (p_idVenta IN NUMBER) IS
  c_tax CONSTANT NUMBER := 0.16;   -- IVA 16% (ajusta si usas otro)
  v_sub       NUMBER := 0;
  v_desc      NUMBER := 0;
  v_sub_desc  NUMBER := 0;
  v_imp       NUMBER := 0;
  v_tot       NUMBER := 0;
BEGIN
  SELECT NVL(SUM(subtotal),0)
    INTO v_sub
    FROM DetalleVentaProducto
   WHERE idVenta = p_idVenta;

  SELECT NVL(MAX(descuento),0)
    INTO v_desc
    FROM Descuento
   WHERE idVenta = p_idVenta;

  v_sub_desc := ROUND(v_sub * (1 - v_desc), 2);
  v_imp      := ROUND(v_sub_desc * c_tax, 2);
  v_tot      := v_sub_desc + v_imp;

  UPDATE Venta
     SET subtotal = v_sub_desc,
         impuesto = v_imp,
         total    = v_tot
   WHERE idVenta = p_idVenta;
END;
/
SHOW ERRORS;

-- Inventario: fecha de actualización automática
CREATE OR REPLACE TRIGGER trg_inv_touch_bu
BEFORE UPDATE OF cantidadStock, stockMinimo ON Inventario
FOR EACH ROW
BEGIN
  :NEW.fechaActualizacion := SYSDATE;
END;
/
SHOW ERRORS;

-- Crear inventario al insertar producto
CREATE OR REPLACE TRIGGER trg_prod_crea_inventario_ai
AFTER INSERT ON Producto
FOR EACH ROW
DECLARE
  v_idInv NUMBER;
BEGIN
  SELECT NVL(MAX(idInventario),0) + 1 INTO v_idInv FROM Inventario;
  INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
  VALUES (v_idInv, :NEW.idProducto, 0, 0, SYSDATE);
END;
/
SHOW ERRORS;

-- Ventas: validación y ajuste de stock

-- Validar stock antes de insertar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_chk_stock_bi
BEFORE INSERT ON DetalleVentaProducto
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT cantidadStock INTO v_stock FROM Inventario
   WHERE idProducto = :NEW.idProducto FOR UPDATE;
  IF :NEW.cantidad > v_stock THEN
    RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente para producto '||:NEW.idProducto);
  END IF;
END;
/
SHOW ERRORS;

-- Descontar stock al insertar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_stock_ai
AFTER INSERT ON DetalleVentaProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock - :NEW.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

-- Validar stock antes de actualizar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_chk_stock_bu
BEFORE UPDATE ON DetalleVentaProducto
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT cantidadStock INTO v_stock FROM Inventario
   WHERE idProducto = :NEW.idProducto FOR UPDATE;
  IF (:NEW.cantidad - :OLD.cantidad) > v_stock THEN
    RAISE_APPLICATION_ERROR(-20002, 'Stock insuficiente para actualización en producto '||:NEW.idProducto);
  END IF;
END;
/
SHOW ERRORS;

-- Ajustar stock al actualizar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_stock_au
AFTER UPDATE ON DetalleVentaProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + :OLD.cantidad - :NEW.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

-- Reintegrar stock al borrar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_stock_ad
AFTER DELETE ON DetalleVentaProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + :OLD.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :OLD.idProducto;
END;
/
SHOW ERRORS;

-- Recalcular totales de Venta cuando cambien detalles (trigger compuesto)
CREATE OR REPLACE TRIGGER trg_dvp_recalc_ct
FOR INSERT OR UPDATE OR DELETE ON DetalleVentaProducto
COMPOUND TRIGGER
  TYPE t_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  g_ids t_ids;

  PROCEDURE add_id(p NUMBER) IS
  BEGIN
    IF p IS NOT NULL THEN
      g_ids(g_ids.COUNT + 1) := p;
    END IF;
  END;

  BEFORE STATEMENT IS
  BEGIN
    g_ids.DELETE;
  END BEFORE STATEMENT;

  AFTER EACH ROW IS
  BEGIN
    add_id(:NEW.idVenta);
    add_id(:OLD.idVenta);
  END AFTER EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF g_ids.COUNT > 0 THEN
      -- Opcional: deduplicar; aquí recalculamos para cada id capturado
      FOR i IN 1..g_ids.COUNT LOOP
        prc_recalcular_venta(g_ids(i));
      END LOOP;
    END IF;
  END AFTER STATEMENT;
END;
/
SHOW ERRORS;

-- Compras: sumar/restar stock según detalle de compra

CREATE OR REPLACE TRIGGER trg_dcp_stock_ai
AFTER INSERT ON DetalleCompraProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + :NEW.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_dcp_stock_au
AFTER UPDATE ON DetalleCompraProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + (:NEW.cantidad - :OLD.cantidad),
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_dcp_stock_ad
AFTER DELETE ON DetalleCompraProducto
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT cantidadStock INTO v_stock FROM Inventario
   WHERE idProducto = :OLD.idProducto FOR UPDATE;
  IF v_stock - :OLD.cantidad < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Eliminación deja stock negativo para producto '||:OLD.idProducto);
  END IF;
  UPDATE Inventario
     SET cantidadStock = v_stock - :OLD.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :OLD.idProducto;
END;
/
SHOW ERRORS;

-- Recalcular totales de Venta cuando cambie Descuento (trigger compuesto)
CREATE OR REPLACE TRIGGER trg_desc_recalc_ct
FOR INSERT OR UPDATE OR DELETE ON Descuento
COMPOUND TRIGGER
  TYPE t_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  g_ids t_ids;

  PROCEDURE add_id(p NUMBER) IS
  BEGIN
    IF p IS NOT NULL THEN
      g_ids(g_ids.COUNT + 1) := p;
    END IF;
  END;

  BEFORE STATEMENT IS
  BEGIN
    g_ids.DELETE;
  END BEFORE STATEMENT;

  AFTER EACH ROW IS
  BEGIN
    add_id(:NEW.idVenta);
    add_id(:OLD.idVenta);
  END AFTER EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF g_ids.COUNT > 0 THEN
      FOR i IN 1..g_ids.COUNT LOOP
        prc_recalcular_venta(g_ids(i));
      END LOOP;
    END IF;
  END AFTER STATEMENT;
END;
/
SHOW ERRORS;

-- ==================== TuplasOK ====================
-- Cliente con al menos un medio de contacto
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (50, 'Contacto OK', '3008887777', NULL, SYSDATE, 0);

-- Bebida coherente: no alcohólica con grado 0
INSERT INTO Producto (idProducto, nombre, descripcion, precio, disponible, idCategoria)
VALUES (850, 'Jugo Manzana', '300 ml', 5.00, 1, 1);
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (850, 0, 0, '300 ml', 'Ambiente', 'Natural');

-- Entrada con fechas coherentes
INSERT INTO Entrada (idEntrada, fechaEntrada, cantidadIngresada, tipo, fechaVencimiento)
VALUES (8500, DATE '2025-11-05', 10, 'Lote', DATE '2026-01-01');

-- Inventario con mínimo <= stock
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9850, 850, 10, 2, SYSDATE);

-- Compra con total = cantidad * precioUnitario
INSERT INTO Compra (idCompra, fechaCompra, cantidad, precioUnitario, total, idProveedor)
VALUES (9500, SYSDATE, 4, 2.50, 10.00, 1);

-- Factura total = subtotal + impuestos
INSERT INTO Factura (numeroFactura, fecha, subtotal, impuestos, total, metodoPago)
VALUES ('F-OK-1', SYSDATE, 100, 16, 116, 'Tarjeta');

-- Venta con totales iguales a subtotal+impuesto (se permite, luego triggers recalculan)
INSERT INTO Venta (idVenta, fecha, hora, subtotal, impuesto, total, estado, idCliente, idEmpleado)
VALUES (9400, SYSDATE, SYSTIMESTAMP, 0, 0, 0, 'Pendiente', 50, NULL);

-- DetalleVentaProducto con subtotal = cantidad * precio
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9400, 201, 1, 18.00, 18.00);

-- ==================== TuplasNoOK ====================
-- Cliente sin teléfono ni email (debe fallar chk_cliente_contacto_minuno)
INSERT INTO Cliente (idCliente, nombre, telefono, email, fechaRegistro, totalCompras)
VALUES (51, 'Sin Contacto', NULL, NULL, SYSDATE, 0);

-- Bebida incoherente: tipoAlcohol=1 con grado 0 (debe fallar chk_beb_consistencia_alcohol)
INSERT INTO Bebida (idProducto, tipoAlcohol, gradoAlcoholico, volumen, temperatura, marcaProductor)
VALUES (850, 1, 0, '300 ml', 'Ambiente', 'Natural');

-- Entrada con vencimiento anterior a la entrada (debe fallar chk_ent_fechas_coherentes)
INSERT INTO Entrada (idEntrada, fechaEntrada, cantidadIngresada, tipo, fechaVencimiento)
VALUES (8501, DATE '2025-11-10', 5, 'Lote', DATE '2025-11-01');

-- Inventario con stockMinimo > cantidadStock (debe fallar chk_inv_min_leq_stock)
INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
VALUES (9851, 850, 3, 5, SYSDATE);

-- Compra con total incorrecto (debe fallar chk_compra_total_calc)
INSERT INTO Compra (idCompra, fechaCompra, cantidad, precioUnitario, total, idProveedor)
VALUES (9501, SYSDATE, 4, 2.50, 11.00, 1);

-- Factura con total incorrecto (debe fallar chk_fact_total_eq)
INSERT INTO Factura (numeroFactura, fecha, subtotal, impuestos, total, metodoPago)
VALUES ('F-BAD-1', SYSDATE, 100, 16, 117, 'Tarjeta');

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

-- ==================== DisparadoresNoOK ====================
-- Intentar vender más de lo que hay (debe fallar por trg_dvp_chk_stock_bi)
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9700, 201, 9999, 18.00, 179982.00);

-- Intentar actualizar detalle de venta para dejar stock negativo (debe fallar)
UPDATE DetalleVentaProducto
   SET cantidad = cantidad + 10000
 WHERE idVenta = 9700 AND idProducto = 201;

-- Intentar borrar detalle de compra dejando stock negativo (debe fallar por -20003)
DELETE FROM DetalleCompraProducto
 WHERE idCompra = 5001 AND idProducto = 201 AND cantidad = 3;
 
-- ==================== XDisparadores: Eliminación de disparadores ====================

DROP TRIGGER trg_inv_touch_bu;
DROP TRIGGER trg_prod_crea_inventario_ai;

DROP TRIGGER trg_dvp_chk_stock_bi;
DROP TRIGGER trg_dvp_stock_ai;
DROP TRIGGER trg_dvp_chk_stock_bu;
DROP TRIGGER trg_dvp_stock_au;
DROP TRIGGER trg_dvp_stock_ad;
DROP TRIGGER trg_dvp_recalc_ct;

DROP TRIGGER trg_dcp_stock_ai;
DROP TRIGGER trg_dcp_stock_au;
DROP TRIGGER trg_dcp_stock_ad;

DROP TRIGGER trg_desc_recalc_ct;



