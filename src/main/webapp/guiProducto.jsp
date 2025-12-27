<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="model.Producto" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registro de Productos</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body class="container">

<h1 class="bg-primary text-white text-center">SERVICAS GROUP E.I.R.L</h1>

<div class="row">
	<div  class="col-lg-4 col-md-6 col-sm-12">
	
	<!-- INICIO DEL FORMULARIO -->
	
	<%
	Producto producto = (Producto) request.getAttribute("producto");
	
	//Valores por defecto
	int id = 0;
	String codigo = "";
	String modelo = "";
	int stock = 0;
	double precio = 0.0;
	String accionFormulario = "guardar";
	String tituloFormulario = "Crear Producto";
	String color = "primary";
	String boton = "agragar";
	
	if (producto != null) {
		id = producto.getId();
		codigo = producto.getCodigo();
		modelo = producto.getModelo();
		stock = producto.getStock();
		precio = producto.getPrecio();
		accionFormulario = "actualizar";
		tituloFormulario = "Editar Producto";
		color = "primary";
		boton = "Editar";
	}
	%>
	
	<form action="ProductoController" method="POST" class="needs-validation" novalidate>
		<h2 class="text-center"><%= tituloFormulario %></h2>
	    <input type="hidden" name="accion" value="<%= accionFormulario %>">
	    
	    <input type="hidden" name="id" value="<%= id %>">
	    
	    <label class="form-label">Código Producto</label>
	    <input type="text" name="txtCodigo" value="<%= codigo %>" class="form-control" maxlength="6" placeholder="Código">
	
	    <!-- Categoría -->
	    <label class="form-label mt-3">Categoría</label>
	    <select id="categoria" class="form-select">
	        <option value="">Seleccione una categoría</option>
	        <option value="gabinetes">Gabinetes PC</option>
	        <option value="laptops">Laptops</option>
	        <option value="monitores">Monitores</option>
	        <option value="componentes">Componentes</option>
	    </select>
	
	    <!-- Subcategoría -->
	    <label class="form-label mt-3">Subcategoría</label>
	    <select id="subCategoria" class="form-select">
	        <option value="">Seleccione una subcategoría</option>
	    </select>
	
	    <!-- Modelos -->
	    <label class="form-label mt-3">Modelo del Producto</label>
	    <select id="modelo" name="txtModelo" class="form-select">
	    	<option value="<%= modelo %>">Seleccione un modelo</option>
	    </select>
	
	    <!-- Stock -->
	    <label class="form-label mt-3">Stock</label>
	    <input type="number" name="txtStock" value="<%= stock %>" id="cantidad" class="form-control" min="1">
	    
	    <!-- Precio -->
	    <label class="form-label mt-3">Precio</label>
	    <input type="number" name="txtPrecio" value="<%= precio %>" id="precio" class="form-control" min="1">
	    
	    <div>
			<input class="btn btn-<%= color %> w-100" type="submit" value="<%= boton %>">
		</div>
		
	</form>
	<!-- FIN DEL FORMULARIO -->
	</div>
	
	<div class="col-lg-8 col-md-6 col-sm-12">
	<!-- INICIO DE LA TABLA -->
	
	<%
	// Recuperar la lista enviada por el ControladorProducto
	List<Producto> lista = (List<Producto>) request.getAttribute("listaProductos");
	
	if(lista != null)
	{
	%>
		<table class="table mt-3">
		  <thead>
		    <tr class="text-center">
		      <th scope="col">id</th>
		      <th scope="col">codigo</th>
		      <th scope="col">modelo</th>
		      <th scope="col">stock</th>
		      <th scope="col">precio</th>
		      <th scope="col">editar</th>
		      <th scope="col">eliminar</th>
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
			  	<td><%= objPro.getPrecio() %></td>
			  	
			  	<td><a href="ProductoController?accion=editar&id=<%= objPro.getId() %>"><i class="bi bi-pencil-square text-warning"></i></a></td>
			  	<td><a href="ProductoController?accion=eliminar&id=<%= objPro.getId() %>"><i class="bi bi-trash-fill text-danger"></i></a></td>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<script>
/* ==========================
   1. SUBCATEGORÍAS POR CATEGORÍA
   ========================== */
const subcategorias = {
    gabinetes: [
        "Gabinete ATX",
        "Gabinete Micro ATX",
        "Gabinete Mini ITX",
        "Gabinete Gamer RGB"
    ],
    laptops: [
        "Laptop Intel",
        "Laptop AMD",
        "Laptop Gamer",
        "Ultrabook"
    ],
    monitores: [
        "Monitor 21 pulgadas",
        "Monitor 24 pulgadas",
        "Monitor 27 pulgadas",
        "Monitor Gamer 144Hz"
    ],
    componentes: [
        "Procesadores",
        "Tarjetas Madre",
        "RAM",
        "Tarjetas de Video",
        "Fuentes de Poder"
    ]
};

/* ==========================
   2. MODELOS POR SUBCATEGORÍA
   ========================== */
const modelos = {

    // GABINETES
    "Gabinete ATX": ["ATX CoolerMaster", "ATX Corsair", "ATX Gamemax"],
    "Gabinete Micro ATX": ["Micro ATX Asus", "Micro ATX Halion"],
    "Gabinete Mini ITX": ["Mini ITX NZXT", "Mini ITX Thermaltake"],
    "Gabinete Gamer RGB": ["RGB Redragon", "RGB Antryx", "RGB Kolink"],

    // LAPTOPS
    "Laptop Intel": ["Intel i3", "Intel i5", "Intel i7"],
    "Laptop AMD": ["Ryzen 3", "Ryzen 5", "Ryzen 7"],
    "Laptop Gamer": ["Asus TUF", "Acer Nitro", "Lenovo Legion"],
    "Ultrabook": ["Dell XPS", "HP Envy", "Samsung Galaxy Book"],

    // MONITORES
    "Monitor 21 pulgadas": ["Samsung 21", "LG 21"],
    "Monitor 24 pulgadas": ["LG 24", "ASUS 24"],
    "Monitor 27 pulgadas": ["BenQ 27", "LG 27"],
    "Monitor Gamer 144Hz": ["MSI Optix", "AOC Gamer"],

    // COMPONENTES
    "Procesadores": ["Intel 12400F", "Ryzen 5600G", "Ryzen 5700X"],
    "Tarjetas Madre": ["MSI B450", "ASUS Z690", "Gigabyte B660"],
    "RAM": ["8GB DDR4", "16GB DDR4", "32GB DDR5"],
    "Tarjetas de Video": ["RTX 4060", "RTX 3060", "GTX 1650"],
    "Fuentes de Poder": ["600W EVGA", "500W Corsair", "750W CoolerMaster"]
};


/* ==========================================
   EVENTO 1: CAMBIO DE CATEGORÍA → SUBCATEGORÍAS
   ========================================== */
document.getElementById("categoria").addEventListener("change", function () {
    const categoria = this.value;
    const subcatSelect = document.getElementById("subCategoria");
    const modeloSelect = document.getElementById("modelo");

    // limpiar selects
    subcatSelect.innerHTML = "<option value=''>Seleccione una subcategoría</option>";
    modeloSelect.innerHTML = "<option value=''>Seleccione un modelo</option>";

    // llenar subcategorías
    if (subcategorias[categoria]) {
        subcategorias[categoria].forEach(sub => {
            const op = document.createElement("option");
            op.value = op.textContent = sub;
            subcatSelect.appendChild(op);
        });
    }
});


/* ==========================================
   EVENTO 2: CAMBIO SUBCATEGORÍA → MODELOS
   ========================================== */
document.getElementById("subCategoria").addEventListener("change", function () {
    const subcat = this.value;
    const modeloSelect = document.getElementById("modelo");

    modeloSelect.innerHTML = "<option value=''>Seleccione un modelo</option>";

    if (modelos[subcat]) {
        modelos[subcat].forEach(mod => {
            const op = document.createElement("option");
            op.value = op.textContent = mod;
            modeloSelect.appendChild(op);
        });
    }
});
</script>

                
</body>
</html>