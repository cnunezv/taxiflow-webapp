<%-- 
    Document   : modificar
    Created on : 8/09/2026, 5:58:12 p. m.
    Author     : CarlosN
--%>

<%-- 
    Documento: modificar (CarreraTaxi)
    Formulario pre-cargado con los datos de la carrera a editar.
    Recibe el atributo 'carrera' (CarreraTaxi) que el Servlet coloca
    en el caso "editar" antes de hacer forward aquí.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.taxiflow.webapp.modelo.CarreraTaxi"%>
<%
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
    CarreraTaxi c = (CarreraTaxi) request.getAttribute("carrera");
    String mensaje = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Carrera</title>
    </head>
    <body>
        <center>
            <h1>Modificar Carrera</h1>
            <hr/>
            <% if (c == null) { %>
                <p style="color:#FF0000;">No se encontró la carrera solicitada.</p>
            <% } else { %>
            <!-- Mismo action que agregar.jsp: el Servlet distingue alta/edición
                 por si viene o no el campo oculto 'id' -->
            <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="post">
                <input type="hidden" name="id" value="<%= c.getId() %>"/>
                <table>
                    <tr><th style="text-align:right">Cliente:</th>
                        <td><input type="text" name="cliente" value="<%= c.getCliente() %>" required/></td></tr>
                    <tr><th style="text-align:right">Taxi:</th>
                        <td><input type="text" name="taxi" value="<%= c.getTaxi() %>" required/></td></tr>
                    <tr><th style="text-align:right">Kilómetros:</th>
                        <td><input type="number" step="0.1" name="kilometros" value="<%= c.getKilometros() %>" required/></td></tr>
                    <tr><th style="text-align:right">Barrio Inicio:</th>
                        <td><input type="text" name="barrioInicio" value="<%= c.getBarrioInicio() %>" required/></td></tr>
                    <tr><th style="text-align:right">Barrio Llegada:</th>
                        <td><input type="text" name="barrioLlegada" value="<%= c.getBarrioLlegada() %>" required/></td></tr>
                    <tr><th style="text-align:right">Pasajeros:</th>
                        <td><input type="number" name="cantidadPasajeros" value="<%= c.getCantidadPasajeros() %>" required/></td></tr>
                    <tr><th style="text-align:right">Taxista:</th>
                        <td><input type="text" name="taxista" value="<%= c.getTaxista() %>" required/></td></tr>
                    <tr><th style="text-align:right">Precio:</th>
                        <td><input type="number" step="0.01" name="precio" value="<%= c.getPrecio() %>" required/></td></tr>
                    <tr><th style="text-align:right">Duración (min):</th>
                        <td><input type="number" name="duracionMinutos" value="<%= c.getDuracionMinutos() %>" required/></td></tr>
                    <tr><th></th><td>
                        <input type="submit" value="Guardar cambios"/>
                    </td></tr>
                </table>
            </form>
            <% } %>
            <hr/>
            <p style="color:#FF0000;"><%= (mensaje != null) ? mensaje : "" %></p>
            <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Volver al listado</a>
        </center>
    </body>
</html>