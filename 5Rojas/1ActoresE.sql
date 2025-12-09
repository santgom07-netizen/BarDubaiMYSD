-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- =========================== ActoresE: ESPECIFICACION =====================================

-- Paquete de seguridad: definición de roles lógicos
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
--------------------------------------------------------------------------------
-- Paquete de actores: operaciones protegidas por rol
CREATE OR REPLACE PACKAGE pkg_actores AS

  --------------------------------------------------------------------
  -- 1) Operaciones de EMPLEADO (solo ADMIN)
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
  );

  --------------------------------------------------------------------
  -- 2) Operaciones de VENTA (MESERO o ADMIN)
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
  );

  --------------------------------------------------------------------
  -- 3) Operaciones de COMPRA (GERENTE o ADMIN)
  --------------------------------------------------------------------
  PROCEDURE registrar_compra_gerente(
    p_rol         IN VARCHAR2,
    p_idCompra    IN Compra.idCompra%TYPE,
    p_fechaCompra IN Compra.fechaCompra%TYPE,
    p_cantidad    IN Compra.cantidad%TYPE,
    p_precioUnit  IN Compra.precioUnitario%TYPE,
    p_total       IN Compra.total%TYPE,
    p_idProveedor IN Compra.idProveedor%TYPE
  );

  --------------------------------------------------------------------
  -- 4) Operaciones de CLIENTE (MESERO o ADMIN)
  --------------------------------------------------------------------
  PROCEDURE crear_cliente_desde_mesero(
    p_rol      IN VARCHAR2,
    p_id       IN Cliente.idCliente%TYPE,
    p_nombre   IN Cliente.nombre%TYPE,
    p_telefono IN Cliente.telefono%TYPE,
    p_email    IN Cliente.email%TYPE
  );

END pkg_actores;
/
