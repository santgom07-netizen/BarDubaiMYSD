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


-- Tablas Ciclo2

CREATE TABLE Evento (
    idEvento       NUMBER,
    nombreEvento   VARCHAR2(100),
    descripcion    VARCHAR2(255),
    fechaEvento    DATE,
    horaInicio     NUMBER,
    horaFin        NUMBER,
    numeroPersonas NUMBER,
    estado         VARCHAR2(20)
);

CREATE TABLE Evaluacion (
    idEvaluacion         NUMBER,
    calificacionServicio NUMBER,
    calificacionProducto NUMBER,
    calificacionAmbiente NUMBER,
    comentario           VARCHAR2(255),
    fechaEvaluacion      DATE
);

CREATE TABLE Turno (
    idTurno       NUMBER,
    tipo          VARCHAR2(50),
    horaInicio    NUMBER,
    horaFin       NUMBER,
    fecha         DATE,
    asistio       NUMBER,      
    observaciones VARCHAR2(255)
);

CREATE TABLE Receta (
    idReceta         NUMBER,
    ingredientes     VARCHAR2(255),
    instrucciones    VARCHAR2(255),
    tiempoPreparacion NUMBER,
    porciones        NUMBER
);

