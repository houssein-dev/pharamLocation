<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Pharmacien" %>
<%@ page import="model.Pharmacie" %>
<%@ page import="java.util.*, model.Medicament, model.Pharmacie,model.Pharmacien, model.Utilisateur" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Pharmaciens</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>
    <nav id="sidebar" class="sidebar">
        <div class="sidebar-header">
            <h3>PharmaLocator</h3>
        </div>
        <ul class="list-unstyled components">
             <li><a href="/PharmLocation/utilisateur"><i class="fas fa-users"></i> Utilisateurs</a></li>
            <li><a href="/PharmLocation/medicament"><i class="fas fa-pills"></i> Médicaments</a></li>
        	<li><a href="/PharmLocation/pharmacie"><i class="fas fa-hospital"></i> Pharmacies</a></li>
            
            <li><a href="/PharmLocation/pharmacien"><i class="fas fa-hospital"></i> Pharmaciens</a></li>
            
            <li><a href="#"><i class="fas fa-shopping-cart"></i> Commandes</a></li>
            <li><a href="#"><i class="fas fa-bell"></i> Notifications</a></li>
            <li><a href="#"><i class="PharmaLocation/logout"></i> Déconnexion</a></li>
        </ul>
    </nav>

    <!-- Contenu principal -->
    <div id="content">
        <!-- Top Bar -->
        <%
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
			response.setHeader("Pragma", "no-cache"); 
			response.setHeader("Expires", "0"); 
			%>
			<%
			    HttpSession sessionUser = request.getSession(false);
			    if (sessionUser == null || sessionUser.getAttribute("utilisateur") == null) {
			    	
			    	
			        response.sendRedirect("auth/connect.jsp");
			        return;
			    }
			    Utilisateur utilisateur;

				utilisateur=(Utilisateur) sessionUser.getAttribute("utilisateur");
			
			
			
			%>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="
		    background: #dee2e6 !important;!i;!;
		    padding-left: 12px;
		    padding-right: 12px;
		    
		">
            <button id="sidebarCollapse" class="btn btn-primary">☰</button>
            <div class="ms-auto">
                <span class="me-3">Bienvenue, <%=utilisateur.getNom()  %>-<%=utilisateur.getRole()  %></span>
            <img src="assets/images/download (1).png" class="rounded-circle" alt="User" style="max-height:70px;">
            </div>
        </nav>

    <div class="container-fluid p-4">
        <h3 class="mb-4">Gestion des Pharmaciens</h3>
        <div class="row">
            <!-- Formulaire d'ajout -->
            <div class="col-lg-4 col-md-12 mb-3">
                <div class="card p-3 shadow-sm">
                    <h5 class="card-title">Ajouter un Pharmacien</h5>
                    <form action="/PharmLocation/pharmacien" method="POST">
                        <div class="mb-2">
                            <label for="nom" class="form-label">Nom :</label>
                            <input type="text" id="nom" name="nom" class="form-control" required>
                        </div>
                        <div class="mb-2">
                            <label for="email" class="form-label">Email :</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-2">
                            <label for="telephone" class="form-label">Téléphone :</label>
                            <input type="tel" id="telephone" name="telephone" class="form-control" required>
                        </div>
                        <div class="mb-2">
                            <label for="adresse" class="form-label">Adresse :</label>
                            <input type="text" id="adresse" name="adresse" class="form-control" required>
                        </div>
                        <div class="mb-2">
                            <label for="password" class="form-label">Mot de passe :</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="pharmacie_id" class="form-label">Pharmacie :</label>
                            <select id="pharmacie_id" name="pharmacie_id" class="form-select" required>
                            <%
                            List<Pharmacie> pharmacies = (List<Pharmacie>) request.getAttribute("pharmacies");
                             if (pharmacies != null && !pharmacies.isEmpty()) {
                                for (Pharmacie p : pharmacies) { %>
                                     <option value="<%=p.getId() %>"><%=p.getNom() %></option>
                                
                            <% }} else { %>
                                <option value="1">indeterminer</option>
                            <% } %>
                               

                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Ajouter Pharmacien</button>
                    </form>
                </div>
            </div>
            <!-- Liste des Pharmaciens -->
            <div class="col-lg-8 col-md-12" >
                <div class="card p-3 shadow-sm" style="overflow-x: scroll;">
                    <h5 class="card-title">Liste des Pharmaciens</h5>
                    <table class="table table-bordered table-striped" style="overflow-x: scroll;width: 900px;">
                        <thead class="table-dark">
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Téléphone</th>
                                <th>adresse</th>                                
                                <th>Pharmacie</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Pharmacien> pharmaciens = (List<Pharmacien>) request.getAttribute("pharmaciens");
                            if (pharmaciens != null && !pharmaciens.isEmpty()) {
                                for (Pharmacien pharmacien : pharmaciens) { %>
                                    <tr>
                                        <td><%= pharmacien.getNom() %></td>
                                        <td><%= pharmacien.getEmail() %></td>
                                        <td><%= pharmacien.getTelephone() %></td>
                                        <td><%= pharmacien.getAdresse() %></td>                                        
                                        <td><%= pharmacien.getPharmacie().getNom() %></td>
                                        <td>
                                            <a href="pharmacien?id=<%=pharmacien.getId()%>&_method=GET" class="btn btn-info btn-sm">Voir</a>
                                            <a href="pharmacien?id=<%=pharmacien.getId()%>&_method=PUT" class="btn btn-warning btn-sm">Modifier</a>
                                            <form action="pharmacien" method="POST" style="display:inline;" onsubmit="return confirm('Êtes-vous sûr ?');">
                                                <input type="hidden" name="id" value="<%=pharmacien.getId()%>">
                                                <input type="hidden" name="_method" value="DELETE">
                                                <button type="submit" class="btn btn-danger btn-sm">Supprimer</button>
                                            </form>
                                        </td>
                                    </tr>
                            <% }} else { %>
                                    <tr>
                                        <td colspan="5" class="text-center">Aucun pharmacien trouvé.</td>
                                    </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
 </div>
 <script>
document.addEventListener("DOMContentLoaded", function() {
    // Sélectionner tous les boutons "Modifier"
    document.querySelectorAll('.btn-warning').forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault(); 
            
            // Récupérer les données du pharmacien depuis la ligne du tableau
            let row = this.closest('tr');
            let nom = row.cells[0].innerText;
            let email = row.cells[1].innerText;
            let telephone = row.cells[2].innerText;
            let pharmacie = row.cells[3].innerText;
            let id = this.href.split('id=')[1].split('&')[0]; // Récupérer l'ID depuis l'URL

            // Remplir le formulaire avec les données du pharmacien
            document.getElementById('nom').value = nom;
            document.getElementById('email').value = email;
            document.getElementById('telephone').value = telephone;
            document.getElementById('pharmacie_id').value = pharmacie;

            // Modifier l'action du formulaire pour mettre à jour le pharmacien
            let form = document.querySelector('form');
            form.action = "?id=" + id + "&_method=PUT"; 

            // Changer le bouton "Ajouter" en "Modifier"
            let submitButton = form.querySelector('button[type="submit"]');
            submitButton.textContent = "Modifier Pharmacien";
            submitButton.classList.remove("btn-primary");
            submitButton.classList.add("btn-warning");
        });
    });
});
</script>
 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
