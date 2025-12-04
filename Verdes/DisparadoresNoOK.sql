-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== DisparadoresNoOK ====================
-- Intentar vender más de lo que hay (debe fallar por trg_dvp_chk_stock_bi)
INSERT INTO DetalleVentaProducto (idVenta, idProducto, cantidad, precioUnitario, subtotal)
VALUES (9700, 201, 9999, 18.00, 179982.00);

-- Intentar actualizar detalle de venta para dejar stock negativo (debe fallar)
UPDATE DetalleVentaProducto
   SET cantidad = cantidad + 10000
 WHERE idVenta = 9700 AND idProducto = 201;

-- Intentar borrar detalle de compra dejando stock negativo (debe fallar por -20003)
DELETE FROM DetalleCompraProducto
 WHERE idCompra = 5001 AND idProducto = 201 AND cantidad = 3;




