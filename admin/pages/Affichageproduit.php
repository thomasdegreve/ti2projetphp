<h2>Produits</h2>


<?php
//récupération des clients et affichage dans table bootstrap
$prod = new ProduitDB($cnx);
$liste = $prod->getAllProducts()();
var_dump($liste);
$nbr = count($liste);

if($nbr == 0){
    print "<br>Aucun produits <br>";
}
else{
    ?>
    <table class="table table-striped">
        <thead>

        <tr>
            <th scope="col">Id</th>
            <th scope="col">Nom</th>
            <th scope="col">Prénom</th>
            <th scope="col">Email</th>
            <th scope="col">Adresse</th>
            <th scope="col">Numéro</th>
            <th scope="col">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for($i=0; $i < $nbr; $i++){
            ?>
            <tr>
                <th><?= $liste[$i]->id;?></th>
                <td contenteditable="true" id="<?= $liste[$i]->id;?>" name="nom_produit"><?= $liste[$i]->nom_prod;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id;?>" name="marque"><?= $liste[$i]->marque;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id;?>" name="taille"><?= $liste[$i]->taille;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id;?>" name="prix"><?= $liste[$i]->prix;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id;?>" name="stock"><?= $liste[$i]->stock;?></td>
                <td contenteditable="true"><img src="public/images/delete.jpg" alt="Effacer" id="delete"></td>
            </tr>
            <?php
        }
        ?>

        </tbody>
    </table>
    <?php
}


//affichage des clients existants
