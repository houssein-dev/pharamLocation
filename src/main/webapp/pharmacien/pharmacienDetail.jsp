<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="model.Pharmacien" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du Pharmacien</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Détails du Pharmacien</h2>
    <%
        Pharmacien pharmacien = (Pharmacien) request.getAttribute("pharmacien");
        if (pharmacien != null) {
    %>
        <p><strong>Nom:</strong> <%= pharmacien.getNom() %></p>
        <p><strong>Email:</strong> <%= pharmacien.getEmail() %></p>
        <p><strong>Téléphone:</strong> <%= pharmacien.getTelephone() %></p>
        <p><strong>Adresse:</strong> <%= pharmacien.getAdresse() %></p>
        <p><strong>Pharmacie:</strong> <%= pharmacien.getPharmacie().getNom() %></p>
        <a href="pharmacien">Retour à la liste</a>
    <%
        } else {
    %>
        <p>Pharmacien introuvable.</p>
    <%
        }
    %>
</body>
</html>
