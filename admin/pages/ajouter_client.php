<?php
// Inclure le fichier contenant la classe ClientDB
require 'admin/src/php/classes/ClientDB.class.php';

// Vérifier si le formulaire a été soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupérer les données du formulaire
    $nom = $_POST['nom'];
    $prenom = $_POST['prenom'];
    $email = $_POST['email'];
    $adresse = $_POST['adresse'];
    $telephone = $_POST['telephone'];



    try {

        $cnx->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        echo "Erreur de connexion : " . $e->getMessage();
    }

    // Instanciation de la classe ClientDB
    $clientDB = new ClientDB($cnx);

    // Appel de la méthode ajout_client pour ajouter un nouveau client
    $resultat = $clientDB->ajout_client($nom, $prenom, $email, $adresse, $telephone);

    if ($resultat) {
        echo "Le client a été ajouté avec succès.";
    } else {
        echo "Une erreur s'est produite lors de l'ajout du client.";
    }
}
?>
