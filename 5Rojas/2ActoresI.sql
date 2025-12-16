-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- =========================== ActoresI: IMPLEMENTACION =====================================

------------------------------------------------------------
-- BODY de pkg_seguridad
------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_seguridad AS

  PROCEDURE validar_rol(
    p_rol    IN VARCHAR2,
    p_accion IN VARCHAR2
  ) IS
  BEGIN
    IF p_rol NOT IN (c_rol_admin, c_rol_gerente, c_rol_mesero, c_rol_guardia) THEN
      RAISE_APPLICATION_ERROR(
        -20000,
        'Rol [' || p_rol || '] no es un rol valido para la accion ' || p_accion
      );
    END IF;
  END validar_rol;

END pkg_seguridad;
/
------------------------------------------------------------
-- BODY de pkg_actor_mesero
------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_actor_mesero AS

  PROCEDURE registrar_venta(
    p_rol        IN VARCHAR2,
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
    pkg_seguridad.validar_rol(p_rol, 'REGISTRAR_VENTA');

    IF p_rol NOT IN (pkg_seguridad.c_rol_mesero, pkg_seguridad.c_rol_admin) THEN
      RAISE_APPLICATION_ERROR(-20002,
        'Solo MESERO o ADMIN pueden registrar ventas');
    END IF;

    pkg_venta.crear_venta(
      p_idVenta    => p_idVenta,
      p_fecha      => p_fecha,
      p_subtotal   => p_subtotal,
      p_impuesto   => p_impuesto,
      p_total      => p_total,
      p_estado     => p_estado,
      p_idCliente  => p_idCliente,
      p_idEmpleado => p_idEmpleado
    );
  END registrar_venta;


  PROCEDURE crear_cliente(
    p_rol      IN VARCHAR2,
    p_id       IN Cliente.idCliente%TYPE,
    p_nombre   IN Cliente.nombre%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  ) IS
  BEGIN
    pkg_seguridad.validar_rol(p_rol, 'CREAR_CLIENTE');

    IF p_rol NOT IN (pkg_seguridad.c_rol_mesero, pkg_seguridad.c_rol_admin) THEN
      RAISE_APPLICATION_ERROR(-20004,
        'Solo MESERO o ADMIN pueden crear clientes');
    END IF;

    pkg_cliente.crear_cliente(
      p_id       => p_id,
      p_nombre   => p_nombre,
      p_telefono => p_telefono,
      p_email    => p_email
    );
  END crear_cliente;


  PROCEDURE crear_evento_cliente(
    p_rol            IN VARCHAR2,
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
    pkg_seguridad.validar_rol(p_rol, 'CREAR_EVENTO');

    IF p_rol NOT IN (pkg_seguridad.c_rol_mesero, pkg_seguridad.c_rol_admin) THEN
      RAISE_APPLICATION_ERROR(-20005,
        'Solo MESERO o ADMIN pueden crear eventos');
    END IF;

    pkg_evento.crear_evento(
      p_idEvento       => p_idEvento,
      p_nombreEvento   => p_nombreEvento,
      p_descripcion    => p_descripcion,
      p_fechaEvento    => p_fechaEvento,
      p_horaInicio     => p_horaInicio,
      p_horaFin        => p_horaFin,
      p_numeroPersonas => p_numeroPersonas,
      p_estado         => p_estado,
      p_idCliente      => p_idCliente
    );
  END crear_evento_cliente;

END pkg_actor_mesero;
/
------------------------------------------------------------
-- BODY de pkg_actor_gerente
------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_actor_gerente AS

  PROCEDURE registrar_compra(
    p_rol         IN VARCHAR2,
    p_idCompra    IN Compra.idCompra%TYPE,
    p_fechaCompra IN Compra.fechaCompra%TYPE,
    p_cantidad    IN Compra.cantidad%TYPE,
    p_precioUnit  IN Compra.precioUnitario%TYPE,
    p_total       IN Compra.total%TYPE,
    p_idProveedor IN Compra.idProveedor%TYPE
  ) IS
  BEGIN
    pkg_seguridad.validar_rol(p_rol, 'REGISTRAR_COMPRA');

    IF p_rol NOT IN (pkg_seguridad.c_rol_gerente, pkg_seguridad.c_rol_admin) THEN
      RAISE_APPLICATION_ERROR(-20003,
        'Solo GERENTE o ADMIN pueden registrar compras');
    END IF;

    pkg_compra.crear_compra(
      p_idCompra    => p_idCompra,
      p_fechaCompra => p_fechaCompra,
      p_cantidad    => p_cantidad,
      p_precioUnit  => p_precioUnit,
      p_total       => p_total,
      p_idProveedor => p_idProveedor
    );
  END registrar_compra;


  PROCEDURE crear_turno_empleado(
    p_rol        IN VARCHAR2,
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
    pkg_seguridad.validar_rol(p_rol, 'CREAR_TURNO');

    IF p_rol NOT IN (pkg_seguridad.c_rol_gerente, pkg_seguridad.c_rol_admin) THEN
      RAISE_APPLICATION_ERROR(-20006,
        'Solo GERENTE o ADMIN pueden gestionar turnos');
    END IF;

    pkg_turno.crear_turno(
      p_idTurno    => p_idTurno,
      p_idEmpleado => p_idEmpleado,
      p_tipo       => p_tipo,
      p_horaInicio => p_horaInicio,
      p_horaFin    => p_horaFin,
      p_fecha      => p_fecha,
      p_asistio    => p_asistio,
      p_observ     => p_observ
    );
  END crear_turno_empleado;

END pkg_actor_gerente;
/
------------------------------------------------------------
-- BODY de pkg_actor_cliente
------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_actor_cliente AS

  PROCEDURE registrar_evaluacion(
    p_rol             IN VARCHAR2,
    p_idEvaluacion    IN Evaluacion.idEvaluacion%TYPE,
    p_idCliente       IN Evaluacion.idCliente%TYPE,
    p_califServicio   IN Evaluacion.calificacionServicio%TYPE,
    p_califProducto   IN Evaluacion.calificacionProducto%TYPE,
    p_califAmbiente   IN Evaluacion.calificacionAmbiente%TYPE,
    p_comentario      IN Evaluacion.comentario%TYPE,
    p_fechaEvaluacion IN Evaluacion.fechaEvaluacion%TYPE
  ) IS
  BEGIN
    pkg_seguridad.validar_rol(p_rol, 'REGISTRAR_EVALUACION');

    IF p_rol NOT IN (pkg_seguridad.c_rol_admin, pkg_seguridad.c_rol_mesero) THEN
      -- si quieres que solo el propio cliente lo haga podrías usar otro rol
      RAISE_APPLICATION_ERROR(-20007,
        'Solo ADMIN o MESERO (en nombre del cliente) pueden registrar evaluaciones');
    END IF;

    pkg_evaluacion.crear_evaluacion(
      p_idEvaluacion    => p_idEvaluacion,
      p_idCliente       => p_idCliente,
      p_califServicio   => p_califServicio,
      p_califProducto   => p_califProducto,
      p_califAmbiente   => p_califAmbiente,
      p_comentario      => p_comentario,
      p_fechaEvaluacion => p_fechaEvaluacion
    );
  END registrar_evaluacion;

END pkg_actor_cliente;
/
