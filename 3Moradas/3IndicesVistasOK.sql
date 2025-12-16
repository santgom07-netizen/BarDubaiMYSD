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

-- B) Ventas realizadas por un empleado/mesero
SELECT  idEmpleado,
        nombre,
        apellido,
        num_ventas,
        total_vendido
FROM v_ventas_mesero
WHERE idEmpleado = 100;

-- C) Resumen de ventas por día en noviembre
SELECT  fecha,
        num_ventas,
        total_vendido
FROM v_resumen_ventas_dia
WHERE fecha BETWEEN DATE '2025-11-01' AND DATE '2025-11-30'
ORDER BY fecha;

-- D) Proveedores con mayor monto comprado
SELECT  idProveedor,
        nombre_proveedor,
        num_compras,
        total_comprado
FROM v_resumen_compras_proveedor
ORDER BY total_comprado DESC;

-- E) Reservas de un cliente específico
SELECT  idReserva,
        fechaReserva,
        numeroPersonas,
        estado
FROM v_reservas_cliente
WHERE idCliente = 1
ORDER BY fechaReserva DESC;

-- Tablas Ciclo2

-- F) Eventos de un cliente en un rango de fechas (usa v_eventos_cliente + ix_evento_idcliente / ix_evento_fecha)
SELECT  idEvento,
        nombreEvento,
        fechaEvento,
        horaInicio,
        horaFin,
        numeroPersonas,
        estado
FROM v_eventos_cliente
WHERE idCliente = 1
  AND fechaEvento BETWEEN DATE '2025-11-01' AND DATE '2025-11-30'
ORDER BY fechaEvento, horaInicio;

-- G) Historial de turnos de un empleado (usa v_turnos_empleado + ix_turno_idempleado / ix_turno_fecha)
SELECT  idTurno,
        fecha,
        tipo,
        horaInicio,
        horaFin,
        asistio,
        observaciones
FROM v_turnos_empleado
WHERE idEmpleado = 100
ORDER BY fecha DESC, horaInicio;

-- H) Evaluaciones de un cliente (usa v_evaluaciones_cliente + ix_evaluacion_idcliente)
SELECT  idEvaluacion,
        fechaEvaluacion,
        calificacionServicio,
        calificacionProducto,
        calificacionAmbiente,
        comentario
FROM v_evaluaciones_cliente
WHERE idCliente = 1
ORDER BY fechaEvaluacion DESC;

-- I) Recetas de productos de cocina (usa v_recetas_producto + ix_receta_idproducto)
SELECT  idReceta,
        idProducto,
        nombre_producto,
        tiempoPreparacion,
        porciones
FROM v_recetas_producto
ORDER BY nombre_producto;
