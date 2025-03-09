<%@ page import="java.util.*, model.Medicament, model.Pharmacie,model.Pharmacien, model.Utilisateur" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PharmaLocation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
		.user-info {
		    background-color: #0000000a;
		    border-radius: 2px !important;
		    padding: 6px 15px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.user-info .user-name {
		    font-size: 1.25rem;
		    font-weight: bold;
		    color: #495057;
		}
		
		.user-info .btn-outline-danger {
		    font-weight: bold;
		    border: 2px solid #dc3545;
		    color: #dc3545;
		    transition: background-color 0.3s ease;
		}
		
		.user-info .btn-outline-danger:hover {
		    background-color: #dc3545;
		    color: white;
		}
        
        .hero-section {
            background: url('https://image.shutterstock.com/image-photo/calm-weather-on-sea-ocean-260nw-2212935531.jpg') no-repeat center center/cover;
            color: white;
            text-align: center;
            padding: 120px 20px;
            position: relative;
        }
        .hero-section::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.5);
        }
        .hero-content {
            position: relative;
            z-index: 2;
        }
        .card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .footer {
            background: #343a40;
            color: white;
            padding: 20px 0;
        }
    </style>
</head>
<body>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
response.setHeader("Pragma", "no-cache"); 
response.setHeader("Expires", "0"); 
%>
<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("utilisateur") == null && sessionUser.getAttribute("pharmacien") == null) {
    	
    	
        response.sendRedirect("auth/connect.jsp");
        return;
    }
    Utilisateur utilisateur;
    if (sessionUser.getAttribute("utilisateur") == null){
    	utilisateur = (Pharmacien) sessionUser.getAttribute("pharmacien") ;
    }else{
		 utilisateur=(Utilisateur) sessionUser.getAttribute("utilisateur");
	}


%>
	<div class="user-info card shadow-sm mb-4">
	    <div class="card-body d-flex justify-content-between align-items-center">
	        <h3 class="user-name mb-0">Bienvenue, monsieur <strong><%= utilisateur.getRole()%> </strong> <%= utilisateur.getNom()%>  !</h3>
	        <a href="logout" class="btn btn-outline-danger btn-sm">Déconnexion</a>
	    </div>
	</div>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">PharmaLocation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/PharmLocation/main">Accueil</a></li>
                    <!--  <li class="nav-item"><a class="nav-link" href="#">Pharmacies</a></li>-->
                     <%  
						    if (sessionUser.getAttribute("pharmacien") != null) { 
						%>
						    <li class="nav-item">
						        <a class="nav-link btn btn-outline-dark" href="medicament/ajouterMedicament.jsp">Ajouter un Médicament</a>
						    </li>
						<%  
						    } 
						%>

                </ul>
            </div>
        </div>
    </nav>
    
    <header class="hero-section">
        <div class="container hero-content">
 <section class="container my-5">
                <h2 class="text-center mb-4">Rechercher un Medicament</h2>
                <form method="GET" action="/PharmLocation/medicament" class="row g-3 justify-content-center">
                    <div class="col-md-4">
                        <input type="text" class="form-control" placeholder="Nom du médicament" aria-label="Nom du médicament" name="search">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Rechercher</button>
                    </div>
                </form>
            </section>
        </div>
    </header>
    
    <section class="container my-5">
        <h2 class="text-center mb-4">Dernières Annonces</h2>
        <div class="row">
            <% List<Medicament> medicaments = (List<Medicament>) request.getAttribute("medicaments");
               if (medicaments != null) {
                   for (Medicament m : medicaments) { %>
            <div class="col-md-4">
                <div class="card">
                    <img src="" class="card-img-top img-fluid" alt="Image Médicament">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= m.getNom() %></h5>
                        <p class="card-text">Prix: <%= m.getPrix() %> €</p>
                        <a href="#" class="btn btn-success">Voir Détails</a>
                    </div>
                </div>
            </div>
            <% } } %>
        </div>
    </section>
    
    <section class="container my-5">
        <h2 class="text-center mb-4">Pharmacies Disponibles</h2>
        <div class="row">
            <% List<Pharmacie> pharmacies = (List<Pharmacie>) request.getAttribute("pharmacies");
               if (pharmacies != null) {
                   for (Pharmacie p : pharmacies) { %>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title"><%= p.getNom() %></h5>
                        <p class="card-text">Adresse: <%= p.getAdresse() %></p>
                        <a href="#" class="btn btn-success">Voir Détails</a>
                    </div>
                </div>
            </div>
            <% } } %>
        </div>
    </section>
    
    <footer class="footer text-center">
        <div class="container">
            <p>&copy; 2025 PharmaLocation - Tous droits réservés</p>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
