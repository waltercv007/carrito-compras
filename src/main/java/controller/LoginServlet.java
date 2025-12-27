package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Producto;

import java.io.IOException;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.Captura el REQUEST
		String codigo = request.getParameter("txtCodigo");
		String modelo=request.getParameter("txtModelo");
		//double precio=Double.parseDouble(request.getParameter("txtCantidad"));
		int stock=Integer.parseInt(request.getParameter("txtStock"));
		//String fechaVencimiento=request.getParameter("txtFechaVencimiento");
		//String gama=request.getParameter("rbGama");
		//String observacion=request.getParameter("txtObservacion");
		
		//2. Se comunica con el MODEL (DB)
		Producto objPro = new Producto();
		
		objPro.setCodigo(codigo);
		objPro.setModelo(modelo);
		objPro.setStock(stock);
		//3. Redireccionar a un VIEW
		request.setAttribute("objPro", objPro);
		request.getRequestDispatcher("RegistrarProducto.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		
		 String usuario = request.getParameter("usuario");
	        String rol = request.getParameter("rol");
	        String clave = request.getParameter("password");

	        boolean accesoValido = false;

	        switch (rol) {
	            case "Administrador":
	                if (clave.equals("Admin123")) accesoValido = true;
	                break;

	            case "Vendedor":
	                if (clave.equals("Vende123")) accesoValido = true;
	                break;

	            case "Técnico":
	                if (clave.equals("Tecni123")) accesoValido = true;
	                break;
	        }

	        if (accesoValido) {
	            request.getSession().setAttribute("usuario", usuario);
	            request.getSession().setAttribute("rol", rol);

	            response.sendRedirect("menu.jsp");
	        } else {
	            request.setAttribute("error", "Usuario, rol o contraseña incorrecta.");
	            request.getRequestDispatcher("RegistrarProducto.jsp").forward(request, response);
	        }
	    }
	}