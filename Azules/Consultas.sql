-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ===================== CONSULTAS: Incluir identificador (Comentadas) ======================

-- 1) Estado de mesas (idMesa)
-- SELECT m.numeroMesa AS idMesa, m.capacidad, m.ubicacion, m.estado,
--        CASE m.reservada WHEN 1 THEN 'SI' ELSE 'NO' END AS reservada
-- FROM Mesa m
-- ORDER BY m.numeroMesa;

-- 2) Mesas disponibles por capacidad (idMesa)
-- -- &p_personas para ejecutar como Script (F5)
-- SELECT m.numeroMesa AS idMesa, m.capacidad, m.ubicacion
-- FROM Mesa m
-- WHERE m.reservada = 0 AND m.capacidad >= &p_personas
-- ORDER BY m.capacidad, m.numeroMesa;

-- 3) Tiempo estimado de entrega (idVenta)
-- -- &p_idventa
-- SELECT v.idVenta,
--        NVL(SUM(c.tiempoPreparacion * d.cantidad), 0) AS minutos_estimados
-- FROM Venta v
-- LEFT JOIN DetalleVentaProducto d ON d.idVenta = v.idVenta
-- LEFT JOIN Comida c              ON c.idProducto = d.idProducto
-- WHERE v.idVenta = &p_idventa
-- GROUP BY v.idVenta;

-- 4) Ventas pendientes por preparar (idVenta)
-- SELECT v.idVenta, v.fecha, v.estado, SUM(d.cantidad) AS total_platos
-- FROM Venta v
-- JOIN DetalleVentaProducto d ON d.idVenta = v.idVenta
-- JOIN Comida c              ON c.idProducto = d.idProducto
-- WHERE v.estado = 'Pendiente'
-- GROUP BY v.idVenta, v.fecha, v.estado
-- ORDER BY v.fecha, v.idVenta;

-- 5) Productos solicitados en compras pendientes (idCompra, idProducto)
-- -- &p_idproveedor
-- WITH ordered AS (
--   SELECT dc.idCompra, dc.idProducto, SUM(dc.cantidad) AS qty_ordered
--   FROM DetalleCompraProducto dc
--   GROUP BY dc.idCompra, dc.idProducto
-- ),
-- received AS (
--   SELECT dce.idCompra, SUM(dce.cantidadEntrada) AS qty_received
--   FROM DetalleCompraEntrada dce
--   GROUP BY dce.idCompra
-- )
-- SELECT c.idCompra, p.idProducto, p.nombre AS producto,
--        o.qty_ordered, NVL(r.qty_received, 0) AS qty_received,
--        (o.qty_ordered - NVL(r.qty_received, 0)) AS qty_pendiente
-- FROM ordered o
-- JOIN Compra   c ON c.idCompra   = o.idCompra
-- JOIN Producto p ON p.idProducto = o.idProducto
-- LEFT JOIN received r ON r.idCompra = o.idCompra
-- WHERE NVL(r.qty_received, 0) < o.qty_ordered
--   AND c.idProveedor = &p_idproveedor
-- ORDER BY c.idCompra, p.idProducto;

-- 6) Historial de entregas del proveedor (idProveedor, idCompra, idEntrada)
-- -- &p_idproveedor
-- SELECT pr.idProveedor, c.idCompra, e.idEntrada, e.fechaEntrada, dce.cantidadEntrada
-- FROM Proveedor pr
-- JOIN Compra c               ON c.idProveedor = pr.idProveedor
-- JOIN DetalleCompraEntrada dce ON dce.idCompra   = c.idCompra
-- JOIN Entrada e              ON e.idEntrada       = dce.idEntrada
-- WHERE pr.idProveedor = &p_idproveedor
-- ORDER BY e.fechaEntrada DESC, e.idEntrada;

