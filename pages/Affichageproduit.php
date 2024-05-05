<?php
$cat = new ProduitDB($cnx);
$liste = $cat->getAllProducts();
$nbr_cat = count($liste);

?>

<div class="album py-5 bg-body-tertiary">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <?php
            // Parcourir la liste des produits et les afficher
            foreach ($liste as $produit) {
                ?>
                <div class="col">
                    <div class="card shadow-sm">
                        <!-- Image du produit -->
                        <img src="<?php echo $produit->image; ?>" class="bd-placeholder-img card-img-top" width="100%" height="225" alt="<?php echo $produit->nom_prod; ?>">
                        <div class="card-body">
                            <!-- Nom du produit -->
                            <h5 class="card-title"><?php echo $produit->nom_prod; ?></h5>
                            <!-- Description ou détails du produit -->
                            <p class="card-text">Description du produit...</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <!-- Boutons d'action -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-sm btn-outline-secondary">View</button>
                                    <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button>
                                </div>
                                <!-- Prix du produit (vous pouvez ajouter le prix réel du produit ici) -->
                                <small class="text-muted"><?php echo $produit->prix; ?> €</small>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?>
        </div>
    </div>
</div>