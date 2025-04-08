
USE SistemaFacturacion;
GO

-- TIPOS DE CLIENTE
INSERT INTO TipoCliente (NombreTipo) VALUES 
('Persona Natural'), 
('Empresa');

-- PERSONAS
INSERT INTO Personas (Nombre, Apellido, FechaNacimiento, TipoDocumento, NumeroDocumento, Direccion, Telefono, Email)
VALUES 
('Carlos', 'Gómez', '1990-05-15', 'CC', '1234567890', 'Cra 45 #123', '3001234567', 'carlos@gmail.com'),
('Ana', 'Martínez', '1985-10-20', 'CC', '9876543210', 'Calle 50 #10-20', '3017654321', 'ana@hotmail.com');

-- EMPRESAS
INSERT INTO Empresas (RazonSocial, RUC, DireccionFiscal, Telefono, Email)
VALUES 
('Soluciones S.A.S.', '8001234567', 'Av. El Poblado #300', '6044440000', 'contacto@soluciones.com'),
('TechNova Ltda.', '9007654321', 'Cra 80 #30-15', '6045559999', 'info@technova.com');

-- CLIENTES
INSERT INTO Clientes (TipoClienteId, PersonaId, EmpresaId, CodigoCliente)
VALUES
(1, 1, NULL, 'CLI-001'),
(1, 2, NULL, 'CLI-002'),
(2, NULL, 1, 'CLI-003'),
(2, NULL, 2, 'CLI-004');

-- USUARIOS
INSERT INTO Usuarios (ClienteId, Username, PasswordHash)
VALUES
(1, 'cgomez', 'hash123'),
(2, 'amartinez', 'hash456'),
(3, 'admin_sol', 'hash789'),
(4, 'admin_tech', 'hash000');

-- ROLES
INSERT INTO Roles (NombreRol) VALUES 
('Administrador'), 
('Vendedor');

-- PERMISOS
INSERT INTO Permisos (NombrePermiso) VALUES 
('Crear Factura'), 
('Ver Reportes'), 
('Gestionar Usuarios');

-- ROLES - PERMISOS
INSERT INTO RolesPermisos (RolId, PermisoId) VALUES 
(1, 1), 
(1, 2), 
(1, 3), 
(2, 1), 
(2, 2);

-- USUARIOS - ROLES
INSERT INTO UsuarioRoles (UsuarioId, RolId) VALUES 
(1, 2), 
(2, 2), 
(3, 1), 
(4, 1);

-- PRODUCTOS
INSERT INTO Productos (Nombre, Precio, Stock, Descripcion) VALUES
('Mouse Inalámbrico', 45000, 100, 'Mouse óptico con USB'),
('Teclado Mecánico', 150000, 50, 'Teclado gamer retroiluminado'),
('Monitor 24"', 700000, 30, 'Monitor Full HD');

-- FACTURAS
INSERT INTO Facturas (ClienteId, Total, Estado) VALUES
(1, 49500, 'Pagado'),
(3, 850000, 'Pendiente');

-- DETALLE FACTURA
INSERT INTO DetalleFactura (FacturaId, ProductoId, Cantidad, PrecioUnitario)
VALUES
(1, 1, 1, 45000),
(2, 3, 1, 700000),
(2, 2, 1, 150000);

-- PAGOS
INSERT INTO Pagos (FacturaId, MontoPagado, MetodoPago, Referencia)
VALUES
(1, 49500, 'Transferencia', 'REF12345');
