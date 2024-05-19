<?php

if (isset($_GET['id']) && isset($_GET['nom']) && isset($_GET['marque']) && isset($_GET['taille']) && isset($_GET['image'])) {

    $idProduit = $_GET['id'];
    $nomProduit = $_GET['nom'];
    $marqueProduit = $_GET['marque'];
    $tailleProduit = $_GET['taille'];
    $imageProduit = $_GET['image'];





    ?>




        <!-- Liens vers les fichiers CSS de Bootstrap -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

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
                <form method="post">
                    <button type="submit" name="ajouter" class="btn btn-primary">Ajouter</button>
                </form>
            </div>
        </div>
    </div>


    <?php
} else {
    // Si certaines informations du produit sont manquantes dans les paramètres GET, affichez un message d'erreur
    echo "<p>Les informations du produit sont incomplètes.</p>";
}
?>
