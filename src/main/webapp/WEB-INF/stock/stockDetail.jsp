<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stock ${stock.medicament.nom}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h3>Détails du Stock</h3>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h4>Pharmacie</h4>
                    <p><strong>Nom:</strong> ${stock.pharmacie.nom}</p>
                    <p><strong>Adresse:</strong> ${stock.pharmacie.adresse}</p>
                </div>
                <div class="col-md-6">
                    <h4>Médicament</h4>
                    <p><strong>Nom:</strong> ${stock.medicament.nom}</p>
                    <p><strong>Dosage:</strong> ${stock.medicament.dosage}</p>
                    <p><strong>Laboratoire:</strong> ${stock.medicament.laboratoire}</p>
                </div>
            </div>
            
            <div class="alert alert-primary">
                <h5>Quantité en stock: ${stock.quantite}</h5>
            </div>
            
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/stock?action=edit&pharmacieId=${stock.pharmacie.id}&medicamentId=${stock.medicament.id}" 
                   class="btn btn-warning">
                    Modifier
                </a>
                <form method="post" action="${pageContext.request.contextPath}/stock" style="display: inline;">
                    <input type="hidden" name="_method" value="DELETE">
                    <input type="hidden" name="pharmacieId" value="${stock.pharmacie.id}">
                    <input type="hidden" name="medicamentId" value="${stock.medicament.id}">
                    <button type="submit" class="btn btn-danger" 
                            onclick="return confirm('Supprimer définitivement ce stock ?')">
                        Supprimer
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>