<%-- 
    Document   : recuperarClave
    Created on : 9/09/2026, 5:43:59 p. m.
    Author     : CarlosN
--%>

<%-- 
    Documento: recuperarClave
    Formulario para solicitar el recordatorio de contraseña por correo.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String mensaje = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Recuperar Contraseña</title>
    </head>
    <body>
        <center>
            <h1>Recuperar Contraseña</h1>
            <hr/>
            <p>Escribe el email con el que te registraste y te enviaremos tu contraseña.</p>
            <form action="${pageContext.request.contextPath}/recuperar-clave" method="post">
                <table>
                    <tr>
                        <th style="text-align: right">Email:</th>
                        <td><input type="email" name="email" required/></td>
                    </tr>
                    <tr>
                        <th></th>
                        <td><input type="submit" value="Enviar"/></td>
                    </tr>
                </table>
            </form>
            <hr/>
            <p style="color:#FF0000;">
                <%= (mensaje != null && !mensaje.isEmpty()) ? mensaje : "" %>
            </p>
            <a href="${pageContext.request.contextPath}/web/usuario/login.jsp">Volver al login</a>
        </center>
    </body>
</html>