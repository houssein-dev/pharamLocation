<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/layouts/header.jsp" />

        <div class="row mb-4 mt-4">
            <div class="col-12">
                <h2 class="border-bottom pb-2">Détails du Médicament</h2>
            </div>
        </div>

        <!-- Section médicament -->
        <div class="row">
            <!-- Image du médicament -->
            <div class="col-md-3">
                <div class="medication-image text-center">
                    <img src="../../../assets/images/medical/p3.jpg" alt="Médicament" class="img-fluid rounded">
                </div>
            </div>

            <!-- Informations du médicament -->
            <div class="col-md-9 medication-info">
                <h3>Doliprane 1000mg</h3>
                
                <div class="mb-3">
                    <span class="badge bg-warning text-dark">Comprimé</span>
                    <span class="badge bg-primary">Boîte de 10</span>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-auto">
                        <input type="text" class="form-control" placeholder="Dosage" value="1000 mg" readonly>
                    </div>
                    <div class="col-auto price-dropdown">
                        <select class="form-select">
                            <option selected>Prix</option>
                            <option value="1">Option 1</option>
                            <option value="2">Option 2</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <a href="#" class="text-decoration-none text-secondary">
                            <i class="fas fa-map-marker-alt"></i> Localiser
                        </a>
                    </div>
                </div>

                <div class="mb-3">
                    <span class="badge bg-success">Disponible</span>
                </div>

                <h5>Inclusion</h5>
                <div class="d-flex gap-3 mt-2">
                    <a href="#" class="text-decoration-none text-muted" title="Ajouter aux favoris">
                        <i class="fas fa-star"></i>
                    </a>
                    <a href="#" class="text-decoration-none text-muted" title="Partager">
                        <i class="fas fa-share-alt"></i>
                    </a>
                    <a href="#" class="text-decoration-none text-muted" title="Informations complémentaires">
                        <i class="fas fa-question-circle"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Tableau des pharmacies -->
        <div class="row mt-5">
            <div class="col-12">
                <h4 class="border-bottom pb-2">Pharmacies Disponibles</h4>
                <div class="table-responsive table-pharmacies">
                    <table class="table table-secondary table-hover">
                        <thead>
                            <tr>
                                <th>Pharmacie</th>
                                <th>Prix</th>
                                <th>Proximité</th>
                                <th>Disponibilité</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Données statiques pour les pharmacies -->
                            <%
                                // Données statiques pour les pharmacies
                                String[][] pharmacies = {
                                    {"Pharmacie Centrale", "38 DH", "1.2 km", "available"},
                                    {"Pharmacie Al Amal", "42 DH", "2.5 km", "unavailable"},
                                    {"Pharmacie Dar el Beida", "36 DH", "3.8 km", "available"},
                                    {"Pharmacie du Centre Ville", "40 DH", "1.5 km", "available"}
                                };
                                
                                for (String[] pharmacy : pharmacies) {
                                    String name = pharmacy[0];
                                    String price = pharmacy[1];
                                    String distance = pharmacy[2];
                                    String availability = pharmacy[3];
                            %>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="pharmacy-icon">
                                                <i class="fas fa-hospital text-primary"></i>
                                            </div>
                                            <div>
                                                <h6><%= name %></h6>
                                                <small class="text-muted">Adresse fictive, Casablanca</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td><strong><%= price %></strong></td>
                                    <td><%= distance %></td>
                                    <td>
                                        <span class="availability-status <%= availability.equals("available") ? "available" : "unavailable" %>">
                                            <%= availability.equals("available") ? "Disponible" : "Épuisé" %>
                                        </span>
                                    </td>
                                    <td>
                                        <a href="#" class="btn btn-view">Voir Pharmacie</a>
                                    </td>
                                </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
<jsp:include page="/WEB-INF/layouts/footer.jsp" />

