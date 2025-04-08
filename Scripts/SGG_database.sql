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

-- 4. Tabla Clientes
CREATE TABLE Clientes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    TipoClienteId INT NOT NULL,
    PersonaId INT NULL, -- Nullable: Solo si es una persona natural
    EmpresaId INT NULL, -- Nullable: Solo si es una empresa
    CodigoCliente NVARCHAR(50) NOT NULL UNIQUE,
    Estado BIT NOT NULL DEFAULT 1,
    -- Campos de auditoría
    CreadoPor NVARCHAR(50) NOT NULL DEFAULT SYSTEM_USER,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    ModificadoPor NVARCHAR(50),
    FechaModificacion DATETIME,
    FOREIGN KEY (TipoClienteId) REFERENCES TipoCliente(Id),
    FOREIGN KEY (PersonaId) REFERENCES Personas(Id),
    FOREIGN KEY (EmpresaId) REFERENCES Empresas(Id),
    CONSTRAINT CHK_Cliente_PersonaEmpresa CHECK (
        (PersonaId IS NOT NULL AND EmpresaId IS NULL) OR 
        (PersonaId IS NULL AND EmpresaId IS NOT NULL)
    )
);
GO

-- 5. Tabla Usuarios
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
    FOREIGN KEY (ClienteId) REFERENCES Clientes(Id)
);
GO

-- 6. Tabla Roles
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

-- 7. Tabla Permisos
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

-- 8. Tabla RolesPermisos (relación muchos a muchos entre Roles y Permisos)
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

-- 9. Tabla UsuarioRoles (relación muchos a muchos entre Usuarios y Roles)
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

-- 10. Tabla Productos
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

-- 11. Tabla Facturas
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
    FOREIGN KEY (ClienteId) REFERENCES Clientes(Id)
);
GO

-- 12. Tabla DetalleFactura
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

-- 13. Tabla Pagos
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