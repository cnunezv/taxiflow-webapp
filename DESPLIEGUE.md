# Despliegue de TaxiFlow en internet (GitHub → Render + Aiven MySQL)

Guía paso a paso para publicar la aplicación **TaxiFlow** (Servlets / JSP / JDBC)
en internet, con código en **GitHub**, servidor en **Render** y base de datos
**MySQL gratuita en Aiven**.

| Pieza | Servicio | Costo |
|---|---|---|
| Código fuente | GitHub (`cnunezv/taxiflow-webapp`) | Gratis |
| Servidor de aplicaciones (Tomcat 9) | Render · Web Service tipo *Docker* | Gratis |
| Base de datos MySQL 8 | Aiven · plan *Free* | Gratis, sin caducidad |

> **¿Por qué Aiven y no Render?** Render solo ofrece PostgreSQL gestionado, y
> además su plan gratuito de base de datos **caduca a los 30 días**. Aiven da
> MySQL gratis de forma indefinida (1 GB), así que el código del proyecto no
> necesita cambiar de motor.

---

## Paso 0 · Qué se preparó en el proyecto

Estos archivos ya están listos y commiteados en el repositorio:

| Archivo | Para qué sirve |
|---|---|
| `Dockerfile` | Receta en dos etapas: Maven 3.9 + JDK 17 compila el `.war`, y Tomcat 9 lo publica como `ROOT.war`. |
| `.dockerignore` | Evita enviar `target/`, `.git/` y los documentos Word/PDF al construir la imagen. |
| `.gitattributes` | Normaliza los finales de línea a LF para que el proyecto compile igual en Windows y en Linux. |
| `db/taxiflow_db_cloud.sql` | El mismo esquema y datos, pero **sin** `CREATE DATABASE` ni `USE` (en Aiven la base ya viene creada). |
| `ConexionBD.java` (modificado) | Lee `DB_URL`, `DB_USER` y `DB_PASSWORD` del entorno. Si no existen, usa los valores de siempre en `localhost` → **tu proyecto local sigue funcionando igual**. |
| `EnvioCorreo.java` (modificado) | Lee `MAIL_USERNAME` y `MAIL_PASSWORD` del entorno; si no están, usa `mail.properties` como antes. |

**Detalle técnico importante:** se usa **Tomcat 9**, no Tomcat 10 ni 11. El
proyecto importa `javax.servlet.*` (Jakarta EE 8); desde Tomcat 10 el paquete se
llama `jakarta.servlet.*` y la aplicación no arrancaría sin migrar todo el
código.

---

## Paso 1 · Subir los cambios a GitHub

El commit ya está hecho en tu repositorio local. Solo falta enviarlo:

**Con GitKraken:** botón **Push** en la barra superior.

**Con la terminal** (Git Bash o la de NetBeans), dentro de la carpeta del proyecto:

```bash
git push origin master
```

Verifica en <https://github.com/cnunezv/taxiflow-webapp> que aparezcan el
`Dockerfile` y la carpeta `db/` con el nuevo script.

---

## Paso 2 · Crear la base de datos MySQL en Aiven

1. Entra a <https://aiven.io/free-mysql-database> y pulsa **Get started for free**.
   Puedes registrarte con tu cuenta de GitHub o Google. **No pide tarjeta de crédito.**
2. En la consola: **Create service** → **MySQL**.
3. Elige:
   - **Service plan:** `Free` (1 GB de disco, máximo 76 conexiones).
   - **Cloud provider / region:** la más cercana a Colombia, por ejemplo
     *AWS · us-east-1 (N. Virginia)*.
   - **Service name:** `taxiflow-db`.
4. **Create service** y espera de 2 a 5 minutos, hasta que el estado pase de
   *Rebuilding* a **Running**.
5. En la pestaña **Overview** anota estos datos de *Connection information*:

   | Dato | Ejemplo |
   |---|---|
   | Host | `taxiflow-db-tuusuario.a.aivencloud.com` |
   | Port | `12345` (no es 3306) |
   | User | `avnadmin` |
   | Password | (se ve con el botón del ojo) |
   | Database name | `defaultdb` |

> Guarda esa contraseña en un lugar seguro. **Nunca** la escribas dentro de un
> archivo del repositorio: va a ir en las variables de entorno de Render.

---

## Paso 3 · Crear las tablas y los datos de prueba

En la consola de Aiven, dentro de tu servicio, abre la pestaña **Query editor**.

1. Abre el archivo `db/taxiflow_db_cloud.sql` de tu proyecto.
2. Copia **todo** su contenido y pégalo en el editor.
3. Pulsa **Run**.
4. Comprueba que quedó bien ejecutando:

```sql
SELECT COUNT(*) AS total_usuarios FROM usuarios;
SELECT COUNT(*) AS total_carreras FROM carreras_taxi;
```

Deben devolver **6** y **10**.

*Alternativa desde tu PC* (si tienes el cliente `mysql` instalado):

