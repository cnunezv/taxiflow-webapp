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

Crear la base de datos:

```sql
CREATE DATABASE taxiflow;
```

Configurar posteriormente las credenciales de conexión en:

```text
src/main/java/com/taxiflow/webapp/dao/ConexionBD.java
```

Ejemplo:

```java
String url = "jdbc:mysql://localhost:3306/taxiflow";
String usuario = "root";
String password = "TU_PASSWORD";
```

> ⚠️ En ambientes de producción se recomienda utilizar variables de entorno para las credenciales.

---

### 3️⃣ Compilar

```bash
mvn clean install
```

o:

```bash
mvn clean package
```

---

### 4️⃣ Ejecutar 🚀

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

### 📈 Reportes

El sistema incorpora funcionalidades orientadas a la consulta y generación de información relacionada con las operaciones registradas.

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

## 📸 Screenshots

> 💡 Puedes agregar aquí capturas de las principales pantallas de TaxiFlow.

```text
📸 Login
📸 Dashboard
📸 Gestión de usuarios
📸 Registro de carreras
📸 Reportes
```

Ejemplo:

```markdown
![Login TaxiFlow](docs/screenshots/login.png)
```

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
