<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <title>ajou medicament</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .form-radio-group {
            display: flex;
            gap: 20px;
            margin-top: 15px;
        }
        
        .form-radio-item {
            display: flex;
            align-items: center;
        }
        
        .form-radio-item input[type="radio"] {
            margin: 0;
            margin-right: 8px;
            width: 16px;
            height: 16px;
        }
        
        .form-radio-item label {
            margin: 0;
            font-size: 14px;
            color: #000;
        }
    </style>
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
                            <form action="/PharmLocation/inscription" method="post" class="signin-form">
                                <input type="hidden" name="action" value="register">
                                
                                <div class="form-group mt-3">
                                    <input type="text" class="form-control" name="nom" required>
                                    <label class="form-control-placeholder" for="nom">Nom</label>
                                </div>
                                <div class="form-group mt-3">
                                    <input type="email" class="form-control" name="email" required>
                                    <label class="form-control-placeholder" for="email">Email</label>
                                </div>
                                <div class="form-group mt-3">
                                    <input type="text" class="form-control" name="telephone" required>
                                    <label class="form-control-placeholder" for="telephone">Téléphone</label>
                                </div>
                                <div class="form-group mt-3">
                                    <input type="text" class="form-control" name="adresse" required>
                                    <label class="form-control-placeholder" for="adresse">Adresse</label>
                                </div>
                                <div class="form-group">
                                    <input id="password-field" type="password" name="password" class="form-control" required>
                                    <label class="form-control-placeholder" for="password">Mot de passe</label>
                                    <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                </div>
                                
                                <div class="form-group">
                                    <div class="form-radio-group">
                                        <div class="form-radio-item">
                                            <input type="radio" id="option1" name="role" value="1" required>
                                            <label for="option1">Utilisateur</label>
                                        </div>
                                        <div class="form-radio-item">
                                            <input type="radio" id="option2" name="role" value="2" required>
                                            <label for="option2">Pharmacien</label>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <button type="submit" class="form-control btn btn-primary rounded submit px-3">S'inscrire</button>
                                </div>
                                <p><a href="/PharmLocation/auth">Déjà un compte ? Connectez-vous</a></p>
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