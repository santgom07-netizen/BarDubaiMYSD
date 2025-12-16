-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================= SeguridadOK ================================================

-- Limpieza previa
BEGIN
  DELETE FROM Venta    WHERE idVenta    = 9001;
  DELETE FROM Compra   WHERE idCompra   = 9002;
  DELETE FROM Cliente  WHERE idCliente  = 900;
  DELETE FROM Empleado WHERE idEmpleado = 9000;
  COMMIT;
END;
/

-- 1) ADMIN crea un nuevo empleado  (usando directamente pkg_empleado)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_admin;
BEGIN
  pkg_seguridad.validar_rol(v_rol, 'CREAR_EMPLEADO');

  IF v_rol <> pkg_seguridad.c_rol_admin THEN
    RAISE_APPLICATION_ERROR(-20990,'Solo ADMIN puede crear empleados');
  END IF;

  pkg_empleado.crear_empleado(
    p_id       => 9000,
    p_nombre   => 'Empleado Admin',
    p_apellido => 'Seguro',
    p_telefono => '3119000000',
    p_email    => 'emp.seguro@rest.com',
    p_salario  => 2500,
    p_turno    => 'Dia'
  );
END;
/
-- SELECT * FROM Empleado WHERE idEmpleado = 9000;

-- 2) MESERO registra una venta (pkg_actor_mesero)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.registrar_venta(
    p_rol        => v_rol,
    p_idVenta    => 9001,
    p_fecha      => SYSDATE,
    p_subtotal   => 20,
    p_impuesto   => 3.2,
    p_total      => 23.2,
    p_estado     => 'Pendiente',
    p_idCliente  => 1,    -- Cliente existente
    p_idEmpleado => 100   -- Mesero existente
  );
END;
/
-- SELECT * FROM Venta WHERE idVenta = 9001;

-- 3) GERENTE registra una compra (pkg_actor_gerente)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actor_gerente.registrar_compra(
    p_rol         => v_rol,
    p_idCompra    => 9002,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 5,
    p_precioUnit  => 10,
    p_total       => 50,
    p_idProveedor => 1      -- Proveedor existente
  );
END;
/
-- SELECT * FROM Compra WHERE idCompra = 9002;

-- 4) MESERO crea un nuevo cliente desde sala (pkg_actor_mesero)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.crear_cliente(
    p_rol      => v_rol,
    p_id       => 900,
    p_nombre   => 'Cliente Sala',
    p_telefono => '3009000000',
    p_email    => 'cliente.sala@rest.com'
  );
END;
/
-- SELECT * FROM Cliente WHERE idCliente = 900;

-- 5) MESERO crea un evento para un cliente (pkg_actor_mesero + Evento)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.crear_evento_cliente(
    p_rol            => v_rol,
    p_idEvento       => 9100,
    p_nombreEvento   => 'Evento SeguridadOK',
    p_descripcion    => 'Prueba de rol MESERO',
    p_fechaEvento    => DATE '2025-12-10',
    p_horaInicio     => 18,
    p_horaFin        => 21,
    p_numeroPersonas => 4,
    p_estado         => 'Programado',
    p_idCliente      => 1      -- cliente existente
  );
END;
/
-- SELECT * FROM Evento WHERE idEvento = 9100;

-- 6) GERENTE crea un turno para un empleado (pkg_actor_gerente + Turno)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actor_gerente.crear_turno_empleado(
    p_rol        => v_rol,
    p_idTurno    => 9100,
    p_idEmpleado => 100,       -- empleado existente
    p_tipo       => 'Noche',
    p_horaInicio => 16,
    p_horaFin    => 23,
    p_fecha      => DATE '2025-12-11',
    p_asistio    => 1,
    p_observ     => 'Turno SeguridadOK'
  );
END;
/
-- SELECT * FROM Turno WHERE idTurno = 9100;

-- 7) CLIENTE (simulado por rol MESERO/ADMIN) registra una evaluación (pkg_actor_cliente + Evaluacion)
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_cliente.registrar_evaluacion(
    p_rol             => v_rol,
    p_idEvaluacion    => 9100,
    p_idCliente       => 1,
    p_califServicio   => 5,
    p_califProducto   => 4,
    p_califAmbiente   => 5,
    p_comentario      => 'SeguridadOK evaluación',
    p_fechaEvaluacion => DATE '2025-12-12'
  );
END;
/
-- SELECT * FROM Evaluacion WHERE idEvaluacion = 9100;
