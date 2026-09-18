# =====================================================================
#  TaxiFlow - Imagen Docker para desplegar en Render
#  Etapa 1: Maven compila el proyecto y genera el archivo .war
#  Etapa 2: Tomcat 9 publica ese .war en la raiz del sitio
#  Autor: Carlos Andres Nunez Vargas
# =====================================================================

# ---------- Etapa 1: construccion ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Se copia primero el pom para aprovechar la cache de dependencias de Docker
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Ahora el codigo fuente y se empaqueta el WAR
COPY src ./src
RUN mvn -B clean package -DskipTests

# ---------- Etapa 2: ejecucion ----------
# Tomcat 9 porque el proyecto usa el paquete javax.servlet (Jakarta EE 8).
# Tomcat 10+ usa jakarta.servlet y NO funcionaria sin migrar el codigo.
FROM tomcat:9.0-jdk17-temurin

# Se eliminan las aplicaciones de ejemplo que trae Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Al llamarlo ROOT.war la app queda en https://<tu-servicio>.onrender.com/
# (sin tener que escribir /taxiflow-webapp al final)
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Render inyecta la variable PORT. Tomcat escucha por defecto en 8080,
# asi que al arrancar se reemplaza ese puerto por el que indique Render.
ENV PORT=10000
EXPOSE 10000

CMD sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml && catalina.sh run
