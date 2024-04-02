<?php
// Vérification et traitement de la soumission du formulaire de connexion
if (isset($_POST['submit_login'])) {
    // Extraction des données du formulaire
    extract($_POST);

    // Vérification de l'existence de l'administrateur dans la base de données
    $ad = new AdminDB($cnx);
    $admin = $ad->getAdmin($login, $password); // $admin reçoit 1 ou 0

    if ($admin) {
        // Si l'administrateur existe, créer une variable de session pour l'administrateur
        $_SESSION['admin'] = 1; // Sera vérifiée dans toutes les pages admin

        // Redirection vers le dossier admin
        header("Location: admin/index_.php?page=accueil_admin.php");
        exit; // Arrêter l'exécution du script après la redirection
    } else {
        // Si l'administrateur n'existe pas, afficher un message d'erreur et rediriger vers l'accueil public
        echo "<br>Accès réservé aux administrateurs";
        header("refresh:3; url=index_.php?page=accueil.php");
        exit; // Arrêter l'exécution du script après la redirection
    }
}
?>

<!-- Formulaire de connexion -->
<form method="post" action="<?= $_SERVER['PHP_SELF']; ?>">
    <div class="mb-3">
        <label for="login" class="form-label">Email address</label>
        <input type="text" name="login" class="form-control" id="login" aria-describedby="loginHelp">
    </div>
    <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" name="password" class="form-control" id="password">
    </div>
    <button type="submit" name="submit_login" class="btn btn-primary">Connexion</button>
</form>
