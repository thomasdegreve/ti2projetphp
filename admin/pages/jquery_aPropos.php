<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>À Propos</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
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
        .jumbotron {
            background-color: #007bff;
            color: #fff;
        }
        section {
            padding: 20px 0;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Boutique de Vêtements de Football</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <button class="nav-link btn btn-link" onclick="scrollToSection('accueil')">Accueil</button>
                </li>

                <li class="nav-item active">
                    <button class="nav-link btn btn-link" onclick="scrollToSection('histoire')">Notre Histoire</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link btn btn-link" onclick="scrollToSection('mission')">Notre Mission</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link btn btn-link" onclick="scrollToSection('equipe')">Notre Équipe</button>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="jumbotron jumbotron-fluid">
    <div class="container">
        <h1 class="display-4">À Propos de Nous</h1>
        <p class="lead">Découvrez qui nous sommes et notre passion pour le football.</p>
    </div>
</div>

<section id="accueil" class="container">
    <h2>Accueil</h2>
    <p>Bienvenue sur notre site web de la Boutique de Vêtements de Football. Nous sommes ravis de vous accueillir ici, où vous pourrez trouver une large gamme de vêtements, d'accessoires et d'équipements de football pour répondre à tous vos besoins. Que vous soyez un joueur, un supporter ou un entraîneur, nous avons tout ce dont vous avez besoin pour vivre pleinement votre passion pour ce sport captivant.</p>
    <p>Consultez notre <a href="../src/php/utils/menu_public.php">menu public</a> pour découvrir nos produits.</p>
</section>


<section id="histoire" class="container">
    <h2>Notre Histoire</h2>
    <p>Nous sommes une équipe de passionnés de football qui a décidé de créer cette boutique en ligne pour partager notre amour du sport avec vous. Notre histoire commence il y a plusieurs années, lorsque nous avons réalisé à quel point le football était une partie essentielle de nos vies. Nous avons joué sur de nombreux terrains, partagé des moments inoubliables et vécu des émotions intenses grâce à ce sport. C'est cette passion qui nous a inspirés à créer cette boutique, dans l'espoir de permettre à d'autres de vivre des expériences similaires à travers nos produits de qualité.</p>
</section>

<section id="mission" class="container">
    <h2>Notre Mission</h2>
    <p>Notre mission est de vous offrir la meilleure expérience d'achat possible en vous proposant une sélection soigneusement choisie de vêtements de football, de chaussures, d'accessoires et d'équipements connexes. Nous nous engageons à fournir un service client exceptionnel et à répondre à vos besoins de manière professionnelle et efficace. Chez Boutique de Vêtements de Football, nous croyons fermement que chaque joueur mérite d'avoir accès aux meilleurs produits pour améliorer son jeu et exprimer son style sur le terrain.</p>
</section>

<section id="equipe" class="container">
    <h2>Notre Équipe</h2>
    <p>Nous sommes une équipe passionnée et engagée, composée de joueurs de football, d'entraîneurs et d'experts en e-commerce. Nous mettons notre expertise et notre passion au service de notre entreprise pour vous offrir une expérience de shopping unique et satisfaisante. Chaque membre de notre équipe apporte ses compétences uniques et sa passion pour le football, ce qui nous permet de créer un environnement dynamique et stimulant où nous nous efforçons constamment d'innover et de vous offrir les meilleurs produits et services.</p>
</section>

<footer class="bg-dark text-white text-center py-4">
    <p>&copy; 2024 Boutique de Vêtements de Football. Tous droits réservés.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function scrollToSection(sectionId) {
        $('html, body').animate({
            scrollTop: $('#' + sectionId).offset().top
        }, 800);
    }
</script>
</body>
</html>
