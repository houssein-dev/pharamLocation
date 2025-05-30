<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Connexion - PharmaLocator</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="assets/css/style.css">

	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="wrap">
						<div class="img" style="background-image: url(assets/images/pharmacy.jpg);"></div>
						<div class="login-wrap p-4 p-md-5">
			      	<div class="d-flex">
			      	</div>
					<form action="/PharmLocation/auth" class="signin-form" method="post">
			      		<div class="form-group mt-3">
			      			<input type="text" class="form-control" name="email" required>
			      			<label class="form-control-placeholder" for="username">Email</label>
			      		</div>
			            <div class="form-group">
			              <input id="password-field" type="password" name="password" class="form-control" required>
			              <label class="form-control-placeholder" for="password">Password</label>
			              <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
			            </div>
			            <div class="form-group">
			            	<button type="submit" class="form-control btn btn-primary rounded submit px-3">se connect</button>
			            </div>
							<p><a href="/PharmLocation//inscription">Créer un compte</a></p>
							<% if (request.getAttribute("error") != null) { %>
							    <p style="color: red;"><%= request.getAttribute("error") %></p>
							<% } %>		            	
		          </form>
		        </div>
		      </div>
				</div>
			</div>
		</div>
	</section>

	<script src="assets/js/jquery.min.js"></script>
  <script src="assets/js/popper.js"></script>
  <script src="assets/js/bootstrap.min.js"></script>
  <script src="assets/js/main.js"></script>

	</body>
</html>

