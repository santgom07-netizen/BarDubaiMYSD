-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== PruebaAceptacion_AngieCiro =========================================

BEGIN
  DELETE FROM Venta      WHERE idVenta    BETWEEN 9301 AND 9305;
  DELETE FROM Compra     WHERE idCompra   = 9302;
  DELETE FROM Evento     WHERE idEvento   = 9301;
  DELETE FROM Turno      WHERE idTurno    = 9301;
  DELETE FROM Evaluacion WHERE idEvaluacion = 9301;
  DELETE FROM Cliente    WHERE idCliente  = 930;
  DELETE FROM Empleado   WHERE idEmpleado = 9300;
  COMMIT;
END;
/

---------------------------------------------------------------
-- 1) ADMIN contrata a Angie como GERENTE esta vez
---------------------------------------------------------------
BEGIN
  pkg_empleado.crear_empleado(
    p_id       => 9300,
    p_nombre   => 'Angie Tatiana',
    p_apellido => 'Ciro',
    p_telefono => '3119300000',
    p_email    => 'angie.gerente@bardubai.com',
    p_salario  => 3000,
    p_turno    => 'Mixto'
  );
END;
/
SELECT idEmpleado, nombre, apellido, salario, turno
FROM Empleado
WHERE idEmpleado = 9300;
/

---------------------------------------------------------------
-- 2) GERENTE programa su propio turno largo de cierre
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actor_gerente.crear_turno_empleado(
    p_rol        => v_rol,
    p_idTurno    => 9301,
    p_idEmpleado => 9300,
    p_tipo       => 'Noche',
    p_horaInicio => 16,
    p_horaFin    => 24,
    p_fecha      => DATE '2025-12-20',
    p_asistio    => 1,
    p_observ     => 'Turno de supervisión general'
  );
END;
/
SELECT * FROM Turno WHERE idTurno = 9301;
/

---------------------------------------------------------------
-- 3) MESERO crea un cliente walk-in y un evento rápido
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.crear_cliente(
    p_rol      => v_rol,
    p_id       => 930,
    p_nombre   => 'Cliente WalkIn',
    p_telefono => '3009300000',
    p_email    => 'walkin.930@correo.com'
  );
END;
/
SELECT * FROM Cliente WHERE idCliente = 930;
/

DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.crear_evento_cliente(
    p_rol            => v_rol,
    p_idEvento       => 9301,
    p_nombreEvento   => 'After Office',
    p_descripcion    => 'Reunión corta en barra',
    p_fechaEvento    => DATE '2025-12-20',
    p_horaInicio     => 18,
    p_horaFin        => 20,
    p_numeroPersonas => 6,
    p_estado         => 'Confirmado',
    p_idCliente      => 930
  );
END;
/
SELECT * FROM Evento WHERE idEvento = 9301;
/

---------------------------------------------------------------
-- 4) GERENTE compra snacks y bebidas para la noche
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actor_gerente.registrar_compra(
    p_rol         => v_rol,
    p_idCompra    => 9302,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 20,
    p_precioUnit  => 5,
    p_total       => 100,
    p_idProveedor => 1
  );
END;
/
SELECT idCompra, fechaCompra, cantidad, total
FROM Compra
WHERE idCompra = 9302;
/

---------------------------------------------------------------
-- 5) MESERO registra varias ventas pequeñas a ese cliente
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.registrar_venta(
    p_rol        => v_rol,
    p_idVenta    => 9301,
    p_fecha      => SYSDATE,
    p_subtotal   => 12,
    p_impuesto   => 1.92,
    p_total      => 13.92,
    p_estado     => 'Pendiente',
    p_idCliente  => 930,
    p_idEmpleado => 100   -- mesero existente
  );

  pkg_actor_mesero.registrar_venta(
    p_rol        => v_rol,
    p_idVenta    => 9302,
    p_fecha      => SYSDATE,
    p_subtotal   => 18,
    p_impuesto   => 2.88,
    p_total      => 20.88,
    p_estado     => 'Pendiente',
    p_idCliente  => 930,
    p_idEmpleado => 100
  );
END;
/
SELECT idVenta, total, idCliente, idEmpleado
FROM Venta
WHERE idVenta BETWEEN 9301 AND 9302;
/

---------------------------------------------------------------
-- 6) Al final el cliente deja una sola evaluación global
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero; -- mesero registra por el cliente
BEGIN
  pkg_actor_cliente.registrar_evaluacion(
    p_rol             => v_rol,
    p_idEvaluacion    => 9301,
    p_idCliente       => 930,
    p_califServicio   => 5,
    p_califProducto   => 4,
    p_califAmbiente   => 5,
    p_comentario      => 'Excelente ambiente para after office',
    p_fechaEvaluacion => SYSDATE
  );
END;
/
SELECT * FROM Evaluacion WHERE idEvaluacion = 9301;
/

---------------------------------------------------------------
-- 7) Consultas de resumen del caso
---------------------------------------------------------------
-- Ventas al cliente walk-in
SELECT idVenta, subtotal, impuesto, total, fecha
FROM Venta
WHERE idCliente = 930
ORDER BY fecha, idVenta;
/

-- Eventos del cliente walk-in
SELECT idEvento, nombreEvento, fechaEvento, numeroPersonas, estado
FROM Evento
WHERE idCliente = 930;
/

-- Turno en que Angie supervisó la jornada
SELECT idTurno, idEmpleado, fecha, tipo, horaInicio, horaFin
FROM Turno
WHERE idEmpleado = 9300;
/
