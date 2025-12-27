<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        SERVICAS
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                 <li class="nav-item">
                    <a class="nav-link" href="ProductoController?accion=mostrarCatalogo">Catálogo</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ProductoController?accion=listar">Admin Productos</a>
                </li>
            </ul>
            
            <!-- Login/Logout and Cart Buttons -->
            <div class="d-flex align-items-center">
                <a href="CarritoController?accion=listar" class="btn btn-outline-primary me-2">
                    Carrito <span class="badge bg-primary text-white ms-1 rounded-pill">${cartCount}</span>
                </a>

                <% if (session.getAttribute("user") != null) { %>
                    <span class="navbar-text me-2">
                        Bienvenido, ${user.username}!
                    </span>
                    <a href="LoginController?accion=logout" class="btn btn-outline-secondary">Logout</a>
                <% } else { %>
                    <a href="Login.jsp" class="btn btn-outline-success">Login</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>
<body> <!-- The opening body tag is placed here to wrap all page content -->
