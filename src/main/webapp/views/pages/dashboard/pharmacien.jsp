<%@ page import="java.util.List" %>
<%@ page import="model.Pharmacien" %>
<%@ page import="model.Pharmacie" %>
<%
List<Pharmacien> pharmaciens = (List<Pharmacien>) request.getAttribute("pharmaciens");
List<Pharmacie> pharmacies = (List<Pharmacie>) request.getAttribute("pharmacies");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Pharmaciens - PharmaAdmin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/assets/css/dashboard.css" rel="stylesheet">
    <style>
        /* Styles spécifiques aux pharmaciens */
        .pharmacie-badge {
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
        }
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
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }
        .role-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        .role-admin {
            background-color: rgba(13, 110, 253, 0.1);
            color: #0d6efd;
        }
        .role-pharmacien {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        .role-utilisateur {
            background-color: rgba(32, 201, 151, 0.1);
            color: #20c997;
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
        .status-inactive {
            background-color: rgba(108, 117, 125, 0.1);
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="wrapper d-flex">
      <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block">
            <div class="logo">
                <i class="bi bi-capsule-pill"></i> PharmaAdmin
            </div>
            <ul class="nav flex-column mt-4">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="bi bi-speedometer2"></i> Tableau de bord
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-capsule"></i> Médicaments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-shop"></i> Pharmacies
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-people"></i> Utilisateurs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-person-badge"></i> Pharmaciens
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-boxes"></i> Stocks
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-cart"></i> Commandes
                    </a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link" href="#">
                        <i class="bi bi-gear"></i> Paramčtres
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-box-arrow-right"></i> Déconnexion
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content" class="p-0">
            <!-- Topbar -->
            <nav class="topbar d-flex justify-content-between align-items-center">
                <div>
                    <button id="sidebarToggle" class="btn bg-success text-white">
                        <i class="bi bi-list"></i>
                    </button>
                </div>
                <div class="d-flex align-items-center">
                    <div class="dropdown me-3">
                        <a href="#" class="btn btn-light position-relative">
                            <i class="bi bi-bell"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                5
                            </span>
                        </a>
                    </div>
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="https://ui-avatars.com/api/?name=Admin+User&background=0D8ABC&color=fff" class="user-avatar">
                            <span class="text-success">Admin User</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUser">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profil</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Paramčtres</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right me-2"></i> Déconnexion</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        <!-- Topbar (identique à utilisateurs.jsp) -->

        <!-- Main Content -->
        <div class="container-fluid p-4">
        
            <h3 class="mb-4">Gestion des Pharmaciens</h3>
            <div class="row">
                <!-- Formulaire -->
                <div class="col-lg-4 col-md-12 mb-4">
                    <div class="card p-3 shadow-sm form-container">
                        <h5 class="card-title" id="form-title">Ajouter un Pharmacien</h5>
                        <form action="${pageContext.request.contextPath}/pharmacien" method="POST" id="pharmacienForm">
                            <input type="hidden" name="_method" id="methodField" value="">
                            <input type="hidden" id="pharmacienId" name="id">
                            
                            <div class="mb-3">
                                <label for="nom" class="form-label">Nom complet :</label>
                                <input type="text" id="nom" name="nom" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email :</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="telephone" class="form-label">Téléphone :</label>
                                <input type="text" id="telephone" name="telephone" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="adresse" class="form-label">Adresse :</label>
                                <input type="text" id="adresse" name="adresse" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="pharmacie_id" class="form-label">Pharmacie :</label>
                                <select id="pharmacie_id" name="pharmacie_id" class="form-select" required>
                                    <% for (Pharmacie pharmacie : pharmacies) { %>
                                        <option value="<%= pharmacie.getId() %>"><%= pharmacie.getNom() %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Mot de passe :</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100" id="submit-button">Ajouter Pharmacien</button>
                        </form>
                    </div>
                </div>

                <!-- Liste -->
                <div class="col-lg-8 col-md-12">
                    <div class="card p-3 shadow-sm">
                        <h5 class="card-title">Liste des Pharmaciens</h5>
                        <div class="table-container">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Pharmacien</th>
                                        <th>Email</th>
                                        <th>Téléphone</th>
                                        <th>Pharmacie</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (pharmaciens != null && !pharmaciens.isEmpty()) { 
                                        for (Pharmacien pharmacien : pharmaciens) { 
                                            Pharmacie pharmacie = pharmacien.getPharmacie();
                                    %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="https://ui-avatars.com/api/?name=<%= pharmacien.getNom() %>&background=random" class="user-avatar">
                                                <div>
                                                    <div class="fw-bold"><%= pharmacien.getNom() %></div>
                                                    <div class="text-muted small">ID: <%= pharmacien.getId() %></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td><%= pharmacien.getEmail() %></td>
                                        <td><%= pharmacien.getTelephone() %></td>
                                        <td>
                                            <% if (pharmacie != null) { %>
                                                <span class="pharmacie-badge"><%= pharmacie.getNom() %></span>
                                            <% } else { %>
                                                <span class="text-muted">Non assigné</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <div class="d-flex">
                                                <a href="#" 
                                                   class="btn btn-warning btn-sm btn-action edit-btn me-2"
                                                   data-id="<%= pharmacien.getId() %>"
                                                   data-nom="<%= pharmacien.getNom() %>"
                                                   data-email="<%= pharmacien.getEmail() %>"
                                                   data-telephone="<%= pharmacien.getTelephone() %>"
                                                   data-adresse="<%= pharmacien.getAdresse() %>"
                                                   data-pharmacie_id="<%= pharmacie != null ? pharmacie.getId() : "" %>">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <form action="${pageContext.request.contextPath}/pharmacien" method="POST">
                                                    <input type="hidden" name="id" value="<%= pharmacien.getId() %>">
                                                    <input type="hidden" name="_method" value="DELETE">
                                                    <button type="submit" class="btn btn-danger btn-sm btn-action" 
                                                            onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce pharmacien ?');">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    <% } 
                                    } else { %>
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
                const email = this.getAttribute('data-email');
                const telephone = this.getAttribute('data-telephone');
                const adresse = this.getAttribute('data-adresse');
                const pharmacieId = this.getAttribute('data-pharmacie_id');

                document.getElementById('nom').value = nom;
                document.getElementById('email').value = email;
                document.getElementById('telephone').value = telephone;
                document.getElementById('adresse').value = adresse;
                document.getElementById('pharmacie_id').value = pharmacieId;
                document.getElementById('pharmacienId').value = id;
                document.getElementById('password').value = "********";
                document.getElementById('password').placeholder = "Laissez vide pour ne pas changer";

                document.getElementById('methodField').value = 'PUT';
                document.getElementById('form-title').textContent = "Modifier le Pharmacien";
                document.getElementById('submit-button').textContent = "Modifier Pharmacien";
                document.getElementById('submit-button').classList.remove('btn-primary');
                document.getElementById('submit-button').classList.add('btn-warning');
            });
        });

        // Réinitialisation du formulaire
        document.getElementById('pharmacienForm').addEventListener('submit', function() {
            setTimeout(() => {
                this.reset();
                document.getElementById('form-title').textContent = "Ajouter un Pharmacien";
                document.getElementById('submit-button').textContent = "Ajouter Pharmacien";
                document.getElementById('submit-button').classList.remove('btn-warning');
                document.getElementById('submit-button').classList.add('btn-primary');
                document.getElementById('methodField').value = '';
                document.getElementById('pharmacienId').value = '';
                document.getElementById('password').placeholder = '';
            }, 1000);
        });
    });
    </script>
</body>
</html>