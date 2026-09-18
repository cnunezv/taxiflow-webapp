# 🚕 TaxiFlow

<p align="center">
  <img src="https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=openjdk" alt="Java 17">
  <img src="https://img.shields.io/badge/Jakarta%20EE-8-blue?style=for-the-badge" alt="Jakarta EE">
  <img src="https://img.shields.io/badge/MySQL-8.3-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Maven-Build-C71A36?style=for-the-badge&logo=apachemaven" alt="Maven">
  <img src="https://img.shields.io/badge/Status-En%20desarrollo-yellow?style=for-the-badge" alt="Status">
</p>

<p align="center">
  <strong>🚖 Una plataforma web para gestionar servicios de taxi de forma simple, organizada y eficiente.</strong>
</p>

<p align="center">
  <a href="#-características">Características</a> •
  <a href="#-arquitectura">Arquitectura</a> •
  <a href="#-tecnologías">Tecnologías</a> •
  <a href="#-instalación">Instalación</a> •
  <a href="#-autor">Autor</a>
</p>

---

## 🚖 ¿Qué es TaxiFlow?

**TaxiFlow** es una aplicación web desarrollada para facilitar la administración de servicios de transporte tipo taxi.

La plataforma permite gestionar usuarios, carreras, autenticación y reportes desde un mismo entorno, utilizando una arquitectura organizada por capas y una base de datos MySQL.

> 💡 **Objetivo:** centralizar la información y facilitar la gestión de las operaciones relacionadas con el servicio de taxi.

---

## 🎓 Datos de la entrega

| Dato                 | Información                                        |
| -------------------- | -------------------------------------------------- |
| **Estudiante**       | Carlos Andrés Núñez Vargas                         |
| **Asignatura**       | Desarrollo Web — Unidad 1                           |
| **Actividad**        | Servlets/JSP: introducción a la segunda generación del desarrollo de aplicaciones web |
| **Ejercicio asignado** | N.º 19 — CarreraTaxi                             |
| **Entidades**        | `Usuario` (entidad común) y `CarreraTaxi` (ejercicio 19) |
| **Repositorio**      | https://github.com/cnunezv/taxiflow-webapp         |
| **Video de sustentación** | _(pendiente: pegar aquí el enlace de YouTube o Vimeo)_ |
| **Aplicación desplegada** | _(pendiente: pegar aquí la URL pública)_        |

---

## ✨ Características

| Módulo                | Descripción                                     |
| --------------------- | ----------------------------------------------- |
| 🔐 **Autenticación**  | Inicio de sesión y validación de usuarios       |
| 👤 **Usuarios**       | Registro, consulta, actualización y eliminación |
| 🚕 **Carreras**       | Gestión de servicios de taxi                    |
| 🔑 **Recuperación**   | Recuperación de acceso mediante contraseña      |
| 📊 **Reportes**       | Consulta y generación de información            |
| 🗄️ **Base de datos** | Persistencia de información mediante MySQL      |

---

## 🖥️ Vista general

```text
                    🚕 TAXIFLOW
                         │
              ┌──────────┴──────────┐
              │                     │
          👤 Usuarios            🔐 Login
              │                     │
              └──────────┬──────────┘
                         │
                         ▼
                 🎛️ CONTROLADORES
                         │
                         ▼
                    📦 MODELOS
                         │
                         ▼
                    🗃️ DAO
                         │
                         ▼
                    🐬 MySQL
                         │
                         ▼
                    📊 REPORTES
```

---

## 🏗️ Arquitectura

TaxiFlow utiliza una arquitectura organizada por capas para separar responsabilidades y facilitar el mantenimiento del sistema.

```text
┌─────────────────────────────────┐
│          🌐 INTERFAZ WEB        │
│        JSP / HTML / CSS         │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│       🎮 CONTROLADORES          │
│            Servlets             │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│          📦 MODELOS             │
│      Usuario / CarreraTaxi      │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│             🗃️ DAO              │
│       Acceso a los datos        │
└────────────────┬────────────────┘
                 │
                 ▼
┌─────────────────────────────────┐
│          🐬 MySQL               │
│          Base de datos          │
└─────────────────────────────────┘
```

### 📂 Estructura principal

```text
taxiflow-webapp/
│
├── 📁 src/
│   └── 📁 main/
│       ├── 📁 java/
│       │   └── 📁 com/taxiflow/webapp/
│       │       ├── 🎮 controlador/
│       │       ├── 🗃️ dao/
│       │       ├── 📦 modelo/
│       │       ├── ⚙️ resources/
│       │       └── 🛠️ util/
│       │
│       └── 📁 webapp/
│           ├── 📁 META-INF/
│           ├── 📁 WEB-INF/
│           ├── 📁 web/
│           └── index.jsp
│
├── 📁 db/
│   └── 🗃️ taxiflow_db.sql   ← script de creación + datos iniciales
│
├── 📄 pom.xml
├── 📄 nb-configuration.xml
└── 📄 README.md
```

---

## 🛠️ Tecnologías

### Backend

* ☕ **Java 17**
* Jakarta EE 8
* Servlets
* JSP
* Maven

### Base de datos

* 🐬 **MySQL 8.3**
* MySQL Connector/J

### Frontend

* 🌐 HTML
* 🎨 CSS
* ⚡ JavaScript
* JSP

### Arquitectura

* MVC / arquitectura por capas
* DAO
* CRUD
* Servlets

---

## 🚀 Instalación

### 1️⃣ Clonar el proyecto

```bash
git clone https://github.com/cnunezv/taxiflow-webapp.git

cd taxiflow-webapp
```

### 2️⃣ Configurar MySQL

