<?php

if(isset($_GET['id'])) {

    $idProduit = $_GET['id'];

    // Obtenez les détails du produit à partir de la base de données en fonction de son ID
    // Vous devez remplacer ces lignes avec votre propre logique pour obtenir les détails du produit depuis la base de données
    $detailsProduit = obtenirDetailsProduitDepuisBD($idProduit); // Fonction fictive pour obtenir les détails du produit

    // Vérifiez si les détails du produit ont été trouvés
    if($detailsProduit) {
        // Affichez les détails du produit
        echo "<h1>Détails du Produit</h1>";
        echo "<p>Nom du produit : " . $detailsProduit->nom_prod . "</p>";
        echo "<p>Marque : " . $detailsProduit->marque . "</p>";
        echo "<p>Taille : " . $detailsProduit->taille . "</p>";
        echo "<p>Prix : " . $detailsProduit->prix . " €</p>";
        // Vous pouvez afficher d'autres détails du produit ici
    } else {
        // Si aucun produit n'est trouvé avec l'ID donné, affichez un message d'erreur
        echo "<p>Le produit demandé n'existe pas.</p>";
    }
} else {
    // Si aucun ID de produit n'est passé en paramètre GET, affichez un message d'erreur
    echo "<p>Aucun produit sélectionné.</p>";
}

// Fonction fictive pour obtenir les détails du produit depuis la base de données
function obtenirDetailsProduitDepuisBD($idProduit) {

    $detailsProduit = new stdClass();
    $detailsProduit->nom_prod = "Nom du produit";
    $detailsProduit->marque = "Marque du produit";
    $detailsProduit->taille = "Taille du produit";
    $detailsProduit->prix = "Prix du produit";
    // Vous pouvez ajouter d'autres détails du produit ici

    return $detailsProduit;
}
?>
