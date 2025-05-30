<%@ page import="java.util.List" %>
<%@ page import="model.Pharmacie" %>
<%
List<Pharmacie> pharmacies = (List<Pharmacie>) request.getAttribute("pharmacies");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Pharmacies - PharmaAdmin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/assets/css/dashboard.css" rel="stylesheet">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            border: none;
        }
        .table-container {
            overflow-x: auto;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        .btn-action {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            line-height: 1.5;
        }
        #form-title {
            color: #0d6efd;
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        #submit-button {
            transition: all 0.3s;
        }
        .pharmacie-logo {
            width: 40px;
            height: 40px;
            border-radius: 5px;
            object-fit: cover;
            margin-right: 10px;
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .status-active {
            background-color: rgba(25, 135, 84, 0.1);
            color: #198754;
        }
    </style>
</head>
<body>
    <div class="wrapper d-flex">
        <!-- Sidebar (identique à utilisateurs.jsp) -->
        <!-- ... -->

        <!-- Page Content -->
        <div id="content" class="p-0">
            <!-- Topbar (identique à utilisateurs.jsp) -->
            <!-- ... -->

            <!-- Main Content -->
            <div class="container-fluid p-4">
                <h3 class="mb-4">Gestion des Pharmacies</h3>
                <div class="row">
                    <!-- Formulaire -->
                    <div class="col-lg-4 col-md-12 mb-4">
                        <div class="card p-3 shadow-sm form-container">
                            <h5 class="card-title" id="form-title">Ajouter une Pharmacie</h5>
                            <form action="${pageContext.request.contextPath}/pharmacie" method="POST" id="pharmacieForm">
                                <input type="hidden" name="_method" id="methodField" value="">
                                <input type="hidden" id="pharmacieId" name="id">
                                
                                <div class="mb-3">
                                    <label for="nom" class="form-label">Nom :</label>
                                    <input type="text" id="nom" name="nom" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="adresse" class="form-label">Adresse :</label>
                                    <input type="text" id="adresse" name="adresse" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="coordonneesGPS" class="form-label">Coordonnées GPS :</label>
                                    <input type="text" id="coordonneesGPS" name="coordonneesGPS" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="logoUrl" class="form-label">URL du logo :</label>
                                    <input type="text" id="logoUrl" name="logoUrl" class="form-control">
                                </div>
                                <button type="submit" class="btn btn-primary w-100" id="submit-button">Ajouter Pharmacie</button>
                            </form>
                        </div>
                    </div>

                    <!-- Liste -->
                    <div class="col-lg-8 col-md-12">
                        <div class="card p-3 shadow-sm">
                            <h5 class="card-title">Liste des Pharmacies</h5>
                            <div class="table-container">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th>Pharmacie</th>
                                            <th>Adresse</th>
                                            <th>Coordonnées</th>
                                            <th>Statut</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (pharmacies != null && !pharmacies.isEmpty()) { 
                                            for (Pharmacie pharmacie : pharmacies) { 
                                        %>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <% if (pharmacie.getLogoUrl() != null && !pharmacie.getLogoUrl().isEmpty()) { %>
                                                        <img src="<%= pharmacie.getLogoUrl() %>" class="pharmacie-logo">
                                                    <% } else { %>
                                                        <img src="https://via.placeholder.com/40" class="pharmacie-logo">
                                                    <% } %>
                                                    <div>
                                                        <div class="fw-bold"><%= pharmacie.getNom() %></div>
                                                        <div class="text-muted small">ID: <%= pharmacie.getId() %></div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><%= pharmacie.getAdresse() %></td>
                                            <td><%= pharmacie.getCoordonneesGPS() %></td>
                                            <td><span class="status-badge status-active">Active</span></td>
                                            <td>
                                                <div class="d-flex">
                                                    <a href="#" 
                                                       class="btn btn-warning btn-sm btn-action edit-btn me-2"
                                                       data-id="<%= pharmacie.getId() %>"
                                                       data-nom="<%= pharmacie.getNom() %>"
                                                       data-adresse="<%= pharmacie.getAdresse() %>"
                                                       data-coordonneesgps="<%= pharmacie.getCoordonneesGPS() %>"
                                                       data-logourl="<%= pharmacie.getLogoUrl() != null ? pharmacie.getLogoUrl() : "" %>">
                                                        <i class="bi bi-pencil"></i>
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/pharmacie" method="POST" class="d-inline">
                                                        <input type="hidden" name="id" value="<%= pharmacie.getId() %>">
                                                        <input type="hidden" name="_method" value="DELETE">
                                                        <button type="submit" class="btn btn-danger btn-sm btn-action" 
                                                                onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette pharmacie ?');">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                        <% } 
                                        } else { %>
                                        <tr>
                                            <td colspan="5" class="text-center">Aucune pharmacie trouvée.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Pagination -->
                            <div class="d-flex justify-content-between align-items-center p-4 border-top">
                                <div class="text-muted">Affichage de 1 à 5 sur 15 pharmacies</div>
                                <nav>
                                    <ul class="pagination mb-0">
                                        <li class="page-item disabled"><a class="page-link" href="#">Précédent</a></li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item"><a class="page-link" href="#">Suivant</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // Gestion de l'édition
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                
                const id = this.getAttribute('data-id');
                const nom = this.getAttribute('data-nom');
                const adresse = this.getAttribute('data-adresse');
                const coordonneesGPS = this.getAttribute('data-coordonneesgps');
                const logoUrl = this.getAttribute('data-logourl');

                document.getElementById('nom').value = nom;
                document.getElementById('adresse').value = adresse;
                document.getElementById('coordonneesGPS').value = coordonneesGPS;
                document.getElementById('logoUrl').value = logoUrl;
                document.getElementById('pharmacieId').value = id;

                document.getElementById('methodField').value = 'PUT';
                document.getElementById('form-title').textContent = "Modifier la Pharmacie";
                document.getElementById('submit-button').textContent = "Modifier Pharmacie";
                document.getElementById('submit-button').classList.remove('btn-primary');
                document.getElementById('submit-button').classList.add('btn-warning');
            });
        });

        // Réinitialisation du formulaire après soumission
        document.getElementById('pharmacieForm').addEventListener('submit', function() {
            setTimeout(() => {
                this.reset();
                document.getElementById('form-title').textContent = "Ajouter une Pharmacie";
                document.getElementById('submit-button').textContent = "Ajouter Pharmacie";
                document.getElementById('submit-button').classList.remove('btn-warning');
                document.getElementById('submit-button').classList.add('btn-primary');
                document.getElementById('methodField').value = '';
                document.getElementById('pharmacieId').value = '';
            }, 1000);
        });
    });
    </script>
</body>
</html>