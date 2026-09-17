<%-- 
    Document   : eliminar
    Created on : 8/09/2026, 2:07:59 p. m.
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
<head><title>Eliminar Usuario</title></head>
<body>
    <%
        Usuario u = (Usuario) session.getAttribute("usuario.buscar");
    %>
    <h2>¿Eliminar este usuario?</h2>
    <p style="color:green"><%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "" %></p>

    <% if (u != null) { %>
        <p>
            <b>ID:</b> <%= u.getId() %> —
            <b>Nombre:</b> <%= u.getNombre() %> <%= u.getApellido() %> —
            <b>Email:</b> <%= u.getEmail() %> —
            <b>Tipo:</b> <%= u.getTipo() %>
        </p>

        <form action="${pageContext.request.contextPath}/usuarios" method="get">
            <input type="hidden" name="accion" value="eliminar" />
            <input type="hidden" name="id" value="<%= u.getId() %>" />
            <button type="submit">Sí, eliminar</button>
            <a href="${pageContext.request.contextPath}/usuarios?accion=listartodo">Cancelar</a>
        </form>
    <% } else { %>
        <p style="color:red">No hay ningún usuario cargado. Ve al listado y elige "Eliminar".</p>
    <% } %>
</body>
</html>