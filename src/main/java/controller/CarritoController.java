package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cart;
import model.Producto;

import java.io.IOException;
import java.util.List;

@WebServlet("/CarritoController")
public class CarritoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Cart cartModel = new Cart();

    /**
     * Handles GET requests. By default, it lists the items in the cart.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        // Default action is to list the cart contents
        if (accion == null || "listar".equals(accion)) {
            listarCarrito(request, response);
        }
    }

    /**
     * Handles POST requests for adding or removing items from the cart.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "agregar":
                    agregarAlCarrito(request, response);
                    break;
                case "eliminar":
                    eliminarDelCarrito(request, response);
                    break;
                default:
                    // Redirect to cart view if action is unknown
                    response.sendRedirect("CarritoController?accion=listar");
                    break;
            }
        } else {
            response.sendRedirect("CarritoController?accion=listar");
        }
    }

    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            cartModel.addProduct(idProducto);
        } catch (NumberFormatException e) {
            // Handle error if ID is not a valid number
            e.printStackTrace();
        }
        // Redirect back to the catalog so the user can continue shopping
        response.sendRedirect("ProductoController?accion=mostrarCatalogo");
    }

    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            cartModel.removeProduct(idProducto);
        } catch (NumberFormatException e) {
            // Handle error if ID is not a valid number
            e.printStackTrace();
        }
        // Redirect back to the cart view to show the updated list
        response.sendRedirect("CarritoController?accion=listar");
    }

    private void listarCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Producto> listaProductosCarrito = cartModel.getCartProducts();
        request.setAttribute("listaProductosCarrito", listaProductosCarrito);
        request.getRequestDispatcher("carrito.jsp").forward(request, response);
    }
}
