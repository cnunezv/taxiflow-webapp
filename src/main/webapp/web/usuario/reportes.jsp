<%-- 
    Documento: reportes (Usuario)
    Pantalla con los DOS reportes parametrizados exigidos por la actividad
    para la entidad Usuario:
      1) por rol/tipo de usuario
      2) por dominio de correo electronico
    Los resultados llegan en los atributos 'resultados' y 'criterio' que
    coloca UsuarioServlet.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.taxiflow.webapp.modelo.Usuario"%>
<%@page import="java.util.List"%>
<%
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
    List<Usuario> resultados = (List<Usuario>) request.getAttribute("resultados");
    String criterio = (String) request.getAttribute("criterio");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes de Usuarios</title>
    </head>
    <body>
        <center>
            <h1>Reportes de Usuarios</h1>
            <hr/>

            <h3>Reporte 1: por rol / tipo de usuario</h3>
            <form action="${pageContext.request.contextPath}/usuarios" method="get">
                <input type="hidden" name="accion" value="reportePorTipo"/>
                Tipo:
                <select name="tipo">
                    <option value="Cliente">Cliente</option>
                    <option value="Taxista">Taxista</option>
                    <option value="Administrador">Administrador</option>
                </select>
                <input type="submit" value="Generar reporte"/>
            </form>

            <h3>Reporte 2: por dominio de correo electr&oacute;nico</h3>
            <form action="${pageContext.request.contextPath}/usuarios" method="get">
                <input type="hidden" name="accion" value="reportePorDominio"/>
                Dominio (ej. taxiflow.com):
                <input type="text" name="dominio" required/>
                <input type="submit" value="Generar reporte"/>
            </form>

            <hr/>
            <% if (criterio != null) { %>
                <h3>Resultados (<%= criterio %>)</h3>
                <table border="1" cellpadding="5">
                    <thead>
                        <tr>
                            <th>ID</th><th>Nombre</th><th>Apellido</th><th>Email</th><th>Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (resultados != null && !resultados.isEmpty()) {
                            for (Usuario u : resultados) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getNombre() %></td>
                            <td><%= u.getApellido() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getTipo() %></td>
                        </tr>
                        <%   }
                        } else { %>
                        <tr><td colspan="5">No se encontraron resultados.</td></tr>
                        <%  } %>
                    </tbody>
                </table>
                <p>Total encontrados: <%= (resultados == null ? 0 : resultados.size()) %></p>
            <% } %>

            <hr/>
            <a href="${pageContext.request.contextPath}/usuarios?accion=listartodo">Volver al listado</a>
            &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/index.jsp">Volver al men&uacute;</a>
        </center>
    </body>
</html>
