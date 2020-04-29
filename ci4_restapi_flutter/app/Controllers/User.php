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
            
        
        }	
        return $this->respond($user, 200);
    }

    public function create()
    {
        $fullname   = $this->request->getPost('fullname');
        $grade      = $this->request->getPost('grade');
        $gender     = $this->request->getPost('gender');
        $phone      = $this->request->getPost('phone');
        
        $data = [
            'fullname' => $fullname,
            'grade' => $grade,
            'gender' => $gender,
            'phone' => $phone
        ];
        
        $simpan = $this->model->createUser($data);
        
        if($simpan){
            $msg = ['message' => 'Created user successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        }
    }

    public function getUserBy($id)
    {
        $data = $this->user->getUser($id);

        $user = [
            'id' => intval($data['id']),
            'fullname' => $data['fullname'],
            'gender' => $data['gender'],
            'grade' => $data['grade'],
            'phone' => $data['phone'] 
        ];
            
        return $this->respond($user, 200);
        
    }

    public function update($id = NULL)
    {
        $fullname   = $this->request->getPost('fullname');
        $grade      = $this->request->getPost('grade');
        $gender     = $this->request->getPost('gender');
        $phone      = $this->request->getPost('phone');
        
        $data = [
            'fullname' => $fullname,
            'grade' => $grade,
            'gender' => $gender,
            'phone' => $phone
        ];
        
        $simpan = $this->model->updateUser($data, $id);
        
        if($simpan){
            $msg = ['message' => 'Updated user successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        }
    }

    public function delete($id = NULL)
    {
        // cek id
        $cekid = $this->model->getUser($id);
        
        if(!empty($cekid)){
            // delete data
            $this->model->deleteUser($id);
            $msg = ['message' => 'Deleted user successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        } else {
            $msg = ['message' => 'Deleted user failed'];
            $response = [
                'status' => 500,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 500);
        }
    }
}