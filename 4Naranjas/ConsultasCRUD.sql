SELECT * FROM Empleado WHERE idEmpleado = 8000;
SELECT * FROM Mesero   WHERE idEmpleado = 8000;

SELECT * FROM Cliente  WHERE idCliente  = 800;
SELECT * FROM Producto WHERE idProducto = 800;
SELECT * FROM Categoria WHERE idCategoria = 80;
SELECT * FROM Compra   WHERE idCompra   = 8000;
SELECT * FROM Venta    WHERE idVenta    = 8000;
SELECT * FROM Factura  WHERE numeroFactura = 'FAC-8000';
SELECT * FROM Entrada  WHERE idEntrada  = 8000;

-- Tablas Ciclo2

-- Evento creado por pkg_evento (ejemplo id 8800)
SELECT * FROM Evento WHERE idEvento = 8800;

-- Evaluación creada por pkg_evaluacion
SELECT * FROM Evaluacion WHERE idEvaluacion = 8800;

-- Turno creado por pkg_turno
SELECT * FROM Turno WHERE idTurno = 8800;

-- Receta creada por pkg_receta
SELECT * FROM Receta WHERE idReceta = 8800;
