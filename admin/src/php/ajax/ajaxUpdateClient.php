<?php
header('Content-Type: application/json');
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Client.class.php';
require '../classes/ClientDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$eq = new ClientDB($cnx);
try {
    $data[] = $eq->updateClient($_GET['id'],$_GET['name'],$_GET['valeur']);
    print json_encode(['success' => true]);
} catch (Exception $e) {
    print json_encode(['error' => $e->getMessage()]);
}