<%@ page import="java.util.*, model.Medicament, model.Pharmacie, model.Pharmacien, model.Utilisateur" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Disponibilité du ${medicament.nom}</title>
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
        .card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .availability-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
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
    Integer pharmacieId=0;
    Utilisateur utilisateur;
    if (sessionUser.getAttribute("utilisateur") == null){
    	utilisateur = (Pharmacien) sessionUser.getAttribute("pharmacien") ;
    	 pharmacieId = (Integer) sessionUser.getAttribute("pharmacieId");

    }else{
		 utilisateur=(Utilisateur) sessionUser.getAttribute("utilisateur");
	}


%>
	<div class="user-info card shadow-sm mb-4">
	    <div class="card-body d-flex justify-content-between align-items-center">
	        <h3 class="user-name mb-0">Bienvenue, monsieur <strong><%= utilisateur.getRole()%> </strong> <%= utilisateur.getNom()%>  !</h3>
	        <a href="logout" class="btn btn-outline-danger btn-sm">Déconnexion</a>
	    
	        <%  
					if (sessionUser.getAttribute("utilisateur") != null  || utilisateur.getRole()=="admin") { 
						%>
						        <a class=" btn btn-sm btn-outline-success" href="/PharmLocation/medicament">Dashboard</a>
						<%  
					} 
			%>
	    
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
                    <li class="nav-item"><a class="nav-link btn  btn-outline-success" href="/PharmLocation/main">Accueil</a></li>
                    <!--  <li class="nav-item"><a class="nav-link" href="#">Pharmacies</a></li>-->
                     <%  
						    if (sessionUser.getAttribute("pharmacien") != null) { 
						%>
						    <li class="nav-item">
						        <a class="nav-link btn btn-outline-success" href="/PharmLocation/medicament/ajouterMedicament.jsp">Ajouter un Médicament</a>
						    </li>
						<%  
						    } 
						%>
						                     <%  
						    if (sessionUser.getAttribute("pharmacien") != null ) { 
						%>
						    <li class="nav-item">
						        <a class="nav-link btn  btn-outline-success" href="/PharmLocation/stock?pharmacieId=<%=pharmacieId %>">mon pharmacie</a>
						    </li>
						<%  
						    } 
						%>

                </ul>
            </div>
        </div>
    </nav>

<div class="container mt-5">
    <div class=" mb-4">
        <div class="card-body">
            <h2 class="mb-4">
                Disponibilité du médicament : ${medicament.nom}
                <a href="/PharmLocation/main" 
                   class="btn btn-secondary btn-sm float-end">
                    ← Retour
                </a>
            </h2>

            <div class="card mb-4" style="
					    width: 280px;
					">
                <div class="card-body">
                    <h5 class="card-title">Détails du médicament</h5>
                    <div class="row">
                    <img src="assets/images/medical.jpg" class="card-img-top img-fluid" alt="Image Médicament" style="
					    height: 280px;
					    border: 1px solid #adb5bd8f;
					">
                    
                        <div class="">
                            <p class="mb-2"><strong>Dosage :</strong> ${medicament.dosage}</p>
                        </div>
                        <div class="">
                            <p class="mb-2"><strong>Laboratoire :</strong> ${medicament.laboratoire}</p>
                        </div>
                        <div class="">
                            <p class="mb-2"><strong>Prix :</strong> ${medicament.prix} MRO</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="availability-table">
                <h4 class="mb-3">Disponible dans ces pharmacies :</h4>
                <table class="table table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Pharmacie</th>
                            <th>Adresse</th>
                            <th>Quantité</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${stocks}" var="stock">
                            <tr>
                                <td>${stock.pharmacie.nom}</td>
                                <td>${stock.pharmacie.adresse}</td>
                                <td>${stock.quantite}</td>
                              
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<footer class="footer text-center bg-dark text-white py-4 mt-4">
    <div class="container">
        <p class="mb-0">&copy; 2025 PharmaLocation - Tous droits réservés</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>