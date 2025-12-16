-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== CRUDNoOK =====================
--------------------------------------------------
-- EMPLEADO – CRUDNoOK
--------------------------------------------------
-- Turno inválido   
BEGIN
  pkg_empleado.crear_empleado(
    p_id       => 9000,
    p_nombre   => 'Turno Malo',
    p_apellido => 'Test',
    p_telefono => '3119000000',
    p_email    => 'turno.malo@rest.com',
    p_salario  => 1500,
    p_turno    => 'Tarde'   -- NO permitido por chk_emp_turno
  );
END;
/
-- Comisión negativa
BEGIN
  pkg_empleado.asignar_mesero(
    p_id       => 8000,
    p_zona     => 'Sala C',
    p_comision => -0.10,    -- NO permitido por chk_mes_comision_nonneg
    p_lugar    => 'Mesa',
    p_horario  => '10-18'
  );
END;
/
--------------------------------------------------
-- CLIENTE – CRUDNoOK
--------------------------------------------------
-- Sin teléfono ni email (rompe chk_cliente_contacto_minuno si lo tienes)
BEGIN
  pkg_cliente.crear_cliente(
    p_id       => 900,
    p_nombre   => 'Sin Contacto',
    p_telefono => NULL,
    p_email    => NULL
  );
END;
/
-- Email duplicado (rompe uq_cliente_email si ya existe uno igual)
BEGIN
  pkg_cliente.crear_cliente(
    p_id       => 901,
    p_nombre   => 'Correo Duplicado',
    p_telefono => '3009000001',
    p_email    => 'ana.perez@example.com'  -- ya usado en PoblarOK
  );
END;
/
--------------------------------------------------
-- PRODUCTO – CRUDNoOK
--------------------------------------------------
-- Precio negativo
BEGIN
  pkg_producto.crear_producto(
    p_id          => 900,
    p_nombre      => 'Prod Negativo',
    p_descripcion => 'Mal precio',
    p_precio      => -5.00,  -- NO permitido por chk_prod_precio_pos
    p_disponible  => 1,
    p_idCategoria => 1
  );
END;
/
-- Categoría inexistente (rompe FK fk_producto_categoria)
BEGIN
  pkg_producto.crear_producto(
    p_id          => 901,
    p_nombre      => 'Sin Categoria',
    p_descripcion => 'Categoria 9999 no existe',
    p_precio      => 10.00,
    p_disponible  => 1,
    p_idCategoria => 9999
  );
END;
/
--------------------------------------------------
-- CATEGORIA – CRUDNoOK
--------------------------------------------------
-- Nombre NULL (rompe NOT NULL de nombre)
BEGIN
  pkg_categoria.crear_categoria(
    p_id          => 90,
    p_nombre      => NULL,   -- nombre NOT NULL
    p_descripcion => 'Categoria sin nombre'
  );
END;
/
--------------------------------------------------
-- COMPRA – CRUDNoOK
--------------------------------------------------
-- Total incorrecto (rompe chk_compra_total_calc si lo tienes activo)
BEGIN
  pkg_compra.crear_compra(
    p_idCompra    => 9000,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 10,
    p_precioUnit  => 3.50,
    p_total       => 100.00,  -- 10*3.5 = 35, total incoherente
    p_idProveedor => 1
  );
END;
/
-- Proveedor inexistente (rompe FK fk_compra_proveedor)
BEGIN
  pkg_compra.crear_compra(
    p_idCompra    => 9001,
    p_fechaCompra => SYSDATE,
    p_cantidad    => 5,
    p_precioUnit  => 3.00,
    p_total       => 15.00,
    p_idProveedor => 9999    -- no existe
  );
END;
/
--------------------------------------------------
-- VENTA – CRUDNoOK
--------------------------------------------------
-- Cliente inexistente (rompe FK fk_venta_cliente)
BEGIN
  pkg_venta.crear_venta(
    p_idVenta    => 9000,
    p_fecha      => SYSDATE,
    p_subtotal   => 20.00,
    p_impuesto   => 3.20,
    p_total      => 23.20,
    p_estado     => 'Pendiente',
    p_idCliente  => 9999,   -- no existe
    p_idEmpleado => NULL
  );
END;
/
-- Estado demasiado largo (rompe chk_venta_estado_len)
BEGIN
  pkg_venta.crear_venta(
    p_idVenta    => 9001,
    p_fecha      => SYSDATE,
    p_subtotal   => 20.00,
    p_impuesto   => 3.20,
    p_total      => 23.20,
    p_estado     => 'Estado-muy-muy-largo-xxx', -- > 20 chars
    p_idCliente  => 1,
    p_idEmpleado => NULL
  );
