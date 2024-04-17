<?php
// Vérifier si le formulaire a été soumis

if (isset($_POST['submit_register'])) {

    extract($_POST, EXTR_OVERWRITE);

    // Création d'une instance de la classe ClientDB pour gérer les clients
    $clientDB = new ClientDB($cnx);

    // Vérification de l'existence du client
    if (!empty($emailRegister)) {
        if(!empty($emailRegister)) {
            $client = $clientDB->getClientByEmail($emailRegister);
            if ($client != null) {
                print "<br>Client trouvé";
                var_dump($client);
            } //client pas trouvé en BD
            else {
                if (!empty($nom) && !empty($prenom) && !empty($telephone) && !empty($passwordRegister)) {
                    $clientDB->addClient($_POST);
                    // récupérer les données du nouveau client
                    $client = $clientDB->getClientByEmail($emailRegister);
                    print "<br>client absent --> enregistré";
                    var_dump($client);
                }
            }
            //client reconnu ou insertion réussie
            if ($client != null) {
                $_SESSION['client']['id'] = $client->id;
                $_SESSION['client']['nom'] = $client->nom;
                $_SESSION['client']['prénom'] = $client->prénom;
                $_SESSION['client']['emailcl'] = $client->emailcl;
                $_SESSION['client']['téléphone'] = $client->téléphone;
                print "<br>Session créée<pre>";
                //var_dump($_SESSION);
                print "</pre>";
                print "<br>Bienvenue ".$_SESSION['client']['prénom']." ".$_SESSION['client']['nom'];
                ?>
                <meta http-equiv="refresh" content="0;url=index_.php?page=accueilC.php">
                <?php
            }
            else {
                //signaler problème
            }
        }
    }

}


?>

<!-- Formulaire d'inscription -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<form action="Inscription.php" method="post">
    <div class="mb-3">
        <label for="nom" class="form-label">Nom</label>
        <input type="text" class="form-control" id="nom" name="nom" required>
    </div>
    <div class="mb-3">
        <label for="prenom" class="form-label">Prénom</label>
        <input type="text" class="form-control" id="prenom" name="prenom" required>
    </div>
    <div class="mb-3">
        <label for="telephone" class="form-label">Téléphone</label>
        <input type="text" class="form-control" id="telephone" name="telephone" required>
    </div>
    <div class="mb-3">
        <label for="emailRegister" class="form-label">Email</label>
        <input type="email" class="form-control" id="emailRegister" name="emailRegister" required>
    </div>
    <div class="mb-3">
        <label for="passwordRegister" class="form-label">Mot de passe</label>
        <input type="password" class="form-control" id="passwordRegister" name="passwordRegister" required>
    </div>
    <button type="submit" class="btn btn-primary" name="submit_register">Créer un compte</button>
</form>

<!-- Bouton pour afficher le formulaire de connexion -->
<div>
    <a href="connexion.php" class="btn btn-secondary">Se connecter</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>