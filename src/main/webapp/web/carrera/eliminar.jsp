<%-- 
    Document   : eliminar
    Created on : 8/09/2026, 5:58:23 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.CarreraTaxi" %>
<!DOCTYPE html>
<html>
<head><title>Eliminar Carrera</title></head>
<body>
    <%
        // Viene desde accion=confirmarEliminar, con la carrera ya cargada
        CarreraTaxi c = (CarreraTaxi) request.getAttribute("carrera");
    %>
    <h2>¿Eliminar esta carrera?</h2>
    <p>
        <b>Cliente:</b> <%= c.getCliente() %> —
        <b>Taxi:</b> <%= c.getTaxi() %> —
        <b>Ruta:</b> <%= c.getBarrioInicio() %> → <%= c.getBarrioLlegada() %> —
        <b>Precio:</b> <%= c.getPrecio() %>
    </p>

    <!-- Este formulario dispara el GET real de eliminación al confirmar -->
    <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="get">
        <input type="hidden" name="accion" value="eliminar" />
        <input type="hidden" name="id" value="<%= c.getId() %>" />
        <button type="submit">Sí, eliminar</button>
        <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Cancelar</a>
    </form>
</body>
</html>