<?php namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

use App\Models\User_model;

class User extends ResourceController
{
    protected $format       = 'json';
    protected $modelName    = 'App\Models\User_model';

    public function __construct()
    {
        $this->user = new User_model;
    }

	public function index()
	{
        $data = $this->user->getUser();

        foreach ($data as $row) { 

            $user[] = [
                'id' => intval($row->id),
                'fullname' => $row->fullname,
                'gender' => $row->gender,
                'grade' => $row->grade,
                'phone' => $row->phone 
            ];
            return $this->respond($user, 200);
        
        }	
    }
}