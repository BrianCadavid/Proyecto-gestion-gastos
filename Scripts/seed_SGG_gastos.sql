
USE SistemaGastos;
GO

-- Monedas
INSERT INTO Monedas (Codigo, Nombre, Simbolo) VALUES
('COP', 'Peso colombiano', '$'),
('USD', 'Dólar estadounidense', '$'),
('EUR', 'Euro', '€'),
('GBP', 'Libra esterlina', '£');

-- Categorías
INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Comida', 'Alimentos y restaurantes'),
('Transporte', 'Transporte público y gasolina'),
('Entretenimiento', 'Cine, conciertos, etc.'),
('Educación', 'Libros, cursos y matrículas');

-- Usuarios
INSERT INTO Usuarios (Nombre, Email, PasswordHash) VALUES
('Laura Gómez', 'laura@example.com', 'hashedpw1'),
('Juan Pérez', 'juan@example.com', 'hashedpw2');

-- Gastos
INSERT INTO Gastos (IdUsuario, IdCategoria, IdMoneda, Monto, Fecha, Descripcion) VALUES
(1, 1, 1, 32000, '2025-04-01', 'Almuerzo en restaurante'),
(1, 2, 1, 15000, '2025-04-02', 'Pasaje bus'),
(2, 3, 2, 50000, '2025-04-03', 'Entradas cine');

-- Presupuestos
INSERT INTO Presupuestos (IdUsuario, IdCategoria, IdMoneda, Limite, FechaInicio, FechaFin) VALUES
(1, 1, 1, 300000, '2025-04-01', '2025-04-30'),
(2, 3, 2, 200000, '2025-04-01', '2025-04-30');
