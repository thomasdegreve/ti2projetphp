<?php
// Inclure les fichiers nécessaires

require_once 'ProductDB.php'; // Classe pour interagir avec la table des produits

// Instancier la classe ProductDB avec la connexion à la base de données
$productDB = new ProduittDB($pdo); // Assurez-vous d'avoir une instance de PDO nommée $pdo

// Récupérer tous les produits depuis la base de données
$products = $productDB->getAllProducts();

// Afficher les produits
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tous les produits</title>
    <style>
        /* Ajoutez votre CSS personnalisé ici */
        .product {
            margin-bottom: 20px;
        }
        .product img {
            max-width: 200px;
            height: auto;
        }
    </style>
</head>
<body>
<h1>Tous les produits</h1>
<div class="products-container">
    <?php foreach ($products as $product): ?>
        <div class="product">
            <h2><?php echo $product['nom_produit']; ?></h2>
            <p>Prix : <?php echo $product['prix']; ?></p>
            <img src="<?php echo $product['chemin_image']; ?>" alt="<?php echo $product['nom_produit']; ?>">
        </div>
    <?php endforeach; ?>
</div>
</body>
</html>
