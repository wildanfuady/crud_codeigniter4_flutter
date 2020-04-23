<?php

namespace App\Models;

use CodeIgniter\Model;

class User_model extends Model {

    protected $table = 'users';

    public function getUser($id = false)
    {
        if($id === false){
            return $this->db->table($this->table)->get()->getResult();
        } else {
            return $this->getWhere(['id' => $id])->getRowArray();
        }  
    }
} 