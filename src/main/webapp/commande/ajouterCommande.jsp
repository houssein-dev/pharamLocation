<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Commande</title>
</head>
<body>
    <h2>Ajouter une Commande</h2>
    <form action="commande" method="post">
        Utilisateur ID: <input type="number" name="utilisateur_id" required><br>
        Pharmacie ID: <input type="number" name="pharmacie_id" required><br>
        Médicaments (IDs séparés par des virgules): <input type="text" name="medicament_id" required><br>
        Statut:
        <select name="statut">
            <option value="en attente">En attente</option>
            <option value="validée">Validée</option>
            <option value="expédiée">Expédiée</option>
            <option value="livrée">Livrée</option>
        </select><br>
        <input type="submit" value="Ajouter">
    </form>
</body>
</html>
