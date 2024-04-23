
<?php

//require ('admin/src/php/classes/ClientDB.class.php');

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
    <button type="submit" class="btn btn-primary" id="texte_bouton_submit" name="submit_register">Créer un compte</button>
</form>

<!-- Bouton pour afficher le formulaire de connexion -->
<div>
    <a href="connexion.php" class="btn btn-secondary">Se connecter</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
