<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Producto, java.util.List" %>
<% pageContext.setAttribute("pageTitle", "Gestión de Productos"); %>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="head.jsp" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-12">
        
        <!-- INICIO DEL FORMULARIO -->
        
        <%
        Producto producto = (Producto) request.getAttribute("producto");
        
        //Valores por defecto
        int id = 0;
        String codigo = "";
        String modelo = "";
        int stock = 0;
        double precio = 0.0;
        String imagen = "";
        String accionFormulario = "guardar";
        String tituloFormulario = "Crear Producto";
        String color = "primary";
        String boton = "Agregar";
        
        if (producto != null) {
            id = producto.getId();
            codigo = producto.getCodigo();
            modelo = producto.getModelo();
            stock = producto.getStock();
            precio = producto.getPrecio();
            imagen = producto.getImagen() != null ? producto.getImagen() : "";
            accionFormulario = "actualizar";
            tituloFormulario = "Editar Producto";
            color = "warning";
            boton = "Actualizar";
        }
        %>
        
        <form action="ProductoController" method="POST" class="needs-validation" novalidate>
            <h2 class="text-center"><%= tituloFormulario %></h2>
            <input type="hidden" name="accion" value="<%= accionFormulario %>">
            <input type="hidden" name="txtId" value="<%= id %>">
            
            <div class="mb-3">
                <label class="form-label">Código Producto</label>
                <input type="text" name="txtCodigo" value="<%= codigo %>" class="form-control" maxlength="6" placeholder="Código">
            </div>

            <!-- Categoría -->
            <div class="mb-3">
                <label for="categoria" class="form-label">Categoría</label>
                <select id="categoria" class="form-select">
                    <option value="">Seleccione una categoría</option>
                    <option value="gabinetes">Gabinetes</option>
                    <option value="laptops">Laptops</option>
                    <option value="monitores">Monitores</option>
                    <option value="componentes">Componentes</option>
                </select>
            </div>
            
            <!-- Subcategoría -->
            <div class="mb-3">
                <label for="subcategoria" class="form-label">Subcategoría</label>
                <select id="subcategoria" class="form-select">
                    <option value="">Seleccione una categoría primero</option>
                </select>
            </div>

            <!-- Modelo -->
            <div class="mb-3">
                <label for="modelo" class="form-label">Modelo del Producto</label>
                <select id="modelo" name="txtModelo" class="form-select">
                    <option value="<%= modelo %>"><%= (modelo != null && !modelo.isEmpty()) ? modelo : "Seleccione una subcategoría primero" %></option>
                </select>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Stock</label>
                <input type="number" name="txtStock" value="<%= stock %>" class="form-control" min="1">
            </div>
            
            <div class="mb-3">
                <label class="form-label">Precio</label>
                <input type="number" name="txtPrecio" value="<%= precio %>" class="form-control" step="0.5" min="1">
            </div>
            
            <div class="mb-3">
                <label class="form-label">URL Imagen</label>
                <input type="text" name="txtImagen" value="<%= imagen %>" placeholder="https://placehold.co/600x400" class="form-control">
            </div>
            
            <div class="mt-4">
                <input class="btn btn-<%= color %> w-100" type="submit" value="<%= boton %>">
            </div>
        </form>
        <!-- FIN DEL FORMULARIO -->
        </div>
        
        <div class="col-lg-8 col-md-6 col-sm-12">
        <!-- INICIO DE LA TABLA -->
        <h2 class="text-center">Listado de Productos</h2>
        <%
        List<Producto> lista = (List<Producto>) request.getAttribute("listaProductos");
        if(lista != null) {
        %>
            <table class="table table-striped table-hover mt-3">
              <thead>
                <tr class="text-center">
                  <th scope="col">ID</th>
                  <th scope="col">Código</th>
                  <th scope="col">Modelo</th>
                  <th scope="col">Stock</th>
                  <th scope="col">Precio</th>
                  <th scope="col">Imagen</th>
                  <th scope="col">Editar</th>
                  <th scope="col">Eliminar</th>
                </tr>
              </thead>
              
              <tbody>
              <%
              for (Producto objPro : lista) {
                  %>
                  <tr class="text-center">
                    <th scope="row"><%= objPro.getId() %></th>
                    <td><%= objPro.getCodigo() %></td>
                    <td><%= objPro.getModelo() %></td>
                    <td><%= objPro.getStock() %></td>
                    <td><%= String.format("%.2f", objPro.getPrecio()) %></td>
                    <td><img src="<%= (objPro.getImagen() != null && !objPro.getImagen().isEmpty()) ? objPro.getImagen() : "https://via.placeholder.com/40" %>" alt="imagen" style="width:40px;"/></td>
                    <td><a href="ProductoController?accion=editar&txtId=<%= objPro.getId() %>"><i class="bi bi-pencil-square text-warning"></i></a></td>
                    <td><a href="ProductoController?accion=eliminar&txtId=<%= objPro.getId() %>" onclick="return confirm('¿Está seguro de eliminar este producto?');"><i class="bi bi-trash-fill text-danger"></i></a></td>
                  </tr>
              <%
              }
              %>
              </tbody>
            </table>
        <%
        }
        %>

        </div>
        <!-- FIN DE LA TABLA -->
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const subcategoriasPorCategoria = {
            gabinetes: ['Gabinete ATX', 'Gabinete Micro ATX', 'Gabinete Mini ITX', 'Gabinete Gamer RGB'],
            laptops: ['Laptop Intel', 'Laptop AMD', 'Laptop Gamer', 'Ultrabook'],
            monitores: ['Monitor 21 pulgadas', 'Monitor 24 pulgadas', 'Monitor 27 pulgadas', 'Monitor Gamer 144Hz'],
            componentes: ['Procesadores', 'Tarjetas Madre', 'RAM', 'Tarjetas de Video', 'Fuentes de Poder']
        };

        const modelosPorSubcategoria = {
            "Gabinete ATX": ["ATX CoolerMaster", "ATX Corsair", "ATX Gamemax"],
            "Gabinete Micro ATX": ["Micro ATX Asus", "Micro ATX Halion"],
            "Gabinete Mini ITX": ["Mini ITX NZXT", "Mini ITX Thermaltake"],
            "Gabinete Gamer RGB": ["RGB Redragon", "RGB Antryx", "RGB Kolink"],
            "Laptop Intel": ["Intel i3", "Intel i5", "Intel i7"],
            "Laptop AMD": ["Ryzen 3", "Ryzen 5", "Ryzen 7"],
            "Laptop Gamer": ["Asus TUF", "Acer Nitro", "Lenovo Legion"],
            "Ultrabook": ["Dell XPS", "HP Envy", "Samsung Galaxy Book"],
            "Monitor 21 pulgadas": ["Samsung 21", "LG 21"],
            "Monitor 24 pulgadas": ["LG 24", "ASUS 24"],
            "Monitor 27 pulgadas": ["BenQ 27", "LG 27"],
            "Monitor Gamer 144Hz": ["MSI Optix", "AOC Gamer"],
            "Procesadores": ["Intel 12400F", "Ryzen 5600G", "Ryzen 5700X"],
            "Tarjetas Madre": ["MSI B450", "ASUS Z690", "Gigabyte B660"],
            "RAM": ["8GB DDR4", "16GB DDR4", "32GB DDR5"],
            "Tarjetas de Video": ["RTX 4060", "RTX 3060", "GTX 1650"],
            "Fuentes de Poder": ["600W EVGA", "500W Corsair", "750W CoolerMaster"]
        };

        const categoriaSelect = document.getElementById('categoria');
        const subcategoriaSelect = document.getElementById('subcategoria');
        const modeloSelect = document.getElementById('modelo');

        categoriaSelect.addEventListener('change', function () {
            const selectedCategory = this.value;
            
            subcategoriaSelect.innerHTML = '<option value="">Seleccione una subcategoría</option>';
            modeloSelect.innerHTML = '<option value="">Seleccione una subcategoría primero</option>';

            if (selectedCategory && subcategoriasPorCategoria[selectedCategory]) {
                const subcategorias = subcategoriasPorCategoria[selectedCategory];
                subcategorias.forEach(function (sub) {
                    const option = document.createElement('option');
                    option.value = sub;
                    option.textContent = sub;
                    subcategoriaSelect.appendChild(option);
                });
            }
        });

        subcategoriaSelect.addEventListener('change', function () {
            const selectedSubcategory = this.value;

            modeloSelect.innerHTML = '<option value="">Seleccione un modelo</option>';

            if (selectedSubcategory && modelosPorSubcategoria[selectedSubcategory]) {
                const modelos = modelosPorSubcategoria[selectedSubcategory];
                modelos.forEach(function (modelo) {
                    const option = document.createElement('option');
                    option.value = modelo;
                    option.textContent = modelo;
                    modeloSelect.appendChild(option);
                });
            }
        });
    });
</script>

<jsp:include page="footer.jsp" />
</html>