<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="model.Pharmacien" %>
<%@ page import="model.Pharmacie" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Pharmacien</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Ajouter un Nouveau Pharmacien</h2>
    
    <!-- Formulaire d'ajout de pharmacien -->
    <form action="/PharmLocation/pharmacien" method="POST">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required><br>

        <label for="email">Email :</label>
        <input type="email" id="email" name="email" required><br>

        <label for="telephone">Téléphone :</label>
        <input type="tel" id="telephone" name="telephone" required><br>

        <label for="adresse">Adresse :</label>
        <input type="text" id="adresse" name="adresse" required><br>

        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" required><br>

        <label for="pharmacie_id">Pharmacie :</label>
        <select id="pharmacie_id" name="pharmacie_id" required>
            <%
                // Charger la liste des pharmacies depuis la base de données
               // List<Pharmacie> pharmacies = new PharmacieDAO().getAll();
              //  for (Pharmacie pharmacie : pharmacies) {
            %>
                <option value="1">tamichiki6</option>
            <%
                //}
            %>
        </select><br>

        <button type="submit">Ajouter Pharmacien</button>
    </form>

    <br>
    <a href="pharmaciens.jsp">Retour à la liste des pharmaciens</a>
</body>
</html>
