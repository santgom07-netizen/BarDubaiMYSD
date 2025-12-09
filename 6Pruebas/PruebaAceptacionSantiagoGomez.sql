-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================= PruebaAceptacion_SantiagoGomez ==================================

-- Limpieza previa: por si la prueba ya se ejecutó antes
BEGIN
  -- Primero borrar dependencias en caso de que esten creadas
  DELETE FROM Venta   WHERE idVenta    = 9101;
  DELETE FROM Compra  WHERE idCompra   = 9102;
  DELETE FROM Cliente WHERE idCliente  = 910;
  DELETE FROM Empleado WHERE idEmpleado = 9100;

  COMMIT;
END;
/

-- 1) El ADMIN registra a Santiago como nuevo empleado
BEGIN
  pkg_actores.crear_empleado_admin(
    p_rol       => pkg_seguridad.c_rol_admin,
    p_id        => 9100,
    p_nombre    => 'Santiago',
    p_apellido  => 'Gomez',
    p_telefono  => '3119100000',
    p_email     => 'santiago.gomez@bardubai.com',
    p_salario   => 2300,
    p_turno     => 'Noche'
  );
END;
/
-- SELECT * FROM Empleado WHERE idEmpleado = 9100;

-- 2) El ADMIN consulta que Santiago quedó registrado
SELECT idEmpleado, nombre, apellido, turno
FROM Empleado
WHERE idEmpleado = 9100;
/

-- 3) Santiago (MESERO) registra a un nuevo cliente que llega al bar
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actores.crear_cliente_desde_mesero(
    p_rol      => v_rol,
    p_id       => 910,
    p_nombre   => 'Cliente Prueba',
    p_telefono => '3009100000',
    p_email    => 'cliente.prueba@correo.com'
  );
END;
/
-- SELECT * FROM Cliente WHERE idCliente = 910;

-- 4) Santiago verifica en el sistema que el cliente quedó creado
SELECT idCliente, nombre, telefono
FROM Cliente
WHERE idCliente = 910;
/

-- 5) Santiago toma la orden y registra la venta del cliente
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_mesero;
BEGIN
  pkg_actores.registrar_venta_mesero(
    p_rol        => v_rol,
    p_idVenta    => 9101,
    p_fecha      => SYSDATE,
    p_subtotal   => 30,      -- valor de los productos
    p_impuesto   => 4.8,
    p_total      => 34.8,
    p_estado     => 'Pendiente',
    p_idCliente  => 910,     -- cliente creado
    p_idEmpleado => 9100     -- Santiago
  );
END;
/
-- SELECT * FROM Venta WHERE idVenta = 9101;

-- 6) El sistema muestra la venta registrada por Santiago
SELECT idVenta, fecha, subtotal, impuesto, total, idCliente, idEmpleado
FROM Venta
WHERE idVenta = 9101;
/

-- 7) Más tarde el GERENTE registra una compra de insumos para reponer inventario
DECLARE
  v_rol VARCHAR2(20) := pkg_seguridad.c_rol_gerente;
BEGIN
  pkg_actores.registrar_compra_gerente(
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

-- 8) El GERENTE revisa las compras del día para controlar gastos
SELECT idCompra, fechaCompra, total
FROM Compra
WHERE idCompra = 9102;
/

-- 9) El ADMIN revisa rápidamente qué ventas hizo Santiago en su turno
SELECT v.idVenta, v.total, v.fecha
FROM Venta v
WHERE v.idEmpleado = 9100;
/

-- 10) Resumen del día: ventas y compras registradas en el sistema
SELECT idVenta, total, fecha
FROM Venta
WHERE TRUNC(fecha) = TRUNC(SYSDATE);
/

SELECT idCompra, total, fechaCompra
FROM Compra
WHERE TRUNC(fechaCompra) = TRUNC(SYSDATE);
/

---------------------------------------------------------------
-- 11) Consultas de verificación generales (opcional)
---------------------------------------------------------------
-- SELECT * FROM Empleado WHERE idEmpleado = 9100;
-- SELECT * FROM Cliente  WHERE idCliente  = 910;
-- SELECT * FROM Venta    WHERE idVenta    = 9101;
-- SELECT * FROM Compra   WHERE idCompra   = 9102;

