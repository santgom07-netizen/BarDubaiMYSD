-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== XPoblar: Eliminación de datos ====================

-- Detalles de ventas y compras
DELETE FROM DetalleCompraEntrada;
DELETE FROM DetalleVentaEntrada;
DELETE FROM DetalleCompraProducto;
DELETE FROM DetalleVentaProducto;

-- Atributos [0..*]
DELETE FROM Descuento;
DELETE FROM Ingredientes;
DELETE FROM ZonasAsignadas;
DELETE FROM Observaciones;

-- Especializaciones de producto
DELETE FROM Bebida;
DELETE FROM Comida;

-- Movimientos e inventario
DELETE FROM Inventario;
DELETE FROM Entrada;
DELETE FROM Compra;

-- Relaciones principales
DELETE FROM Venta;
DELETE FROM Reserva;

-- Entidades dependientes
DELETE FROM Mesero;
DELETE FROM Gerente;
DELETE FROM Seguridad;
DELETE FROM Empleado;

DELETE FROM Cliente_vip;
DELETE FROM Cliente_regular;
DELETE FROM Cliente;

-- Productos y categorías
DELETE FROM Producto;
DELETE FROM Categoria;

-- Proveedores y mesas
DELETE FROM Proveedor;
DELETE FROM Mesa;

-- Opcional: Facturación y métodos de pago (si los usaste)
DELETE FROM Factura;
DELETE FROM Metodo_pago;
