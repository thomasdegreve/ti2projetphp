<?php
header('Content-Type: application/json');
// Chemin d'accès depuis le fichier ajax php
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Produit.class.php'; // Assurez-vous d'avoir la classe Produit et ProduitDB définies
require '../classes/ProduitDB.class.php';
$cnx = Connexion::getInstance($dsn, $user, $password);

$produitDB = new ProduitDB($cnx);
$data[] = $produitDB->ajout_produit($_GET['nom_prod'], $_GET['marque'], $_GET['taille'], $_GET['prix'], $_GET['stock'], $_GET['categorie_id'], $_GET['image']);
print json_encode($data);
?>
