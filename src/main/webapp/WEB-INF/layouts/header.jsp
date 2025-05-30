<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>PharmaciePlus</title>

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/css/home.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css ">

  <!-- Styles personnalisés -->
  <style>
    .search-form {
      min-width: 200px;
    }
    @media (max-width: 767.98px) {
      .search-form {
        display: none;
      }
    }
  </style>
</head>

<body>
  <!-- Barre de navigation -->
  <nav class="navbar navbar-expand-lg navbar-light bg-success">
    <div class="container">
      <a class="navbar-brand text-white fw-bold" href="home.jsp">PharmaciePlus</a>
      
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
              aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto align-items-center">

          <li class="nav-item">
            <form class="d-flex search-form" role="search" action="search-results.jsp" method="get">
              <input class="form-control me-2" type="search" name="query" placeholder="Rechercher une pharmacie..." aria-label="Search">
              <button class="btn btn-outline-light" type="submit">Recherche</button>
            </form>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="home.jsp">Accueil</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="login.jsp">Connexion</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Contenu principal -->
  <div class="container ">
