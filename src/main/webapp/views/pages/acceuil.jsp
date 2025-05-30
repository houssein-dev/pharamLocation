<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Medicament, model.Pharmacie" %>

<jsp:include page="/WEB-INF/layouts/header.jsp" />

<style>
    .medical-card {
        transition: transform 0.3s;
        height: 100%;
    }
    
    .medical-card:hover {
        transform: translateY(-5px);
    }
    
    .pharmacy-card img {
        height: 200px;
        object-fit: cover;
    }
    
    .carousel-img {
        height: 22rem;
        object-fit: cover;
    }
</style>

<div id="carouselExampleCaptions" class="carousel slide">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="${pageContext.request.contextPath}/assets/images/s2.jpg" class="d-block w-100 carousel-img" alt="Promotion">
      <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 p-3 rounded">
        <h5>Votre santé, notre priorité</h5>
        <p>Trouvez vos médicaments essentiels en quelques clics</p>
      </div>
    </div>
    <!-- Ajouter d'autres éléments carousel si nécessaire -->
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<div class="container">
  <!-- Section Médicaments -->
  <div class="head-section mt-5 d-flex justify-content-center align-items-center mb-4">
    <h2 class="fw-bold text-primary">Médicaments en vente</h2>
  </div>
  
  <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4 mb-5">
    <%
      List<Medicament> medicaments = (List<Medicament>) request.getAttribute("medicaments");
      if (medicaments != null && !medicaments.isEmpty()) {
        for (Medicament med : medicaments) {
    %>
      <div class="col">
        <div class="card h-100 medical-card shadow-sm">
          <img src="${pageContext.request.contextPath}/assets/images/medical/p<%= med.getId() % 4 + 1 %>.jpg" 
               class="card-img-top" 
               style="height: 200px; object-fit: cover;" 
               alt="<%= med.getNom() %>">
          <div class="card-body">
            <h5 class="card-title"><%= med.getNom() %></h5>
            <ul class="list-group list-group-flush">
              <li class="list-group-item"><strong>Dosage:</strong> <%= med.getDosage() %></li>
              <li class="list-group-item"><strong>Laboratoire:</strong> <%= med.getLaboratoire() %></li>
              <li class="list-group-item"><strong>Prix:</strong> <%= med.getPrix() %> DH</li>
            </ul>
          </div>
          <div class="card-footer bg-white">
            <a href="${pageContext.request.contextPath}/medicament?id=<%= med.getId() %>" 
               class="btn btn-sm btn-outline-primary me-2">
              Voir détails
            </a>
            <a href="#" class="btn btn-sm btn-outline-success">
              <i class="bi bi-cart-plus"></i> Commander
            </a>
          </div>
        </div>
      </div>
    <% 
        }
      } else {
    %>
      <div class="col-12 text-center">
        <div class="alert alert-info">Aucun médicament disponible pour le moment</div>
      </div>
    <% } %>
  </div>

  <!-- Section Pharmacies -->
  <div class="head-section mt-5 d-flex justify-content-center align-items-center mb-4">
    <h2 class="fw-bold text-primary">Pharmacies disponibles</h2>
  </div>
  
  <div class="row row-cols-1 row-cols-lg-2 g-4 mb-5">
    <%
      List<Pharmacie> pharmacies = (List<Pharmacie>) request.getAttribute("pharmacies");
      if (pharmacies != null && !pharmacies.isEmpty()) {
        for (Pharmacie pharma : pharmacies) {
    %>
      <div class="col">
        <div class="card pharmacy-card shadow-sm">
          <div class="row g-0 h-100">
            <div class="col-md-5">
              <img src="${pageContext.request.contextPath}/assets/images/medical/l<%= pharma.getId() % 4 + 1 %>.jpg" 
                   class="img-fluid rounded-start h-100" 
                   alt="<%= pharma.getNom() %>">
            </div>
            <div class="col-md-7 d-flex flex-column">
              <div class="card-body">
                <h5 class="card-title"><%= pharma.getNom() %></h5>
                <p class="card-text">
                  <i class="bi bi-geo-alt-fill text-danger me-2"></i>
                  <%= pharma.getAdresse() %>
                </p>
                <div class="d-grid gap-2 mt-3">
                  <a href="${pageContext.request.contextPath}/pharmacie?id=<%= pharma.getId() %>" 
                     class="btn btn-outline-primary">
                    <i class="bi bi-boxes me-2"></i> Voir le stock
                  </a>
                  <a href="https://maps.google.com/?q=<%= pharma.getCoordonneesGPS() %>" 
                     target="_blank" 
                     class="btn btn-outline-success">
                    <i class="bi bi-map me-2"></i> Itinéraire
                  </a>
                </div>
              </div>
              <div class="card-footer bg-transparent">
                <small class="text-muted">
                  <i class="bi bi-clock-history me-2"></i> Ouvert 24h/24
                </small>
              </div>
            </div>
          </div>
        </div>
      </div>
    <% 
        }
      } else {
    %>
      <div class="col-12 text-center">
        <div class="alert alert-info">Aucune pharmacie disponible pour le moment</div>
      </div>
    <% } %>
  </div>
</div>

<jsp:include page="/WEB-INF/layouts/footer.jsp" />