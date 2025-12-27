package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User; // Import the User model

import java.io.IOException;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginController() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("accion");
		
		if ("logout".equals(accion)) {
			HttpSession session = request.getSession(false); // Do not create a new session if one doesn't exist
			if (session != null) {
				session.invalidate(); // Invalidate the session
			}
			response.sendRedirect("Login.jsp"); // Redirect to login page
		} else {
			// If no action or unrecognized action, perhaps redirect to login form
			response.sendRedirect("Login.jsp"); 
		}
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("usuario"); // Matches your form field name
		String password = request.getParameter("password");

		// Authenticate using the User model
		User authenticatedUser = User.authenticate(username, password);

		if (authenticatedUser != null) {
			// Login successful
			HttpSession session = request.getSession();
			session.setAttribute("user", authenticatedUser); // Store the User object in session
			
			// Redirect to the product catalog
			response.sendRedirect("ProductoController?accion=mostrarCatalogo"); 
		} else {
			// Login failed
			request.setAttribute("error", "Usuario o contraseña incorrectos.");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
	}
}
