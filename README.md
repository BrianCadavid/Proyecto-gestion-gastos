
# Sistema de Gestión de Gastos - Taller de Base de Datos

Este proyecto implementa un sistema básico para registrar y controlar los gastos personales de los usuarios. Utiliza un modelo de datos relacional y normalizado, diseñado para ser claro, escalable y funcional.

## 📁 Estructura del Proyecto

```
/proyecto-gestion-gastos
├── scripts
│   ├── SGG_database_gastos.sql   # Script para crear la base de datos y sus tablas
│   └── seed_SGG_gastos.sql         # Script con datos semilla para probar la estructura
└── README.md                        # Documentación del proyecto
```

---

## 📌 Requisitos

- SQL Server (Management Studio o compatible)

---

## ⚙️ Ejecución de Scripts

1. **Crear Base de Datos:**

   Ejecuta el archivo `SGG_database_gastos.sql` en tu entorno SQL Server. Este script:

   - Crea la base de datos `SistemaGastos`
   - Genera las tablas necesarias con sus claves primarias y foráneas

2. **Insertar Datos de Prueba:**

   Luego, ejecuta el archivo `seed_SGG_gastos.sql`. Este incluye:

   - Usuarios, monedas, categorías
   - Gastos y presupuestos relacionados

---

## 🧱 Tablas Principales

- **Usuarios**: Personas que registran sus gastos y presupuestos.
- **Monedas**: Apoya el uso de diferentes divisas.
- **Categorías**: Clasificación de los gastos.
- **Gastos**: Registro detallado de los gastos realizados por los usuarios.
- **Presupuestos**: Límite asignado a cada categoría durante un periodo.

---

## ✍️ Autor

- NombreS: *[Brian Cadavid]*
           *[Cristian Lopez]*


