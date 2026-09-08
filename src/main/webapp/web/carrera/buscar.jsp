<%-- 
    Document   : buscar
    Created on : 8/09/2026, 5:58:35 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.CarreraTaxi, java.util.List" %>
<!DOCTYPE html>
<html>
<head><title>Buscar Carreras</title></head>
<body>
    <h2>Buscar / Reportes</h2>

    <!-- Reporte 1: por barrio de inicio -->
    <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="get">
        <input type="hidden" name="accion" value="buscarPorBarrio" />
        Barrio de inicio: <input type="text" name="barrio" required />
        <button type="submit">Buscar por barrio</button>
    </form>

    <br/>

    <!-- Reporte 2: por precio mínimo -->
    <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="get">
        <input type="hidden" name="accion" value="buscarPorPrecio" />
        Precio mínimo: <input type="number" step="0.01" name="precioMinimo" required />
        <button type="submit">Buscar por precio</button>
    </form>

    <hr/>

    <%
        // Solo se muestran resultados si el Servlet ya ejecutó alguna búsqueda
        List<CarreraTaxi> resultados = (List<CarreraTaxi>) request.getAttribute("resultados");
        String criterio = (String) request.getAttribute("criterio");
        if (resultados != null) {
    %>
        <h3>Resultados — <%= criterio %></h3>
        <table border="1" cellpadding="5">
            <tr>
                <th>ID</th><th>Cliente</th><th>Taxi</th><th>Km</th><th>Barrio inicio</th>
                <th>Barrio llegada</th><th>Pasajeros</th><th>Taxista</th><th>Precio</th><th>Min</th>
            </tr>
            <% for (CarreraTaxi c : resultados) { %>
            <tr>
                <td><%= c.getId() %></td>
                <td><%= c.getCliente() %></td>
                <td><%= c.getTaxi() %></td>
                <td><%= c.getKilometros() %></td>
                <td><%= c.getBarrioInicio() %></td>
                <td><%= c.getBarrioLlegada() %></td>
                <td><%= c.getCantidadPasajeros() %></td>
                <td><%= c.getTaxista() %></td>
                <td><%= c.getPrecio() %></td>
                <td><%= c.getDuracionMinutos() %></td>
            </tr>
            <% } %>
        </table>
        <% if (resultados.isEmpty()) { %>
            <p>No se encontraron carreras con ese criterio.</p>
        <% } %>
    <% } %>

    <p><a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Volver al listado</a></p>
</body>
</html>