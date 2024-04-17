<h2>cc</h2>
<?php
// Inclusion du fichier de la classe ProduitDB



require('../admin/src/php/classes/ProduitDB.class.php');








// Création d'une instance de la classe ProduitDB
$produitDB = new ProduitDB($cnx);

// Récupération de tous les produits à partir de la vue_produits
$produits = $produitDB->getAllProduits();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Produits</title>
    <!-- Ajout des liens vers Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Liste des Produits</h2>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>#</th>
            <th>Nom du Produit</th>
            <th>Description</th>
            <th>Prix</th>
            <th>Catégorie</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach ($produits as $produit) : ?>
            <tr>
                <td><?php echo $produit->getIdProduit(); ?></td>
                <td><?php echo $produit->getNomProduit(); ?></td>
                <td><?php echo $produit->getDescriptionProduit(); ?></td>
                <td><?php echo $produit->getPrixProduit(); ?></td>
                <td><?php echo $produit->getNomCategorie(); ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<!-- Ajout du script Bootstrap JS pour les fonctionnalités avancées -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
