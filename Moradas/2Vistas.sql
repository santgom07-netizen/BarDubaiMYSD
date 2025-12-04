-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ===== VISTAS =====

-- 1) Detalle completo de ventas (cabecera + cliente + producto)
CREATE VIEW v_ventas_detalle AS
SELECT  v.idVenta,
        v.fecha,
        v.total,
        v.estado,
        c.idCliente,
        c.nombre      AS nombre_cliente,
        p.idProducto,
        p.nombre      AS nombre_producto,
        d.cantidad,
        d.precioUnitario,
        d.subtotal
FROM Venta v
JOIN Cliente              c ON c.idCliente   = v.idCliente
JOIN DetalleVentaProducto d ON d.idVenta    = v.idVenta
JOIN Producto             p ON p.idProducto  = d.idProducto;

-- 2) Stock actual por producto
CREATE VIEW v_stock_producto AS
SELECT  p.idProducto,
        p.nombre,
        i.cantidadStock,
        i.stockMinimo
FROM Producto  p
JOIN Inventario i ON i.idProducto = p.idProducto;

-- 3) Resumen de ventas por día
CREATE VIEW v_resumen_ventas_dia AS
SELECT  fecha,
        COUNT(*)   AS num_ventas,
        SUM(total) AS total_vendido
FROM Venta
GROUP BY fecha;

-- 4) Ventas por mesero/empleado
CREATE VIEW v_ventas_mesero AS
SELECT  e.idEmpleado,
        e.nombre,
        e.apellido,
        COUNT(v.idVenta)  AS num_ventas,
        SUM(v.total)      AS total_vendido
FROM Empleado e
LEFT JOIN Venta v ON v.idEmpleado = e.idEmpleado
GROUP BY e.idEmpleado, e.nombre, e.apellido;

-- 5) Compras y resumen por proveedor
CREATE VIEW v_resumen_compras_proveedor AS
SELECT  pr.idProveedor,
        pr.nombre         AS nombre_proveedor,
        COUNT(c.idCompra) AS num_compras,
        SUM(c.total)      AS total_comprado
FROM Proveedor pr
LEFT JOIN Compra c ON c.idProveedor = pr.idProveedor
GROUP BY pr.idProveedor, pr.nombre;

-- 6) Reservas con datos de cliente
CREATE VIEW v_reservas_cliente AS
SELECT  r.idReserva,
        r.fechaReserva,
        r.numeroPersonas,
        r.estado,
        c.idCliente,
        c.nombre AS nombre_cliente
FROM Reserva r
JOIN Cliente c ON c.idCliente = r.idCliente;
