<?php
header('Content-Type: application/json');


require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Client.class.php';
require '../classes/ClientDB.class.php';

$cnx = Connexion::getInstance($dsn, $user, $password);


$cl = new ClientDB($cnx);


$result = $cl->deleteClient($_GET['id']);


if ($result) {

    echo json_encode(array('success' => true));
} else {

    echo json_encode(array('success' => false, 'error' => 'La suppression du client a échoué.'));
}
?>
