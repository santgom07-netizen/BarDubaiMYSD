-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ===== IndicesVistasOK =====

-- A) Ventas de un cliente en un rango de fechas
SELECT  idVenta,
        fecha,
        nombre_producto,
        cantidad,
        subtotal,
        total
FROM v_ventas_detalle
WHERE idCliente = 1
  AND fecha BETWEEN DATE '2025-11-01' AND DATE '2025-11-30'
ORDER BY fecha, idVenta;

-- B) Productos por debajo del stock mínimo
SELECT  idProducto,
        nombre,
        cantidadStock,
        stockMinimo
FROM v_stock_producto
WHERE cantidadStock < stockMinimo
ORDER BY nombre;

-- C) Ventas realizadas por un empleado/mesero
SELECT  idEmpleado,
        nombre,
        apellido,
        num_ventas,
        total_vendido
FROM v_ventas_mesero
WHERE idEmpleado = 100;

-- D) Resumen de ventas por día en noviembre
SELECT  fecha,
        num_ventas,
        total_vendido
FROM v_resumen_ventas_dia
WHERE fecha BETWEEN DATE '2025-11-01' AND DATE '2025-11-30'
ORDER BY fecha;

-- E) Proveedores con mayor monto comprado
SELECT  idProveedor,
        nombre_proveedor,
        num_compras,
        total_comprado
FROM v_resumen_compras_proveedor
ORDER BY total_comprado DESC;

-- F) Reservas de un cliente específico
SELECT  idReserva,
        fechaReserva,
        numeroPersonas,
        estado
FROM v_reservas_cliente
WHERE idCliente = 1
ORDER BY fechaReserva DESC;
