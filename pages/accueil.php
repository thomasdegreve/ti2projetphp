<?php
// Supposons que vous ayez une fonction dans votre classe `CategorieDB` pour récupérer tous les produits de la vue `cat_prod`
$cat = new CategorieDB($cnx);
$liste_produits = $cat->getAllProductsFromView();

// Assurez-vous que $liste_produits contient les données des produits à partir de la vue `cat_prod`
// Vous devrez ajuster cela selon la structure et le fonctionnement de votre classe CategorieDB

// Boucle pour afficher chaque produit
foreach ($liste_produits as $produit) {
    ?>
    <div class="col">
        <div class="card shadow-sm">
            <!-- Ici vous pouvez afficher l'image du produit, son nom, sa description, etc. -->
            <img src="<?php echo $produit->image_url; ?>" class="bd-placeholder-img card-img-top" width="100%" height="225" alt="Product Image">
            <div class="card-body">
                <h5 class="card-title"><?php echo $produit->nom_produit; ?></h5>
                <p class="card-text"><?php echo $produit->description; ?></p>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="btn-group">
                        <!-- Lien vers la page de détails du produit -->
                        <a href="produit_details.php?id_produit=<?php echo $produit->id_produit; ?>" class="btn btn-sm btn-outline-secondary">View</a>
                        <!-- Bouton pour éditer le produit -->
                        <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php
}
?>
