<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Commande, model.Medicament, model.Utilisateur, model.Pharmacie" %>
<jsp:useBean id="commandes" class="java.util.ArrayList" scope="session"/>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des Commandes</title>
</head>
<body>
    <h2>Liste des Commandes</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Utilisateur</th>
            <th>Pharmacie</th>
            <th>Médicaments</th>
            <th>Statut</th>
            <th>Actions</th>
        </tr>
        <%
            // Récupérer la liste des commandes depuis l'attribut "commandes"
            for (Commande c : (ArrayList<Commande>) request.getAttribute("commandes")) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getUtilisateur().getNom() %> <%= c.getUtilisateur().getPrenom() %></td>
            <td><%= c.getPharmacie().getNom() %></td>
            <td>
                <ul>
                <%
                    // Afficher les médicaments de la commande
                    for (Medicament m : c.getMedicaments()) {
                %>
                    <li><%= m.getNom() %></li>
                <%
                    }
                %>
                </ul>
            </td>
            <td><%= c.getStatut() %></td>
            <td>
                <!-- Lien pour modifier une commande -->
                <a href="modifierCommande.jsp?id=<%= c.getId() %>">Modifier</a> |
                <!-- Lien pour supprimer une commande -->
                <a href="supprimerCommande.jsp?id=<%= c.getId() %>">Supprimer</a>
            </td>
        </tr>
        <% } %>
    </table>

    <h2>Ajouter une Nouvelle Commande</h2>
    <form action="/PharmLocation/commande" method="post">
        Utilisateur ID: <input type="number" name="utilisateur_id" required><br>
        Pharmacie ID: <input type="number" name="pharmacie_id" required><br>
        Statut: 
        <select name="statut" required>
            <option value="en cours">En cours</option>
            <option value="terminée">Terminée</option>
            <option value="annulée">Annulée</option>
        </select><br>
        Médicaments: 
        <select name="medicament_id" multiple required>
            <% 
                // Récupérer les médicaments disponibles et les afficher dans la liste déroulante
                List<Medicament> medicaments = (List<Medicament>) request.getAttribute("medicaments");
                for (Medicament medicament : medicaments) {
            %>
                <option value="<%= medicament.getId() %>"><%= medicament.getNom() %></option>
            <% } %>
        </select><br>
        <input type="submit" value="Ajouter Commande">
    </form>
</body>
</html>
