<%-- 
    Document   : agregar
    Created on : 8/09/2026, 5:57:56 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Nueva Carrera</title></head>
<body>
    <h2>Nueva Carrera</h2>
    <p style="color:red"><%= request.getParameter("mensaje") != null ? request.getParameter("mensaje") : "" %></p>

    <!-- Siempre vacío: no hay id porque es un alta -->
    <form action="${pageContext.request.contextPath}/CarreraTaxiServlet" method="post">
        Cliente: <input type="text" name="cliente" required /><br/>
        Taxi: <input type="text" name="taxi" required /><br/>
        Kilómetros: <input type="number" step="0.1" name="kilometros" required /><br/>
        Barrio inicio: <input type="text" name="barrioInicio" required /><br/>
        Barrio llegada: <input type="text" name="barrioLlegada" required /><br/>
        Pasajeros: <input type="number" name="cantidadPasajeros" required /><br/>
        Taxista: <input type="text" name="taxista" required /><br/>
        Precio: <input type="number" step="0.01" name="precio" required /><br/>
        Duración (min): <input type="number" name="duracionMinutos" required /><br/>

        <button type="submit">Guardar</button>
        <a href="${pageContext.request.contextPath}/CarreraTaxiServlet?accion=listar">Cancelar</a>
    </form>
</body>
</html>