<h2>Gestion des clients</h2>
<a href="index_.php?page=ajouter_client.php">Nouveau client</a><br>

<?php
//récupération des clients et affichage dans table bootstrap
$clients = new ClientDB($cnx);
$liste = $clients->getAllClients();
$nbr = count($liste);

if($nbr == 0){
    print "<br>Aucun client encodé<br>";
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
        foreach($liste as $client){
            ?>
            <tr>
                <th><?= $client->id_c;?></th>
                <td contenteditable="true" id="nom<?= $client->id_c;?>" name="nom_client"><?= $client->nom;?></td>
                <td contenteditable="true" id="prenom<?= $client->id_c;?>" name="prenom_client"><?= $client->prenom;?></td>
                <td contenteditable="true" id="email<?= $client->id_c;?>" name="email"><?= $client->emailcl;?></td>
                <td contenteditable="true" id="adresse<?= $client->id_c;?>" name="adresse"><?= $client->adresse;?></td>
                <td contenteditable="true" id="telephone<?= $client->id_c;?>" name="telephone"><?= $client->telephone;?></td>
                <td data-id="<?= $client->id_c;?>" class="delete-client"><button class="btn btn-danger">Supprimer</button></td>

            </tr>
            <?php
        }
        ?>
        </tbody>
    </table>
    <?php
}




