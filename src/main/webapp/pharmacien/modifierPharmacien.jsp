<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="model.Pharmacien" %>
<%@ page import="model.Pharmacie" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier un Pharmacien</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Modifier un Pharmacien</h2>

    <%
        // Récupérer l'ID du pharmacien depuis la requête
       // int id = Integer.parseInt(request.getParameter("id"));
        
        // Récupérer le pharmacien depuis la base de données
        Pharmacien pharmacien = (Pharmacien) request.getAttribute("pharmacien");
        
        // Si pharmacien n'est pas trouvé, rediriger vers la liste
        if (pharmacien == null) {
            response.sendRedirect("/PharmLocation/pharmaciens.jsp");
            return;
        }
    %>

    <!-- Formulaire de modification du pharmacien -->
    <form action="/PharmLocation/pharmacien?id=<%= pharmacien.getId() %>" method="POST">
        <input type="hidden" name="_method" value="PUT"> <!-- Utilisation de PUT pour modifier -->

        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" value="<%= pharmacien.getNom() %>" required><br>

        <label for="email">Email :</label>
        <input type="email" id="email" name="email" value="<%= pharmacien.getEmail() %>" required><br>

        <label for="telephone">Téléphone :</label>
        <input type="tel" id="telephone" name="telephone" value="<%= pharmacien.getTelephone() %>" required><br>

        <label for="adresse">Adresse :</label>
        <input type="text" id="adresse" name="adresse" value="<%= pharmacien.getAdresse() %>" required><br>

        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" value="<%= pharmacien.getPassword() %>" required><br>

        <label for="pharmacie_id">Pharmacie :</label>
        <select id="pharmacie_id" name="pharmacie_id" required>
            <%
                // Charger la liste des pharmacies depuis la base de données
              //  List<Pharmacie> pharmacies = new PharmacieDAO().getAll();
              //  for (Pharmacie pharmacie : pharmacies) {
                    // Sélectionner la pharmacie du pharmacien actuel
             //       String selected = (pharmacien.getPharmacie().getId() == pharmacie.getId()) ? "selected" : "";
            %>
                <option value="1" >tamichik6</option>
            <%
               // }
            %>
        </select><br>

        <button type="submit">Modifier Pharmacien</button>
    </form>

    <br>
    <a href="pharmaciens.jsp">Retour à la liste des pharmaciens</a>
</body>
</html>
