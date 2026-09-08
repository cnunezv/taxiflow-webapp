<%-- 
    Documento: login
    Formulario de inicio de sesión para TaxiFlow.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Recupera el mensaje de error/confirmación si viene de un intento anterior
    String mensaje = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFlow - Iniciar Sesión</title>
    </head>
    <body>
        <center>
            <h1>Iniciar Sesión en TaxiFlow</h1>
            <hr/>
            <!-- action apunta al LoginServlet (urlPatterns = "/login").
                 Usamos contextPath para que la ruta funcione sin importar
                 desde qué subcarpeta (web/usuario/) se cargue esta página. -->
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="hidden" name="accion" value="login"/>
                <table>
                    <tr>
                        <th style="text-align: right">ID:</th>
                        <td><input type="text" name="id"/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Password:</th>
                        <td><input type="password" name="password"/></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <input type="submit" value="ENTRAR"/>
                            <input type="reset" value="Restablecer"/>
                        </td>
                    </tr>
                </table>
            </form>
            <hr/>
            <p style="color:#FF0000;">
                <%= (mensaje != null && !mensaje.isEmpty()) ? mensaje : "" %>
            </p>

            <!-- Enlace para la recuperación de clave por correo (requisito 8 de la actividad) -->
            <p><a href="${pageContext.request.contextPath}/web/usuario/recuperarClave.jsp">¿Olvidaste tu contraseña?</a></p>
        </center>
    </body>
</html>