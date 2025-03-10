<%@ page import="java.util.*, model.Pharmacien, model.Utilisateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:choose><c:when test="${not empty stock}">Modifier</c:when><c:otherwise>Nouveau</c:otherwise></c:choose> Stock</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .user-info {
            background-color: #0000000a;
            border-radius: 2px !important;
            padding: 6px 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-select:disabled {
            background-color: #e9ecef;
            opacity: 1;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
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
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card form-card">
                <div class="card-header bg-dark text-white">
                    <h3 class="mb-0">
                        <c:choose>
                            <c:when test="${not empty stock}">Modifier le Stock</c:when>
                            <c:otherwise>Nouveau Stock</c:otherwise>
                        </c:choose>
                    </h3>
                </div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/stock">
                        <c:if test="${not empty stock}">
                            <input type="hidden" name="_method" value="PUT">
                        </c:if>

                        <div class="mb-4">
                            <label class="form-label">Pharmacie</label>
							<select name="pharmacieId" class="form-select" <c:if test="${not empty stock}">disabled</c:if>>
							    <c:forEach items="${pharmacies}" var="pharma">
							        <c:if test="${pharma.id eq pharmacieId }">
							            <option value="${pharma.id}" ${(stock.pharmacie.id eq pharma.id) ? 'selected' : ''}>
							                ${pharma.nom} - ${pharma.adresse}
							            </option>
							        </c:if>
							    </c:forEach>
							</select>
							 <c:if test="${not empty stock}">
                                <input type="hidden" name="pharmacieId" value="${stock.pharmacie.id}">
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Médicament</label>
                            <select name="medicamentId" class="form-select" <c:if test="${not empty stock}">disabled</c:if>>
                                <c:forEach items="${medicaments}" var="medoc">
                                    <option value="${medoc.id}" ${(stock.medicament.id eq medoc.id) ? 'selected' : ''}>
                                        ${medoc.nom} (${medoc.dosage}) - ${medoc.laboratoire}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty stock}">
                                <input type="hidden" name="medicamentId" value="${stock.medicament.id}">
                            </c:if>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Quantité</label>
                            <input type="number" name="quantite" value="${stock.quantite}" 
                                   class="form-control form-control-lg" 
                                   required min="0">
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-success btn-lg">
                                <c:choose>
                                    <c:when test="${not empty stock}">Mettre à jour</c:when>
                                    <c:otherwise>Créer le stock</c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>
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