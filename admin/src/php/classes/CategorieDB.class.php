<?php

class CategorieDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }




    public function getALLCategorie(){
        try{
            $query="select * from catégorie";
            $res = $this->_bd->prepare($query);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }


}


