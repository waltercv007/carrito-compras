<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<h1 class="bg-primary text-center text-white">SERVICAS GROUP E.I.R.L</h1>
	<p class="text-center Strong"> Venta de Equipos  Accesorios y Suministros de Computo</p>
	
	<main class="container d-flex align-items-center justify-content-center">
		
			<form action="Validar.jsp" method="POST" class="needs-validation" novalidate>

				<h1 class="text-center text-primary">Login</h1>

				<div class="form-floating mb-3">
				  <input type="text" name="txtUser" class="form-control" placeholder="" required>
				  <label>Usuario</label>
				  <div class="invalid-feedback"> ¡Ingrese su usuario!</div>
				</div>
				<select name="rol" class="form-select mx-auto mb-4" style="width: 250px;">
				    <option selected disabled>Seleccione Rol</option>
				    <option value="ADMIN">Administrador</option>
				    <option value="VENDEDOR">Vendedor</option>
				    <option value="TECNICO">Técnico</option>
				</select>
				<div class="form-floating mb-3">
				  <input type="text" name="txtPass" class="form-control" placeholder="" required>
				  <label>Contraseña</label>
				  <div class="invalid-feedback"> ¡Ingrese su contraseña!</div>
				</div>
				
				<div>
					<input class="btn btn-primary w-100" type="submit" value="INGRESAR">				
				</div>
				
			</form>
					
		</main>
			
			
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
		
		<script>
			// Example starter JavaScript for disabling form submissions if there are invalid fields
			(() => {
			  'use strict'
	
			  // Fetch all the forms we want to apply custom Bootstrap validation styles to
			  const forms = document.querySelectorAll('.needs-validation')
	
			  // Loop over them and prevent submission
			  Array.from(forms).forEach(form => {
			    form.addEventListener('submit', event => {
			      if (!form.checkValidity()) {
			        event.preventDefault()
			        event.stopPropagation()
			      }
	
			      form.classList.add('was-validated')
			    }, false)
			  })
			})()			
		</script>

</body>
</html>