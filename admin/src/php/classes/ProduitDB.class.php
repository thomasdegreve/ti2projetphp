<?php

require_once ('admin/src/php/classes/Produit.class.php');

class ProduitDB extends Produit
{
    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getAllProduits()
    {
        $query = "select * from produit";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            //var_dump($data);
            foreach ($data as $d) {
                $_array[] = new Produit($d);
            }
            return $_array;
            $this->_bd->commit();
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    /* public function getProduitsByCategorie($id_cat)
    {
        try {
            $query = "SELECT * FROM vue_produits WHERE id_cat = :id_cat";
            $stmt = $this->_cnx->prepare($query);
            $stmt->bindParam(':id_cat', $id_cat, PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            // Gérer les erreurs de requête SQL
            return array();
        }
    }*/
}

?>
