<%-- 
    Document   : agregar
    Created on : 8/09/2026, 5:57:56 p. m.
    Author     : CarlosN
--%>

<%-- 
    Documento: agregar (CarreraTaxi)
    Formulario para registrar una nueva carrera de taxi.
    No lleva campo 'id': el Servlet interpreta la ausencia de 'id' como un alta (INSERT).
--%>
<%-- 
    Documento: agregar (CarreraTaxi)
    Formulario para registrar una nueva carrera de taxi.
    No lleva campo 'id': el Servlet interpreta la ausencia de 'id' como un alta (INSERT).
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Solo usuarios con sesión activa pueden acceder a este formulario.
    if (session.getAttribute("usuario.login") == null) {
        getServletContext().getRequestDispatcher("/web/usuario/login.jsp").forward(request, response);
        return;
    }
    // Si el Servlet redirigió aquí tras un error (accion=nueva&mensaje=...),
    // el mensaje llega como parámetro de query string.
    String mensaje = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Carrera de Taxi</title>
    </head>
    <body>
        <center>
            <h1>Agregar Carrera de Taxi</h1>
            <hr/>
            <!-- method="post" hace que llegue a doPost() del Servlet.
                 Como no se envía 'id', el Servlet ejecuta dao.agregar(c). -->
            <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="post">
                <table>
                    <tr>
                        <th style="text-align: right">Cliente:</th>
                        <td><input type="text" name="cliente" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Taxi (placa):</th>
                        <td><input type="text" name="taxi" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Kilómetros:</th>
                        <td><input type="number" step="0.1" name="kilometros" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Barrio de Inicio:</th>
                        <td><input type="text" name="barrioInicio" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Barrio de Llegada:</th>
                        <td><input type="text" name="barrioLlegada" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Cantidad de Pasajeros:</th>
                        <td><input type="number" name="cantidadPasajeros" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Taxista:</th>
                        <td><input type="text" name="taxista" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Precio:</th>
                        <td><input type="number" step="0.01" name="precio" required/></td>
                    </tr>
                    <tr>
                        <th style="text-align: right">Duración (minutos):</th>
                        <td><input type="number" name="duracionMinutos" required/></td>
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
<p style="color:#FF0000;">
    <%= (mensaje != null && !mensaje.isEmpty()) ? mensaje : "" %>
</p>
<a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Volver al listado</a>
&nbsp;|&nbsp;
<a href="${pageContext.request.contextPath}/index.jsp">Volver al menú</a>
        </center>
    </body>
</html>