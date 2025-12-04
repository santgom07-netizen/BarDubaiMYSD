-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ===== XIndicesVistas =====

-- Primero eliminar vistas
DROP VIEW v_ventas_detalle;
DROP VIEW v_stock_producto;
DROP VIEW v_resumen_ventas_dia;
DROP VIEW v_ventas_mesero;
DROP VIEW v_resumen_compras_proveedor;
DROP VIEW v_reservas_cliente;

-- Luego eliminar índices
DROP INDEX ix_cliente_nombre;
DROP INDEX ix_cliente_email;

DROP INDEX ix_empleado_apellido;
DROP INDEX ix_empleado_turno;

DROP INDEX ix_reserva_idcliente;
DROP INDEX ix_reserva_fecha;

DROP INDEX ix_venta_idcliente;
DROP INDEX ix_venta_idempleado;
DROP INDEX ix_venta_fecha;
DROP INDEX ix_venta_estado;

DROP INDEX ix_producto_nombre;
DROP INDEX ix_producto_idcategoria;

DROP INDEX ix_dvp_idventa;
DROP INDEX ix_dvp_idproducto;

DROP INDEX ix_compra_idproveedor;
DROP INDEX ix_compra_fecha;

DROP INDEX ix_dcp_idcompra;
DROP INDEX ix_dcp_idproducto;

DROP INDEX ix_inventario_idproducto;

DROP INDEX ix_entrada_fechavenc;
