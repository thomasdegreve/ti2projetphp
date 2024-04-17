<?php
require ('Client.class.php');
class ClientDB extends Client
{
    private $_bd;

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getClientByEmailAndPassword($email, $password)
    {
        $query = "SELECT * FROM client WHERE emailcl = :email AND password = :password";
        try {
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':email', $email);
            $resultset->bindValue(':password', $password);
            $resultset->execute();
            $clientData = $resultset->fetch(PDO::FETCH_ASSOC);
            if ($clientData) {
                return new Client($clientData);
            } else {
                return null;
            }
        } catch (PDOException $e) {
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function addClient($client)
    { print "<br>dans addClient : ";
        var_dump($client);
        // Génération du code client aléatoire
        $code = uniqid();
//utiliser une fonction plpgsql
        $query = "INSERT INTO client (id, nom,prénom, adresse,emailcl,téléphone, password) VALUES (:id, :nom, :prenom, :email, :telephone, :password)";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':code', $code);
            $resultset->bindValue(':nom', $client['nom']);
            $resultset->bindValue(':prenom', $client['prenom']);
            $resultset->bindValue(':telephone', $client['telephone']);
            $resultset->bindValue(':email', $client['emailRegister']);
            $resultset->bindValue(':password', $client['passwordRegister']);
            $resultset->execute();
            $this->_bd->commit();
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de l'inscription du client : " . $e->getMessage();
        }

    }
    public function getClientByEmail($email)
    {
        $query = "SELECT * FROM client WHERE emailcl = :email";
        try {
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':email', $email);
            $resultset->execute();
            $clientData = $resultset->fetch(PDO::FETCH_ASSOC);
            if ($clientData) {
                return new Client($clientData);
            } else {
                return null;
            }
        } catch (PDOException $e) {
            print "Echec de la requête " . $e->getMessage();
        }
    }
}

