<%-- 
    Document   : buscar
    Created on : 8/09/2026, 5:58:35 p. m.
    Author     : CarlosN
--%>

<%-- 
    Documento: buscar (CarreraTaxi)
    Pantalla con los DOS reportes parametrizados exigidos por la actividad:
    1) por barrio de inicio, 2) por precio mínimo.
    Muestra resultados si 'resultados' y 'criterio' vienen en el request.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.taxiflow.webapp.modelo.CarreraTaxi"%>
<%@page import="java.util.List"%>
<%
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
    List<CarreraTaxi> resultados = (List<CarreraTaxi>) request.getAttribute("resultados");
    String criterio = (String) request.getAttribute("criterio");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes de Carreras</title>
    </head>
    <body>
        <center>
            <h1>Reportes de Carreras de Taxi</h1>
            <hr/>

            <h3>Reporte 1: por barrio de inicio</h3>
            <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="get">
                <input type="hidden" name="accion" value="buscarPorBarrio"/>
                Barrio de inicio: <input type="text" name="barrio" required/>
                <input type="submit" value="Buscar"/>
            </form>

            <h3>Reporte 2: por precio mínimo</h3>
            <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="get">
                <input type="hidden" name="accion" value="buscarPorPrecio"/>
                Precio mínimo: <input type="number" step="0.01" name="precioMinimo" required/>
                <input type="submit" value="Buscar"/>
            </form>

            <hr/>
            <% if (criterio != null) { %>
                <h3>Resultados (<%= criterio %>)</h3>
                <table border="1" cellpadding="5">
                    <thead>
                        <tr>
                            <th>Id</th><th>Cliente</th><th>Taxi</th><th>Barrio Inicio</th>
                            <th>Barrio Llegada</th><th>Precio</th><th>Duración (min)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (resultados != null && !resultados.isEmpty()) {
                            for (CarreraTaxi c : resultados) { %>
                        <tr>
                            <td><%= c.getId() %></td>
                            <td><%= c.getCliente() %></td>
                            <td><%= c.getTaxi() %></td>
                            <td><%= c.getBarrioInicio() %></td>
                            <td><%= c.getBarrioLlegada() %></td>
                            <td><%= c.getPrecio() %></td>
                            <td><%= c.getDuracionMinutos() %></td>
                        </tr>
                        <%   }
                        } else { %>
                        <tr><td colspan="7">No se encontraron resultados.</td></tr>
                        <%  } %>
                    </tbody>
                </table>
            <% } %>

            <hr/>
            <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Volver al listado</a>
        </center>
    </body>
</html>