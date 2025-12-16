-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== CRUDOK =====================
-- Limpieza de datos de prueba de CRUDOK
DELETE FROM DetalleVentaProducto WHERE idVenta = 8000;
DELETE FROM Venta                WHERE idVenta = 8000;

DELETE FROM Factura              WHERE numeroFactura = 'FAC-8000';

DELETE FROM Mesero               WHERE idEmpleado = 8000;
DELETE FROM Empleado             WHERE idEmpleado = 8000;

DELETE FROM Reserva              WHERE idCliente  = 800; 
DELETE FROM Cliente              WHERE idCliente  = 800;

DELETE FROM DetalleCompraProducto WHERE idCompra = 8000;
DELETE FROM Compra                WHERE idCompra = 8000;

DELETE FROM Inventario           WHERE idProducto = 800;
DELETE FROM Producto             WHERE idProducto = 800;

DELETE FROM Categoria            WHERE idCategoria = 80;

DELETE FROM Entrada              WHERE idEntrada = 8000;
COMMIT;

--------------------------------------------------
-- EMPLEADO – CRUDOK
--------------------------------------------------
BEGIN
  pkg_empleado.crear_empleado(
    p_id       => 8000,
    p_nombre   => 'Ana',
    p_apellido => 'Rios',
    p_telefono => '3118000000',
    p_email    => 'ana.rios@rest.com',
    p_salario  => 2000,
    p_turno    => 'Dia'
  );

  pkg_empleado.asignar_mesero(
    p_id       => 8000,
    p_zona     => 'Sala A',
    p_comision => 0.05,
    p_lugar    => 'Mesa',
    p_horario  => '8-16'
  );

  pkg_empleado.actualizar_empleado(
    p_id       => 8000,
    p_telefono => '3118000001',
    p_email    => 'ana.rios2@rest.com',
    p_salario  => 2100,
    p_turno    => 'Mixto'
  );
END;
/
--------------------------------------------------
-- CLIENTE – CRUDOK
--------------------------------------------------
BEGIN
  pkg_cliente.crear_cliente(
    p_id       => 800,
    p_nombre   => 'Carlos Cliente',
    p_telefono => '3008000000',
    p_email    => 'carlos.cliente@rest.com'
  );

  pkg_cliente.actualizar_cliente(
    p_id       => 800,
    p_telefono => '3008000001',
    p_email    => 'carlos.cliente2@rest.com'
  );
END;
/
--------------------------------------------------
-- PRODUCTO – CRUDOK
--------------------------------------------------
BEGIN
  pkg_producto.crear_producto(
    p_id          => 800,
    p_nombre      => 'Hamburguesa Especial',
    p_descripcion => 'Doble carne',
    p_precio      => 25.00,
    p_disponible  => 1,
    p_idCategoria => 2
  );

  pkg_producto.actualizar_producto(
    p_id          => 800,
    p_nombre      => 'Hamburguesa Especial XL',
    p_descripcion => 'Doble carne y queso',
    p_precio      => 27.00,
    p_disponible  => 1
  );
END;
/
--------------------------------------------------
-- CATEGORIA – CRUDOK
--------------------------------------------------
BEGIN
  pkg_categoria.crear_categoria(
    p_id          => 80,
    p_nombre      => 'Postres',
    p_descripcion => 'Dulces y postres'
  );

  pkg_categoria.actualizar_categoria(
    p_id          => 80,
    p_nombre      => 'Postres y Dulces',
    p_descripcion => 'Postres variados'
  );
END;
/
--------------------------------------------------
-- COMPRA – CRUDOK
--------------------------------------------------
BEGIN
  pkg_compra.crear_compra(
    p_idCompra    => 8000,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 10,
    p_precioUnit  => 3.50,
    p_total       => 35.00,
    p_idProveedor => 1
  );

  pkg_compra.actualizar_compra(
    p_idCompra   => 8000,
    p_cantidad   => 12,
    p_precioUnit => 3.50,
    p_total      => 42.00
  );
END;
/
--------------------------------------------------
-- VENTA – CRUDOK
--------------------------------------------------
BEGIN
  pkg_venta.crear_venta(
    p_idVenta    => 8000,
    p_fecha      => SYSDATE,
    p_subtotal   => 30.00,
    p_impuesto   => 4.80,
    p_total      => 34.80,
    p_estado     => 'Pendiente',
    p_idCliente  => 800,
    p_idEmpleado => 8000
  );

  pkg_venta.actualizar_venta(
    p_idVenta => 8000,
    p_estado  => 'Pagada'
  );
