-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================== SEGURIDAD ===============================================

-- Aquí se define la lógica de roles y permisos del paquete pkg_seguridad
-- declarado en ActoresE. No se vuelve a crear el PACKAGE, solo su BODY.

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
