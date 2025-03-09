<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Pharmacie" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Pharmacies</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/dashboard.css">
</head>
<body>

<!-- Sidebar -->
    <nav id="sidebar" class="sidebar">
        <div class="sidebar-header">
            <h3>PharmaLocator</h3>
        </div>
        <ul class="list-unstyled components">
            <li><a href="#"><i class="fas fa-home"></i> Dashboard</a></li>
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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button id="sidebarCollapse" class="btn btn-primary">☰</button>
        <div class="ms-auto">
            <span class="me-3">Bienvenue, Admin</span>
            <img src="https://via.placeholder.com/40" class="rounded-circle" alt="User">
        </div>
    </nav>

    <div class="container-fluid p-4">
        <h3 class="mb-4">Gestion des Pharmacies</h3>
        <div class="row">
            <!-- Formulaire d'ajout -->
            <div class="col-lg-4 col-md-12 mb-3">
                <div class="card p-3 shadow-sm">
                    <h5 class="card-title">Ajouter une Pharmacie</h5>
                    <form action="/PharmLocation/pharmacie" method="post">
                        <div class="mb-2">
                            <label for="nom" class="form-label">Nom :</label>
                            <input type="text" id="nom" name="nom" class="form-control" required>
                        </div>
                        <div class="mb-2">
                            <label for="adresse" class="form-label">Adresse :</label>
                            <input type="text" id="adresse" name="adresse" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="coordonneesGPS" class="form-label">Coordonnées GPS :</label>
                            <input type="text" id="coordonneesGPS" name="coordonneesGPS" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Ajouter</button>
                    </form>
                </div>
            </div>

            <!-- Liste des Pharmacies -->
            <div class="col-lg-8 col-md-12">
                <div class="card p-3 shadow-sm" style="overflow-x: scroll;">
                    <h5 class="card-title">Liste des Pharmacies</h5>
                    <table class="table table-bordered table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Adresse</th>
                                <th>Coordonnées GPS</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            List<Pharmacie> pharmacies = (List<Pharmacie>) request.getAttribute("pharmacies");
                            if (pharmacies != null && !pharmacies.isEmpty()) {
                                for (Pharmacie p : pharmacies) { %>
                                    <tr>
                                        <td><%= p.getId() %></td>
                                        <td><%= p.getNom() %></td>
                                        <td><%= p.getAdresse() %></td>
                                        <td><%= p.getCoordonneesGPS() %></td>
                                        <td>
                                            <button class="btn btn-warning btn-sm" onclick="remplirForm('<%= p.getId() %>', '<%= p.getNom() %>', '<%= p.getAdresse() %>', '<%= p.getCoordonneesGPS() %>')">Modifier</button>
                                            <form action="/PharmLocation/pharmacie" method="POST" style="display:inline;" onsubmit="return confirm('Êtes-vous sûr ?');">
                                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                                <input type="hidden" name="_method" value="DELETE">
                                                <button type="submit" class="btn btn-danger btn-sm">Supprimer</button>
                                            </form>
                                        </td>
                                    </tr>
                            <% }} else { %>
                                    <tr>
                                        <td colspan="5" class="text-center">Aucune pharmacie trouvée.</td>
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
    function remplirForm(id, nom, adresse, coordonneesGPS) {
        document.getElementById('nom').value = nom;
        document.getElementById('adresse').value = adresse;
        document.getElementById('coordonneesGPS').value = coordonneesGPS;

        let form = document.querySelector("form");
        form.action = "/PharmLocation/pharmacie?id=" + id + "&_method=PUT";

        let submitBtn = form.querySelector("button[type='submit']");
        submitBtn.innerText = "Modifier";
        submitBtn.classList.remove("btn-primary");
        submitBtn.classList.add("btn-warning");
    }
</script>

</body>
</html>
