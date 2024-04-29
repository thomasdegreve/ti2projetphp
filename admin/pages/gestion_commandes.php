<?php
// Récupération des commandes et affichage dans une table bootstrap
$commandes = new CommandeDB($cnx);
$liste_commandes = $commandes->getAllCommandes();
$nbr_commandes = count($liste_commandes);

if ($nbr_commandes == 0) {
    print "<br>Aucune commande enregistrée<br>";
} else {
    ?>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Date</th>
            <th scope="col">Statut</th>
            <th scope="col">Client</th>
            <th scope="col">Produit</th>
            <th scope="col">Supprimer</th>
        </tr>
        </thead>
        <tbody>
        <?php
        foreach ($liste_commandes as $commande) {
            ?>
            <tr>
                <td><?= $commande->id_commande; ?></td>
                <td contenteditable="true" id="date_commande_<?= $commande->id_commande; ?>" name="date"><?= $commande->date_commande; ?></td>
                <td contenteditable="true" id="statut_commande_<?= $commande->id_commande; ?>" name="statut"><?= $commande->statut; ?></td>
                <td contenteditable="true"><?= $commandes->getClientNameById($commande->id_client); ?></td>
                <td contenteditable="true"><?= $commandes->getProductNameById($commande->id_produit); ?></td>
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
