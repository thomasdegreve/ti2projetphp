<?php
class ProduitDB
{
    private $_bd;

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getAllProducts()
    {
        $query = "SELECT * FROM produit";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            $this->_bd->commit();

            $liste_produits = array();
            foreach ($data as $d) {
                $liste_produits[] = new Produit($d);
            }
            return $liste_produits;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
            return array(); // Retourne un tableau vide en cas d'échec
        }
    }
}
?>