END;
/
--------------------------------------------------
-- FACTURA – CRUDNoOK
--------------------------------------------------
-- Total incoherente (rompe chk_fact_total_eq)
BEGIN
  pkg_factura.crear_factura(
    p_numero     => 'FAC-BAD-9000',
    p_fecha      => SYSDATE,
    p_subtotal   => 50.00,
    p_impuestos  => 8.00,
    p_total      => 70.00,    -- 50+8=58, no 70
    p_metodoPago => 'Tarjeta'
  );
END;
/
-- Número vacío (rompe chk_fac_num_len)
BEGIN
  pkg_factura.crear_factura(
    p_numero     => '',        -- longitud 0
    p_fecha      => SYSDATE,
    p_subtotal   => 10.00,
    p_impuestos  => 1.60,
    p_total      => 11.60,
    p_metodoPago => 'Efectivo'
  );
END;
/
--------------------------------------------------
-- ENTRADA – CRUDNoOK
--------------------------------------------------
-- Vencimiento antes de la entrada (rompe chk_ent_fechas_coherentes)
BEGIN
  pkg_entrada.crear_entrada(
    p_idEntrada        => 9000,
    p_fechaEntrada     => DATE '2025-11-10',
    p_cantidadIngresada=> 10,
    p_tipo             => 'Lote',
    p_fechaVencimiento => DATE '2025-11-01'  -- anterior
  );
END;
/
-- Cantidad negativa (rompe chk_ent_cant_nonneg)
BEGIN
  pkg_entrada.crear_entrada(
    p_idEntrada        => 9001,
    p_fechaEntrada     => SYSDATE,
    p_cantidadIngresada=> -5,  -- no permitido
    p_tipo             => 'Lote',
    p_fechaVencimiento => ADD_MONTHS(SYSDATE, 3)
  );
END;
/

-- Tablas Ciclo2

-- EVENTO 
-- Hora fin <= hora inicio (viola restricciones/trigger de Evento)
BEGIN
  pkg_evento.crear_evento(
    p_idEvento       => 9900,
    p_nombreEvento   => 'Evento Malo',
    p_descripcion    => 'Fin antes que inicio',
    p_fechaEvento    => DATE '2025-12-10',
    p_horaInicio     => 20,
    p_horaFin        => 18,             -- incorrecto
    p_numeroPersonas => 5,
    p_estado         => 'Programado',
    p_idCliente      => 1
  );
END;
/
-- Personas <= 0 (también debería fallar)
BEGIN
  pkg_evento.crear_evento(
    p_idEvento       => 9901,
    p_nombreEvento   => 'Sin Personas',
    p_descripcion    => 'Num personas 0',
    p_fechaEvento    => DATE '2025-12-11',
    p_horaInicio     => 18,
    p_horaFin        => 20,
    p_numeroPersonas => 0,              -- no permitido
    p_estado         => 'Programado',
    p_idCliente      => 1
  );
END;
/

-- EVALUACION
-- Calificación fuera de rango 0..5
BEGIN
  pkg_evaluacion.crear_evaluacion(
    p_idEvaluacion    => 9900,
    p_idCliente       => 1,
    p_califServicio   => 7,             -- inválido
    p_califProducto   => 4,
    p_califAmbiente   => 5,
    p_comentario      => 'Servicio 7/5',
    p_fechaEvaluacion => DATE '2025-12-12'
  );
END;
/

-- TURNO 
-- Rango horario incoherente
BEGIN
  pkg_turno.crear_turno(
    p_idTurno    => 9900,
    p_idEmpleado => 100,
    p_tipo       => 'Mañana',
    p_horaInicio => 18,
    p_horaFin    => 8,                  -- fin < inicio
    p_fecha      => DATE '2025-12-13',
    p_asistio    => 1,
    p_observ     => 'Turno inválido'
  );
END;
/
-- Asistio no binario
BEGIN
  pkg_turno.crear_turno(
    p_idTurno    => 9901,
    p_idEmpleado => 100,
    p_tipo       => 'Noche',
    p_horaInicio => 18,
    p_horaFin    => 23,
    p_fecha      => DATE '2025-12-13',
    p_asistio    => 3,                  -- solo 0 o 1
    p_observ     => 'Asistio = 3'
  );
END;
/

-- RECETA 
-- Tiempo y porciones no positivos
BEGIN
  pkg_receta.crear_receta(
    p_idReceta          => 9900,
    p_idProducto        => 201,
    p_ingredientes      => 'X',
    p_instrucciones     => 'Y',
    p_tiempoPreparacion => 0,           -- no permitido
    p_porciones         => 2
  );
END;
/
BEGIN
  pkg_receta.crear_receta(
    p_idReceta          => 9901,
    p_idProducto        => 201,
    p_ingredientes      => 'X',
    p_instrucciones     => 'Y',
    p_tiempoPreparacion => 15,
    p_porciones         => 0            -- no permitido
  );
END;
/
