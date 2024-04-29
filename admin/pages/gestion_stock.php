<h2>Gestion des produits</h2>
<a href="index_.php?page=ajouter_produit.php">Nouveau produit</a><br>

<?php
// Récupération des produits et affichage dans une table bootstrap
$produits = new ProduitDB($cnx);
$liste_produits = $produits->getAllProducts();
$nbr_produits = count($liste_produits);

if ($nbr_produits == 0) {
    print "<br>Aucun produit encodé<br>";
} else {
    ?>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Nom</th>
            <th scope="col">Prix</th>
            <th scope="col">Stock</th>
            <th scope="col">Supprimer</th>
        </tr>
        </thead>
        <tbody>
        <?php
        for ($i = 0; $i < $nbr_produits; $i++) {
            ?>
            <tr>
                <th><?= $liste_produits[$i]->id_produit; ?></th>
                <td contenteditable="true" id="<?= $liste_produits[$i]->id_produit; ?>" name="nom_produit"><?= $liste_produits[$i]->nom_prod; ?></td>
                <td contenteditable="true" id="<?= $liste_produits[$i]->id_produit; ?>" name="prix"><?= $liste_produits[$i]->prix; ?></td>
                <td contenteditable="true" id="<?= $liste_produits[$i]->id_produit; ?>" name="stock"><?= $liste_produits[$i]->stock; ?></td>
                <td contenteditable="true"><img src="public/images/delete.jpg" alt="Effacer" id="delete"></td>
            </tr>
            <?php
        }
        ?>
        </tbody>
    </table>
    <?php
}
?>
