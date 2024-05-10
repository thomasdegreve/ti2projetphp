<?php

class ClientDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function ajout_client($nom,$prénom,$emailcl,$adresse,$téléphone,$password){
        try{
            $query="select ajout_client(:nom,:prénom,:emailcl,:adresse,:téléphone,:password)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':nom',$nom);
            $res->bindValue(':prénom',$prénom);
            $res->bindValue(':emailcl',$emailcl);
            $res->bindValue(':adresse',$adresse);
            $res->bindValue(':téléphone',$téléphone);
            $res->bindValue(':password',$password);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }


    public function getClientByEmail($email){
        try{
            $query="select * from client where emailcl = :email";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':email',$email);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function getAllClients(){
        try{
            $query="select * from client order by nom";
            $res = $this->_bd->prepare($query);
            $res->execute();
            $data = $res->fetchAll();
            if(!empty($data))  {
                foreach($data as $d) {
                    $_array[] = new Client($d);
                }
                return $_array;
            }
            else{
                return null;
            }

            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }
    public function updateClient($id,$champ,$valeur){
        $query="select updateClient(:id,:champ,:valeur)";
        //$query= "update client set $champ='$valeur' where id_client=$id";
        try{
            $this->_bd->beginTransaction();
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id',$id);
            $res->bindValue(':champ',$champ);
            $res->bindValue(':valeur',$valeur);
            $res->execute();
            $this->_bd->commit();
        }catch(PDOException $e){
            $this->_bd->rollback();
            print "Echec ".$e->getMessage();
        }
    }

}

