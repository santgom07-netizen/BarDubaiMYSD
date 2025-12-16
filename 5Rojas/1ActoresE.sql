-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- =========================== ActoresE: ESPECIFICACION =====================================

--------------------------------------------------------------------
-- Paquete de seguridad: definición de roles lógicos comunes
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_seguridad AS
  -- Roles permitidos
  c_rol_admin    CONSTANT VARCHAR2(20) := 'ADMIN';
  c_rol_gerente  CONSTANT VARCHAR2(20) := 'GERENTE';
  c_rol_mesero   CONSTANT VARCHAR2(20) := 'MESERO';
  c_rol_guardia  CONSTANT VARCHAR2(20) := 'SEGURIDAD';

  -- Procedimiento genérico de validación de rol
  PROCEDURE validar_rol(
    p_rol    IN VARCHAR2,
    p_accion IN VARCHAR2
  );
END pkg_seguridad;
/
--------------------------------------------------------------------
-- Actor: ADMIN / EMPLEADO (gestión de empleados)
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_actor_empleado AS
  -- Crear empleado (solo ADMIN)
  PROCEDURE crear_empleado(
    p_rol       IN VARCHAR2,
    p_id        IN Empleado.idEmpleado%TYPE,
    p_nombre    IN Empleado.nombre%TYPE,
    p_apellido  IN Empleado.apellido%TYPE,
    p_telefono  IN Empleado.telefono%TYPE,
    p_email     IN Empleado.email%TYPE,
    p_salario   IN Empleado.salario%TYPE,
    p_turno     IN Empleado.turno%TYPE
  );
END pkg_actor_empleado;
/
--------------------------------------------------------------------
-- Actor: MESERO (ventas y clientes)
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_actor_mesero AS
  -- Registrar venta (MESERO o ADMIN)
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
  );

  -- Crear cliente desde el mesero (MESERO o ADMIN)
  PROCEDURE crear_cliente(
    p_rol      IN VARCHAR2,
    p_id       IN Cliente.idCliente%TYPE,
    p_nombre   IN Cliente.nombre%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  );

  -- Crear evento para un cliente
  PROCEDURE crear_evento_cliente(
    p_rol           IN VARCHAR2,
    p_idEvento      IN Evento.idEvento%TYPE,
    p_nombreEvento  IN Evento.nombreEvento%TYPE,
    p_descripcion   IN Evento.descripcion%TYPE,
    p_fechaEvento   IN Evento.fechaEvento%TYPE,
    p_horaInicio    IN Evento.horaInicio%TYPE,
    p_horaFin       IN Evento.horaFin%TYPE,
    p_numeroPersonas IN Evento.numeroPersonas%TYPE,
    p_estado        IN Evento.estado%TYPE,
    p_idCliente     IN Evento.idCliente%TYPE
  );
END pkg_actor_mesero;
/
--------------------------------------------------------------------
-- Actor: GERENTE (compras y turnos)
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_actor_gerente AS
  -- Registrar compra (GERENTE o ADMIN)
  PROCEDURE registrar_compra(
    p_rol         IN VARCHAR2,
    p_idCompra    IN Compra.idCompra%TYPE,
    p_fechaCompra IN Compra.fechaCompra%TYPE,
    p_cantidad    IN Compra.cantidad%TYPE,
    p_precioUnit  IN Compra.precioUnitario%TYPE,
    p_total       IN Compra.total%TYPE,
    p_idProveedor IN Compra.idProveedor%TYPE
  );

  -- Gestionar turno de un empleado (GERENTE o ADMIN)
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
  );
END pkg_actor_gerente;
/
--------------------------------------------------------------------
-- Actor: CLIENTE (evaluaciones)
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pkg_actor_cliente AS
  -- Registrar evaluación de una visita (CLIENTE o ADMIN)
  PROCEDURE registrar_evaluacion(
    p_rol            IN VARCHAR2,
    p_idEvaluacion   IN Evaluacion.idEvaluacion%TYPE,
    p_idCliente      IN Evaluacion.idCliente%TYPE,
    p_califServicio  IN Evaluacion.calificacionServicio%TYPE,
    p_califProducto  IN Evaluacion.calificacionProducto%TYPE,
    p_califAmbiente  IN Evaluacion.calificacionAmbiente%TYPE,
    p_comentario     IN Evaluacion.comentario%TYPE,
    p_fechaEvaluacion IN Evaluacion.fechaEvaluacion%TYPE
  );
END pkg_actor_cliente;
/
