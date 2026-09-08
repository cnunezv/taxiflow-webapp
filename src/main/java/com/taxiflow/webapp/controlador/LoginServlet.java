package com.taxiflow.webapp.controlador;

import com.taxiflow.webapp.dao.UsuarioDAO;
import com.taxiflow.webapp.modelo.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet encargado exclusivamente de iniciar y cerrar sesión.
 * urlPatterns = "/login" debe coincidir con el action del formulario en login.jsp.
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion"); // "login" o "logout"
        String ctx = request.getContextPath();

        if ("logout".equals(accion)) {
            // Cierra sesión: invalida todo y regresa al login.
            request.getSession().invalidate();
            response.sendRedirect(ctx + "/web/usuario/login.jsp?mensaje=Sesión cerrada");
            return;
        }

        // Caso login: recupera credenciales del formulario
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        try {
            UsuarioDAO dao = new UsuarioDAO();
            Usuario usuario = dao.iniciarSesion(id, password);

            if (usuario != null) {
                // Credenciales correctas: guarda el usuario en la sesión y va al menú.
                HttpSession session = request.getSession();
                session.setAttribute("usuario.login", usuario);
                response.sendRedirect(ctx + "/index.jsp");
            } else {
                // Credenciales incorrectas: vuelve al login con mensaje de error.
                response.sendRedirect(ctx + "/web/usuario/login.jsp?mensaje=ID o contraseña incorrectos");
            }
        } catch (Exception e) {
            // Error de conexión u otro problema: muestra el mensaje en el login.
            response.sendRedirect(ctx + "/web/usuario/login.jsp?mensaje=" + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // permite logout por link (GET) reutilizando la misma lógica
    }
}