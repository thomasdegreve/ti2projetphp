<?php
// Vérifier si un ID de produit a été passé en paramètre GET
if (isset($_GET['id']) && isset($_GET['nom']) && isset($_GET['marque']) && isset($_GET['taille']) && isset($_GET['image'])) {
    // Récupérer les informations du produit depuis les paramètres GET
    $idProduit = $_GET['id'];
    $nomProduit = $_GET['nom'];
    $marqueProduit = $_GET['marque'];
    $tailleProduit = $_GET['taille'];
    $imageProduit = $_GET['image'];
    ?>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Détails du Produit</title>
        <!-- Liens vers les fichiers CSS de Bootstrap -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
    <div class="container">
        <h1 class="my-4">Détails du Produit</h1>
        <div class="row">
            <div class="col-md-4">
                <img src="<?php echo $imageProduit; ?>" class="img-fluid rounded" alt="Image du produit">
            </div>
            <div class="col-md-8">
                <h3><?php echo $nomProduit; ?></h3>
                <p>Marque : <?php echo $marqueProduit; ?></p>
                <p>Taille : <?php echo $tailleProduit; ?></p>
                <!-- Vous pouvez ajouter d'autres détails du produit ici -->
                <a href="#" class="btn btn-primary">Acheter</a>
            </div>
        </div>
    </div>
    <!-- Liens vers les fichiers JavaScript de Bootstrap (si nécessaire) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
    </html>

    <?php
} else {
    // Si certaines informations du produit sont manquantes dans les paramètres GET, affichez un message d'erreur
    echo "<p>Les informations du produit sont incomplètes.</p>";
}
?>
