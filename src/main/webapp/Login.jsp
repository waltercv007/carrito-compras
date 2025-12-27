<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("pageTitle", "Iniciar Sesión"); %>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="head.jsp" />
</head>

<jsp:include page="header.jsp" />

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4" style="margin-top: 50px;">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>Iniciar Sesión</h3>
                    </div>
                    <div class="card-body">
                        <form action="LoginController" method="post">
                            <!-- Display Error Message -->
                            <% if (request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger" role="alert">
                                    ${error}
                                </div>
                            <% } %>

                            <div class="mb-3">
                                <label for="usuario" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="usuario" name="usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Ingresar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

<jsp:include page="footer.jsp" />
