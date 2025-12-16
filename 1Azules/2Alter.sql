-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== ATRIBUTOS: RESTRICCIONES POR COLUMNA (28 TABLAS) ====================

-- CLIENTE
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_id_pos        CHECK (idCliente > 0);
ALTER TABLE Cliente MODIFY nombre VARCHAR2(100) NOT NULL;
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_tel_format    CHECK (telefono IS NULL OR REGEXP_LIKE(telefono, '^[0-9]{7,15}$'));
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_email_format  CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Cliente ADD CONSTRAINT chk_cliente_total_nonneg  CHECK (totalCompras >= 0);

-- CLIENTE_VIP
ALTER TABLE Cliente_vip ADD CONSTRAINT chk_vip_id_pos        CHECK (idCliente > 0);
ALTER TABLE Cliente_vip ADD CONSTRAINT chk_vip_desc_nonneg   CHECK (descuentoVip >= 0);
ALTER TABLE Cliente_vip ADD CONSTRAINT chk_vip_puntos_nonneg CHECK (puntosAcumulados >= 0);

-- CLIENTE_REGULAR
ALTER TABLE Cliente_regular ADD CONSTRAINT chk_reg_id_pos     CHECK (idCliente > 0);
ALTER TABLE Cliente_regular ADD CONSTRAINT chk_reg_lim_nonneg CHECK (limiteCompras >= 0);
ALTER TABLE Cliente_regular ADD CONSTRAINT chk_reg_desc_nonneg CHECK (descuentoRegular >= 0);

-- RESERVA
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_id_pos        CHECK (idReserva > 0);
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_personas_pos  CHECK (numeroPersonas > 0);
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_estado_len    CHECK (estado IS NULL OR LENGTH(estado) BETWEEN 1 AND 20);
ALTER TABLE Reserva ADD CONSTRAINT chk_reserva_cli_pos       CHECK (idCliente > 0);

-- OBSERVACIONES (atributo [0..*] de Reserva)
ALTER TABLE Observaciones ADD CONSTRAINT chk_obs_id_res_pos  CHECK (idReserva > 0);
ALTER TABLE Observaciones ADD CONSTRAINT chk_obs_texto_nn    CHECK (TRIM(observaciones) IS NOT NULL AND LENGTH(TRIM(observaciones)) > 0);

-- MESA
ALTER TABLE Mesa ADD CONSTRAINT chk_mesa_num_pos             CHECK (numeroMesa > 0);
ALTER TABLE Mesa ADD CONSTRAINT chk_mesa_cap_pos             CHECK (capacidad > 0);
ALTER TABLE Mesa ADD CONSTRAINT chk_mesa_reservada_bin       CHECK (reservada IN (0,1));

-- EMPLEADO
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_id_pos           CHECK (idEmpleado > 0);
ALTER TABLE Empleado MODIFY nombre  VARCHAR2(100) NOT NULL;
ALTER TABLE Empleado MODIFY apellido VARCHAR2(100) NOT NULL;
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_tel_format       CHECK (telefono IS NULL OR REGEXP_LIKE(telefono, '^[0-9]{7,15}$'));
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_mail_format      CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));
ALTER TABLE Empleado ADD CONSTRAINT chk_emp_salario_nonneg   CHECK (salario >= 0);

-- GERENTE (herencia)
ALTER TABLE Gerente ADD CONSTRAINT chk_ger_id_pos            CHECK (idEmpleado > 0);
ALTER TABLE Gerente ADD CONSTRAINT chk_ger_nivel_nonneg      CHECK (nivelAutorizacion >= 0);
ALTER TABLE Gerente ADD CONSTRAINT chk_ger_bono_nonneg       CHECK (bonoPorDesempeno >= 0);

-- MESERO (herencia)
ALTER TABLE Mesero ADD CONSTRAINT chk_mes_id_pos             CHECK (idEmpleado > 0);
ALTER TABLE Mesero ADD CONSTRAINT chk_mes_comision_nonneg    CHECK (comisionVentas >= 0);

-- SEGURIDAD (herencia)
ALTER TABLE Seguridad ADD CONSTRAINT chk_seg_id_pos          CHECK (idEmpleado > 0);

