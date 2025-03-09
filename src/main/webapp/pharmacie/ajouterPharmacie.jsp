<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Pharmacie</title>
</head>
<body>
    <h2>Ajouter une Pharmacie</h2>
    <form action="/PharmLocation/pharmacie" method="post">
        Nom: <input type="text" name="nom" required><br>
        Adresse: <input type="text" name="adresse" required><br>
        Coordonnées GPS: <input type="text" name="coordonneesGPS" required><br>
        <input type="submit" value="Ajouter">
    </form>
</body>
</html>
