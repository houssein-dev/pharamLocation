<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Medicament" %>
<jsp:useBean id="medicaments" class="java.util.ArrayList" scope="session"/>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard PharmaLocator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/dashboard.css">
    <script defer src="script.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
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
        <!-- Top Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button id="sidebarCollapse" class="btn btn-primary">☰</button>
            <div class="ms-auto">
                <span class="me-3">Bienvenue, Admin</span>
                <img src="https://via.placeholder.com/40" class="rounded-circle" alt="User">
            </div>
        </nav>

        <!-- Dashboard Content -->
  <div class="container-fluid p-4">
    <h3 class="mb-4">Page Médicaments</h3>
    
    <div class="row">
        <!-- Formulaire d'ajout -->
        <div class="col-lg-4 col-md-12 mb-3 card p-0 pr-0">
            <form action="/PharmLocation/medicament" method="post" class="bg-light p-4 rounded shadow-sm">
                <h5 class="text-center">Ajouter un Médicament</h5>
                <div class="mb-3">
                    <label for="nom" class="form-label">Nom</label>
                    <input type="text" id="nom" name="nom" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="dosage" class="form-label">Dosage</label>
                    <input type="text" id="dosage" name="dosage" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="laboratoire" class="form-label">Laboratoire</label>
                    <input type="text" id="laboratoire" name="laboratoire" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="disponibilite" class="form-label">Disponibilité</label>
                    <select name="disponibilite" id="disponibilite" class="form-select" required>
                        <option value="true">Oui</option>
                        <option value="false">Non</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="prix" class="form-label">Prix</label>
                    <input type="number" step="0.01" id="prix" name="prix" class="form-control" required>
                </div>
                <div class="text-center">
                    <input type="submit" value="Ajouter" class="btn btn-primary w-100">
                </div>
            </form>
        </div>

        <!-- Tableau des médicaments -->
        <div class="col-lg-8 col-md-12">
          <div class="card p-3 shadow-sm" style="overflow-x: scroll;">
        
            <input type="text" id="search" class="form-control mb-3" placeholder="Rechercher un médicament...">

            <table class="table table-striped table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Dosage</th>
                        <th>Laboratoire</th>
                        <th>Disponible</th>
                        <th>Prix</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="medicamentTable">
                    <% for (Medicament m : (ArrayList<Medicament>) request.getAttribute("medicaments")) { %>
                    <tr>
                        <td><%= m.getId() %></td>
                        <td><%= m.getNom() %></td>
                        <td><%= m.getDosage() %></td>
                        <td><%= m.getLaboratoire() %></td>
                        <td>
                            <span class="badge <%= m.isDisponibilite() ? "bg-success" : "bg-danger" %>">
                                <%= m.isDisponibilite() ? "Oui" : "Non" %>
                            </span>
                        </td>
                        <td><%= m.getPrix() %> €</td>
                        <td>
                            <!-- Bouton Modifier -->
                            <form action="medicament" method="POST" style="display:inline;">
                                <input type="hidden" name="id" value="<%= m.getId() %>">
                                <input type="hidden" name="_method" value="PUT">
                                <button class="btn btn-sm btn-warning" type="submit"><i class="fas fa-edit"></i> Modifier</button>
                            </form>

                            <!-- Bouton Supprimer avec confirmation -->
                            <form action="medicament" method="POST" style="display:inline;" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce médicament ?');">
                                <input type="hidden" name="id" value="<%= m.getId() %>">
                                <input type="hidden" name="_method" value="DELETE">
                                <button class="btn btn-sm btn-danger" type="submit"><i class="fas fa-trash"></i> Supprimer</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>document.addEventListener("DOMContentLoaded", function () {
    const sidebar = document.getElementById("sidebar");
    const sidebarToggle = document.getElementById("sidebarCollapse");

    sidebarToggle.addEventListener("click", function () {
        if (sidebar.style.width === "150px") {
            sidebar.style.width = "0";
            sidebar.style.marginLeft = "-150px";

            
            document.getElementById("content").style.marginLeft = "0";
        } else {
            sidebar.style.width = "150px";
            sidebar.style.marginLeft = "unset";

            document.getElementById("content").style.marginLeft = "150px";
        }
    });
});


document.addEventListener("DOMContentLoaded", function () {
    // Filtre de recherche dynamique
    document.getElementById("search").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#medicamentTable tr");

        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });
});


document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form[action='/PharmLocation/medicament']");
    const submitButton = form.querySelector("input[type='submit']");
    let editingId = null; // Stocke l'ID du médicament en cours de modification

    document.querySelectorAll(".btn-warning").forEach(button => {
        button.addEventListener("click", function (event) {
            event.preventDefault(); // Empêcher l'envoi du formulaire immédiat

            let row = this.closest("tr"); // Récupère la ligne du tableau
            let cells = row.getElementsByTagName("td");

            // Récupère les valeurs des cellules
            editingId = cells[0].innerText; // ID du médicament
            document.getElementById("nom").value = cells[1].innerText;
            document.getElementById("dosage").value = cells[2].innerText;
            document.getElementById("laboratoire").value = cells[3].innerText;
            document.getElementById("disponibilite").value = cells[4].innerText === "Oui" ? "true" : "false";
            document.getElementById("prix").value = parseFloat(cells[5].innerText.replace("€", "").trim());

            // Modifier le bouton et l'action du formulaire
            submitButton.value = "Modifier";
            form.action = "/PharmLocation/medicament?id=" + editingId; // Ajoute l'ID au formulaire
            form.method = "POST"; // Changer la méthode en POST pour modification

            // Ajoute un champ caché pour indiquer la modification
            let hiddenInput = document.createElement("input");
            hiddenInput.type = "hidden";
            hiddenInput.name = "_method";
            hiddenInput.value = "PUT"; // Utilisation de la méthode PUT
            form.appendChild(hiddenInput);
        });
    });
});

</script>
</body>
</html>