-- ZONAS ASIGNADAS (atributo [0..*] de Seguridad)
ALTER TABLE ZonasAsignadas ADD CONSTRAINT chk_za_emp_pos     CHECK (idEmpleado > 0);
ALTER TABLE ZonasAsignadas ADD CONSTRAINT chk_za_texto_nn    CHECK (TRIM(zonasAsignadas) IS NOT NULL AND LENGTH(TRIM(zonasAsignadas)) > 0);

-- VENTA
ALTER TABLE Venta ADD CONSTRAINT chk_venta_id_pos            CHECK (idVenta > 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_subtotal_nonneg   CHECK (subtotal >= 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_impuesto_nonneg   CHECK (impuesto >= 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_total_nonneg      CHECK (total >= 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_estado_len        CHECK (estado IS NULL OR LENGTH(estado) BETWEEN 1 AND 20);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_cli_pos           CHECK (idCliente > 0);
ALTER TABLE Venta ADD CONSTRAINT chk_venta_emp_pos           CHECK (idEmpleado IS NULL OR idEmpleado > 0);

-- DESCUENTO (atributo [0..*] de Venta; rango 0..1)
ALTER TABLE Descuento ADD CONSTRAINT chk_desc_venta_pos      CHECK (idVenta > 0);
ALTER TABLE Descuento ADD CONSTRAINT chk_desc_valor_01       CHECK (descuento >= 0 AND descuento <= 1);

-- CATEGORIA
ALTER TABLE Categoria ADD CONSTRAINT chk_cat_id_pos          CHECK (idCategoria > 0);
ALTER TABLE Categoria MODIFY nombre VARCHAR2(100) NOT NULL;

-- PRODUCTO
ALTER TABLE Producto ADD CONSTRAINT chk_prod_id_pos          CHECK (idProducto > 0);
ALTER TABLE Producto MODIFY nombre VARCHAR2(100) NOT NULL;
ALTER TABLE Producto ADD CONSTRAINT chk_prod_precio_pos      CHECK (precio > 0);
ALTER TABLE Producto ADD CONSTRAINT chk_prod_disp_bin        CHECK (disponible IN (0,1));
ALTER TABLE Producto ADD CONSTRAINT chk_prod_cat_pos         CHECK (idCategoria > 0);

-- BEBIDA (herencia)
ALTER TABLE Bebida ADD CONSTRAINT chk_beb_id_pos             CHECK (idProducto > 0);
ALTER TABLE Bebida ADD CONSTRAINT chk_beb_tipo_bin           CHECK (tipoAlcohol IN (0,1));
ALTER TABLE Bebida ADD CONSTRAINT chk_beb_grado_01           CHECK (gradoAlcoholico >= 0 AND gradoAlcoholico <= 1);

-- COMIDA (herencia)
ALTER TABLE Comida ADD CONSTRAINT chk_com_id_pos             CHECK (idProducto > 0);
ALTER TABLE Comida ADD CONSTRAINT chk_com_tiempo_nonneg      CHECK (tiempoPreparacion >= 0);
ALTER TABLE Comida ADD CONSTRAINT chk_com_cal_nonneg         CHECK (calorias >= 0);

-- INGREDIENTES (atributo [0..*] de Producto/Comida)
ALTER TABLE Ingredientes ADD CONSTRAINT chk_ing_prod_pos     CHECK (idProducto > 0);
ALTER TABLE Ingredientes ADD CONSTRAINT chk_ing_texto_nn     CHECK (TRIM(ingredientes) IS NOT NULL AND LENGTH(TRIM(ingredientes)) > 0);

-- INVENTARIO
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_id_pos         CHECK (idInventario > 0);
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_prod_pos       CHECK (idProducto > 0);
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_stock_nonneg   CHECK (cantidadStock >= 0);
ALTER TABLE Inventario ADD CONSTRAINT chk_inv_min_nonneg     CHECK (stockMinimo >= 0);

-- PROVEEDOR
ALTER TABLE Proveedor ADD CONSTRAINT chk_prov_id_pos         CHECK (idProveedor > 0);
ALTER TABLE Proveedor MODIFY nombre VARCHAR2(100) NOT NULL;
ALTER TABLE Proveedor ADD CONSTRAINT chk_prov_tel_format     CHECK (telefono IS NULL OR REGEXP_LIKE(telefono, '^[0-9]{7,15}$'));
ALTER TABLE Proveedor ADD CONSTRAINT chk_prov_mail_format    CHECK (email IS NULL OR REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));

-- COMPRA
ALTER TABLE Compra ADD CONSTRAINT chk_compra_id_pos          CHECK (idCompra > 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_cant_nonneg     CHECK (cantidad >= 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_pu_pos          CHECK (precioUnitario > 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_total_nonneg    CHECK (total >= 0);
ALTER TABLE Compra ADD CONSTRAINT chk_compra_prov_pos        CHECK (idProveedor > 0);

-- ENTRADA
ALTER TABLE Entrada ADD CONSTRAINT chk_ent_id_pos            CHECK (idEntrada > 0);
ALTER TABLE Entrada ADD CONSTRAINT chk_ent_cant_nonneg       CHECK (cantidadIngresada >= 0);
ALTER TABLE Entrada ADD CONSTRAINT chk_ent_tipo_len          CHECK (tipo IS NULL OR LENGTH(tipo) BETWEEN 1 AND 20);

-- FACTURA
ALTER TABLE Factura ADD CONSTRAINT chk_fac_num_len           CHECK (LENGTH(numeroFactura) BETWEEN 1 AND 50);
ALTER TABLE Factura ADD CONSTRAINT chk_fac_sub_nonneg        CHECK (subtotal >= 0);
ALTER TABLE Factura ADD CONSTRAINT chk_fac_imp_nonneg        CHECK (impuestos >= 0);
ALTER TABLE Factura ADD CONSTRAINT chk_fac_tot_nonneg        CHECK (total >= 0);

-- METODO_PAGO
ALTER TABLE Metodo_pago ADD CONSTRAINT chk_mp_id_pos         CHECK (idTarjeta > 0);
ALTER TABLE Metodo_pago ADD CONSTRAINT chk_mp_req_bin        CHECK (requiereValidacion IN (0,1));

-- DETALLE VENTA PRODUCTO
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_idv_pos   CHECK (idVenta > 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_idp_pos   CHECK (idProducto > 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_cant_nonneg CHECK (cantidad >= 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_pu_pos    CHECK (precioUnitario > 0);
ALTER TABLE DetalleVentaProducto ADD CONSTRAINT chk_dvp_sub_nonneg CHECK (subtotal >= 0);

-- DETALLE COMPRA PRODUCTO
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_idc_pos   CHECK (idCompra > 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_idp_pos   CHECK (idProducto > 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_cant_nonneg CHECK (cantidad >= 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_pu_pos    CHECK (precioUnitario > 0);
ALTER TABLE DetalleCompraProducto ADD CONSTRAINT chk_dcp_sub_nonneg CHECK (subtotal >= 0);

-- DETALLE VENTA ENTRADA
ALTER TABLE DetalleVentaEntrada ADD CONSTRAINT chk_dve_idv_pos     CHECK (idVenta > 0);
ALTER TABLE DetalleVentaEntrada ADD CONSTRAINT chk_dve_ide_pos     CHECK (idEntrada > 0);
ALTER TABLE DetalleVentaEntrada ADD CONSTRAINT chk_dve_cant_nonneg CHECK (cantidadSalida >= 0);

-- DETALLE COMPRA ENTRADA
ALTER TABLE DetalleCompraEntrada ADD CONSTRAINT chk_dce_idc_pos    CHECK (idCompra > 0);
ALTER TABLE DetalleCompraEntrada ADD CONSTRAINT chk_dce_ide_pos    CHECK (idEntrada > 0);
ALTER TABLE DetalleCompraEntrada ADD CONSTRAINT chk_dce_cant_nonneg CHECK (cantidadEntrada >= 0);

-- ==================== TIPOS ENUMERADOS  =======================

-- Turno (Empleado y Seguridad)
ALTER TABLE Empleado  ADD CONSTRAINT chk_emp_turno          CHECK (turno IN ('Dia','Noche','Mixto'));
ALTER TABLE Seguridad ADD CONSTRAINT chk_seg_turno_enum     CHECK (turno IN ('Dia','Noche','Mixto'));

-- Temperatura (Bebida)
ALTER TABLE Bebida    ADD CONSTRAINT chk_beb_temperatura    CHECK (temperatura IN ('Fria','Caliente','Ambiente'));

-- Tipo de comida (Comida)
ALTER TABLE Comida    ADD CONSTRAINT chk_com_tipo_enum      CHECK (tipoComida IN ('Entrada','Plato Fuerte','Postre','Acompanamiento'));

-- Lugar de trabajo (Mesero)
ALTER TABLE Mesero    ADD CONSTRAINT chk_mes_lugar_enum     CHECK (lugarTrabajo IN ('Mesa','Barra'));

-- Volumen con unidad (Bebida)  ej: "500 ml" o "1.5 litros"
ALTER TABLE Bebida    ADD CONSTRAINT chk_beb_volumen_fmt    CHECK (REGEXP_LIKE(volumen, '^[0-9]+(\.[0-9]+)? (ml|litros)$'));


-- Tablas Ciclo2

-- EVENTO
ALTER TABLE Evento ADD CONSTRAINT chk_evento_id_pos
    CHECK (idEvento > 0);
ALTER TABLE Evento ADD CONSTRAINT chk_evento_nombre_len
    CHECK (LENGTH(TRIM(nombreEvento)) BETWEEN 1 AND 100);
ALTER TABLE Evento ADD CONSTRAINT chk_evento_personas_pos
    CHECK (numeroPersonas > 0);
ALTER TABLE Evento ADD CONSTRAINT chk_evento_estado_len
    CHECK (estado IS NULL OR LENGTH(estado) BETWEEN 1 AND 20);

-- EVALUACION
ALTER TABLE Evaluacion ADD CONSTRAINT chk_eval_id_pos
    CHECK (idEvaluacion > 0);
ALTER TABLE Evaluacion ADD CONSTRAINT chk_eval_serv_0_5
    CHECK (calificacionServicio BETWEEN 0 AND 5);
ALTER TABLE Evaluacion ADD CONSTRAINT chk_eval_prod_0_5
    CHECK (calificacionProducto BETWEEN 0 AND 5);
ALTER TABLE Evaluacion ADD CONSTRAINT chk_eval_amb_0_5
    CHECK (calificacionAmbiente BETWEEN 0 AND 5);
ALTER TABLE Evaluacion ADD CONSTRAINT chk_eval_coment_len
    CHECK (comentario IS NULL OR LENGTH(TRIM(comentario)) > 0);

-- TURNO
ALTER TABLE Turno ADD CONSTRAINT chk_turno_id_pos
    CHECK (idTurno > 0);
ALTER TABLE Turno ADD CONSTRAINT chk_turno_tipo_len
    CHECK (LENGTH(TRIM(tipo)) BETWEEN 1 AND 50);
ALTER TABLE Turno ADD CONSTRAINT chk_turno_hora_ini_0_23
    CHECK (horaInicio BETWEEN 0 AND 23);
ALTER TABLE Turno ADD CONSTRAINT chk_turno_hora_fin_0_23
    CHECK (horaFin BETWEEN 0 AND 23);
ALTER TABLE Turno ADD CONSTRAINT chk_turno_asistio_bin
    CHECK (asistio IN (0,1));
ALTER TABLE Turno ADD CONSTRAINT chk_turno_obs_len
    CHECK (observaciones IS NULL OR LENGTH(TRIM(observaciones)) > 0);

-- RECETA
ALTER TABLE Receta ADD CONSTRAINT chk_receta_id_pos
    CHECK (idReceta > 0);
ALTER TABLE Receta ADD CONSTRAINT chk_receta_ing_len
    CHECK (LENGTH(TRIM(ingredientes)) > 0);
ALTER TABLE Receta ADD CONSTRAINT chk_receta_instr_len
    CHECK (LENGTH(TRIM(instrucciones)) > 0);
ALTER TABLE Receta ADD CONSTRAINT chk_receta_tiempo_nonneg
    CHECK (tiempoPreparacion >= 0);
ALTER TABLE Receta ADD CONSTRAINT chk_receta_porciones_pos
    CHECK (porciones > 0);
