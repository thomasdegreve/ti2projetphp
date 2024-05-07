<?php
// Vérification et traitement de la soumission du formulaire de connexion
if (isset($_POST['submit_login'])) {
    // Extraction des données du formulaire
    extract($_POST);
    // Vérification de l'existence de l'administrateur dans la base de données
    $ad = new AdminDB($cnx);
    $admin = $ad->getAdmin($login, $password); // $admin reçoit 1 ou 0
    if ($admin) {
        // Si l'administrateur existe, créer une variable de session pour l'administrateur
        $_SESSION['admin'] = 1; // Sera vérifiée dans toutes les pages admin
        header("Location: admin/index_.php?page=accueil_admin.php");
        exit; // Arrêter l'exécution du script après la redirection
    } else {
        // Si l'administrateur n'existe pas, afficher un message d'erreur et rediriger vers l'accueil public
        echo "<br>Accès réservé aux administrateurs";
        header("refresh:3; url=index_.php?page=accueil.php");
        exit; // Arrêter l'exécution du script après la redirection
    }
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boutique de Vêtements de Football</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding-top: 60px;
        }
        .jumbotron {
            background-image: url('admin/public/images/Maillot.jpg');
            background-size: cover;
            color: #fff;
            text-align: center;
            padding: 100px 0;
            margin-bottom: 0;
        }
        .jumbotron h1 {
            font-size: 3.5rem;
        }
        .jumbotron p {
            font-size: 1.5rem;
        }
        .navbar {
            background-color: #343a40;
        }
        .navbar-brand, .navbar-nav .nav-link {
            color: #fff;
        }
        .navbar-brand:hover, .navbar-nav .nav-link:hover {
            color: #ccc;
        }
        .product-card {
            margin-bottom: 30px;
        }
        .product-card img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">Boutique de Vêtements de Football</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Accueil</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="admin/pages/jquery_aPropos.php">À Propos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="pages/Contact.php">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href='pages/Inscription.php'>Inscription</a>
                </li>

            </ul>
        </div>
    </div>
</nav>

<div class="jumbotron">
    <div class="container">

        <h1>Des Tenues de Football Exceptionnelles</h1>
        <p>Découvrez notre large sélection de maillots, shorts, chaussures et plus encore!</p>
        <a class="btn btn-primary btn-lg" href="index_.php?page=Affichageproduit.php" role="button">Explorer</a>
    </div>
</div>

<div class="container">
    <h2>Nos Produits</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card product-card">
                <img src="admin/public/images/OIP.jpg" class="card-img-top" alt="Maillot">
                <div class="card-body">
                    <h5 class="card-title">Maillot</h5>
                    <p class="card-text">Maillot de football  de haute qualité.</p>
                    <a class="btn btn-primary btn-lg" href="index_.php?page=affichage_maillot.php" role="button">Explorer</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card product-card">
                <img src="admin/public/images/shortt_foot.jpg" class="card-img-top" alt="Short">
                <div class="card-body">
                    <h5 class="card-title">Short Football</h5>
                    <p class="card-text">Short de football  confortable et respirant.</p>
                    <a class="btn btn-primary btn-lg" href="index_.php?page=affichage_short.php" role="button">Explorer</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card product-card">
                <img src="admin/public/images/5cee8bf877627.jpg" class="card-img-top" alt="Chaussures">
                <div class="card-body">
                    <h5 class="card-title">Chaussures de Football</h5>
                    <p class="card-text">Chaussures de football professionnelles pour une performance optimale.</p>
                    <a class="btn btn-primary btn-lg" href="index_.php?page=affichage_chaussures.php" role="button">Explorer</a>
                </div>
            </div>
        </div>
    </div>
</div>


<footer class="bg-dark text-white text-center py-4">
    <p>&copy; 2024 Boutique de Vêtements de Football. Tous droits réservés.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
