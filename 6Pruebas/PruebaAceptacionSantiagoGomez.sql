-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================= PruebaAceptacion_SantiagoGomez ==================================

-- Limpieza previa: por si la prueba ya se ejecutó antes
BEGIN
  DELETE FROM Evaluacion WHERE idEvaluacion = 9101;
  DELETE FROM Evento      WHERE idEvento    = 9101;
  DELETE FROM Turno       WHERE idTurno     = 9101;

  DELETE FROM Venta       WHERE idVenta     = 9101;
  DELETE FROM Compra      WHERE idCompra    = 9102;
  DELETE FROM Cliente     WHERE idCliente   = 910;
  DELETE FROM Empleado    WHERE idEmpleado  = 9100;

  COMMIT;
END;
/

---------------------------------------------------------------
-- 1) El ADMIN registra a Santiago como nuevo empleado
---------------------------------------------------------------
BEGIN
  pkg_empleado.crear_empleado(
    p_id       => 9100,
    p_nombre   => 'Santiago',
    p_apellido => 'Gomez',
    p_telefono => '3119100000',
    p_email    => 'santiago.gomez@bardubai.com',
    p_salario  => 2300,
    p_turno    => 'Noche'
  );
END;
/
-- SELECT * FROM Empleado WHERE idEmpleado = 9100;

---------------------------------------------------------------
-- 2) El ADMIN consulta que Santiago quedó registrado
---------------------------------------------------------------
SELECT idEmpleado, nombre, apellido, turno
FROM Empleado
WHERE idEmpleado = 9100;
/

---------------------------------------------------------------
-- 3) Santiago (MESERO) registra a un nuevo cliente que llega al bar
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.crear_cliente(
    p_rol      => v_rol,
    p_id       => 910,
    p_nombre   => 'Cliente Prueba',
    p_telefono => '3009100000',
    p_email    => 'cliente.prueba@correo.com'
  );
END;
/
-- SELECT * FROM Cliente WHERE idCliente = 910;

---------------------------------------------------------------
-- 4) Santiago verifica en el sistema que el cliente quedó creado
---------------------------------------------------------------
SELECT idCliente, nombre, telefono
FROM Cliente
WHERE idCliente = 910;
/

---------------------------------------------------------------
-- 5) Santiago toma la orden y registra la venta del cliente
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.registrar_venta(
    p_rol        => v_rol,
    p_idVenta    => 9101,
    p_fecha      => SYSDATE,
    p_subtotal   => 30,     -- valor de los productos
    p_impuesto   => 4.8,
    p_total      => 34.8,
    p_estado     => 'Pendiente',
    p_idCliente  => 910,    -- cliente creado
    p_idEmpleado => 9100    -- Santiago
  );
END;
/
-- SELECT * FROM Venta WHERE idVenta = 9101;

---------------------------------------------------------------
-- 6) El sistema muestra la venta registrada por Santiago
---------------------------------------------------------------
SELECT idVenta, fecha, subtotal, impuesto, total, idCliente, idEmpleado
FROM Venta
WHERE idVenta = 9101;
/

---------------------------------------------------------------
-- 7) Más tarde el GERENTE registra una compra de insumos
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actor_gerente.registrar_compra(
    p_rol         => v_rol,
    p_idCompra    => 9102,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 10,
    p_precioUnit  => 8,
    p_total       => 80,
    p_idProveedor => 1       -- proveedor existente
  );
END;
/
-- SELECT * FROM Compra WHERE idCompra = 9102;

---------------------------------------------------------------
-- 8) El GERENTE revisa las compras del día para controlar gastos
---------------------------------------------------------------
SELECT idCompra, fechaCompra, total
FROM Compra
WHERE idCompra = 9102;
/

---------------------------------------------------------------
-- 9) El ADMIN revisa rápidamente qué ventas hizo Santiago en su turno
---------------------------------------------------------------
SELECT v.idVenta, v.total, v.fecha
FROM Venta v
WHERE v.idEmpleado = 9100;
/

---------------------------------------------------------------
-- 10) Resumen del día: ventas y compras registradas en el sistema
---------------------------------------------------------------
SELECT idVenta, total, fecha
FROM Venta
WHERE TRUNC(fecha) = TRUNC(SYSDATE);
/

SELECT idCompra, total, fechaCompra
FROM Compra
WHERE TRUNC(fechaCompra) = TRUNC(SYSDATE);
/

---------------------------------------------------------------
-- 11) Santiago (MESERO) agenda un evento para su cliente
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actor_mesero.crear_evento_cliente(
    p_rol            => v_rol,
    p_idEvento       => 9101,
    p_nombreEvento   => 'Cata de vinos',
    p_descripcion    => 'Evento privado para cliente de prueba',
    p_fechaEvento    => DATE '2025-12-18',
    p_horaInicio     => 19,
    p_horaFin        => 22,
    p_numeroPersonas => 4,
    p_estado         => 'Programado',
    p_idCliente      => 910
  );
END;
/
SELECT idEvento, nombreEvento, fechaEvento, numeroPersonas, estado
FROM Evento
WHERE idEvento = 9101;
/

---------------------------------------------------------------
-- 12) El GERENTE crea el turno de Santiago para atender ese evento
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actor_gerente.crear_turno_empleado(
    p_rol        => v_rol,
    p_idTurno    => 9101,
    p_idEmpleado => 9100,
    p_tipo       => 'Noche',
    p_horaInicio => 18,
    p_horaFin    => 23,
    p_fecha      => DATE '2025-12-18',
    p_asistio    => 1,
    p_observ     => 'Turno para evento de cata'
  );
END;
/
SELECT idTurno, idEmpleado, fecha, tipo, horaInicio, horaFin
FROM Turno
WHERE idTurno = 9101;
/

---------------------------------------------------------------
-- 13) Después del servicio se registra una evaluación del cliente
---------------------------------------------------------------
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;  -- mesero registra por el cliente
BEGIN
  pkg_actor_cliente.registrar_evaluacion(
    p_rol             => v_rol,
    p_idEvaluacion    => 9101,
    p_idCliente       => 910,
    p_califServicio   => 5,
    p_califProducto   => 4,
    p_califAmbiente   => 5,
    p_comentario      => 'Servicio excelente de Santiago en la cata',
    p_fechaEvaluacion => SYSDATE
  );
END;
/
SELECT * 
FROM Evaluacion
WHERE idEvaluacion = 9101;
/

---------------------------------------------------------------
-- 14) Consultas de verificación generales (opcional)
---------------------------------------------------------------
-- SELECT * FROM Empleado   WHERE idEmpleado   = 9100;
-- SELECT * FROM Cliente    WHERE idCliente    = 910;
-- SELECT * FROM Venta      WHERE idVenta      = 9101;
-- SELECT * FROM Compra     WHERE idCompra     = 9102;
-- SELECT * FROM Evento     WHERE idEvento     = 9101;
-- SELECT * FROM Turno      WHERE idTurno      = 9101;
-- SELECT * FROM Evaluacion WHERE idEvaluacion = 9101;
