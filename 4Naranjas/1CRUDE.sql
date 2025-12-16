-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== CRUDE =====================
--------------------------------------------------
-- 1) EMPLEADO
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_empleado AS
  PROCEDURE crear_empleado(
    p_id        IN Empleado.idEmpleado%TYPE,
    p_nombre    IN Empleado.nombre%TYPE,
    p_apellido  IN Empleado.apellido%TYPE,
    p_telefono  IN Empleado.telefono%TYPE,
    p_email     IN Empleado.email%TYPE,
    p_salario   IN Empleado.salario%TYPE,
    p_turno     IN Empleado.turno%TYPE
  );

  PROCEDURE asignar_mesero(
    p_id        IN Empleado.idEmpleado%TYPE,
    p_zona      IN Mesero.zonaAsignada%TYPE,
    p_comision  IN Mesero.comisionVentas%TYPE,
    p_lugar     IN Mesero.lugarTrabajo%TYPE,
    p_horario   IN Mesero.horarioTurno%TYPE
  );

  FUNCTION obtener_empleado(
    p_id IN Empleado.idEmpleado%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_empleado(
    p_id        IN Empleado.idEmpleado%TYPE,
    p_telefono  IN Empleado.telefono%TYPE,
    p_email     IN Empleado.email%TYPE,
    p_salario   IN Empleado.salario%TYPE,
    p_turno     IN Empleado.turno%TYPE
  );

  PROCEDURE eliminar_empleado(
    p_id IN Empleado.idEmpleado%TYPE
  );
END pkg_empleado;
/
--------------------------------------------------
-- 2) CLIENTE
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_cliente AS
  PROCEDURE crear_cliente(
    p_id       IN Cliente.idCliente%TYPE,
    p_nombre   IN Cliente.nombre%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  );

  FUNCTION obtener_cliente(
    p_id IN Cliente.idCliente%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_cliente(
    p_id       IN Cliente.idCliente%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  );

  PROCEDURE eliminar_cliente(
    p_id IN Cliente.idCliente%TYPE
  );
END pkg_cliente;
/
--------------------------------------------------
-- 3) PRODUCTO
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_producto AS
  PROCEDURE crear_producto(
    p_id          IN Producto.idProducto%TYPE,
    p_nombre      IN Producto.nombre%TYPE,
    p_descripcion IN Producto.descripcion%TYPE,
    p_precio      IN Producto.precio%TYPE,
    p_disponible  IN Producto.disponible%TYPE,
    p_idCategoria IN Producto.idCategoria%TYPE
  );

  FUNCTION obtener_producto(
    p_id IN Producto.idProducto%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_producto(
    p_id          IN Producto.idProducto%TYPE,
    p_nombre      IN Producto.nombre%TYPE,
    p_descripcion IN Producto.descripcion%TYPE,
    p_precio      IN Producto.precio%TYPE,
    p_disponible  IN Producto.disponible%TYPE
  );

  PROCEDURE eliminar_producto(
    p_id IN Producto.idProducto%TYPE
  );
END pkg_producto;
/
--------------------------------------------------
-- 4) CATEGORIA
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_categoria AS
  PROCEDURE crear_categoria(
    p_id          IN Categoria.idCategoria%TYPE,
    p_nombre      IN Categoria.nombre%TYPE,
    p_descripcion IN Categoria.descripcion%TYPE
  );

  FUNCTION obtener_categoria(
    p_id IN Categoria.idCategoria%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_categoria(
    p_id          IN Categoria.idCategoria%TYPE,
    p_nombre      IN Categoria.nombre%TYPE,
    p_descripcion IN Categoria.descripcion%TYPE
  );

  PROCEDURE eliminar_categoria(
    p_id IN Categoria.idCategoria%TYPE
  );
END pkg_categoria;
/
--------------------------------------------------
-- 5) COMPRA
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_compra AS
  PROCEDURE crear_compra(
    p_idCompra     IN Compra.idCompra%TYPE,
    p_fechaCompra  IN Compra.fechaCompra%TYPE,
    p_cantidad     IN Compra.cantidad%TYPE,
    p_precioUnit   IN Compra.precioUnitario%TYPE,
    p_total        IN Compra.total%TYPE,
    p_idProveedor  IN Compra.idProveedor%TYPE
  );

  FUNCTION obtener_compra(
    p_idCompra IN Compra.idCompra%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_compra(
    p_idCompra    IN Compra.idCompra%TYPE,
    p_cantidad    IN Compra.cantidad%TYPE,
    p_precioUnit  IN Compra.precioUnitario%TYPE,
    p_total       IN Compra.total%TYPE
  );

  PROCEDURE eliminar_compra(
    p_idCompra IN Compra.idCompra%TYPE
  );
END pkg_compra;
/
--------------------------------------------------
-- 6) VENTA
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_venta AS
  PROCEDURE crear_venta(
    p_idVenta   IN Venta.idVenta%TYPE,
    p_fecha     IN Venta.fecha%TYPE,
    p_subtotal  IN Venta.subtotal%TYPE,
    p_impuesto  IN Venta.impuesto%TYPE,
    p_total     IN Venta.total%TYPE,
    p_estado    IN Venta.estado%TYPE,
    p_idCliente IN Venta.idCliente%TYPE,
    p_idEmpleado IN Venta.idEmpleado%TYPE
  );

  FUNCTION obtener_venta(
    p_idVenta IN Venta.idVenta%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_venta(
    p_idVenta  IN Venta.idVenta%TYPE,
    p_estado   IN Venta.estado%TYPE
  );

  PROCEDURE eliminar_venta(
    p_idVenta IN Venta.idVenta%TYPE
  );
END pkg_venta;
/
--------------------------------------------------
-- 7) FACTURA
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_factura AS
  PROCEDURE crear_factura(
    p_numero      IN Factura.numeroFactura%TYPE,
    p_fecha       IN Factura.fecha%TYPE,
    p_subtotal    IN Factura.subtotal%TYPE,
    p_impuestos   IN Factura.impuestos%TYPE,
    p_total       IN Factura.total%TYPE,
    p_metodoPago  IN Factura.metodoPago%TYPE
  );

  FUNCTION obtener_factura(
    p_numero IN Factura.numeroFactura%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_factura(
    p_numero    IN Factura.numeroFactura%TYPE,
    p_subtotal  IN Factura.subtotal%TYPE,
    p_impuestos IN Factura.impuestos%TYPE,
    p_total     IN Factura.total%TYPE,
    p_metodoPago IN Factura.metodoPago%TYPE
  );

  PROCEDURE eliminar_factura(
    p_numero IN Factura.numeroFactura%TYPE
  );
END pkg_factura;
/
--------------------------------------------------
-- 8) ENTRADA
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_entrada AS
  PROCEDURE crear_entrada(
    p_idEntrada        IN Entrada.idEntrada%TYPE,
    p_fechaEntrada     IN Entrada.fechaEntrada%TYPE,
    p_cantidadIngresada IN Entrada.cantidadIngresada%TYPE,
    p_tipo             IN Entrada.tipo%TYPE,
    p_fechaVencimiento IN Entrada.fechaVencimiento%TYPE
  );

  FUNCTION obtener_entrada(
    p_idEntrada IN Entrada.idEntrada%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_entrada(
    p_idEntrada        IN Entrada.idEntrada%TYPE,
    p_cantidadIngresada IN Entrada.cantidadIngresada%TYPE,
    p_fechaVencimiento IN Entrada.fechaVencimiento%TYPE
  );

  PROCEDURE eliminar_entrada(
    p_idEntrada IN Entrada.idEntrada%TYPE
  );
END pkg_entrada;
/

-- Tablas Ciclo2

--------------------------------------------------
-- 9) EVENTO
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_evento AS
  PROCEDURE crear_evento(
    p_idEvento       IN Evento.idEvento%TYPE,
    p_nombreEvento   IN Evento.nombreEvento%TYPE,
    p_descripcion    IN Evento.descripcion%TYPE,
    p_fechaEvento    IN Evento.fechaEvento%TYPE,
    p_horaInicio     IN Evento.horaInicio%TYPE,
    p_horaFin        IN Evento.horaFin%TYPE,
    p_numeroPersonas IN Evento.numeroPersonas%TYPE,
    p_estado         IN Evento.estado%TYPE,
    p_idCliente      IN Evento.idCliente%TYPE
  );

  FUNCTION obtener_evento(
    p_idEvento IN Evento.idEvento%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_evento(
    p_idEvento       IN Evento.idEvento%TYPE,
    p_nombreEvento   IN Evento.nombreEvento%TYPE,
    p_descripcion    IN Evento.descripcion%TYPE,
    p_fechaEvento    IN Evento.fechaEvento%TYPE,
    p_horaInicio     IN Evento.horaInicio%TYPE,
    p_horaFin        IN Evento.horaFin%TYPE,
    p_numeroPersonas IN Evento.numeroPersonas%TYPE,
    p_estado         IN Evento.estado%TYPE
  );

  PROCEDURE eliminar_evento(
    p_idEvento IN Evento.idEvento%TYPE
  );
END pkg_evento;
/
--------------------------------------------------
-- 10) EVALUACION
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_evaluacion AS
  PROCEDURE crear_evaluacion(
    p_idEvaluacion        IN Evaluacion.idEvaluacion%TYPE,
    p_idCliente           IN Evaluacion.idCliente%TYPE,
    p_califServicio       IN Evaluacion.calificacionServicio%TYPE,
    p_califProducto       IN Evaluacion.calificacionProducto%TYPE,
    p_califAmbiente       IN Evaluacion.calificacionAmbiente%TYPE,
    p_comentario          IN Evaluacion.comentario%TYPE,
    p_fechaEvaluacion     IN Evaluacion.fechaEvaluacion%TYPE
  );

  FUNCTION obtener_evaluacion(
    p_idEvaluacion IN Evaluacion.idEvaluacion%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_evaluacion(
    p_idEvaluacion        IN Evaluacion.idEvaluacion%TYPE,
    p_califServicio       IN Evaluacion.calificacionServicio%TYPE,
    p_califProducto       IN Evaluacion.calificacionProducto%TYPE,
    p_califAmbiente       IN Evaluacion.calificacionAmbiente%TYPE,
    p_comentario          IN Evaluacion.comentario%TYPE
  );

  PROCEDURE eliminar_evaluacion(
    p_idEvaluacion IN Evaluacion.idEvaluacion%TYPE
  );
END pkg_evaluacion;
/
--------------------------------------------------
-- 11) TURNO
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_turno AS
  PROCEDURE crear_turno(
    p_idTurno    IN Turno.idTurno%TYPE,
    p_idEmpleado IN Turno.idEmpleado%TYPE,
    p_tipo       IN Turno.tipo%TYPE,
    p_horaInicio IN Turno.horaInicio%TYPE,
    p_horaFin    IN Turno.horaFin%TYPE,
    p_fecha      IN Turno.fecha%TYPE,
    p_asistio    IN Turno.asistio%TYPE,
    p_observ     IN Turno.observaciones%TYPE
  );

  FUNCTION obtener_turno(
    p_idTurno IN Turno.idTurno%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_turno(
    p_idTurno    IN Turno.idTurno%TYPE,
    p_tipo       IN Turno.tipo%TYPE,
    p_horaInicio IN Turno.horaInicio%TYPE,
    p_horaFin    IN Turno.horaFin%TYPE,
    p_fecha      IN Turno.fecha%TYPE,
    p_asistio    IN Turno.asistio%TYPE,
    p_observ     IN Turno.observaciones%TYPE
  );

  PROCEDURE eliminar_turno(
    p_idTurno IN Turno.idTurno%TYPE
  );
END pkg_turno;
/
--------------------------------------------------
-- 12) RECETA
--------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_receta AS
  PROCEDURE crear_receta(
    p_idReceta         IN Receta.idReceta%TYPE,
    p_idProducto       IN Receta.idProducto%TYPE,
    p_ingredientes     IN Receta.ingredientes%TYPE,
    p_instrucciones    IN Receta.instrucciones%TYPE,
    p_tiempoPreparacion IN Receta.tiempoPreparacion%TYPE,
    p_porciones        IN Receta.porciones%TYPE
  );

  FUNCTION obtener_receta(
    p_idReceta IN Receta.idReceta%TYPE
  ) RETURN SYS_REFCURSOR;

  PROCEDURE actualizar_receta(
    p_idReceta         IN Receta.idReceta%TYPE,
    p_ingredientes     IN Receta.ingredientes%TYPE,
    p_instrucciones    IN Receta.instrucciones%TYPE,
    p_tiempoPreparacion IN Receta.tiempoPreparacion%TYPE,
    p_porciones        IN Receta.porciones%TYPE
  );

  PROCEDURE eliminar_receta(
    p_idReceta IN Receta.idReceta%TYPE
  );
END pkg_receta;
/
