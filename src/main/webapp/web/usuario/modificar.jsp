<%-- 
    Document   : modificar
    Created on : 8/09/2026, 2:08:29 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.taxiflow.webapp.modelo.Usuario" %>
<!DOCTYPE html>
<html>
<head><title>Editar Usuario</title></head>
<body>
<center>
    <%
        Usuario u = (Usuario) session.getAttribute("usuario.buscar");
    %>
    <h2>Editar Usuario</h2>
    <p style="color:green"><%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "" %></p>

    <% if (u == null) { %>
        <p style="color:red">No hay ningún usuario cargado. Ve al listado y elige "Editar".</p>
    <% } else { %>
        <form action="${pageContext.request.contextPath}/usuarios" method="post">
            <input type="hidden" name="accion" value="modificar" />
            <!-- El id no se edita, pero debe reenviarse para que el UPDATE sepa a quién actualizar -->
            <input type="hidden" name="id" value="<%= u.getId() %>" />

            ID: <%= u.getId() %><br/>
            Contraseña: <input type="password" name="password" value="<%= u.getPassword() %>" required /><br/>
            Nombre: <input type="text" name="nombre" value="<%= u.getNombre() %>" required /><br/>
            Apellido: <input type="text" name="apellido" value="<%= u.getApellido() %>" required /><br/>
            Email: <input type="email" name="email" value="<%= u.getEmail() %>" required /><br/>
            Tipo:
            <select name="tipo">
                <option value="Cliente" <%= "Cliente".equals(u.getTipo()) ? "selected" : "" %>>Cliente</option>
                <option value="Taxista" <%= "Taxista".equals(u.getTipo()) ? "selected" : "" %>>Taxista</option>
                <option value="Administrador" <%= "Administrador".equals(u.getTipo()) ? "selected" : "" %>>Administrador</option>
            </select><br/>

            <button type="submit">Guardar cambios</button>
            <a href="${pageContext.request.contextPath}/usuarios?accion=listartodo">Cancelar</a>
        </form>
    <% } %>
<center>
</body>
</html>