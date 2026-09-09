<%-- 
    Document   : eliminar
    Created on : 8/09/2026, 5:58:23 p. m.
    Author     : CarlosN
--%>

<%-- 
    Documento: eliminar (CarreraTaxi)
    Pantalla de confirmación antes de borrar. Recibe el atributo 'carrera'
    que el Servlet coloca en el caso "confirmarEliminar".
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.taxiflow.webapp.modelo.CarreraTaxi"%>
<%
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
    CarreraTaxi c = (CarreraTaxi) request.getAttribute("carrera");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Carrera</title>
    </head>
    <body>
        <center>
            <h1>Eliminar Carrera</h1>
            <hr/>
            <% if (c == null) { %>
                <p style="color:#FF0000;">No se encontró la carrera solicitada.</p>
            <% } else { %>
                <p>¿Seguro que deseas eliminar esta carrera?</p>
                <table border="1" cellpadding="5">
                    <tr><th>Cliente</th><td><%= c.getCliente() %></td></tr>
                    <tr><th>Taxi</th><td><%= c.getTaxi() %></td></tr>
                    <tr><th>Barrio Inicio</th><td><%= c.getBarrioInicio() %></td></tr>
                    <tr><th>Barrio Llegada</th><td><%= c.getBarrioLlegada() %></td></tr>
                    <tr><th>Precio</th><td><%= c.getPrecio() %></td></tr>
                </table>
                <br/>
                <!-- La eliminación real ocurre en el caso "eliminar" del Servlet (GET) -->
                <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=eliminar&id=<%= c.getId() %>">
                    <button>Sí, eliminar</button>
                </a>
                <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Cancelar</a>
            <% } %>
        </center>
    </body>
</html>