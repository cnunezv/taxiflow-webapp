package com.taxiflow.webapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/taxiflow_bd";
    private static final String USUARIO = "root";
    private static final String CLAVE = "";

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver de MySQL no encontrado", e);
        }

        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }
}