Ejecutar el script incluido en el repositorio. Crea la base de datos `taxiflow_db`,
las tablas `usuarios` y `carreras_taxi`, y carga los datos iniciales de prueba:

```bash
mysql -u root -p < db/taxiflow_db.sql
```

> También puede abrirse `db/taxiflow_db.sql` en MySQL Workbench y ejecutarlo completo.
> El script es **no destructivo**: usa `IF NOT EXISTS` e `INSERT IGNORE`, así que puede
> ejecutarse varias veces sin borrar información existente.

Si tu MySQL usa otro usuario o contraseña, ajustar las credenciales en:

```text
src/main/java/com/taxiflow/webapp/dao/ConexionBD.java
```

```java
private final String url = "jdbc:mysql://localhost:3306/taxiflow_db?serverTimezone=UTC&useSSL=false";
private final String usuario = "root";
private final String password = "";
```

> ⚠️ El nombre de la base de datos debe ser **`taxiflow_db`**, tal como lo crea el script.
> ⚠️ En ambientes de producción se recomienda utilizar variables de entorno para las credenciales.

**Usuario de prueba para iniciar sesión:**

| ID      | Contraseña   | Rol           |
| ------- | ------------ | ------------- |
| `admin` | `admin123`   | Administrador |

---

### 3️⃣ Configurar el envío de correo

La recuperación de clave usa el SMTP de Gmail. Las credenciales **no se versionan**
(están en `.gitignore`), por lo que hay que crear manualmente el archivo:

```text
src/main/resources/mail.properties
```

Con este contenido:

```properties
mail.username=tucuenta@gmail.com
mail.password=CONTRASENA_DE_APLICACION_DE_16_CARACTERES
```

> ⚠️ `mail.password` **no** es la contraseña normal de Gmail: es una
> *contraseña de aplicación* generada con la verificación en dos pasos activada.
> Sin este archivo la aplicación compila y funciona, pero la recuperación de clave falla.

---

### 4️⃣ Compilar

```bash
mvn clean install
```

o:

```bash
mvn clean package
```

---

### 5️⃣ Ejecutar 🚀

El proyecto genera un archivo:

```text
target/taxiflow-webapp-1.0-SNAPSHOT.war
```

Este archivo puede desplegarse en un servidor compatible con Jakarta EE/Servlets.

---

## 🔄 Flujo de funcionamiento

```text
👤 Usuario
    │
    ▼
🌐 Aplicación Web
    │
    ▼
🎮 Servlet
    │
    ▼
📦 Modelo
    │
    ▼
🗃️ DAO
    │
    ▼
🐬 Base de Datos
    │
    ▼
📊 Información / Reportes
```

---

## 📊 Módulos

### 👤 Gestión de usuarios

Permite administrar la información de los usuarios mediante operaciones CRUD.

```text
➕ Crear
🔎 Consultar
✏️ Actualizar
🗑️ Eliminar
```

### 🚕 Gestión de carreras

Permite registrar y administrar los servicios realizados.

```text
🚕 Registrar carrera
🔎 Consultar carrera
✏️ Actualizar información
📊 Generar información
```

### 🔐 Autenticación

Incluye:

```text
🔑 Inicio de sesión
🚪 Gestión de acceso
🔄 Recuperación de contraseña
```

### 📈 Reportes parametrizados

La aplicación incluye **dos reportes parametrizados por cada entidad**:

| Entidad         | Reporte                        | Parámetro                  | Dónde se accede                          |
| --------------- | ------------------------------ | -------------------------- | --------------------------------------- |
| **Usuario**     | Usuarios por rol/tipo          | `tipo`                     | Menú → Reportes de Usuarios             |
| **Usuario**     | Usuarios por dominio de correo | `dominio` (ej. `taxiflow.com`) | Menú → Reportes de Usuarios         |
| **CarreraTaxi** | Carreras por barrio de inicio  | `barrio`                   | Menú → Reportes de Carreras            |
| **CarreraTaxi** | Carreras por precio mínimo     | `precioMinimo`             | Menú → Reportes de Carreras            |

---

## 🗺️ Roadmap

TaxiFlow continúa en desarrollo 🚧

* [x] 👤 Gestión de usuarios
* [x] 🔐 Autenticación
* [x] 🚕 Gestión de carreras
* [x] 📊 Reportes
* [x] 🗄️ Persistencia MySQL
* [ ] 🔒 Gestión avanzada de roles
* [ ] 🧪 Pruebas automatizadas
* [ ] 🐳 Docker
* [ ] ⚙️ CI/CD
* [ ] 📊 Dashboard avanzado
* [ ] 📱 Optimización responsive
* [ ] 📍 Integración con geolocalización

---

## 🔒 Recomendaciones de seguridad

Para una futura versión productiva se recomienda incorporar:

* 🔐 Hashing seguro de contraseñas.
* 🔑 Gestión de roles y permisos.
* 🛡️ Protección CSRF.
* 🚫 Prevención de SQL Injection.
* 🔒 HTTPS.
* 🔐 Variables de entorno.
* 📝 Sistema de logging.
* 🧪 Pruebas de seguridad.

---

## 📌 Estado del proyecto

🚧 **En desarrollo**

**Versión:** `1.0-SNAPSHOT`

**Tipo:** Aplicación web

**Empaquetado:** WAR

**Base de datos:** MySQL

---

## 👨‍💻 Autor

### Carlos Andrés Núñez Vargas

Proyecto desarrollado como aplicación web para la gestión de servicios de taxi.

---

<p align="center">

### 🚕 TaxiFlow

**Gestiona. Organiza. Conecta.**

⭐ Si el proyecto te resulta útil, considera darle una estrella al repositorio.

</p>
