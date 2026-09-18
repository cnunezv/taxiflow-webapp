package com.taxiflow.webapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Clase encargada de abrir, usar y cerrar la conexión con la base de datos MySQL.
 * Todas las clases DAO (UsuarioDAO, CarreraTaxiDAO) usan esta clase para
 * ejecutar sentencias SQL sin repetir el código de conexión.
 */
public class ConexionBD {

    // -----------------------------------------------------------------
    // Datos de conexión.
    // En la nube (Render) se leen de variables de entorno; si no existen,
    // se usan los valores locales de desarrollo (MySQL en localhost).
    // -----------------------------------------------------------------
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver"; // Connector/J 8+

    /** Lee una variable de entorno; si está vacía o no existe, devuelve el valor por defecto. */
    private static String env(String clave, String porDefecto) {
        String valor = System.getenv(clave);
        return (valor == null || valor.trim().isEmpty()) ? porDefecto : valor;
    }

    private final String url = env("DB_URL",
            "jdbc:mysql://localhost:3306/taxiflow_db?serverTimezone=UTC&useSSL=false");
    private final String usuario = env("DB_USER", "root");
    private final String password = env("DB_PASSWORD", "");

    private Connection conexion;

    /**
     * Constructor: registra el driver y abre la conexión apenas se crea el objeto.
     */
    public ConexionBD() throws Exception {
        conectar();
    }

    /**
     * Registra el driver JDBC y abre la conexión a la base de datos.
     */
    public void conectar() throws Exception {
        try {
            Class.forName(DRIVER); // carga la clase del driver en memoria
        } catch (ClassNotFoundException ex) {
            throw new Exception("No se encontró el driver de MySQL: " + ex.getMessage());
        }
        try {
            conexion = DriverManager.getConnection(url, usuario, password);
        } catch (SQLException ex) {
            throw new Exception("Error al conectar con la base de datos: " + ex.getMessage());
        }
    }

    /**
     * Prepara una sentencia SQL (INSERT, UPDATE, DELETE o SELECT) para ejecutarla
     * de forma segura contra inyección SQL, usando '?' como marcador de valores.
     */
    public PreparedStatement crearSentencia(String sql) throws Exception {
        return conexion.prepareStatement(sql);
    }

    /**
     * Ejecuta sentencias que modifican datos (INSERT, UPDATE, DELETE).
     * Devuelve el número de filas afectadas.
     */
    public int actualizar(PreparedStatement sentencia) throws Exception {
        try {
            return sentencia.executeUpdate();
        } catch (SQLException ex) {
            throw new Exception("Error al ejecutar la sentencia: " + ex.getMessage());
        }
    }

    /**
     * Ejecuta sentencias SELECT y devuelve el resultado (filas encontradas).
     */
    public ResultSet consultar(PreparedStatement sentencia) throws Exception {
        try {
            return sentencia.executeQuery();
        } catch (SQLException ex) {
            throw new Exception("Error al consultar: " + ex.getMessage());
        }
    }

    /**
     * Cierra la conexión. Debe llamarse siempre en un bloque finally
     * para no dejar conexiones abiertas.
     */
    public void desconectar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException ex) {
            // Si falla el cierre no interrumpimos el flujo, solo se podría loguear.
        }
    }
}