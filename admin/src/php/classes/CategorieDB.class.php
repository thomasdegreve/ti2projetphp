<?php

class CategorieDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getProduitsById_cat($id_cat)
    {
        $query = "SELECT * FROM vueproduitcategorie WHERE catégorie_id = :id_cat";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':id_cat', $id_cat);
            $resultset->execute();
            $data = $resultset->fetchAll();

            $produits = array();

            foreach ($data as $d) {
                $produits[] = new Categorie($d);
            }

            $this->_bd->commit();

            return $produits;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function getAllCategories()
    {
        $query = "select * from catégorie";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            //var_dump($data);
            foreach ($data as $d) {
                $_array[] = new Categorie($d);
            }
            return $_array;
            $this->_bd->commit();
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }
}
