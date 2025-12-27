<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Producto" %>
<% pageContext.setAttribute("pageTitle", "Catálogo de Productos"); %>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="head.jsp" />
    <style>
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
    </style>
</head>

<jsp:include page="header.jsp" />

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
                    <img src="<%= (p.getImagen() != null && !p.getImagen().isEmpty()) ? p.getImagen() : "https://via.placeholder.com/200" %>" class="card-img-top" alt="<%= p.getModelo() %>">
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

<jsp:include page="footer.jsp" />
