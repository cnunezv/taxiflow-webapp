<%-- 
    Document   : agregar
    Created on : 8/09/2026, 2:07:16 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Nuevo Usuario</title></head>
<body>
    <h2>Nuevo Usuario</h2>
    <p style="color:green"><%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "" %></p>

    <form action="${pageContext.request.contextPath}/usuarios" method="post">
        <input type="hidden" name="accion" value="agregar" />

        ID: <input type="text" name="id" required /><br/>
        Contraseña: <input type="password" name="password" required /><br/>
        Nombre: <input type="text" name="nombre" required /><br/>
        Apellido: <input type="text" name="apellido" required /><br/>
        Email: <input type="email" name="email" required /><br/>
        Tipo:
        <select name="tipo">
            <option value="Cliente">Cliente</option>
            <option value="Taxista">Taxista</option>
            <option value="Administrador">Administrador</option>
        </select><br/>

        <button type="submit">Guardar</button>
        <a href="${pageContext.request.contextPath}/usuarios?accion=listartodo">Cancelar</a>
    </form>
</body>
</html>