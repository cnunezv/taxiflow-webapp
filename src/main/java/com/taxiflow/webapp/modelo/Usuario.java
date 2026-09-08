/*
 * Clase Usuario se utilizara para trabajar con las propiedades (datos) de
 * los usuarios que se vallan agregando, eliminando, buscando, modificando,
 listando o logeando al sistema 
*/
package com.taxiflow.webapp.modelo;

/**
 *
 * @author CarlosN
 */
public class Usuario {
    private String id;
    private String password;
    private String nombre;
    private String apellido;
    private String email;
    private String tipo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
}
