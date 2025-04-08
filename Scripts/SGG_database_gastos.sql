
-- Crear base de datos
CREATE DATABASE SistemaGastos;
GO
USE SistemaGastos;
GO

-- Tabla Usuarios
CREATE TABLE Usuarios (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(MAX) NOT NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Tabla Categorías
CREATE TABLE Categorias (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255)
);
GO

-- Tabla Monedas
CREATE TABLE Monedas (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Codigo NVARCHAR(10) NOT NULL UNIQUE,
    Nombre NVARCHAR(50) NOT NULL,
    Simbolo NVARCHAR(10) NOT NULL
);
GO

-- Tabla Gastos
CREATE TABLE Gastos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdUsuario INT NOT NULL,
    IdCategoria INT NOT NULL,
    IdMoneda INT NOT NULL,
    Monto DECIMAL(18,2) NOT NULL,
    Fecha DATETIME NOT NULL,
    Descripcion NVARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id),
    FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id),
    FOREIGN KEY (IdMoneda) REFERENCES Monedas(Id)
);
GO

-- Tabla Presupuestos
CREATE TABLE Presupuestos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdUsuario INT NOT NULL,
    IdCategoria INT NOT NULL,
    IdMoneda INT NOT NULL,
    Limite DECIMAL(18,2) NOT NULL,
    FechaInicio DATETIME NOT NULL,
    FechaFin DATETIME NOT NULL,
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(Id),
    FOREIGN KEY (IdCategoria) REFERENCES Categorias(Id),
    FOREIGN KEY (IdMoneda) REFERENCES Monedas(Id)
);
GO
