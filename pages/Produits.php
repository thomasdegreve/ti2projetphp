<?php
// Inclure la classe CategorieDB
require_once './admin/src/php/classes/CategorieDB.class.php';

// Créer une instance de la classe CategorieDB
$categorieDB = new CategorieDB($cnx);

// Récupérer toutes les catégories
$categories = $categorieDB->getAllCategorie();



?>

<div class="container">
    <h1>Liste des catégories</h1>
    <div class="list-group">
        <?php foreach ($categories as $categorie) : ?>
            <?php if (is_array($categorie)) : ?>
                <a href="prod_par_cat.php?id_cat=<?php echo $categorie['id_cat']; ?>" class="list-group-item list-group-item-action">
                    <?php echo $categorie['nom_cat']; ?>
                </a>
            <?php endif; ?>
        <?php endforeach; ?>
    </div>
</div>

