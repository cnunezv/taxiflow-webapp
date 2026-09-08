package com.taxiflow.webapp.dao;

import com.taxiflow.webapp.modelo.CarreraTaxi;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO de CarreraTaxi (ejercicio N.º 19).
 * Contiene el CRUD completo y dos reportes parametrizados.
 */
public class CarreraTaxiDAO {

    /** Inserta una nueva carrera de taxi. El id lo genera la BD automáticamente. */
    public void agregar(CarreraTaxi c) throws Exception {
        String sql = "INSERT INTO carreras_taxi (cliente, taxi, kilometros, barrioInicio, "
                + "barrioLlegada, cantidadPasajeros, taxista, precio, duracionMinutos) "
                + "VALUES (?,?,?,?,?,?,?,?,?)";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, c.getCliente());
            st.setString(2, c.getTaxi());
            st.setDouble(3, c.getKilometros());
            st.setString(4, c.getBarrioInicio());
            st.setString(5, c.getBarrioLlegada());
            st.setInt(6, c.getCantidadPasajeros());
            st.setString(7, c.getTaxista());
            st.setDouble(8, c.getPrecio());
            st.setInt(9, c.getDuracionMinutos());
            bd.actualizar(st);
        } finally {
            bd.desconectar(); // se cierra la conexión pase lo que pase
        }
    }

    /** Actualiza una carrera existente, identificada por su id. */
    public void modificar(CarreraTaxi c) throws Exception {
        String sql = "UPDATE carreras_taxi SET cliente=?, taxi=?, kilometros=?, barrioInicio=?, "
                + "barrioLlegada=?, cantidadPasajeros=?, taxista=?, precio=?, duracionMinutos=? "
                + "WHERE id=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, c.getCliente());
            st.setString(2, c.getTaxi());
            st.setDouble(3, c.getKilometros());
            st.setString(4, c.getBarrioInicio());
            st.setString(5, c.getBarrioLlegada());
            st.setInt(6, c.getCantidadPasajeros());
            st.setString(7, c.getTaxista());
            st.setDouble(8, c.getPrecio());
            st.setInt(9, c.getDuracionMinutos());
            st.setInt(10, c.getId());
            bd.actualizar(st);
        } finally {
            bd.desconectar();
        }
    }

    /** Elimina una carrera por su id. */
    public void eliminar(int id) throws Exception {
        String sql = "DELETE FROM carreras_taxi WHERE id=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setInt(1, id);
            bd.actualizar(st);
        } finally {
            bd.desconectar();
        }
    }

    /** Busca una carrera por su id. Devuelve null si no existe. */
    public CarreraTaxi consultar(int id) throws Exception {
        String sql = "SELECT * FROM carreras_taxi WHERE id=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setInt(1, id);
            ResultSet rs = bd.consultar(st);
            if (rs.next()) {
                return mapearCarrera(rs);
            }
            return null;
        } finally {
            bd.desconectar();
        }
    }

    /** Devuelve todas las carreras registradas. */
    public List<CarreraTaxi> listarTodas() throws Exception {
        String sql = "SELECT * FROM carreras_taxi";
        ConexionBD bd = new ConexionBD();
        List<CarreraTaxi> lista = new ArrayList<>();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            ResultSet rs = bd.consultar(st);
            while (rs.next()) {
                lista.add(mapearCarrera(rs));
            }
            return lista;
        } finally {
            bd.desconectar();
        }
    }

    /**
     * Reporte parametrizado 1: carreras que iniciaron en un barrio específico.
     * El parámetro 'barrio' viene del formulario JSP del reporte.
     */
    public List<CarreraTaxi> reportePorBarrioInicio(String barrio) throws Exception {
        String sql = "SELECT * FROM carreras_taxi WHERE barrioInicio = ?";
        ConexionBD bd = new ConexionBD();
        List<CarreraTaxi> lista = new ArrayList<>();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, barrio);
            ResultSet rs = bd.consultar(st);
            while (rs.next()) {
                lista.add(mapearCarrera(rs));
            }
            return lista;
        } finally {
            bd.desconectar();
        }
    }

    /**
     * Reporte parametrizado 2: carreras con precio mayor o igual a un valor mínimo.
     */
    public List<CarreraTaxi> reportePorPrecioMinimo(double precioMinimo) throws Exception {
        String sql = "SELECT * FROM carreras_taxi WHERE precio >= ? ORDER BY precio DESC";
        ConexionBD bd = new ConexionBD();
        List<CarreraTaxi> lista = new ArrayList<>();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setDouble(1, precioMinimo);
            ResultSet rs = bd.consultar(st);
            while (rs.next()) {
                lista.add(mapearCarrera(rs));
            }
            return lista;
        } finally {
            bd.desconectar();
        }
    }

    /** Método privado de apoyo: convierte una fila del ResultSet en un objeto CarreraTaxi. */
    private CarreraTaxi mapearCarrera(ResultSet rs) throws Exception {
        CarreraTaxi c = new CarreraTaxi();
        c.setId(rs.getInt("id"));
        c.setCliente(rs.getString("cliente"));
        c.setTaxi(rs.getString("taxi"));
        c.setKilometros(rs.getDouble("kilometros"));
        c.setBarrioInicio(rs.getString("barrioInicio"));
        c.setBarrioLlegada(rs.getString("barrioLlegada"));
        c.setCantidadPasajeros(rs.getInt("cantidadPasajeros"));
        c.setTaxista(rs.getString("taxista"));
        c.setPrecio(rs.getDouble("precio"));
        c.setDuracionMinutos(rs.getInt("duracionMinutos"));
        return c;
    }
}