```bash
mysql --host=TU_HOST --port=TU_PUERTO --user=avnadmin --password \
      --ssl-mode=REQUIRED defaultdb < db/taxiflow_db_cloud.sql
```

---

## Paso 4 · Crear el servicio web en Render

1. Entra a <https://render.com> y regístrate con **GitHub** (así Render ve tus repositorios).
2. En el panel: **New +** → **Web Service**.
3. **Connect a repository** → busca y selecciona `cnunezv/taxiflow-webapp`.
   Si no aparece, pulsa *Configure account* y dale acceso a ese repositorio.
4. Configura el servicio así:

   | Campo | Valor |
   |---|---|
   | **Name** | `taxiflow-webapp` (define la URL final) |
   | **Language** / **Runtime** | **Docker** |
   | **Branch** | `master` |
   | **Root Directory** | *(déjalo vacío)* |
   | **Dockerfile Path** | `./Dockerfile` |
   | **Region** | Oregon (US West) u Ohio |
   | **Instance Type** | **Free** |

5. Baja hasta **Environment Variables** y añade estas tres
   (*Add Environment Variable* por cada una), reemplazando con tus datos de Aiven:

   | Key | Value |
   |---|---|
   | `DB_URL` | `jdbc:mysql://TU_HOST:TU_PUERTO/defaultdb?sslMode=REQUIRED&serverTimezone=UTC` |
   | `DB_USER` | `avnadmin` |
   | `DB_PASSWORD` | *(la contraseña de Aiven)* |

   Si quieres que funcione la recuperación de clave por correo, añade también:

   | Key | Value |
   |---|---|
   | `MAIL_USERNAME` | tu correo de Gmail |
   | `MAIL_PASSWORD` | la contraseña de aplicación de 16 caracteres |

   > No agregues `PORT`: Render la inyecta automáticamente y el `Dockerfile` ya
   > la usa para configurar Tomcat.

6. Pulsa **Create Web Service**.

La primera construcción tarda entre 5 y 10 minutos (descarga Maven, las
dependencias y la imagen de Tomcat). Puedes seguirla en la pestaña **Logs**.
Cuando termine verás algo como:

```
Server startup in [xxxx] milliseconds
==> Your service is live 🎉
```

---

## Paso 5 · Probar la aplicación

Abre la URL que muestra Render, por ejemplo:

```
https://taxiflow-webapp.onrender.com
```

Debe aparecer directamente la pantalla de **login** (no hace falta escribir
`/taxiflow-webapp` al final, porque el WAR se despliega como `ROOT.war`).

Usuarios de prueba cargados por el script:

| Usuario | Clave | Rol |
|---|---|---|
| `admin` | `admin123` | Administrador |
| `ldiaz` | `ldiaz123` | Cliente |
| `jperez` | `jperez12` | Taxista |

Recorre el CRUD de usuarios, el CRUD de carreras y los dos reportes para
confirmar que la base de datos en la nube responde.

---

## Paso 6 · Cada vez que cambies el código

Render queda conectado al repositorio: **cada `git push` a la rama `master`
dispara un despliegue automático**. No hay que volver a configurar nada.

---

## Problemas frecuentes

| Síntoma | Causa y solución |
|---|---|
| La primera visita tarda ~1 minuto | Normal. El plan Free de Render apaga el servicio tras 15 minutos sin tráfico y lo enciende con la siguiente petición. |
| `Port scan timeout reached, no open ports detected` | Render no detectó el puerto. Verifica que no creaste una variable `PORT` con un valor distinto y que el `Dockerfile` conserva la línea `CMD sed -i ...`. |
| `Error al conectar con la base de datos: Communications link failure` | Revisa `DB_URL`: el puerto de Aiven **no** es 3306, y debe terminar en `/defaultdb?sslMode=REQUIRED&serverTimezone=UTC`. |
| `Access denied for user 'avnadmin'` | Contraseña mal copiada en `DB_PASSWORD` (cuidado con espacios al pegar). |
| `Table 'defaultdb.usuarios' doesn't exist` | Falta ejecutar el Paso 3. |
| `HTTP 404` al entrar | El WAR no se copió como `ROOT.war`. Revisa los logs de construcción. |
| El envío de correo falla | Faltan `MAIL_USERNAME` / `MAIL_PASSWORD`, o Gmail requiere una *contraseña de aplicación* (no la clave normal de la cuenta). |

---

## Límites de los planes gratuitos

- **Render Free:** 750 horas de instancia al mes por cuenta, una sola instancia,
  sin disco persistente, y suspensión tras 15 minutos de inactividad.
- **Aiven Free (MySQL):** 1 GB de disco, 76 conexiones simultáneas, sin copias
  de seguridad gestionadas y sin SLA. Aiven puede apagar servicios que lleven
  mucho tiempo sin uso, pero se vuelven a encender desde la consola.

Para una sustentación o una entrega académica es más que suficiente; solo
conviene abrir la URL unos minutos antes de presentar, para que el servicio ya
esté despierto.
