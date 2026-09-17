package com.taxiflow.webapp.controlador;

import com.taxiflow.webapp.dao.UsuarioDAO;
import com.taxiflow.webapp.modelo.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet controlador para el CRUD de Usuario.
 * Recibe el parámetro 'accion' desde los formularios JSP y decide
 * qué operación del UsuarioDAO invocar.
 */
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/usuarios"})
public class UsuarioServlet extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // <-- evita el problema de la ñ/tildes
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        String ctx = request.getContextPath();

        // Control de acceso: ninguna operacion sobre usuarios sin sesion iniciada.
        if (request.getSession().getAttribute("usuario.login") == null) {
            response.sendRedirect(ctx + "/web/usuario/login.jsp?mensaje=Inicia sesion para continuar");
            return;
        }

        try {
            if ("agregar".equals(accion)) {
                // Alta: aquí el id SÍ se pide porque lo escribe la persona (no es autogenerado)
                Usuario u = new Usuario();
                u.setId(request.getParameter("id"));
                u.setPassword(request.getParameter("password"));
                u.setNombre(request.getParameter("nombre"));
                u.setApellido(request.getParameter("apellido"));
                u.setEmail(request.getParameter("email"));
                u.setTipo(request.getParameter("tipo"));
                dao.agregar(u);
                response.sendRedirect(ctx + "/web/usuario/agregar.jsp?mensaje=Usuario agregado correctamente");

            } else if ("modificar".equals(accion)) {
                Usuario u = new Usuario();
                u.setId(request.getParameter("id"));
                u.setPassword(request.getParameter("password"));
                u.setNombre(request.getParameter("nombre"));
                u.setApellido(request.getParameter("apellido"));
                u.setEmail(request.getParameter("email"));
                u.setTipo(request.getParameter("tipo"));
                dao.modificar(u);
                response.sendRedirect(ctx + "/web/usuario/modificar.jsp?mensaje=Usuario modificado correctamente");

            } else if ("eliminar".equals(accion)) {
                dao.eliminar(request.getParameter("id"));
                response.sendRedirect(ctx + "/web/usuario/eliminar.jsp?mensaje=Usuario eliminado correctamente");

            } else if ("buscar".equals(accion)) {
                // Busca por id y guarda en SESIÓN, porque el sendRedirect pierde los atributos del request
                Usuario u = dao.consultar(request.getParameter("id"));
                request.getSession().setAttribute("usuario.buscar", u);
                String redir = request.getParameter("redir"); // a qué JSP volver: buscar/modificar/eliminar
                response.sendRedirect(ctx + "/web/usuario/" + redir + ".jsp");

            } else if ("listartodo".equals(accion)) {
                List<Usuario> lista = dao.listarTodos();
                request.getSession().setAttribute("usuario.listar", lista);
                response.sendRedirect(ctx + "/web/usuario/listar.jsp");

            } else if ("reportes".equals(accion)) {
                // Pantalla con los DOS reportes parametrizados de Usuario (aun sin resultados)
                request.getRequestDispatcher("/web/usuario/reportes.jsp").forward(request, response);

            } else if ("reportePorTipo".equals(accion)) {
                // Reporte parametrizado 1: usuarios por rol/tipo
                String tipo = request.getParameter("tipo");
                request.setAttribute("resultados", dao.reportePorTipo(tipo));
                request.setAttribute("criterio", "Rol / tipo de usuario: " + tipo);
                request.getRequestDispatcher("/web/usuario/reportes.jsp").forward(request, response);

            } else if ("reportePorDominio".equals(accion)) {
                // Reporte parametrizado 2: usuarios por dominio de correo
                String dominio = request.getParameter("dominio");
                request.setAttribute("resultados", dao.reportePorDominioEmail(dominio));
                request.setAttribute("criterio", "Dominio de correo: @" + dominio);
                request.getRequestDispatcher("/web/usuario/reportes.jsp").forward(request, response);

            } else {
                response.sendRedirect(ctx + "/index.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect(ctx + "/web/mensaje.jsp?mensaje=" + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}