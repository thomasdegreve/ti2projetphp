<?php
class CommandeDB
{
    private $_bd;

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }



    public function getAllCommandes()
    {
        try {
            $query = "SELECT * FROM commande";
            $stmt = $this->_bd->prepare($query);
            $stmt->execute();
            $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $liste_commandes = array();
            foreach ($data as $d) {
                $liste_commandes[] = new Commande($d);
            }
            return $liste_commandes;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
            return array();
        }
    }
    public function getClientNameById($id_client) {
        $query = "SELECT nom FROM client WHERE id = :id_client";
        $stmt = $this->_bd->prepare($query);
        $stmt->bindParam(':id_client', $id_client, PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result['nom'];
    }

    public function getProductNameById($id_produit) {
        $query = "SELECT nom_prod FROM produit WHERE id = :id_produit";
        $stmt = $this->_bd->prepare($query);
        $stmt->bindParam(':id_produit', $id_produit, PDO::PARAM_INT);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result['nom_prod'];
    }

}
?>
