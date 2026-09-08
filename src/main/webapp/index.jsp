<%-- 
    Documento: index
    Página de entrada de la aplicación TaxiFlow.
    Verifica si hay sesión activa; si no la hay, redirige al login.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Si no hay usuario logueado en la sesión, se redirige a la página de login.
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFlow - Menú Principal</title>
    </head>
    <body>
        <center>
            <h2>Menú de TaxiFlow</h2>
            <hr/>
            <table border="0">
                <tr><td><a href="web/usuario/agregar.jsp">Agregar Usuario</a></td></tr>
                <tr><td><a href="web/usuario/listar.jsp">Listar Usuarios</a></td></tr>
                <tr><td><a href="web/carreraTaxi/agregar.jsp">Agregar Carrera</a></td></tr>
                <tr><td><a href="web/carreraTaxi/listar.jsp">Listar Carreras</a></td></tr>
                <tr><td><a href="UsuarioServlet?accion=logout">Salir</a></td></tr>
            </table>
            <hr/>
        </center>
    </body>
</html>