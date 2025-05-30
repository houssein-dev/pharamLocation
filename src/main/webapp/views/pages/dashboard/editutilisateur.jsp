<%@ page import="model.Utilisateur" %>
<%
Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Utilisateur - PharmaAdmin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f5f7fb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0">Modifier l'utilisateur</h2>
            <a href="utilisateur" class="btn btn-secondary">
                <i class="bi bi-arrow-left me-1"></i> Retour
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <form action="utilisateur" method="post">
                    <input type="hidden" name="_method" value="PUT">
                    <input type="hidden" name="id" value="<%= utilisateur.getId() %>">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Nom complet</label>
                            <input type="text" class="form-control" name="nom" value="<%= utilisateur.getNom() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" value="<%= utilisateur.getEmail() %>" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Téléphone</label>
                            <input type="text" class="form-control" name="telephone" value="<%= utilisateur.getTelephone() %>">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Adresse</label>
                            <input type="text" class="form-control" name="adresse" value="<%= utilisateur.getAdresse() %>">
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Rôle</label>
                            <select class="form-select" name="role" required>
                                <option value="administrateur" <%= "administrateur".equals(utilisateur.getRole()) ? "selected" : "" %>>Administrateur</option>
                                <option value="pharmacien" <%= "pharmacien".equals(utilisateur.getRole()) ? "selected" : "" %>>Pharmacien</option>
                                <option value="utilisateur" <%= "utilisateur".equals(utilisateur.getRole()) ? "selected" : "" %>>Utilisateur</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Statut</label>
                            <select class="form-select">
                                <option selected>Actif</option>
                                <option>Inactif</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Nouveau mot de passe</label>
                            <input type="password" class="form-control" name="password" placeholder="Laissez vide pour ne pas changer">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Confirmer le mot de passe</label>
                            <input type="password" class="form-control" placeholder="Confirmez le nouveau mot de passe">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Photo de profil</label>
                        <input class="form-control" type="file">
                    </div>
                    
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary me-2">Enregistrer les modifications</button>
                        <a href="utilisateur" class="btn btn-outline-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>