END;
/
--------------------------------------------------
-- FACTURA – CRUDOK
--------------------------------------------------
BEGIN
  pkg_factura.crear_factura(
    p_numero     => 'FAC-8000',
    p_fecha      => SYSDATE,
    p_subtotal   => 30.00,
    p_impuestos  => 4.80,
    p_total      => 34.80,
    p_metodoPago => 'Tarjeta'
  );

  pkg_factura.actualizar_factura(
    p_numero     => 'FAC-8000',
    p_subtotal   => 30.00,
    p_impuestos  => 4.80,
    p_total      => 34.80,
    p_metodoPago => 'Efectivo'
  );
END;
/
--------------------------------------------------
-- ENTRADA – CRUDOK
--------------------------------------------------
BEGIN
  pkg_entrada.crear_entrada(
    p_idEntrada        => 8000,
    p_fechaEntrada     => SYSDATE,
    p_cantidadIngresada=> 50,
    p_tipo             => 'Lote',
    p_fechaVencimiento => ADD_MONTHS(SYSDATE, 6)
  );

  pkg_entrada.actualizar_entrada(
    p_idEntrada        => 8000,
    p_cantidadIngresada=> 60,
    p_fechaVencimiento => ADD_MONTHS(SYSDATE, 7)
  );
END;
/

-- Tablas Ciclo2

--------------------------------------------------
-- EVENTO – CRUDOK
--------------------------------------------------
BEGIN
  pkg_evento.crear_evento(
    p_idEvento       => 8800,
    p_nombreEvento   => 'Evento CRUDOK',
    p_descripcion    => 'Prueba paquete evento',
    p_fechaEvento    => DATE '2025-11-30',
    p_horaInicio     => 18,
    p_horaFin        => 21,
    p_numeroPersonas => 5,
    p_estado         => 'Programado',
    p_idCliente      => 1
  );

  pkg_evento.actualizar_evento(
    p_idEvento       => 8800,
    p_nombreEvento   => 'Evento CRUDOK Editado',
    p_descripcion    => 'Prueba evento actualizado',
    p_fechaEvento    => DATE '2025-12-01',
    p_horaInicio     => 19,
    p_horaFin        => 22,
    p_numeroPersonas => 6,
    p_estado         => 'Confirmado'
  );
END;
/
--------------------------------------------------
-- EVALUACION – CRUDOK
--------------------------------------------------
BEGIN
  pkg_evaluacion.crear_evaluacion(
    p_idEvaluacion    => 8800,
    p_idCliente       => 1,
    p_califServicio   => 5,
    p_califProducto   => 4,
    p_califAmbiente   => 5,
    p_comentario      => 'CRUDOK evaluación',
    p_fechaEvaluacion => DATE '2025-12-02'
  );

  pkg_evaluacion.actualizar_evaluacion(
    p_idEvaluacion    => 8800,
    p_califServicio   => 4,
    p_califProducto   => 4,
    p_califAmbiente   => 5,
    p_comentario      => 'CRUDOK evaluación editada'
  );
END;
/
--------------------------------------------------
-- TURNO – CRUDOK
--------------------------------------------------
BEGIN
  pkg_turno.crear_turno(
    p_idTurno    => 8800,
    p_idEmpleado => 100,
    p_tipo       => 'Mañana',
    p_horaInicio => 8,
    p_horaFin    => 16,
    p_fecha      => DATE '2025-12-03',
    p_asistio    => 1,
    p_observ     => 'Turno CRUDOK'
  );

  pkg_turno.actualizar_turno(
    p_idTurno    => 8800,
    p_tipo       => 'Mixto',
    p_horaInicio => 10,
    p_horaFin    => 18,
    p_fecha      => DATE '2025-12-03',
    p_asistio    => 1,
    p_observ     => 'Turno CRUDOK actualizado'
  );
END;
/
--------------------------------------------------
-- RECETA – CRUDOK
--------------------------------------------------
BEGIN
  pkg_receta.crear_receta(
    p_idReceta          => 8800,
    p_idProducto        => 201,
    p_ingredientes      => 'Ing CRUDOK',
    p_instrucciones     => 'Instrucciones CRUDOK',
    p_tiempoPreparacion => 15,
    p_porciones         => 2
  );

  pkg_receta.actualizar_receta(
    p_idReceta          => 8800,
    p_ingredientes      => 'Ing CRUDOK editados',
    p_instrucciones     => 'Instrucciones CRUDOK editadas',
    p_tiempoPreparacion => 20,
    p_porciones         => 3
  );
END;
/
