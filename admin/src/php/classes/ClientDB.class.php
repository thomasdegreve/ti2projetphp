<?php

class ClientDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function ajout_client($nom,$prenom,$adresse,$emailcl,$telephone,$password){
        try{
            $query="select ajout_client(:nom,:prenom,:adresse,:emailcl,:telephone,:password)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':nom',$nom);
            $res->bindValue(':prenom',$prenom);
            $res->bindValue(':emailcl',$emailcl);
            $res->bindValue(':adresse',$adresse);
            $res->bindValue(':telephone',$telephone);
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


    public function deleteClient($id)
    {
        $query = "select deleteclient(:id)";
        try {
            $res = $this->_database->prepare($query);
            $res->bindValue(':id', $id, PDO::PARAM_INT);
            $res->execute();
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }
    public function updateClient($id, $champ, $valeur)
    {
        $query = "select update_Client(:id,:champ,:valeur)";
        try {
            $res = $this->_database->prepare($query);
            $res->bindValue(':id', $id);
            $res->bindValue(':champ', $champ);
            $res->bindValue(':valeur', $valeur);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }



}

