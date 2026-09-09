package com.taxiflow.webapp.controlador;

import com.taxiflow.webapp.dao.UsuarioDAO;
import com.taxiflow.webapp.modelo.Usuario;
import com.taxiflow.webapp.util.EnvioCorreo;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet que envía por correo la contraseña actual del usuario
 * cuando este la ha olvidado (recordatorio de clave).
 */
@WebServlet(name = "RecuperarClaveServlet", urlPatterns = {"/recuperar-clave"})
public class RecuperarClaveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Muestra el formulario donde el usuario escribe su email
        request.getRequestDispatcher("/web/usuario/recuperarClave.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String ctx = request.getContextPath();
        String email = request.getParameter("email");

        try {
            UsuarioDAO dao = new UsuarioDAO();
            Usuario usuario = dao.consultarPorEmail(email);

            if (usuario == null) {
                response.sendRedirect(ctx + "/recuperar-clave?mensaje="
                        + URLEncoder.encode("No existe ningún usuario registrado con ese email", StandardCharsets.UTF_8));
                return;
            }

            // Envía la contraseña actual por correo (recordatorio de clave)
            String asunto = "TaxiFlow - Recordatorio de contraseña";
            String cuerpo = "Hola" + usuario.getNombre() + ", gran pendejo,\n\n"
                    + "Tu contraseña actual en TaxiFlow es: " + usuario.getPassword() + "\n\n"
                    + "Si no solicitaste este correo, ignóralo.";

            EnvioCorreo.enviarCorreo(usuario.getEmail(), asunto, cuerpo);

            response.sendRedirect(ctx + "/web/usuario/login.jsp?mensaje="
                    + URLEncoder.encode("Te enviamos tu contraseña al correo registrado", StandardCharsets.UTF_8));

        } catch (Exception e) {
            response.sendRedirect(ctx + "/recuperar-clave?mensaje="
                    + URLEncoder.encode("Error al enviar el correo: " + e.getMessage(), StandardCharsets.UTF_8));
        }
    }
}