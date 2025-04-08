
# Sistema de Facturación - Taller de Base de Datos

Este proyecto implementa un sistema básico de facturación, diseñado para gestionar clientes, usuarios, productos, facturas y pagos. Se utilizaron principios de normalización para garantizar integridad y eficiencia en la base de datos.

## 📁 Estructura del Proyecto

```
/proyecto-sistema-facturacion
├── scripts
│   ├── create_database.sql   # Script para crear la base de datos y sus tablas
│   └── seed_data.sql         # Script con datos semilla para probar la estructura
└── README.md                 # Documentación del proyecto
```

---

## 📌 Requisitos

- SQL Server (Management Studio o compatible)
- Permisos para ejecutar scripts T-SQL

---

## ⚙️ Ejecución de Scripts

1. **Crear Base de Datos:**

   Abre el archivo `create_database.sql` y ejecútalo en SQL Server. Este script:

   - Crea la base de datos `SistemaFacturacion`
   - Genera todas las tablas necesarias
   - Establece claves primarias y foráneas

2. **Insertar Datos de Prueba:**

   Luego, ejecuta el script `seed_data.sql`. Este incluye:

   - Tipos de cliente
   - Personas y empresas
   - Clientes, usuarios, roles y permisos
   - Productos, facturas, detalles y pagos

---

## 🧱 Tablas Principales

- **Personas / Empresas**: Representan personas naturales o jurídicas.
- **Clientes**: Agrupa la relación con personas o empresas.
- **Usuarios**: Cuentas asociadas a los clientes.
- **Roles y Permisos**: Sistema de autenticación y autorización.
- **Productos / Facturas / Pagos**: Gestión comercial.

---

## ✍️ Autor

- Nombre: *[Tu nombre completo aquí]*
- Curso: Taller de Bases de Datos
- Institución: Pascual Bravo

---

## 🎥 Video Individual

No olvides grabar tu video explicando el modelo y la ejecución del script, como indica el taller.
