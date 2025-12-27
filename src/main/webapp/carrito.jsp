<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Producto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Carrito de Compras</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">Mi Carrito de Compras</h1>
        
        <% 
            List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductosCarrito");
            if (listaProductos != null && !listaProductos.isEmpty()) {
                double total = 0.0;
        %>
        <table class="table align-middle">
            <thead>
                <tr>
                    <th scope="col">Producto</th>
                    <th scope="col">Modelo</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Acción</th>
                </tr>
            </thead>
            <tbody>
            <% 
                for (Producto p : listaProductos) {
                    total += p.getPrecio();
            %>
                <tr>
                    <td>
                        <img src="<%= (p.getImagen() != null && !p.getImagen().isEmpty()) ? p.getImagen() : "https://via.placeholder.com/80" %>" class="product-image" alt="<%= p.getModelo() %>">
                    </td>
                    <td><%= p.getModelo() %></td>
                    <td>S/ <%= p.getPrecio() %></td>
                    <td>
                        <form action="CarritoController" method="post" style="display:inline;">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                        </form>
                    </td>
                </tr>
            <% 
                }
            %>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="2" class="text-end"><strong>Total:</strong></td>
                    <td colspan="2"><strong>S/ <%= total %></strong></td>
                </tr>
            </tfoot>
        </table>
        
        <div class="d-flex justify-content-between mt-4">
             <a href="ProductoController?accion=mostrarCatalogo" class="btn btn-secondary">Seguir Comprando</a>
             <button type="button" class="btn btn-success">Proceder al Pago</button>
        </div>

        <% 
            } else {
        %>
            <div class="alert alert-info" role="alert">
                Tu carrito de compras está vacío.
            </div>
            <a href="ProductoController?accion=mostrarCatalogo" class="btn btn-primary">Ver Catálogo</a>
        <% 
            }
        %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
