<%-- 
    Document   : agregar
    Created on : 8/09/2026, 2:07:16 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Nuevo Usuario</title>
</head>
<body>
    <center>
        <h1>Nuevo Usuario</h1>
        <hr/>
        <form action="${pageContext.request.contextPath}/usuarios" method="post">
            <input type="hidden" name="accion" value="agregar" />
            <table>
                <tr>
                    <th style="text-align: right">ID:</th>
                    <td><input type="text" name="id" required/></td>
                </tr>
                <tr>
                    <th style="text-align: right">Contraseña:</th>
                    <td><input type="password" name="password" required/></td>
                </tr>
                <tr>
                    <th style="text-align: right">Nombre:</th>
                    <td><input type="text" name="nombre" required/></td>
                </tr>
                <tr>
                    <th style="text-align: right">Apellido:</th>
                    <td><input type="text" name="apellido" required/></td>
                </tr>
                <tr>
                    <th style="text-align: right">Email:</th>
                    <td><input type="email" name="email" required/></td>
                </tr>
                <tr>
                    <th style="text-align: right">Tipo:</th>
                    <td>
                        <select name="tipo">
                            <option value="Cliente">Cliente</option>
                            <option value="Taxista">Taxista</option>
                            <option value="Administrador">Administrador</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th></th>
                    <td>
                        <input type="submit" value="Guardar"/>
                        <input type="reset" value="Limpiar"/>
                    </td>
                </tr>
            </table>
        </form>
        <hr/>
        <p style="color:green">
            <%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "" %>
        </p>
        <a href="${pageContext.request.contextPath}/usuarios?accion=listartodo">Cancelar</a>
    </center>
</body>
</html>