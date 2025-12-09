-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- =========================== ActoresI: IMPLEMENTACION =====================================

-- BODY de pkg_seguridad (si prefieres, puedes dejarlo en Seguridad.sql;
-- aquí lo dejo completo para que compile todo junto)

CREATE OR REPLACE PACKAGE BODY pkg_seguridad AS

  PROCEDURE validar_rol(
    p_rol    IN VARCHAR2,
    p_accion IN VARCHAR2
  ) IS
  BEGIN
    -- Validar que el rol sea uno de los definidos en la especificación
    IF p_rol NOT IN (c_rol_admin, c_rol_gerente, c_rol_mesero, c_rol_guardia) THEN
      RAISE_APPLICATION_ERROR(
        -20000,
        'Rol [' || p_rol || '] no es un rol valido para la accion ' || p_accion
      );
    END IF;
  END validar_rol;

END pkg_seguridad;
/
--------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_actores AS

  --------------------------------------------------------------------
  -- 1) EMPLEADO: solo ADMIN
  --------------------------------------------------------------------
  PROCEDURE crear_empleado_admin(
    p_rol       IN VARCHAR2,
    p_id        IN Empleado.idEmpleado%TYPE,
    p_nombre    IN Empleado.nombre%TYPE,
    p_apellido  IN Empleado.apellido%TYPE,
    p_telefono  IN Empleado.telefono%TYPE,
    p_email     IN Empleado.email%TYPE,
    p_salario   IN Empleado.salario%TYPE,
    p_turno     IN Empleado.turno%TYPE
  ) IS
  BEGIN
    pkg_seguridad.validar_rol(p_rol, 'CREAR_EMPLEADO');

    IF p_rol <> pkg_seguridad.c_rol_admin THEN
      RAISE_APPLICATION_ERROR(-20001,
        'Solo ADMIN puede crear empleados');
    END IF;

    pkg_empleado.crear_empleado(
      p_id        => p_id,
      p_nombre    => p_nombre,
      p_apellido  => p_apellido,
      p_telefono  => p_telefono,
      p_email     => p_email,
      p_salario   => p_salario,
      p_turno     => p_turno
    );
  END crear_empleado_admin;

  --------------------------------------------------------------------
  -- 2) VENTA: MESERO o ADMIN
  --------------------------------------------------------------------
  PROCEDURE registrar_venta_mesero(
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
  END registrar_venta_mesero;

  --------------------------------------------------------------------
  -- 3) COMPRA: GERENTE o ADMIN
  --------------------------------------------------------------------
  PROCEDURE registrar_compra_gerente(
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
  END registrar_compra_gerente;

  --------------------------------------------------------------------
  -- 4) CLIENTE: MESERO o ADMIN
  --------------------------------------------------------------------
  PROCEDURE crear_cliente_desde_mesero(
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
  END crear_cliente_desde_mesero;

END pkg_actores;
/
