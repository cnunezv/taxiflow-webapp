<%-- 
    Document   : listar
    Created on : 8/09/2026, 2:08:09 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.Usuario, java.util.List" %>
<!DOCTYPE html>
<html>
<head><title>Usuarios</title></head>
<body>
    <h2>Listado de Usuarios</h2>

    <a href="${pageContext.request.contextPath}/web/usuario/agregar.jsp">+ Nuevo usuario</a> |
    <a href="${pageContext.request.contextPath}/web/usuario/buscar.jsp">Buscar por ID</a>

    <table border="1" cellpadding="5">
        <tr>
            <th>ID</th><th>Nombre</th><th>Apellido</th><th>Email</th><th>Tipo</th><th>Acciones</th>
        </tr>
        <%
            // El Servlet guardó la lista en SESIÓN (llega por sendRedirect)
            List<Usuario> usuarios = (List<Usuario>) session.getAttribute("usuario.listar");
            if (usuarios != null) {
                for (Usuario u : usuarios) {
        %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getNombre() %></td>
            <td><%= u.getApellido() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getTipo() %></td>
            <td>
                <a href="${pageContext.request.contextPath}/usuarios?accion=buscar&id=<%= u.getId() %>&redir=modificar">Editar</a> |
                <a href="${pageContext.request.contextPath}/usuarios?accion=buscar&id=<%= u.getId() %>&redir=eliminar">Eliminar</a>
            </td>
        </tr>
        <% } } %>
    </table>
</body>
</html>