<?php
// Vérifier si l'identifiant de la catégorie est passé en tant que paramètre GET
if (isset($_GET['id_cat']) && is_numeric($_GET['id_cat'])) {
    $id_cat = $_GET['id_cat'];

    // Inclure la classe ProduitDB
    require_once './admin/src/php/classes/ProduitDB.class.php';

    // Créer une instance de la classe ProduitDB
    $produitDB = new ProduitDB($cnx);

    // Récupérer tous les produits de la catégorie spécifiée
    $produits = $produitDB->getProduitsByCategorie($id_cat);
} else {
    // Rediriger l'utilisateur vers une autre page s'il manque l'identifiant de la catégorie
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>produits par Catégorie</title>
</head>
<body>
<div class="container">
    <h1>Produits de la Catégorie</h1>
    <div class="list-group">
        <?php foreach ($produits as $produit) : ?>
            <div class="list-group-item">
                <h3><?php echo $produit['nom_prod']; ?></h3>
                <p>Description: <?php echo $produit['marque']; ?></p>
                <p>Prix: <?php echo $produit['prix']; ?></p>

            </div>
        <?php endforeach; ?>
    </div>
</div>
</body>
</html>
