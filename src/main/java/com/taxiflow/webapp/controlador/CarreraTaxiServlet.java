package com.taxiflow.webapp.controlador;

import com.taxiflow.webapp.dao.CarreraTaxiDAO;
import com.taxiflow.webapp.modelo.CarreraTaxi;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet("/CarreraTaxiServlet")
public class CarreraTaxiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Control de acceso: ninguna operacion sobre carreras sin sesion iniciada.
        if (request.getSession().getAttribute("usuario.login") == null) {
            response.sendRedirect(request.getContextPath() + "/web/usuario/login.jsp?mensaje=Inicia sesion para continuar");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        CarreraTaxiDAO dao = new CarreraTaxiDAO();

        try {
            switch (accion) {

                case "listar":
                    // Trae todas las filas y las manda a listar.jsp
                    request.setAttribute("carreras", dao.listarTodas());
                    request.getRequestDispatcher("/web/carrera/listar.jsp")
                           .forward(request, response);
                    break;

                case "nueva":
                    // Muestra el formulario vacío de alta
                    request.getRequestDispatcher("/web/carrera/agregar.jsp")
                           .forward(request, response);
                    break;

                case "editar":
                    // Trae la carrera existente y la manda a modificar.jsp para precargar el form
                    int idEditar = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("carrera", dao.consultar(idEditar));
                    request.getRequestDispatcher("/web/carrera/modificar.jsp")
                           .forward(request, response);
                    break;

                case "confirmarEliminar":
                    // Muestra la pantalla de confirmación (eliminar.jsp) antes de borrar
                    int idConfirmar = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("carrera", dao.consultar(idConfirmar));
                    request.getRequestDispatcher("/web/carrera/eliminar.jsp")
                           .forward(request, response);
                    break;

                case "eliminar":
                    // Ejecuta el DELETE real (llega desde el botón "Sí, eliminar" de eliminar.jsp)
                    int idEliminar = Integer.parseInt(request.getParameter("id"));
                    dao.eliminar(idEliminar);
                    response.sendRedirect(request.getContextPath()
                            + "/CarreraTaxiServlet?accion=listar");
                    break;

                case "buscar":
                    // Muestra el formulario de búsqueda (sin resultados todavía)
                    request.getRequestDispatcher("/web/carrera/buscar.jsp")
                           .forward(request, response);
                    break;

                case "buscarPorBarrio":
                    // Ejecuta el reporte parametrizado 1 y muestra resultados en buscar.jsp
                    String barrio = request.getParameter("barrio");
                    List<CarreraTaxi> porBarrio = dao.reportePorBarrioInicio(barrio);
                    request.setAttribute("resultados", porBarrio);
                    request.setAttribute("criterio", "Barrio de inicio: " + barrio);
                    request.getRequestDispatcher("/web/carrera/buscar.jsp")
                           .forward(request, response);
                    break;

                case "buscarPorPrecio":
                    // Ejecuta el reporte parametrizado 2 y muestra resultados en buscar.jsp
                    double precioMinimo = Double.parseDouble(request.getParameter("precioMinimo"));
                    List<CarreraTaxi> porPrecio = dao.reportePorPrecioMinimo(precioMinimo);
                    request.setAttribute("resultados", porPrecio);
                    request.setAttribute("criterio", "Precio mínimo: " + precioMinimo);
                    request.getRequestDispatcher("/web/carrera/buscar.jsp")
                           .forward(request, response);
                    break;

                default:
                    response.sendRedirect(request.getContextPath()
                            + "/CarreraTaxiServlet?accion=listar");
            }
        } catch (Exception e) {
            request.setAttribute("mensaje", "Error: " + e.getMessage());
            request.getRequestDispatcher("/web/carrera/listar.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Control de acceso: ninguna operacion sobre carreras sin sesion iniciada.
        if (request.getSession().getAttribute("usuario.login") == null) {
            response.sendRedirect(request.getContextPath() + "/web/usuario/login.jsp?mensaje=Inicia sesion para continuar");
            return;
        }

        String ctx = request.getContextPath();
        CarreraTaxiDAO dao = new CarreraTaxiDAO();

        try {
            CarreraTaxi c = new CarreraTaxi();
            c.setCliente(request.getParameter("cliente"));
            c.setTaxi(request.getParameter("taxi"));
            c.setKilometros(Double.parseDouble(request.getParameter("kilometros")));
            c.setBarrioInicio(request.getParameter("barrioInicio"));
            c.setBarrioLlegada(request.getParameter("barrioLlegada"));
            c.setCantidadPasajeros(Integer.parseInt(request.getParameter("cantidadPasajeros")));
            c.setTaxista(request.getParameter("taxista"));
            c.setPrecio(Double.parseDouble(request.getParameter("precio")));
            c.setDuracionMinutos(Integer.parseInt(request.getParameter("duracionMinutos")));

            // id vacío = alta (agregar.jsp); id con valor = edición (modificar.jsp)
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                c.setId(Integer.parseInt(id));
                dao.modificar(c);
            } else {
                dao.agregar(c);
            }

            response.sendRedirect(ctx + "/CarreraTaxiServlet?accion=listar");

        } catch (Exception e) {
            response.sendRedirect(ctx + "/CarreraTaxiServlet?accion=nueva&mensaje="
                    + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8));
        }
    }
}