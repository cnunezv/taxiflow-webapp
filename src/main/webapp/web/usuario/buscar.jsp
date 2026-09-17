<%-- 
    Document   : buscar
    Created on : 8/09/2026, 2:07:45 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.Usuario" %>
<%
    // Control de acceso: si no hay sesión iniciada, se redirige al login.
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Buscar Usuario</title></head>
<body>
<center>
    <h2>Buscar Usuario por ID</h2>

    <form action="${pageContext.request.contextPath}/usuarios" method="get">
        <input type="hidden" name="accion" value="buscar" />
        <input type="hidden" name="redir" value="buscar" />
        ID: <input type="text" name="id" required />
        <button type="submit">Buscar</button>
    </form>

    <hr/>

    <%
        Usuario u = (Usuario) session.getAttribute("usuario.buscar");
        if (u != null) {
    %>
        <table border="1" cellpadding="5">
            <tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>Email</th><th>Tipo</th></tr>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getNombre() %></td>
                <td><%= u.getApellido() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.getTipo() %></td>
            </tr>
        </table>
    <% } %>

    <p><a href="${pageContext.request.contextPath}/usuarios?accion=listartodo">Volver al listado</a></p>
    <center>
</body>
</html>