-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================= SeguridadOK ================================================

-- Limpieza previa por si ya se ejecutó antes
BEGIN
  DELETE FROM Venta    WHERE idVenta    = 9001;
  DELETE FROM Compra   WHERE idCompra   = 9002;
  DELETE FROM Cliente  WHERE idCliente  = 900;
  DELETE FROM Empleado WHERE idEmpleado = 9000;
  COMMIT;
END;
/

-- 1) ADMIN crea un nuevo empleado
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_admin;
BEGIN
  pkg_actores.crear_empleado_admin(
    p_rol       => v_rol,
    p_id        => 9000,
    p_nombre    => 'Empleado Admin',
    p_apellido  => 'Seguro',
    p_telefono  => '3119000000',
    p_email     => 'emp.seguro@rest.com',
    p_salario   => 2500,
    p_turno     => 'Dia'
  );
END;
/
-- Verificación sugerida:
-- SELECT * FROM Empleado WHERE idEmpleado = 9000;

-- 2) MESERO registra una venta
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actores.registrar_venta_mesero(
    p_rol        => v_rol,
    p_idVenta    => 9001,
    p_fecha      => SYSDATE,
    p_subtotal   => 20,
    p_impuesto   => 3.2,
    p_total      => 23.2,
    p_estado     => 'Pendiente',
    p_idCliente  => 1,      -- asumiendo que ya existe Cliente 1
    p_idEmpleado => 100     -- asumiendo que ya existe Empleado 100 (mesero)
  );
END;
/
-- SELECT * FROM Venta WHERE idVenta = 9001;

-- 3) GERENTE registra una compra
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actores.registrar_compra_gerente(
    p_rol         => v_rol,
    p_idCompra    => 9002,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 5,
    p_precioUnit  => 10,
    p_total       => 50,
    p_idProveedor => 1      -- asumiendo que ya existe Proveedor 1
  );
END;
/
-- SELECT * FROM Compra WHERE idCompra = 9002;

-- 4) MESERO crea un nuevo cliente desde sala
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actores.crear_cliente_desde_mesero(
    p_rol      => v_rol,
    p_id       => 900,
    p_nombre   => 'Cliente Sala',
    p_telefono => '3009000000',
    p_email    => 'cliente.sala@rest.com'
  );
END;
/
-- SELECT * FROM Cliente WHERE idCliente = 900;
