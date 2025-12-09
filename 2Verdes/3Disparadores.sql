-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== DISPARADORES ====================

-- Soporte: procedimiento para recalcular totales de una venta
CREATE OR REPLACE PROCEDURE prc_recalcular_venta (p_idVenta IN NUMBER) IS
  c_tax CONSTANT NUMBER := 0.16;   -- IVA 16% (ajusta si usas otro)
  v_sub       NUMBER := 0;
  v_desc      NUMBER := 0;
  v_sub_desc  NUMBER := 0;
  v_imp       NUMBER := 0;
  v_tot       NUMBER := 0;
BEGIN
  SELECT NVL(SUM(subtotal),0)
    INTO v_sub
    FROM DetalleVentaProducto
   WHERE idVenta = p_idVenta;

  SELECT NVL(MAX(descuento),0)
    INTO v_desc
    FROM Descuento
   WHERE idVenta = p_idVenta;

  v_sub_desc := ROUND(v_sub * (1 - v_desc), 2);
  v_imp      := ROUND(v_sub_desc * c_tax, 2);
  v_tot      := v_sub_desc + v_imp;

  UPDATE Venta
     SET subtotal = v_sub_desc,
         impuesto = v_imp,
         total    = v_tot
   WHERE idVenta = p_idVenta;
END;
/
SHOW ERRORS;

-- Inventario: fecha de actualización automática
CREATE OR REPLACE TRIGGER trg_inv_touch_bu
BEFORE UPDATE OF cantidadStock, stockMinimo ON Inventario
FOR EACH ROW
BEGIN
  :NEW.fechaActualizacion := SYSDATE;
END;
/
SHOW ERRORS;

-- Crear inventario al insertar producto
CREATE OR REPLACE TRIGGER trg_prod_crea_inventario_ai
AFTER INSERT ON Producto
FOR EACH ROW
DECLARE
  v_idInv NUMBER;
BEGIN
  SELECT NVL(MAX(idInventario),0) + 1 INTO v_idInv FROM Inventario;
  INSERT INTO Inventario (idInventario, idProducto, cantidadStock, stockMinimo, fechaActualizacion)
  VALUES (v_idInv, :NEW.idProducto, 0, 0, SYSDATE);
END;
/
SHOW ERRORS;

-- Ventas: validación y ajuste de stock

-- Validar stock antes de insertar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_chk_stock_bi
BEFORE INSERT ON DetalleVentaProducto
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT cantidadStock INTO v_stock FROM Inventario
   WHERE idProducto = :NEW.idProducto FOR UPDATE;
  IF :NEW.cantidad > v_stock THEN
    RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente para producto '||:NEW.idProducto);
  END IF;
END;
/
SHOW ERRORS;

-- Descontar stock al insertar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_stock_ai
AFTER INSERT ON DetalleVentaProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock - :NEW.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

-- Validar stock antes de actualizar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_chk_stock_bu
BEFORE UPDATE ON DetalleVentaProducto
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT cantidadStock INTO v_stock FROM Inventario
   WHERE idProducto = :NEW.idProducto FOR UPDATE;
  IF (:NEW.cantidad - :OLD.cantidad) > v_stock THEN
    RAISE_APPLICATION_ERROR(-20002, 'Stock insuficiente para actualización en producto '||:NEW.idProducto);
  END IF;
END;
/
SHOW ERRORS;

-- Ajustar stock al actualizar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_stock_au
AFTER UPDATE ON DetalleVentaProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + :OLD.cantidad - :NEW.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

-- Reintegrar stock al borrar detalle de venta
CREATE OR REPLACE TRIGGER trg_dvp_stock_ad
AFTER DELETE ON DetalleVentaProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + :OLD.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :OLD.idProducto;
END;
/
SHOW ERRORS;

-- Recalcular totales de Venta cuando cambien detalles (trigger compuesto)
CREATE OR REPLACE TRIGGER trg_dvp_recalc_ct
FOR INSERT OR UPDATE OR DELETE ON DetalleVentaProducto
COMPOUND TRIGGER
  TYPE t_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  g_ids t_ids;

  PROCEDURE add_id(p NUMBER) IS
  BEGIN
    IF p IS NOT NULL THEN
      g_ids(g_ids.COUNT + 1) := p;
    END IF;
  END;

  BEFORE STATEMENT IS
  BEGIN
    g_ids.DELETE;
  END BEFORE STATEMENT;

  AFTER EACH ROW IS
  BEGIN
    add_id(:NEW.idVenta);
    add_id(:OLD.idVenta);
  END AFTER EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF g_ids.COUNT > 0 THEN
      -- Opcional: deduplicar; aquí recalculamos para cada id capturado
      FOR i IN 1..g_ids.COUNT LOOP
        prc_recalcular_venta(g_ids(i));
      END LOOP;
    END IF;
  END AFTER STATEMENT;
END;
/
SHOW ERRORS;

-- Compras: sumar/restar stock según detalle de compra

CREATE OR REPLACE TRIGGER trg_dcp_stock_ai
AFTER INSERT ON DetalleCompraProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + :NEW.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_dcp_stock_au
AFTER UPDATE ON DetalleCompraProducto
FOR EACH ROW
BEGIN
  UPDATE Inventario
     SET cantidadStock = cantidadStock + (:NEW.cantidad - :OLD.cantidad),
         fechaActualizacion = SYSDATE
   WHERE idProducto = :NEW.idProducto;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_dcp_stock_ad
AFTER DELETE ON DetalleCompraProducto
FOR EACH ROW
DECLARE
  v_stock NUMBER;
BEGIN
  SELECT cantidadStock INTO v_stock FROM Inventario
   WHERE idProducto = :OLD.idProducto FOR UPDATE;
  IF v_stock - :OLD.cantidad < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Eliminación deja stock negativo para producto '||:OLD.idProducto);
  END IF;
  UPDATE Inventario
     SET cantidadStock = v_stock - :OLD.cantidad,
         fechaActualizacion = SYSDATE
   WHERE idProducto = :OLD.idProducto;
END;
/
SHOW ERRORS;

-- Recalcular totales de Venta cuando cambie Descuento (trigger compuesto)
CREATE OR REPLACE TRIGGER trg_desc_recalc_ct
FOR INSERT OR UPDATE OR DELETE ON Descuento
COMPOUND TRIGGER
  TYPE t_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  g_ids t_ids;

  PROCEDURE add_id(p NUMBER) IS
  BEGIN
    IF p IS NOT NULL THEN
      g_ids(g_ids.COUNT + 1) := p;
    END IF;
  END;

  BEFORE STATEMENT IS
  BEGIN
    g_ids.DELETE;
  END BEFORE STATEMENT;

  AFTER EACH ROW IS
  BEGIN
    add_id(:NEW.idVenta);
    add_id(:OLD.idVenta);
  END AFTER EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF g_ids.COUNT > 0 THEN
      FOR i IN 1..g_ids.COUNT LOOP
        prc_recalcular_venta(g_ids(i));
      END LOOP;
    END IF;
  END AFTER STATEMENT;
END;
/
SHOW ERRORS;
