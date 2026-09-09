<%-- 
    Documento: listar (CarreraTaxi)
    Muestra todas las carreras. Recibe el atributo 'carreras' (List<CarreraTaxi>)
    que el Servlet coloca con request.setAttribute("carreras", ...).
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.taxiflow.webapp.modelo.CarreraTaxi"%>
<%@page import="java.util.List"%>
<%
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
    List<CarreraTaxi> carreras = (List<CarreraTaxi>) request.getAttribute("carreras");
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Carreras</title>
    </head>
    <body>
        <center>
            <h1>Carreras de Taxi Registradas</h1>
            <hr/>
            <% if (mensaje != null) { %>
                <p style="color:#FF0000;"><%= mensaje %></p>
            <% } %>

            <table border="1" cellpadding="5">
                <thead>
                    <tr>
                        <th>Id</th><th>Cliente</th><th>Taxi</th><th>Km</th>
                        <th>Barrio Inicio</th><th>Barrio Llegada</th><th>Pasajeros</th>
                        <th>Taxista</th><th>Precio</th><th>Duración (min)</th><th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (carreras != null) {
                        for (CarreraTaxi c : carreras) { %>
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
                            <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=editar&id=<%= c.getId() %>">Editar</a>
                            |
                            <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=confirmarEliminar&id=<%= c.getId() %>">Eliminar</a>
                        </td>
                    </tr>
                    <%  }
                    } %>
                </tbody>
            </table>
            <hr/>
            <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=nueva">Agregar nueva carrera</a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=buscar">Reportes / Buscar</a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/index.jsp">Volver al menú</a>
        </center>
    </body>
</html>