package com.taxiflow.webapp.dao;

import com.taxiflow.webapp.modelo.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object) de Usuario.
 * Contiene todas las operaciones CRUD + login sobre la tabla 'usuarios'.
 */
public class UsuarioDAO {

    /** Inserta un nuevo usuario en la BD. */
    public void agregar(Usuario u) throws Exception {
        String sql = "INSERT INTO usuarios (id, password, nombre, apellido, email, tipo) "
                + "VALUES (?,?,?,?,?,?)";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, u.getId());
            st.setString(2, u.getPassword());
            st.setString(3, u.getNombre());
            st.setString(4, u.getApellido());
            st.setString(5, u.getEmail());
            st.setString(6, u.getTipo());
            bd.actualizar(st);
        } finally {
            bd.desconectar(); // se cierra la conexión pase lo que pase
        }
    }

    /** Actualiza los datos de un usuario existente, identificado por su id. */
    public void modificar(Usuario u) throws Exception {
        String sql = "UPDATE usuarios SET password=?, nombre=?, apellido=?, email=?, tipo=? WHERE id=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, u.getPassword());
            st.setString(2, u.getNombre());
            st.setString(3, u.getApellido());
            st.setString(4, u.getEmail());
            st.setString(5, u.getTipo());
            st.setString(6, u.getId());
            bd.actualizar(st);
        } finally {
            bd.desconectar();
        }
    }

    /** Elimina un usuario por su id. */
    public void eliminar(String id) throws Exception {
        String sql = "DELETE FROM usuarios WHERE id=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, id);
            bd.actualizar(st);
        } finally {
            bd.desconectar();
        }
    }

    /** Busca y devuelve un usuario por su id, o null si no existe. */
    public Usuario consultar(String id) throws Exception {
        String sql = "SELECT * FROM usuarios WHERE id=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, id);
            ResultSet rs = bd.consultar(st);
            if (rs.next()) {
                return mapearUsuario(rs);
            }
            return null; // no se encontró
        } finally {
            bd.desconectar();
        }
    }

    /** Busca un usuario por su email (para recuperación de clave). */
    public Usuario consultarPorEmail(String email) throws Exception {
        String sql = "SELECT * FROM usuarios WHERE email=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, email);
            ResultSet rs = bd.consultar(st);
            if (rs.next()) {
                return mapearUsuario(rs);
            }
            return null;
        } finally {
            bd.desconectar();
        }
    }

    /** Valida credenciales de login. Devuelve el Usuario si son correctas, o null. */
    public Usuario iniciarSesion(String id, String password) throws Exception {
        String sql = "SELECT * FROM usuarios WHERE id=? AND password=?";
        ConexionBD bd = new ConexionBD();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            st.setString(1, id);
            st.setString(2, password);
            ResultSet rs = bd.consultar(st);
            if (rs.next()) {
                return mapearUsuario(rs);
            }
            return null; // id o password incorrectos
        } finally {
            bd.desconectar();
        }
    }

    /** Devuelve todos los usuarios registrados. */
    public List<Usuario> listarTodos() throws Exception {
        String sql = "SELECT * FROM usuarios";
        ConexionBD bd = new ConexionBD();
        List<Usuario> lista = new ArrayList<>();
        try {
            PreparedStatement st = bd.crearSentencia(sql);
            ResultSet rs = bd.consultar(st);
            while (rs.next()) {
                lista.add(mapearUsuario(rs));
            }
            return lista;
        } finally {
            bd.desconectar();
        }
    }

    /**
     * Método privado de apoyo: convierte una fila del ResultSet en un objeto Usuario.
     * Evita repetir el mismo bloque de código en cada método de consulta.
     */
    private Usuario mapearUsuario(ResultSet rs) throws Exception {
        Usuario u = new Usuario();
        u.setId(rs.getString("id"));
        u.setPassword(rs.getString("password"));
        u.setNombre(rs.getString("nombre"));
        u.setApellido(rs.getString("apellido"));
        u.setEmail(rs.getString("email"));
        u.setTipo(rs.getString("tipo"));
        return u;
    }
}