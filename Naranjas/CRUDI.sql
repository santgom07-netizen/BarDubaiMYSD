-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== CRUDI =====================
--------------------------------------------------
-- 1) EMPLEADO
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_empleado AS

  PROCEDURE crear_empleado(
    p_id, p_nombre, p_apellido, p_telefono, p_email, p_salario, p_turno
  ) IS
  BEGIN
    INSERT INTO Empleado(idEmpleado,nombre,apellido,telefono,email,
                         fechaIngreso,salario,turno)
    VALUES(p_id,p_nombre,p_apellido,p_telefono,p_email,
           SYSDATE,p_salario,p_turno);
  END crear_empleado;

  PROCEDURE asignar_mesero(
    p_id, p_zona, p_comision, p_lugar, p_horario
  ) IS
  BEGIN
    INSERT INTO Mesero(idEmpleado,zonaAsignada,comisionVentas,
                       lugarTrabajo,horarioTurno)
    VALUES(p_id,p_zona,p_comision,p_lugar,p_horario);
  END asignar_mesero;

  FUNCTION obtener_empleado(
    p_id IN Empleado.idEmpleado%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT e.idEmpleado,e.nombre,e.apellido,e.telefono,e.email,
             e.salario,e.turno,
             m.zonaAsignada,m.comisionVentas,m.lugarTrabajo,m.horarioTurno
      FROM Empleado e
      LEFT JOIN Mesero m ON m.idEmpleado = e.idEmpleado
      WHERE e.idEmpleado = p_id;
    RETURN v_cur;
  END obtener_empleado;

  PROCEDURE actualizar_empleado(
    p_id, p_telefono, p_email, p_salario, p_turno
  ) IS
  BEGIN
    UPDATE Empleado
       SET telefono = p_telefono,
           email    = p_email,
           salario  = p_salario,
           turno    = p_turno
     WHERE idEmpleado = p_id;
  END actualizar_empleado;

  PROCEDURE eliminar_empleado(
    p_id IN Empleado.idEmpleado%TYPE
  ) IS
  BEGIN
    DELETE FROM Mesero    WHERE idEmpleado = p_id;
    DELETE FROM Gerente   WHERE idEmpleado = p_id;
    DELETE FROM Seguridad WHERE idEmpleado = p_id;
    DELETE FROM Empleado  WHERE idEmpleado = p_id;
  END eliminar_empleado;

END pkg_empleado;
/
--------------------------------------------------
-- 2) CLIENTE
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_cliente AS

  PROCEDURE crear_cliente(
    p_id,p_nombre,p_telefono,p_email
  ) IS
  BEGIN
    INSERT INTO Cliente(idCliente,nombre,telefono,email,fechaRegistro,totalCompras)
    VALUES(p_id,p_nombre,p_telefono,p_email,SYSDATE,0);
  END crear_cliente;

  FUNCTION obtener_cliente(
    p_id IN Cliente.idCliente%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Cliente
      WHERE idCliente = p_id;
    RETURN v_cur;
  END obtener_cliente;

  PROCEDURE actualizar_cliente(
    p_id,p_telefono,p_email
  ) IS
  BEGIN
    UPDATE Cliente
       SET telefono = p_telefono,
           email    = p_email
     WHERE idCliente = p_id;
  END actualizar_cliente;

  PROCEDURE eliminar_cliente(
    p_id IN Cliente.idCliente%TYPE
  ) IS
  BEGIN
    DELETE FROM Cliente_vip     WHERE idCliente = p_id;
    DELETE FROM Cliente_regular WHERE idCliente = p_id;
    DELETE FROM Reserva         WHERE idCliente = p_id;
    DELETE FROM Venta           WHERE idCliente = p_id;
    DELETE FROM Cliente         WHERE idCliente = p_id;
  END eliminar_cliente;

END pkg_cliente;
/
--------------------------------------------------
-- 3) PRODUCTO
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_producto AS

  PROCEDURE crear_producto(
    p_id,p_nombre,p_descripcion,p_precio,p_disponible,p_idCategoria
  ) IS
  BEGIN
    INSERT INTO Producto(idProducto,nombre,descripcion,precio,disponible,idCategoria)
    VALUES(p_id,p_nombre,p_descripcion,p_precio,p_disponible,p_idCategoria);
  END crear_producto;

  FUNCTION obtener_producto(
    p_id IN Producto.idProducto%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Producto
      WHERE idProducto = p_id;
    RETURN v_cur;
  END obtener_producto;

  PROCEDURE actualizar_producto(
    p_id,p_nombre,p_descripcion,p_precio,p_disponible
  ) IS
  BEGIN
    UPDATE Producto
       SET nombre      = p_nombre,
           descripcion = p_descripcion,
           precio      = p_precio,
           disponible  = p_disponible
     WHERE idProducto = p_id;
  END actualizar_producto;

  PROCEDURE eliminar_producto(
    p_id IN Producto.idProducto%TYPE
  ) IS
  BEGIN
    DELETE FROM Bebida        WHERE idProducto = p_id;
    DELETE FROM Comida        WHERE idProducto = p_id;
    DELETE FROM Ingredientes  WHERE idProducto = p_id;
    DELETE FROM Inventario    WHERE idProducto = p_id;
    DELETE FROM DetalleVentaProducto  WHERE idProducto = p_id;
    DELETE FROM DetalleCompraProducto WHERE idProducto = p_id;
    DELETE FROM Producto      WHERE idProducto = p_id;
  END eliminar_producto;

END pkg_producto;
/
--------------------------------------------------
-- 4) CATEGORIA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_categoria AS

  PROCEDURE crear_categoria(
    p_id,p_nombre,p_descripcion
  ) IS
  BEGIN
    INSERT INTO Categoria(idCategoria,nombre,descripcion)
    VALUES(p_id,p_nombre,p_descripcion);
  END crear_categoria;

  FUNCTION obtener_categoria(
    p_id IN Categoria.idCategoria%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Categoria
      WHERE idCategoria = p_id;
    RETURN v_cur;
  END obtener_categoria;

  PROCEDURE actualizar_categoria(
    p_id,p_nombre,p_descripcion
  ) IS
  BEGIN
    UPDATE Categoria
       SET nombre      = p_nombre,
           descripcion = p_descripcion
     WHERE idCategoria = p_id;
  END actualizar_categoria;

  PROCEDURE eliminar_categoria(
    p_id IN Categoria.idCategoria%TYPE
  ) IS
  BEGIN
    DELETE FROM Producto
     WHERE idCategoria = p_id;
    DELETE FROM Categoria
     WHERE idCategoria = p_id;
  END eliminar_categoria;

END pkg_categoria;
/
--------------------------------------------------
-- 5) COMPRA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_compra AS

  PROCEDURE crear_compra(
    p_idCompra,p_fechaCompra,p_cantidad,p_precioUnit,p_total,p_idProveedor
  ) IS
  BEGIN
    INSERT INTO Compra(idCompra,fechaCompra,cantidad,precioUnitario,total,idProveedor)
    VALUES(p_idCompra,p_fechaCompra,p_cantidad,p_precioUnit,p_total,p_idProveedor);
  END crear_compra;

  FUNCTION obtener_compra(
    p_idCompra IN Compra.idCompra%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Compra
      WHERE idCompra = p_idCompra;
    RETURN v_cur;
  END obtener_compra;

  PROCEDURE actualizar_compra(
    p_idCompra,p_cantidad,p_precioUnit,p_total
  ) IS
  BEGIN
    UPDATE Compra
       SET cantidad      = p_cantidad,
           precioUnitario = p_precioUnit,
           total          = p_total
     WHERE idCompra = p_idCompra;
  END actualizar_compra;

  PROCEDURE eliminar_compra(
    p_idCompra IN Compra.idCompra%TYPE
  ) IS
  BEGIN
    DELETE FROM DetalleCompraProducto WHERE idCompra = p_idCompra;
    DELETE FROM DetalleCompraEntrada  WHERE idCompra = p_idCompra;
    DELETE FROM Compra                WHERE idCompra = p_idCompra;
  END eliminar_compra;

END pkg_compra;
/
--------------------------------------------------
-- 6) VENTA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_venta AS

  PROCEDURE crear_venta(
    p_idVenta,p_fecha,p_subtotal,p_impuesto,p_total,
    p_estado,p_idCliente,p_idEmpleado
  ) IS
  BEGIN
    INSERT INTO Venta(idVenta,fecha,hora,subtotal,impuesto,total,
                      estado,idCliente,idEmpleado)
    VALUES(p_idVenta,p_fecha,SYSTIMESTAMP,p_subtotal,p_impuesto,
           p_total,p_estado,p_idCliente,p_idEmpleado);
  END crear_venta;

  FUNCTION obtener_venta(
    p_idVenta IN Venta.idVenta%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Venta
      WHERE idVenta = p_idVenta;
    RETURN v_cur;
  END obtener_venta;

  PROCEDURE actualizar_venta(
    p_idVenta,p_estado
  ) IS
  BEGIN
    UPDATE Venta
       SET estado = p_estado
     WHERE idVenta = p_idVenta;
  END actualizar_venta;

  PROCEDURE eliminar_venta(
    p_idVenta IN Venta.idVenta%TYPE
  ) IS
  BEGIN
    DELETE FROM DetalleVentaProducto WHERE idVenta = p_idVenta;
    DELETE FROM DetalleVentaEntrada  WHERE idVenta = p_idVenta;
    DELETE FROM Descuento            WHERE idVenta = p_idVenta;
    DELETE FROM Venta                WHERE idVenta = p_idVenta;
  END eliminar_venta;

END pkg_venta;
/
--------------------------------------------------
-- 7) FACTURA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_factura AS

  PROCEDURE crear_factura(
    p_numero,p_fecha,p_subtotal,p_impuestos,p_total,p_metodoPago
  ) IS
  BEGIN
    INSERT INTO Factura(numeroFactura,fecha,subtotal,impuestos,total,metodoPago)
    VALUES(p_numero,p_fecha,p_subtotal,p_impuestos,p_total,p_metodoPago);
  END crear_factura;

  FUNCTION obtener_factura(
    p_numero IN Factura.numeroFactura%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Factura
      WHERE numeroFactura = p_numero;
    RETURN v_cur;
  END obtener_factura;

  PROCEDURE actualizar_factura(
    p_numero,p_subtotal,p_impuestos,p_total,p_metodoPago
  ) IS
  BEGIN
    UPDATE Factura
       SET subtotal   = p_subtotal,
           impuestos  = p_impuestos,
           total      = p_total,
           metodoPago = p_metodoPago
     WHERE numeroFactura = p_numero;
  END actualizar_factura;

  PROCEDURE eliminar_factura(
    p_numero IN Factura.numeroFactura%TYPE
  ) IS
  BEGIN
    DELETE FROM Factura
     WHERE numeroFactura = p_numero;
  END eliminar_factura;

END pkg_factura;
/
--------------------------------------------------
-- 8) ENTRADA
--------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_entrada AS

  PROCEDURE crear_entrada(
    p_idEntrada,p_fechaEntrada,p_cantidadIngresada,p_tipo,p_fechaVencimiento
  ) IS
  BEGIN
    INSERT INTO Entrada(idEntrada,fechaEntrada,cantidadIngresada,tipo,fechaVencimiento)
    VALUES(p_idEntrada,p_fechaEntrada,p_cantidadIngresada,p_tipo,p_fechaVencimiento);
  END crear_entrada;

  FUNCTION obtener_entrada(
    p_idEntrada IN Entrada.idEntrada%TYPE
  ) RETURN SYS_REFCURSOR IS
    v_cur SYS_REFCURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Entrada
      WHERE idEntrada = p_idEntrada;
    RETURN v_cur;
  END obtener_entrada;

  PROCEDURE actualizar_entrada(
    p_idEntrada,p_cantidadIngresada,p_fechaVencimiento
  ) IS
  BEGIN
    UPDATE Entrada
       SET cantidadIngresada = p_cantidadIngresada,
           fechaVencimiento  = p_fechaVencimiento
     WHERE idEntrada = p_idEntrada;
  END actualizar_entrada;

  PROCEDURE eliminar_entrada(
    p_idEntrada IN Entrada.idEntrada%TYPE
  ) IS
  BEGIN
    DELETE FROM DetalleCompraEntrada WHERE idEntrada = p_idEntrada;
    DELETE FROM DetalleVentaEntrada  WHERE idEntrada = p_idEntrada;
    DELETE FROM Entrada              WHERE idEntrada = p_idEntrada;
  END eliminar_entrada;

END pkg_entrada;
/

