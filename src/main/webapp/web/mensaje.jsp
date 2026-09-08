<%-- 
    Document   : mensaje
    Created on : 8/09/2026, 6:10:04 p. m.
    Author     : CarlosN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Mensaje</title></head>
<body>
    <h2>Aviso</h2>
    <p style="color:red"><%= request.getParameter("mensaje") %></p>
    <a href="${pageContext.request.contextPath}/index.jsp">Volver al inicio</a>
</body>
</html>