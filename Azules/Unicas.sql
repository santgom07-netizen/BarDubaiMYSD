-- ================================ PROYECTO BARDUBAI =======================================
-- ==================== SANTIAGO ANDRES GOMEZ ROJAS Y ANGIE TATIANA CIRO ====================
-- ==================== UNICAS: DEFINICION DE CLAVES UNICAS ====================

-- Cliente
ALTER TABLE Cliente  ADD CONSTRAINT uq_cliente_email    UNIQUE (email);
ALTER TABLE Cliente  ADD CONSTRAINT uq_cliente_telefono UNIQUE (telefono);

-- Empleado
ALTER TABLE Empleado ADD CONSTRAINT uq_empleado_email    UNIQUE (email);
ALTER TABLE Empleado ADD CONSTRAINT uq_empleado_telefono UNIQUE (telefono);

-- Proveedor
ALTER TABLE Proveedor ADD CONSTRAINT uq_proveedor_telefono UNIQUE (telefono);
