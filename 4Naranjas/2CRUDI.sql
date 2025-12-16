-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== CRUDI =====================
--------------------------------------------------
-- 1) EMPLEADO
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_empleado AS

  PROCEDURE crear_empleado(
    p_id       IN Empleado.idEmpleado%TYPE,
    p_nombre   IN Empleado.nombre%TYPE,
    p_apellido IN Empleado.apellido%TYPE,
    p_telefono IN Empleado.telefono%TYPE,
    p_email    IN Empleado.email%TYPE,
    p_salario  IN Empleado.salario%TYPE,
    p_turno    IN Empleado.turno%TYPE
  ) IS
  BEGIN
    INSERT INTO Empleado(idEmpleado,nombre,apellido,telefono,email,
                         fechaIngreso,salario,turno)
    VALUES(p_id,p_nombre,p_apellido,p_telefono,p_email,
           SYSDATE,p_salario,p_turno);
  END crear_empleado;

  PROCEDURE asignar_mesero(
    p_id       IN Empleado.idEmpleado%TYPE,
    p_zona     IN Mesero.zonaAsignada%TYPE,
    p_comision IN Mesero.comisionVentas%TYPE,
    p_lugar    IN Mesero.lugarTrabajo%TYPE,
    p_horario  IN Mesero.horarioTurno%TYPE
  ) IS
  BEGIN
    INSERT INTO Mesero(idEmpleado,zonaAsignada,comisionVentas,
                       lugarTrabajo,horarioTurno)
    VALUES(p_id,p_zona,p_comision,p_lugar,p_horario);
  END asignar_mesero;

  FUNCTION obtener_empleado(
    p_id IN Empleado.idEmpleado%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT e.idEmpleado,e.nombre,e.apellido,e.telefono,e.email,
             e.salario,e.turno,
             m.zonaAsignada,m.comisionVentas,m.lugarTrabajo,m.horarioTurno
      FROM Empleado e
      LEFT JOIN Mesero m ON m.idEmpleado = e.idEmpleado
      WHERE e.idEmpleado = p_id;
    RETURN v_cur;
  END obtener_empleado;

  PROCEDURE actualizar_empleado(
    p_id       IN Empleado.idEmpleado%TYPE,
    p_telefono IN Empleado.telefono%TYPE,
    p_email    IN Empleado.email%TYPE,
    p_salario  IN Empleado.salario%TYPE,
    p_turno    IN Empleado.turno%TYPE
  ) IS
  BEGIN
    UPDATE Empleado
       SET telefono = p_telefono,
           email    = p_email,
           salario  = p_salario,
           turno    = p_turno
     WHERE idEmpleado = p_id;
  END actualizar_empleado;

  PROCEDURE eliminar_empleado(
    p_id IN Empleado.idEmpleado%TYPE
  ) IS
  BEGIN
    DELETE FROM Mesero    WHERE idEmpleado = p_id;
    DELETE FROM Gerente   WHERE idEmpleado = p_id;
    DELETE FROM Seguridad WHERE idEmpleado = p_id;
    DELETE FROM Empleado  WHERE idEmpleado = p_id;
  END eliminar_empleado;

END pkg_empleado;
/
--------------------------------------------------
-- 2) CLIENTE
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_cliente AS

  PROCEDURE crear_cliente(
    p_id       IN Cliente.idCliente%TYPE,
    p_nombre   IN Cliente.nombre%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  ) IS
  BEGIN
    INSERT INTO Cliente(idCliente,nombre,telefono,email,fechaRegistro,totalCompras)
    VALUES(p_id,p_nombre,p_telefono,p_email,SYSDATE,0);
  END crear_cliente;

  FUNCTION obtener_cliente(
    p_id IN Cliente.idCliente%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Cliente
      WHERE idCliente = p_id;
    RETURN v_cur;
  END obtener_cliente;

  PROCEDURE actualizar_cliente(
    p_id       IN Cliente.idCliente%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  ) IS
  BEGIN
    UPDATE Cliente
       SET telefono = p_telefono,
           email    = p_email
     WHERE idCliente = p_id;
  END actualizar_cliente;

  PROCEDURE eliminar_cliente(
    p_id IN Cliente.idCliente%TYPE
  ) IS
  BEGIN
    DELETE FROM Cliente_vip     WHERE idCliente = p_id;
    DELETE FROM Cliente_regular WHERE idCliente = p_id;
    DELETE FROM Reserva         WHERE idCliente = p_id;
    DELETE FROM Venta           WHERE idCliente = p_id;
    DELETE FROM Cliente         WHERE idCliente = p_id;
  END eliminar_cliente;

END pkg_cliente;
/
--------------------------------------------------
-- 3) PRODUCTO
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_producto AS

  PROCEDURE crear_producto(
    p_id          IN Producto.idProducto%TYPE,
    p_nombre      IN Producto.nombre%TYPE,
    p_descripcion IN Producto.descripcion%TYPE,
    p_precio      IN Producto.precio%TYPE,
    p_disponible  IN Producto.disponible%TYPE,
    p_idCategoria IN Producto.idCategoria%TYPE
  ) IS
  BEGIN
    INSERT INTO Producto(idProducto,nombre,descripcion,precio,disponible,idCategoria)
    VALUES(p_id,p_nombre,p_descripcion,p_precio,p_disponible,p_idCategoria);
  END crear_producto;

  FUNCTION obtener_producto(
    p_id IN Producto.idProducto%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Producto
      WHERE idProducto = p_id;
    RETURN v_cur;
  END obtener_producto;

  PROCEDURE actualizar_producto(
    p_id          IN Producto.idProducto%TYPE,
    p_nombre      IN Producto.nombre%TYPE,
    p_descripcion IN Producto.descripcion%TYPE,
    p_precio      IN Producto.precio%TYPE,
    p_disponible  IN Producto.disponible%TYPE
  ) IS
  BEGIN
    UPDATE Producto
       SET nombre      = p_nombre,
           descripcion = p_descripcion,
           precio      = p_precio,
           disponible  = p_disponible
     WHERE idProducto = p_id;
  END actualizar_producto;

  PROCEDURE eliminar_producto(
    p_id IN Producto.idProducto%TYPE
  ) IS
  BEGIN
    DELETE FROM Bebida                WHERE idProducto = p_id;
    DELETE FROM Comida                WHERE idProducto = p_id;
    DELETE FROM Ingredientes          WHERE idProducto = p_id;
    DELETE FROM Inventario            WHERE idProducto = p_id;
    DELETE FROM DetalleVentaProducto  WHERE idProducto = p_id;
    DELETE FROM DetalleCompraProducto WHERE idProducto = p_id;
    DELETE FROM Producto              WHERE idProducto = p_id;
  END eliminar_producto;

END pkg_producto;
/
--------------------------------------------------
-- 4) CATEGORIA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_categoria AS

  PROCEDURE crear_categoria(
    p_id          IN Categoria.idCategoria%TYPE,
    p_nombre      IN Categoria.nombre%TYPE,
    p_descripcion IN Categoria.descripcion%TYPE
  ) IS
  BEGIN
    INSERT INTO Categoria(idCategoria,nombre,descripcion)
    VALUES(p_id,p_nombre,p_descripcion);
  END crear_categoria;

  FUNCTION obtener_categoria(
    p_id IN Categoria.idCategoria%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Categoria
      WHERE idCategoria = p_id;
    RETURN v_cur;
  END obtener_categoria;

  PROCEDURE actualizar_categoria(
    p_id          IN Categoria.idCategoria%TYPE,
    p_nombre      IN Categoria.nombre%TYPE,
    p_descripcion IN Categoria.descripcion%TYPE
  ) IS
  BEGIN
    UPDATE Categoria
       SET nombre      = p_nombre,
           descripcion = p_descripcion
     WHERE idCategoria = p_id;
  END actualizar_categoria;

  PROCEDURE eliminar_categoria(
    p_id IN Categoria.idCategoria%TYPE
  ) IS
  BEGIN
    DELETE FROM Producto
     WHERE idCategoria = p_id;
    DELETE FROM Categoria
     WHERE idCategoria = p_id;
  END eliminar_categoria;

END pkg_categoria;
/
--------------------------------------------------
-- 5) COMPRA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_compra AS

  PROCEDURE crear_compra(
    p_idCompra    IN Compra.idCompra%TYPE,
    p_fechaCompra IN Compra.fechaCompra%TYPE,
    p_cantidad    IN Compra.cantidad%TYPE,
    p_precioUnit  IN Compra.precioUnitario%TYPE,
    p_total       IN Compra.total%TYPE,
    p_idProveedor IN Compra.idProveedor%TYPE
  ) IS
  BEGIN
    INSERT INTO Compra(idCompra,fechaCompra,cantidad,precioUnitario,total,idProveedor)
    VALUES(p_idCompra,p_fechaCompra,p_cantidad,p_precioUnit,p_total,p_idProveedor);
  END crear_compra;

  FUNCTION obtener_compra(
    p_idCompra IN Compra.idCompra%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Compra
      WHERE idCompra = p_idCompra;
    RETURN v_cur;
  END obtener_compra;

  PROCEDURE actualizar_compra(
    p_idCompra   IN Compra.idCompra%TYPE,
    p_cantidad   IN Compra.cantidad%TYPE,
    p_precioUnit IN Compra.precioUnitario%TYPE,
    p_total      IN Compra.total%TYPE
  ) IS
  BEGIN
    UPDATE Compra
       SET cantidad      = p_cantidad,
           precioUnitario = p_precioUnit,
           total          = p_total
     WHERE idCompra = p_idCompra;
  END actualizar_compra;

  PROCEDURE eliminar_compra(
    p_idCompra IN Compra.idCompra%TYPE
  ) IS
  BEGIN
    DELETE FROM DetalleCompraProducto WHERE idCompra = p_idCompra;
    DELETE FROM DetalleCompraEntrada  WHERE idCompra = p_idCompra;
    DELETE FROM Compra                WHERE idCompra = p_idCompra;
  END eliminar_compra;

END pkg_compra;
/
--------------------------------------------------
-- 6) VENTA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_venta AS

  PROCEDURE crear_venta(
    p_idVenta    IN Venta.idVenta%TYPE,
    p_fecha      IN Venta.fecha%TYPE,
    p_subtotal   IN Venta.subtotal%TYPE,
    p_impuesto   IN Venta.impuesto%TYPE,
    p_total      IN Venta.total%TYPE,
    p_estado     IN Venta.estado%TYPE,
    p_idCliente  IN Venta.idCliente%TYPE,
    p_idEmpleado IN Venta.idEmpleado%TYPE
  ) IS
  BEGIN
    INSERT INTO Venta(idVenta,fecha,hora,subtotal,impuesto,total,
                      estado,idCliente,idEmpleado)
    VALUES(p_idVenta,p_fecha,SYSTIMESTAMP,p_subtotal,p_impuesto,
           p_total,p_estado,p_idCliente,p_idEmpleado);
  END crear_venta;

  FUNCTION obtener_venta(
    p_idVenta IN Venta.idVenta%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Venta
      WHERE idVenta = p_idVenta;
    RETURN v_cur;
  END obtener_venta;

  PROCEDURE actualizar_venta(
    p_idVenta IN Venta.idVenta%TYPE,
    p_estado  IN Venta.estado%TYPE
  ) IS
  BEGIN
    UPDATE Venta
       SET estado = p_estado
     WHERE idVenta = p_idVenta;
  END actualizar_venta;

  PROCEDURE eliminar_venta(
    p_idVenta IN Venta.idVenta%TYPE
  ) IS
  BEGIN
    DELETE FROM DetalleVentaProducto WHERE idVenta = p_idVenta;
    DELETE FROM DetalleVentaEntrada  WHERE idVenta = p_idVenta;
    DELETE FROM Descuento            WHERE idVenta = p_idVenta;
    DELETE FROM Venta                WHERE idVenta = p_idVenta;
  END eliminar_venta;

END pkg_venta;
/
--------------------------------------------------
-- 7) FACTURA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_factura AS

  PROCEDURE crear_factura(
    p_numero     IN Factura.numeroFactura%TYPE,
    p_fecha      IN Factura.fecha%TYPE,
    p_subtotal   IN Factura.subtotal%TYPE,
    p_impuestos  IN Factura.impuestos%TYPE,
    p_total      IN Factura.total%TYPE,
    p_metodoPago IN Factura.metodoPago%TYPE
  ) IS
  BEGIN
    INSERT INTO Factura(numeroFactura,fecha,subtotal,impuestos,total,metodoPago)
    VALUES(p_numero,p_fecha,p_subtotal,p_impuestos,p_total,p_metodoPago);
  END crear_factura;

  FUNCTION obtener_factura(
    p_numero IN Factura.numeroFactura%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Factura
      WHERE numeroFactura = p_numero;
    RETURN v_cur;
  END obtener_factura;

  PROCEDURE actualizar_factura(
    p_numero    IN Factura.numeroFactura%TYPE,
    p_subtotal  IN Factura.subtotal%TYPE,
    p_impuestos IN Factura.impuestos%TYPE,
    p_total     IN Factura.total%TYPE,
    p_metodoPago IN Factura.metodoPago%TYPE
  ) IS
  BEGIN
    UPDATE Factura
       SET subtotal   = p_subtotal,
           impuestos  = p_impuestos,
           total      = p_total,
           metodoPago = p_metodoPago
     WHERE numeroFactura = p_numero;
  END actualizar_factura;

  PROCEDURE eliminar_factura(
    p_numero IN Factura.numeroFactura%TYPE
  ) IS
  BEGIN
    DELETE FROM Factura
     WHERE numeroFactura = p_numero;
  END eliminar_factura;

END pkg_factura;
/
--------------------------------------------------
-- 8) ENTRADA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_entrada AS

  PROCEDURE crear_entrada(
    p_idEntrada        IN Entrada.idEntrada%TYPE,
    p_fechaEntrada     IN Entrada.fechaEntrada%TYPE,
    p_cantidadIngresada IN Entrada.cantidadIngresada%TYPE,
    p_tipo             IN Entrada.tipo%TYPE,
    p_fechaVencimiento IN Entrada.fechaVencimiento%TYPE
  ) IS
  BEGIN
    INSERT INTO Entrada(idEntrada,fechaEntrada,cantidadIngresada,tipo,fechaVencimiento)
    VALUES(p_idEntrada,p_fechaEntrada,p_cantidadIngresada,p_tipo,p_fechaVencimiento);
  END crear_entrada;

  FUNCTION obtener_entrada(
    p_idEntrada IN Entrada.idEntrada%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Entrada
      WHERE idEntrada = p_idEntrada;
    RETURN v_cur;
  END obtener_entrada;

  PROCEDURE actualizar_entrada(
    p_idEntrada        IN Entrada.idEntrada%TYPE,
    p_cantidadIngresada IN Entrada.cantidadIngresada%TYPE,
    p_fechaVencimiento IN Entrada.fechaVencimiento%TYPE
  ) IS
  BEGIN
    UPDATE Entrada
       SET cantidadIngresada = p_cantidadIngresada,
           fechaVencimiento  = p_fechaVencimiento
     WHERE idEntrada = p_idEntrada;
  END actualizar_entrada;

  PROCEDURE eliminar_entrada(
    p_idEntrada IN Entrada.idEntrada%TYPE
  ) IS
  BEGIN
    DELETE FROM DetalleCompraEntrada WHERE idEntrada = p_idEntrada;
    DELETE FROM DetalleVentaEntrada  WHERE idEntrada = p_idEntrada;
    DELETE FROM Entrada              WHERE idEntrada = p_idEntrada;
  END eliminar_entrada;

END pkg_entrada;
/

-- Tablas Ciclo2

--------------------------------------------------
-- 9) EVENTO
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_evento AS

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
  ) IS
  BEGIN
    INSERT INTO Evento(idEvento, nombreEvento, descripcion,
                       fechaEvento, horaInicio, horaFin,
                       numeroPersonas, estado, idCliente)
    VALUES(p_idEvento, p_nombreEvento, p_descripcion,
           p_fechaEvento, p_horaInicio, p_horaFin,
           p_numeroPersonas, p_estado, p_idCliente);
  END crear_evento;


  FUNCTION obtener_evento(
    p_idEvento IN Evento.idEvento%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Evento
      WHERE idEvento = p_idEvento;
    RETURN v_cur;
  END obtener_evento;


  PROCEDURE actualizar_evento(
    p_idEvento       IN Evento.idEvento%TYPE,
    p_nombreEvento   IN Evento.nombreEvento%TYPE,
    p_descripcion    IN Evento.descripcion%TYPE,
    p_fechaEvento    IN Evento.fechaEvento%TYPE,
    p_horaInicio     IN Evento.horaInicio%TYPE,
    p_horaFin        IN Evento.horaFin%TYPE,
    p_numeroPersonas IN Evento.numeroPersonas%TYPE,
    p_estado         IN Evento.estado%TYPE
  ) IS
  BEGIN
    UPDATE Evento
       SET nombreEvento   = p_nombreEvento,
           descripcion    = p_descripcion,
           fechaEvento    = p_fechaEvento,
           horaInicio     = p_horaInicio,
           horaFin        = p_horaFin,
           numeroPersonas = p_numeroPersonas,
           estado         = p_estado
     WHERE idEvento = p_idEvento;
  END actualizar_evento;


  PROCEDURE eliminar_evento(
    p_idEvento IN Evento.idEvento%TYPE
  ) IS
  BEGIN
    DELETE FROM Evento
     WHERE idEvento = p_idEvento;
  END eliminar_evento;

END pkg_evento;
/
--------------------------------------------------
-- 10) EVALUACION
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_evaluacion AS

  PROCEDURE crear_evaluacion(
    p_idEvaluacion    IN Evaluacion.idEvaluacion%TYPE,
    p_idCliente       IN Evaluacion.idCliente%TYPE,
    p_califServicio   IN Evaluacion.calificacionServicio%TYPE,
    p_califProducto   IN Evaluacion.calificacionProducto%TYPE,
    p_califAmbiente   IN Evaluacion.calificacionAmbiente%TYPE,
    p_comentario      IN Evaluacion.comentario%TYPE,
    p_fechaEvaluacion IN Evaluacion.fechaEvaluacion%TYPE
  ) IS
  BEGIN
    INSERT INTO Evaluacion(idEvaluacion, idCliente,
                           calificacionServicio, calificacionProducto,
                           calificacionAmbiente, comentario, fechaEvaluacion)
    VALUES(p_idEvaluacion, p_idCliente,
           p_califServicio, p_califProducto,
           p_califAmbiente, p_comentario, p_fechaEvaluacion);
  END crear_evaluacion;


  FUNCTION obtener_evaluacion(
    p_idEvaluacion IN Evaluacion.idEvaluacion%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Evaluacion
      WHERE idEvaluacion = p_idEvaluacion;
    RETURN v_cur;
  END obtener_evaluacion;


  PROCEDURE actualizar_evaluacion(
    p_idEvaluacion    IN Evaluacion.idEvaluacion%TYPE,
    p_califServicio   IN Evaluacion.calificacionServicio%TYPE,
    p_califProducto   IN Evaluacion.calificacionProducto%TYPE,
    p_califAmbiente   IN Evaluacion.calificacionAmbiente%TYPE,
    p_comentario      IN Evaluacion.comentario%TYPE
  ) IS
  BEGIN
    UPDATE Evaluacion
       SET calificacionServicio = p_califServicio,
           calificacionProducto = p_califProducto,
           calificacionAmbiente = p_califAmbiente,
           comentario           = p_comentario
     WHERE idEvaluacion = p_idEvaluacion;
  END actualizar_evaluacion;


  PROCEDURE eliminar_evaluacion(
    p_idEvaluacion IN Evaluacion.idEvaluacion%TYPE
  ) IS
  BEGIN
    DELETE FROM Evaluacion
     WHERE idEvaluacion = p_idEvaluacion;
  END eliminar_evaluacion;

END pkg_evaluacion;
/
--------------------------------------------------
-- 11) TURNO
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_turno AS

  PROCEDURE crear_turno(
    p_idTurno    IN Turno.idTurno%TYPE,
    p_idEmpleado IN Turno.idEmpleado%TYPE,
    p_tipo       IN Turno.tipo%TYPE,
    p_horaInicio IN Turno.horaInicio%TYPE,
    p_horaFin    IN Turno.horaFin%TYPE,
    p_fecha      IN Turno.fecha%TYPE,
    p_asistio    IN Turno.asistio%TYPE,
    p_observ     IN Turno.observaciones%TYPE
  ) IS
  BEGIN
    INSERT INTO Turno(idTurno, idEmpleado, tipo,
                      horaInicio, horaFin, fecha,
                      asistio, observaciones)
    VALUES(p_idTurno, p_idEmpleado, p_tipo,
           p_horaInicio, p_horaFin, p_fecha,
           p_asistio, p_observ);
  END crear_turno;


  FUNCTION obtener_turno(
    p_idTurno IN Turno.idTurno%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Turno
      WHERE idTurno = p_idTurno;
    RETURN v_cur;
  END obtener_turno;


  PROCEDURE actualizar_turno(
    p_idTurno    IN Turno.idTurno%TYPE,
    p_tipo       IN Turno.tipo%TYPE,
    p_horaInicio IN Turno.horaInicio%TYPE,
    p_horaFin    IN Turno.horaFin%TYPE,
    p_fecha      IN Turno.fecha%TYPE,
    p_asistio    IN Turno.asistio%TYPE,
    p_observ     IN Turno.observaciones%TYPE
  ) IS
  BEGIN
    UPDATE Turno
       SET tipo          = p_tipo,
           horaInicio    = p_horaInicio,
           horaFin       = p_horaFin,
           fecha         = p_fecha,
           asistio       = p_asistio,
           observaciones = p_observ
     WHERE idTurno = p_idTurno;
  END actualizar_turno;


  PROCEDURE eliminar_turno(
    p_idTurno IN Turno.idTurno%TYPE
  ) IS
  BEGIN
    DELETE FROM Turno
     WHERE idTurno = p_idTurno;
  END eliminar_turno;

END pkg_turno;
/
--------------------------------------------------
-- 12) RECETA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_receta AS

  PROCEDURE crear_receta(
    p_idReceta          IN Receta.idReceta%TYPE,
    p_idProducto        IN Receta.idProducto%TYPE,
    p_ingredientes      IN Receta.ingredientes%TYPE,
    p_instrucciones     IN Receta.instrucciones%TYPE,
    p_tiempoPreparacion IN Receta.tiempoPreparacion%TYPE,
    p_porciones         IN Receta.porciones%TYPE
  ) IS
  BEGIN
    INSERT INTO Receta(idReceta, idProducto, ingredientes,
                       instrucciones, tiempoPreparacion, porciones)
    VALUES(p_idReceta, p_idProducto, p_ingredientes,
           p_instrucciones, p_tiempoPreparacion, p_porciones);
  END crear_receta;


  FUNCTION obtener_receta(
    p_idReceta IN Receta.idReceta%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Receta
      WHERE idReceta = p_idReceta;
    RETURN v_cur;
  END obtener_receta;


  PROCEDURE actualizar_receta(
    p_idReceta          IN Receta.idReceta%TYPE,
    p_ingredientes      IN Receta.ingredientes%TYPE,
    p_instrucciones     IN Receta.instrucciones%TYPE,
    p_tiempoPreparacion IN Receta.tiempoPreparacion%TYPE,
    p_porciones         IN Receta.porciones%TYPE
  ) IS
  BEGIN
    UPDATE Receta
       SET ingredientes      = p_ingredientes,
           instrucciones     = p_instrucciones,
           tiempoPreparacion = p_tiempoPreparacion,
           porciones         = p_porciones
     WHERE idReceta = p_idReceta;
  END actualizar_receta;


  PROCEDURE eliminar_receta(
    p_idReceta IN Receta.idReceta%TYPE
  ) IS
  BEGIN
    DELETE FROM Receta
     WHERE idReceta = p_idReceta;
  END eliminar_receta;

END pkg_receta;
/
