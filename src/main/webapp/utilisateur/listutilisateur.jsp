<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.*, model.Medicament, model.Pharmacie,model.Pharmacien, model.Utilisateur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <!-- Sidebar -->
    <!-- Sidebar -->
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
            <li><a href="#"><i class="fas fa-sign-out-alt"></i> Déconnexion</a></li>
        </ul>
    </nav>

    <!-- Contenu principal -->
    <div id="content">
        <!-- Top Bar -->
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
			    Utilisateur utilisateu;

				utilisateu=(Utilisateur) sessionUser.getAttribute("utilisateur");
			
			
			
			%>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="
		    background: #dee2e6 !important;!i;!;
		    padding-left: 12px;
		    padding-right: 12px;
		    
		">
            <button id="sidebarCollapse" class="btn btn-primary">☰</button>
            <div class="ms-auto">
                <span class="me-3">Bienvenue, <%=utilisateu.getNom()  %>-<%=utilisateu.getRole()  %></span>
            <img src="assets/images/download (1).png" class="rounded-circle" alt="User" style="max-height:70px;">
            </div>
        </nav>

        <div class="container-fluid p-4">
            <h3 class="mb-4">Gestion des Utilisateurs</h3>
            <div class="row">
                <!-- Formulaire -->
                <div class="col-lg-4 col-md-12 mb-3">
                    <div class="card p-3 shadow-sm">
                        <h5 class="card-title" id="form-title">Ajouter un Utilisateur</h5>
                        <form action="utilisateur" method="POST" id="userForm">
                            <input type="hidden" name="_method" id="methodField" value=""> <!-- Nouveau champ -->
                        
                            <input type="hidden" id="userId" name="id">
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
                                <input type="text" id="telephone" name="telephone" class="form-control" required>
                            </div>
                            <div class="mb-2">
                                <label for="adresse" class="form-label">Adresse :</label>
                                <input type="text" id="adresse" name="adresse" class="form-control" required>
                            </div>
                            <div class="mb-2">
                                <label for="password" class="form-label">Mot de passe :</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100" id="submit-button">Ajouter Utilisateur</button>
                        </form>
                    </div>
                </div>

                <!-- Liste -->
                <div class="col-lg-8 col-md-12"  >
                    <div class="card p-3 shadow-sm" style="overflow-x: scroll;">
                        <h5 class="card-title">Liste des Utilisateurs</h5>
                        <table class="table table-bordered table-striped">
                            <thead class="table-dark">
                                <tr>
                                    <th>Nom</th>
                                    <th>Email</th>
                                    <th>Téléphone</th>
                                    <th>Adresse</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("utilisateurs");
                                if (utilisateurs != null && !utilisateurs.isEmpty()) {
                                    for (Utilisateur utilisateur : utilisateurs) { %>
                                        <tr>
                                            <td><%= utilisateur.getNom() %></td>
                                            <td><%= utilisateur.getEmail() %></td>
                                            <td><%= utilisateur.getTelephone() %></td>
                                            <td><%= utilisateur.getAdresse() %></td>
                                            <td>
                                                <a href="utilisateur?id=<%=utilisateur.getId()%>&_method=PUT" 
                                                   class="btn btn-warning btn-sm">Modifier</a>
                                                <form action="utilisateur" method="POST" style="display:inline;">
                                                    <input type="hidden" name="id" value="<%=utilisateur.getId()%>">
                                                    <input type="hidden" name="_method" value="DELETE">
                                                    <button type="submit" class="btn btn-danger btn-sm" 
                                                            onclick="return confirm('Êtes-vous sûr ?');">Supprimer</button>
                                                </form>
                                            </td>
                                        </tr>
                                <% }} else { %>
                                    <tr>
                                        <td colspan="5" class="text-center">Aucun utilisateur trouvé.</td>
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
        document.querySelectorAll('.btn-warning').forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                
                const row = this.closest('tr');
                const cells = row.cells;
                const id = this.href.split('id=')[1].split('&')[0];

                // Remplir les champs du formulaire
                document.getElementById('nom').value = cells[0].innerText;
                document.getElementById('email').value = cells[1].innerText;
                document.getElementById('telephone').value = cells[2].innerText;
                document.getElementById('adresse').value = cells[3].innerText;
                document.getElementById('userId').value = id;  // Set l'ID caché

                // Configurer la méthode PUT
                document.getElementById('methodField').value = 'PUT';  

                // Mettre à jour le bouton
                const submitBtn = document.getElementById('submit-button');
                submitBtn.textContent = "Modifier Utilisateur";
                submitBtn.classList.replace('btn-primary', 'btn-warning');
            });
        });
    });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>