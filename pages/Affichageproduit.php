<?php
$produitDB = new ProduitDB($cnx);
$listeProduits = $produitDB->getAllProducts();
$nbrProduits = count($listeProduits);
?>

<div class="album py-5 bg-body-tertiary">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <?php
            // Parcourir la liste des produits de la deuxième catégorie et les afficher
            foreach ($listeProduits as $produit) {
                ?>
                <div class="col">
                    <div class="card shadow-sm">

                        <img src="<?php echo $produit->image; ?>" class="bd-placeholder-img card-img-top" width="100%" height="225" alt="<?php echo $produit->nom_prod; ?>">
                        <div class="card-body">

                            <h5 class="card-title"><?php echo $produit->nom_prod; ?></h5>
                            <p class="card-text">Description du produit...</p>
                            <div class="d-flex justify-content-between align-items-center">

                                <div class="btn-group">

                                    <a href="pages/detail_produit.php?id=<?php echo $produit->id; ?>&nom=<?php echo urlencode($produit->nom_prod); ?>&marque=<?php echo urlencode($produit->marque); ?>&taille=<?php echo urlencode($produit->taille); ?>&image=<?php echo urlencode($produit->image); ?>" class="btn btn-sm btn-outline-secondary">View</a>
                                </div>

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