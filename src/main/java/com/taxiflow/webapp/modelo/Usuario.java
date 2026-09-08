package com.taxiflow.webapp.modelo;

/**
 * Entidad Usuario: representa una fila de la tabla 'usuarios'.
 * El id AQUÍ es escrito manualmente por la persona (VARCHAR), no autogenerado,
 * a diferencia de CarreraTaxi.
 */
public class Usuario {
    private String id;
    private String password; // corresponde a "clave" en el enunciado
    private String nombre;
    private String apellido;
    private String email;
    private String tipo; // corresponde a "rol" (Administrador, Cliente, Taxista, etc.)

    public Usuario() {
    }

    // --- Getters y Setters ---
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
}