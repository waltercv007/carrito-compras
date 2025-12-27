<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Producto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Productos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">Mi Tienda</a>
            <a href="CarritoController?accion=listar" class="btn btn-outline-primary">
                Carrito <span class="badge bg-primary text-white ms-1 rounded-pill">${cartCount}</span>
            </a>
        </div>
    </nav>

    <div class="container mt-4">
        <h1 class="mb-4">Nuestro Catálogo</h1>
        <div class="row">
            <% 
                List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
                if (listaProductos != null && !listaProductos.isEmpty()) {
                    for (Producto p : listaProductos) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="<%= (p.getImagen() != null && !p.getImagen().isEmpty()) ? p.getImagen() : "https://placehold.co/600x400" %>" class="card-img-top" alt="<%= p.getModelo() %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= p.getModelo() %></h5>
                        <p class="card-text">Precio: S/ <%= String.format("%.2f", p.getPrecio()) %></p>
                        <p class="card-text">Stock: <%= p.getStock() %></p>
                        <form action="CarritoController" method="post">
                            <input type="hidden" name="accion" value="agregar">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button type="submit" class="btn btn-primary">Agregar al Carrito</button>
                        </form>
                    </div>
                </div>
            </div>
            <% 
                    }
                } else {
            %>
            <div class="col">
                <p>No hay productos disponibles en este momento.</p>
            </div>
            <% 
                }
            %>
        </div>
    </div>
    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
