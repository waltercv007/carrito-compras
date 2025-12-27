<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Validacion</title>
</head>
<body>
	<form action="LoginServlet" method="post">

    <input type="text" name="usuario" class="form-control mb-3" placeholder="Usuario">

    <select name="rol" class="form-select mb-3">
        <option selected disabled>Seleccione Rol</option>
        <option>Administrador</option>
        <option>Vendedor</option>
        <option>Técnico</option>
    </select>

    <input type="password" name="password" class="form-control mb-3" placeholder="Contraseña">

    <button type="submit" class="btn btn-primary w-100">INGRESAR</button>
</form>

<c:if test="${not empty error}">
    <p class="text-danger text-center mt-2">${error}</p>
</c:if>

</body>
</html>