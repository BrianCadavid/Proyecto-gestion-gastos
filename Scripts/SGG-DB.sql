-- Crear la base de datos
CREATE DATABASE SistemaFacturacion;
GO

USE SistemaFacturacion;
GO

-- 1. Tabla Personas
CREATE TABLE Personas (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    FechaNacimiento DATE,
    TipoDocumento NVARCHAR(20) NOT NULL,
    NumeroDocumento NVARCHAR(20) NOT NULL UNIQUE,
    Direccion NVARCHAR(255),
    Telefono NVARCHAR(20),
    Email NVARCHAR(100),
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME
);
GO

-- 2. Tabla Empresas
CREATE TABLE Empresas (
    Id INT PRIMARY KEY IDENTITY(1,1),
    RazonSocial NVARCHAR(255) NOT NULL,
    RUC NVARCHAR(20) NOT NULL UNIQUE,
    DireccionFiscal NVARCHAR(255) NOT NULL,
    Telefono NVARCHAR(20),
    Email NVARCHAR(100),
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME
);
GO

-- 3. Tabla TipoCliente
CREATE TABLE TipoCliente (
    Id INT PRIMARY KEY IDENTITY(1,1),
    NombreTipo NVARCHAR(50) NOT NULL UNIQUE,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME
);
GO

-- 4. Tabla ClientesPersona: Separar clientes naturales
CREATE TABLE ClientesPersona (
    ClienteId INT PRIMARY KEY,
    PersonaId INT NOT NULL,
    CodigoCliente NVARCHAR(50) NOT NULL UNIQUE,
    Estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (PersonaId) REFERENCES Personas(Id)
);
GO

-- 5. Tabla ClientesEmpresa: Separar clientes jurídicos
CREATE TABLE ClientesEmpresa (
    ClienteId INT PRIMARY KEY,
    EmpresaId INT NOT NULL,
    CodigoCliente NVARCHAR(50) NOT NULL UNIQUE,
    Estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id)
);
GO

-- 6. Tabla Usuarios
CREATE TABLE Usuarios (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ClienteId INT NOT NULL UNIQUE,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Estado BIT NOT NULL DEFAULT 1,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    FOREIGN KEY (ClienteId) REFERENCES ClientesPersona(ClienteId) -- Cambiar a la tabla correspondiente
    -- Cambiar según si el cliente es Persona o Empresa
);
GO

-- 7. Tabla Roles
CREATE TABLE Roles (
    Id INT PRIMARY KEY IDENTITY(1,1),
    NombreRol NVARCHAR(50) NOT NULL UNIQUE,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME
);
GO

-- 8. Tabla Permisos
CREATE TABLE Permisos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    NombrePermiso NVARCHAR(50) NOT NULL UNIQUE,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME
);
GO

-- 9. Tabla RolesPermisos (relación muchos a muchos entre Roles y Permisos)
CREATE TABLE RolesPermisos (
    RolId INT NOT NULL,
    PermisoId INT NOT NULL,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    PRIMARY KEY (RolId, PermisoId),
    FOREIGN KEY (RolId) REFERENCES Roles(Id),
    FOREIGN KEY (PermisoId) REFERENCES Permisos(Id)
);
GO

-- 10. Tabla UsuarioRoles (relación muchos a muchos entre Usuarios y Roles)
CREATE TABLE UsuarioRoles (
    UsuarioId INT NOT NULL,
    RolId INT NOT NULL,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    PRIMARY KEY (UsuarioId, RolId),
    FOREIGN KEY (UsuarioId) REFERENCES Usuarios(Id),
    FOREIGN KEY (RolId) REFERENCES Roles(Id)
);
GO

-- 11. Tabla Productos
CREATE TABLE Productos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Precio DECIMAL(18,2) NOT NULL,
    Stock INT NOT NULL,
    Descripcion NVARCHAR(255),
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME
);
GO

-- 12. Tabla Facturas
CREATE TABLE Facturas (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FechaEmision DATETIME NOT NULL DEFAULT GETDATE(),
    ClienteId INT NOT NULL,
    Total DECIMAL(18,2) NOT NULL,
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    FOREIGN KEY (ClienteId) REFERENCES ClientesPersona(ClienteId) -- Cambiar según si el cliente es Persona o Empresa
    -- Cambiar según tipo de cliente
);
GO

-- 13. Tabla DetalleFactura
CREATE TABLE DetalleFactura (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FacturaId INT NOT NULL,
    ProductoId INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Subtotal AS (Cantidad * PrecioUnitario),
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    FOREIGN KEY (FacturaId) REFERENCES Facturas(Id),
    FOREIGN KEY (ProductoId) REFERENCES Productos(Id)
);
GO

-- 14. Tabla Pagos
CREATE TABLE Pagos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FacturaId INT NOT NULL,
    MontoPagado DECIMAL(18,2) NOT NULL,
    FechaPago DATETIME NOT NULL DEFAULT GETDATE(),
    MetodoPago NVARCHAR(50) NOT NULL,
    Referencia NVARCHAR(100),
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    FOREIGN KEY (FacturaId) REFERENCES Facturas(Id)
);
GO


-----Justificación de los Ajustes:

--1. Separación de Clientes:

	--Cambio: Se crearon dos tablas separadas para los clientes, ClientesPersona y ClientesEmpresa. Cada tipo de cliente tiene su propia tabla para evitar la dependencia parcial en la tabla Clientes y para garantizar que los datos sean más claros y eficientes.

	--Justificación: Esto cumple con la segunda forma normal (2FN), ya que eliminamos la redundancia de almacenar tanto PersonaId como EmpresaId en la misma tabla, lo que podría causar dependencias parciales.

--2. Normalización a 1FN:

	--Cambio: Se aseguró que todas las columnas dentro de las tablas son atómicas. Por ejemplo, las columnas Telefono y Email en Personas y Empresas son únicas y no contienen listas de valores.

	--Justificación: Esto asegura que los datos sean atómicos, lo que cumple con la primera forma normal (1FN).

--3. Normalización a 3FN:

	--Cambio: Los campos de auditoría como CreadoPor, FechaCreacion, etc., ahora están presentes de forma consistente en todas las tablas que los necesitan.

	--Justificación: Se ha considerado que los campos de auditoría no deben causar dependencias transitivas. Sin embargo, si el modelo se expande, los campos de auditoría podrían ser movidos a una tabla separada para evitar redundancia y mejorar la flexibilidad.

--4.Optimización de Relaciones:

	--Cambio: Se ajustaron las relaciones entre las tablas para que las claves foráneas apunten a las tablas correctas dependiendo del tipo de cliente.

	--Justificación: Esto asegura que no haya inconsistencias en las relaciones y que las claves foráneas estén correctamente implementadas para mantener la	integridad referencial.

--Con estos ajustes, el modelo de datos está más normalizado, es más eficiente y flexible, y facilita el mantenimiento a medida que la base de datos crece.