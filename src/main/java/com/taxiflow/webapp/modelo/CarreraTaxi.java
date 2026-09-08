package com.taxiflow.webapp.modelo;

/**
 * Entidad CarreraTaxi: representa una fila de la tabla 'carreras_taxi'.
 * Ejercicio N.º 19 asignado.
 */
/**
 *
 * @author CarlosN
 */
public class CarreraTaxi {
    private int id;
    private String cliente;
    private String taxi;
    private double kilometros;
    private String barrioInicio;
    private String barrioLlegada;
    private int cantidadPasajeros;
    private String taxista;
    private double precio;
    private int duracionMinutos;

    public CarreraTaxi() {
    }

    // --- Getters y Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }

    public String getTaxi() { return taxi; }
    public void setTaxi(String taxi) { this.taxi = taxi; }

    public double getKilometros() { return kilometros; }
    public void setKilometros(double kilometros) { this.kilometros = kilometros; }

    public String getBarrioInicio() { return barrioInicio; }
    public void setBarrioInicio(String barrioInicio) { this.barrioInicio = barrioInicio; }

    public String getBarrioLlegada() { return barrioLlegada; }
    public void setBarrioLlegada(String barrioLlegada) { this.barrioLlegada = barrioLlegada; }

    public int getCantidadPasajeros() { return cantidadPasajeros; }
    public void setCantidadPasajeros(int cantidadPasajeros) { this.cantidadPasajeros = cantidadPasajeros; }

    public String getTaxista() { return taxista; }
    public void setTaxista(String taxista) { this.taxista = taxista; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getDuracionMinutos() { return duracionMinutos; }
    public void setDuracionMinutos(int duracionMinutos) { this.duracionMinutos = duracionMinutos; }
}