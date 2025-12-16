-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ================================ CONSULTAS =========================================

-- 1) Estado de mesas (idMesa)
SELECT m.numeroMesa AS idMesa,
       m.capacidad,
       m.ubicacion,
       m.estado,
       CASE m.reservada WHEN 1 THEN 'SI' ELSE 'NO' END AS reservada
FROM Mesa m
ORDER BY m.numeroMesa;
/

-- 2) Mesas disponibles por capacidad (idMesa)
-- Capacidad mínima fija: 4 personas
SELECT m.numeroMesa AS idMesa,
       m.capacidad,
       m.ubicacion
FROM Mesa m
WHERE m.reservada = 0
  AND m.capacidad >= 4
ORDER BY m.capacidad, m.numeroMesa;
/

-- 3) Tiempo estimado de entrega (idVenta)
-- Venta fija: 8000 
SELECT v.idVenta,
       NVL(SUM(c.tiempoPreparacion * d.cantidad), 0) AS minutos_estimados
FROM Venta v
LEFT JOIN DetalleVentaProducto d ON d.idVenta   = v.idVenta
LEFT JOIN Comida              c ON c.idProducto = d.idProducto
WHERE v.idVenta = 8000
GROUP BY v.idVenta;
/

-- 4) Ventas pendientes por preparar (idVenta)
SELECT v.idVenta,
       v.fecha,
       v.estado,
       SUM(d.cantidad) AS total_platos
FROM Venta v
JOIN DetalleVentaProducto d ON d.idVenta   = v.idVenta
JOIN Comida              c ON c.idProducto = d.idProducto
WHERE v.estado = 'Pendiente'
GROUP BY v.idVenta, v.fecha, v.estado
ORDER BY v.fecha, v.idVenta;
/

-- 5) Compras con cantidad comprada, recibida y pendiente (incluye 0 pendiente)
SELECT  c.idCompra,
        p.idProducto,
        p.nombre                       AS producto,
        dc.cantidad                    AS qty_comprada,
        NVL(SUM(dce.cantidadEntrada),0) AS qty_recibida,
        (dc.cantidad - NVL(SUM(dce.cantidadEntrada),0)) AS qty_pendiente
FROM Compra c
JOIN DetalleCompraProducto   dc  ON dc.idCompra  = c.idCompra
JOIN Producto                p   ON p.idProducto = dc.idProducto
LEFT JOIN DetalleCompraEntrada dce ON dce.idCompra = c.idCompra
WHERE c.idProveedor = 1      -- tu proveedor
GROUP BY c.idCompra, p.idProducto, p.nombre, dc.cantidad
ORDER BY c.idCompra, p.idProducto;
/ 

-- 6) Historial de entregas del proveedor (idProveedor, idCompra, idEntrada)
-- Proveedor fijo: 1
SELECT pr.idProveedor,
       c.idCompra,
       e.idEntrada,
       e.fechaEntrada,
       dce.cantidadEntrada
FROM Proveedor pr
JOIN Compra               c   ON c.idProveedor = pr.idProveedor
JOIN DetalleCompraEntrada dce ON dce.idCompra  = c.idCompra
JOIN Entrada              e   ON e.idEntrada   = dce.idEntrada
WHERE pr.idProveedor = 1
ORDER BY e.fechaEntrada DESC, e.idEntrada;
/

-- Tablas Ciclo2

-- 7) Eventos de un cliente (idEvento, idCliente)
-- Cliente fijo: 1
SELECT  e.idEvento,
        e.nombreEvento,
        e.fechaEvento,
        e.horaInicio,
        e.horaFin,
        e.numeroPersonas,
        e.estado
FROM Evento e
WHERE e.idCliente = 1
ORDER BY e.fechaEvento, e.horaInicio;
/

-- 8) Historial de turnos de un empleado (idTurno, idEmpleado)
-- Empleado fijo: 100
SELECT  t.idTurno,
        t.idEmpleado,
        t.tipo,
        t.fecha,
        t.horaInicio,
        t.horaFin,
        CASE t.asistio WHEN 1 THEN 'SI' ELSE 'NO' END AS asistio,
        t.observaciones
FROM Turno t
WHERE t.idEmpleado = 100
ORDER BY t.fecha DESC, t.horaInicio;
/
