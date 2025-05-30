<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/layouts/header.jsp" flush="true" />

<div class="container d-flex justify-content-center align-items-center min-vh-75">
  <div class="card shadow-sm p-4" style="width:100%;max-width:500px;">
    <h3 class="text-center mb-4">Inscription</h3>
    
    <%-- Affichage des erreurs --%>
    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/inscription" method="post">
      <div class="mb-2">
        <label for="nom" class="form-label">Nom complet</label>
        <input type="text" id="nom" name="nom" class="form-control" required>
      </div>
      <div class="mb-2">
        <label for="email" class="form-label">Email</label>
        <input type="email" id="email" name="email" class="form-control" required>
      </div>
      <div class="mb-2">
        <label for="password" class="form-label">Mot de passe</label>
        <input type="password" id="password" name="password" class="form-control" required>
      </div>
      <div class="mb-2">
        <label for="telephone" class="form-label">Téléphone</label>
        <input type="text" id="telephone" name="telephone" class="form-control">
      </div>
      <div class="mb-2">
        <label for="adresse" class="form-label">Adresse</label>
        <input type="text" id="adresse" name="adresse" class="form-control">
      </div>
      
      <div class="mb-3">
        <label class="form-label">Type de compte</label>
        <div class="form-check">
          <input class="form-check-input" type="radio" name="role" id="roleUser" value="utilisateur" checked>
          <label class="form-check-label" for="roleUser">
            Utilisateur normal
          </label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="radio" name="role" id="rolePharma" value="pharmacien">
          <label class="form-check-label" for="rolePharma">
            Pharmacien
          </label>
        </div>
      </div>
      
      <div class="mb-3" id="pharmacySelect" style="display: none;">
        <label for="pharmacie_id" class="form-label">Pharmacie</label>
        <select id="pharmacie_id" name="pharmacie_id" class="form-select">
          <option value="">Sélectionnez une pharmacie</option>
          <c:forEach items="${pharmacies}" var="pharmacie">
            <option value="${pharmacie.id}">${pharmacie.nom}</option>
          </c:forEach>
        </select>
      </div>

      <button type="submit" class="btn btn-success w-100">S'inscrire</button>
    </form>
    <p class="text-center mt-3">
      Déjà un compte ? <a href="login.jsp">Connectez-vous</a>
    </p>
  </div>
</div>

<script>
  // Afficher/masquer la sélection de pharmacie
  document.querySelectorAll('input[name="role"]').forEach(radio => {
    radio.addEventListener('change', function() {
      const pharmacySelect = document.getElementById('pharmacySelect');
      pharmacySelect.style.display = this.value === 'pharmacien' ? 'block' : 'none';
    });
  });
</script>

<jsp:include page="/WEB-INF/layouts/footer.jsp" flush="true" />