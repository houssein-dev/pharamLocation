<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - PharmaLocator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
      <link href="${pageContext.request.contextPath}/assets/css/dashboard.css" rel="stylesheet">
    
</head>
<body>
    <div class="wrapper d-flex">
        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-succes">
            <div class="logo">
                <i class="bi bi-capsule-pill"></i> PharmaAdmin
            </div>
            <ul class="nav flex-column mt-4">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="bi bi-speedometer2"></i> Tableau de bord
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-capsule"></i> Médicaments
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-shop"></i> Pharmacies
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-people"></i> Utilisateurs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-person-badge"></i> Pharmaciens
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-boxes"></i> Stocks
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-cart"></i> Commandes
                    </a>
                </li>
                <li class="nav-item mt-4">
                    <a class="nav-link" href="#">
                        <i class="bi bi-gear"></i> Paramètres
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="bi bi-box-arrow-right"></i> Déconnexion
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div id="content" class="p-0">
            <!-- Topbar -->
            <nav class="topbar d-flex justify-content-between align-items-center">
                <div>
                    <button id="sidebarToggle" class="btn btn-success">
                        <i class="bi bi-list"></i>
                    </button>
                </div>
                <div class="d-flex align-items-center">
                    <div class="dropdown me-3">
                        <a href="#" class="btn btn-light position-relative">
                            <i class="bi bi-bell"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                5
                            </span>
                        </a>
                    </div>
                    <div class="dropdown">
                        <a href="#" class="d-flex align-items-center text-decoration-none dropdown-toggle" id="dropdownUser" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="https://ui-avatars.com/api/?name=Admin+User&background=0D8ABC&color=fff" class="user-avatar">
                            <span class="text-success" >Admin User</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUser">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Profil</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Paramètres</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right me-2"></i> Déconnexion</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Main Content -->
            <div class="container-fluid p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="mb-0">Tableau de bord</h2>
                    <div>
                        <button class="btn btn-outline-success me-2">
                            <i class="bi bi-download me-1"></i> Exporter
                        </button>
                        <button class="btn btn-success">
                            <i class="bi bi-plus-circle me-1"></i> Nouveau
                        </button>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card bg-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="text-muted">Médicaments</div>
                                        <h2 class="mt-2">142</h2>
                                        <div class="small text-success">
                                            <i class="bi bi-arrow-up"></i> 12% depuis le mois dernier
                                        </div>
                                    </div>
                                    <div class="icon text-success">
                                        <i class="bi bi-capsule"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card bg-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="text-muted">Pharmacies</div>
                                        <h2 class="mt-2">24</h2>
                                        <div class="small text-success">
                                            <i class="bi bi-arrow-up"></i> 3 nouvelles
                                        </div>
                                    </div>
                                    <div class="icon text-success">
                                        <i class="bi bi-shop"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card bg-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="text-muted">Commandes</div>
                                        <h2 class="mt-2">324</h2>
                                        <div class="small text-danger">
                                            <i class="bi bi-arrow-down"></i> 2% depuis hier
                                        </div>
                                    </div>
                                    <div class="icon text-warning">
                                        <i class="bi bi-cart"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card bg-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="text-muted">Revenu</div>
                                        <h2 class="mt-2">€12,430</h2>
                                        <div class="small text-success">
                                            <i class="bi bi-arrow-up"></i> 18.2% depuis hier
                                        </div>
                                    </div>
                                    <div class="icon text-info">
                                        <i class="bi bi-currency-euro"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts and Tables -->
                <div class="row mt-4">
                    <!-- Left Column -->
                    <div class="col-lg-8">
                        <!-- Sales Chart -->
                        <div class="chart-container mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5>Statistiques des ventes</h5>
                                <div>
                                    <button class="btn btn-sm btn-outline-secondary">Mensuel</button>
                                    <button class="btn btn-sm btn-outline-secondary active">Hebdomadaire</button>
                                    <button class="btn btn-sm btn-outline-secondary">Quotidien</button>
                                </div>
                            </div>
                            <div style="height: 300px; position: relative;">
                                <canvas id="salesChart"></canvas>
                            </div>
                        </div>

                        <!-- Recent Orders -->
                        <div class="recent-table mb-4">
                            <div class="p-3 border-bottom">
                                <h5 class="mb-0">Dernières commandes</h5>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th>Commande</th>
                                            <th>Client</th>
                                            <th>Pharmacie</th>
                                            <th>Montant</th>
                                            <th>Statut</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>#ORD-00125</td>
                                            <td>
                                                <img src="https://ui-avatars.com/api/?name=Jean+Dupont&background=0D8ABC&color=fff" class="user-avatar">
                                                Jean Dupont
                                            </td>
                                            <td>Pharmacie Centrale</td>
                                            <td>€87.50</td>
                                            <td><span class="status-badge status-completed">Complétée</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-success">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#ORD-00124</td>
                                            <td>
                                                <img src="https://ui-avatars.com/api/?name=Marie+Martin&background=6f42c1&color=fff" class="user-avatar">
                                                Marie Martin
                                            </td>
                                            <td>Pharmacie du Nord</td>
                                            <td>€42.30</td>
                                            <td><span class="status-badge status-pending">En attente</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-warnning">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#ORD-00123</td>
                                            <td>
                                                <img src="https://ui-avatars.com/api/?name=Pierre+Leroy&background=20c997&color=fff" class="user-avatar">
                                                Pierre Leroy
                                            </td>
                                            <td>Pharmacie Sud</td>
                                            <td>€125.80</td>
                                            <td><span class="status-badge status-completed">Complétée</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-success">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#ORD-00122</td>
                                            <td>
                                                <img src="https://ui-avatars.com/api/?name=Sophie+Petit&background=fd7e14&color=fff" class="user-avatar">
                                                Sophie Petit
                                            </td>
                                            <td>Pharmacie Ouest</td>
                                            <td>€56.90</td>
                                            <td><span class="status-badge status-canceled">Annulée</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-danger">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#ORD-00121</td>
                                            <td>
                                                <img src="https://ui-avatars.com/api/?name=Thomas+Moreau&background=e83e8c&color=fff" class="user-avatar">
                                                Thomas Moreau
                                            </td>
                                            <td>Pharmacie Centrale</td>
                                            <td>€93.20</td>
                                            <td><span class="status-badge status-completed">Complétée</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-success">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="p-3 border-top text-center">
                                <a href="#" class="btn btn-link">Voir toutes les commandes</a>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="col-lg-4">
                        <!-- Activity -->
                        <div class="chart-container mb-4">
                            <h5 class="mb-4">Activité récente</h5>
                            <div class="d-flex mb-4">
                                <div class="flex-shrink-0">
                                    <img src="https://ui-avatars.com/api/?name=Admin+User&background=0D8ABC&color=fff" class="user-avatar">
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1">Admin User a ajouté un nouveau médicament</h6>
                                    <p class="mb-0 text-muted">Paracétamol 500mg ajouté au catalogue</p>
                                    <small class="text-muted">Il y a 15 minutes</small>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <div class="flex-shrink-0">
                                    <img src="https://ui-avatars.com/api/?name=Marie+Martin&background=6f42c1&color=fff" class="user-avatar">
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1">Marie Martin a passé une commande</h6>
                                    <p class="mb-0 text-muted">Commande #ORD-00124 pour €42.30</p>
                                    <small class="text-muted">Il y a 2 heures</small>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <div class="flex-shrink-0">
                                    <img src="https://ui-avatars.com/api/?name=Dr+Robert&background=20c997&color=fff" class="user-avatar">
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1">Dr Robert a mis à jour le stock</h6>
                                    <p class="mb-0 text-muted">Stock d'Ibuprofène mis à jour à Pharmacie Centrale</p>
                                    <small class="text-muted">Il y a 5 heures</small>
                                </div>
                            </div>
                            <div class="d-flex">
                                <div class="flex-shrink-0">
                                    <img src="https://ui-avatars.com/api/?name=Admin+User&background=0D8ABC&color=fff" class="user-avatar">
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-1">Admin User a ajouté une nouvelle pharmacie</h6>
                                    <p class="mb-0 text-muted">Pharmacie Est ajoutée au système</p>
                                    <small class="text-muted">Hier à 14:30</small>
                                </div>
                            </div>
                        </div>

                        <!-- Stock Status -->
                        <div class="chart-container">
                            <h5 class="mb-4">Statut des stocks</h5>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Paracétamol 500mg</span>
                                    <span>45/100</span>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 45%"></div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Ibuprofène 400mg</span>
                                    <span>32/100</span>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar bg-warning" role="progressbar" style="width: 32%"></div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Vitamine C</span>
                                    <span>18/50</span>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar bg-danger" role="progressbar" style="width: 36%"></div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Oméprazole 20mg</span>
                                    <span>68/100</span>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar bg-success" role="progressbar" style="width: 68%"></div>
                                </div>
                            </div>
                            <div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Aspirine</span>
                                    <span>12/50</span>
                                </div>
                                <div class="progress">
                                    <div class="progress-bar bg-danger" role="progressbar" style="width: 24%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
    <script>


        // Sales Chart
        const salesChart = new Chart(
            document.getElementById('salesChart'),
            {
                type: 'line',
                data: {
                    labels: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
                    datasets: [
                        {
                            label: 'Commandes',
                            data: [35, 42, 48, 55, 50, 65, 70],
                            borderColor: '#0d6efd',
                            backgroundColor: 'rgba(13, 110, 253, 0.1)',
                            tension: 0.3,
                            fill: true
                        },
                        {
                            label: 'Revenus (€)',
                            data: [1200, 1450, 1620, 1870, 1750, 2100, 2300],
                            borderColor: '#198754',
                            backgroundColor: 'rgba(25, 135, 84, 0.1)',
                            tension: 0.3,
                            fill: true
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            }
        );
    </script>
</body>
</html>