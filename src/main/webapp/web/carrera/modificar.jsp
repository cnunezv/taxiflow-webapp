<%-- 
    Document   : modificar
    Created on : 8/09/2026, 5:58:12 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.CarreraTaxi" %>
<!DOCTYPE html>
<html>
<head><title>Editar Carrera</title></head>
<body>
    <%
        // Siempre viene una carrera desde el Servlet (accion=editar)
        CarreraTaxi c = (CarreraTaxi) request.getAttribute("carrera");
    %>
    <h2>Editar Carrera</h2>
    <p style="color:red"><%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "" %></p>

    <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="post">
        <!-- El id sí viaja aquí, para que el Servlet sepa que es UPDATE y no INSERT -->
        <input type="hidden" name="id" value="<%= c.getId() %>" />

        Cliente: <input type="text" name="cliente" value="<%= c.getCliente() %>" required /><br/>
        Taxi: <input type="text" name="taxi" value="<%= c.getTaxi() %>" required /><br/>
        Kilómetros: <input type="number" step="0.1" name="kilometros" value="<%= c.getKilometros() %>" required /><br/>
        Barrio inicio: <input type="text" name="barrioInicio" value="<%= c.getBarrioInicio() %>" required /><br/>
        Barrio llegada: <input type="text" name="barrioLlegada" value="<%= c.getBarrioLlegada() %>" required /><br/>
        Pasajeros: <input type="number" name="cantidadPasajeros" value="<%= c.getCantidadPasajeros() %>" required /><br/>
        Taxista: <input type="text" name="taxista" value="<%= c.getTaxista() %>" required /><br/>
        Precio: <input type="number" step="0.01" name="precio" value="<%= c.getPrecio() %>" required /><br/>
        Duración (min): <input type="number" name="duracionMinutos" value="<%= c.getDuracionMinutos() %>" required /><br/>

        <button type="submit">Guardar cambios</button>
        <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Cancelar</a>
    </form>
</body>
</html>