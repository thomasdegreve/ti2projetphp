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
    public function getProduitsById($id)
    {
        $query = "select * from produit";
        $query.= " where id = :id";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':id',$id);
            $resultset->execute();
            $data = $resultset->fetchAll();
            //var_dump($data);
            foreach ($data as $d) {
                $this->_array[] = new Produit($d);
            }
            $this->_bd->commit(); // Moved commit before return
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }
    public function ajout_produit($nom_prod, $marque, $taille, $prix, $stock, $categorie_id, $image) {
        try {
            $query = "SELECT ajout_produit(:nom_prod, :marque, :taille, :prix, :stock, :categorie_id, :image)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':nom_prod', $nom_prod);
            $res->bindValue(':marque', $marque);
            $res->bindValue(':taille', $taille);
            $res->bindValue(':prix', $prix);
            $res->bindValue(':stock', $stock);
            $res->bindValue(':categorie_id', $categorie_id);
            $res->bindValue(':image', $image);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch(PDOException $e) {
            print "Echec ".$e->getMessage();
        }
    }

}
?>
