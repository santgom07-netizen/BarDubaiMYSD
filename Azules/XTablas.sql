-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ============================ XTablas: Eliminación de tablas ==============================

DROP TABLE DetalleCompraEntrada   CASCADE CONSTRAINTS;
DROP TABLE DetalleVentaEntrada    CASCADE CONSTRAINTS;
DROP TABLE DetalleCompraProducto  CASCADE CONSTRAINTS;
DROP TABLE DetalleVentaProducto   CASCADE CONSTRAINTS;

DROP TABLE Descuento              CASCADE CONSTRAINTS;
DROP TABLE Ingredientes           CASCADE CONSTRAINTS;
DROP TABLE ZonasAsignadas         CASCADE CONSTRAINTS;
DROP TABLE Observaciones          CASCADE CONSTRAINTS;

DROP TABLE Bebida                 CASCADE CONSTRAINTS;
DROP TABLE Comida                 CASCADE CONSTRAINTS;

DROP TABLE Inventario             CASCADE CONSTRAINTS;
DROP TABLE Entrada                CASCADE CONSTRAINTS;
DROP TABLE Compra                 CASCADE CONSTRAINTS;
DROP TABLE Proveedor              CASCADE CONSTRAINTS;

DROP TABLE Producto               CASCADE CONSTRAINTS;
DROP TABLE Categoria              CASCADE CONSTRAINTS;

DROP TABLE Venta                  CASCADE CONSTRAINTS;
DROP TABLE Reserva                CASCADE CONSTRAINTS;
DROP TABLE Mesa                   CASCADE CONSTRAINTS;

DROP TABLE Gerente                CASCADE CONSTRAINTS;
DROP TABLE Mesero                 CASCADE CONSTRAINTS;
DROP TABLE Seguridad              CASCADE CONSTRAINTS;
DROP TABLE Empleado               CASCADE CONSTRAINTS;

DROP TABLE Cliente_vip            CASCADE CONSTRAINTS;
DROP TABLE Cliente_regular        CASCADE CONSTRAINTS;
DROP TABLE Cliente                CASCADE CONSTRAINTS;

DROP TABLE Factura                CASCADE CONSTRAINTS;
DROP TABLE Metodo_pago            CASCADE CONSTRAINTS;
