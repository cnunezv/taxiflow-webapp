<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.CarreraTaxi, java.util.List" %>
<!DOCTYPE html>
<html>
<head><title>Carreras de Taxi</title></head>
<body>
    <h2>Listado de Carreras</h2>

    <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=nueva">+ Nueva carrera</a> |
    <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=buscar">Buscar / Reportes</a>

    <p style="color:red">${mensaje}</p>

    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th><th>Cliente</th><th>Taxi</th><th>Km</th><th>Barrio inicio</th>
            <th>Barrio llegada</th><th>Pasajeros</th><th>Taxista</th><th>Precio</th><th>Min</th><th>Acciones</th>
        </tr>
        <%
            List<CarreraTaxi> carreras = (List<CarreraTaxi>) request.getAttribute("carreras");
            if (carreras != null) {
                for (CarreraTaxi c : carreras) {
        %>
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
            <td>
                <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=editar&id=<%= c.getId() %>">Editar</a> |
                <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=confirmarEliminar&id=<%= c.getId() %>">Eliminar</a>
            </td>
        </tr>
        <% } } %>
    </table>
</body>
</html>