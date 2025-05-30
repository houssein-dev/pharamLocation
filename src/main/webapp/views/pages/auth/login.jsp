<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/layouts/header.jsp" />

<div class="d-flex justify-content-center align-items-center" style="min-height: 70vh;">
  <div class="card shadow-sm p-4" style="width:100%;max-width:400px;">
    <h3 class="text-center mb-4">Connexion</h3>
    
    <%-- Affichage des erreurs --%>
    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/auth" method="post"> <!-- Correction de l'URL -->
      <div class="mb-3">
        <label for="email" class="form-label">Email</label>
        <input type="email" id="email" name="email" class="form-control" required value="${param.email}">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">Mot de passe</label>
        <input type="password" id="password" name="password" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-success w-100">Se connecter</button>
    </form>
    <p class="text-center mt-3">
      Pas encore de compte ? <a href="register.jsp" style="color:green">Inscrivez-vous</a>
    </p>
  </div>
</div>

<jsp:include page="/WEB-INF/layouts/footer.jsp" />