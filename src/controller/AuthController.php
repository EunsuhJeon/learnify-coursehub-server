<?php
class AuthController{
    public function register(){
        echo json_encode(['message' => 'Registering a new user']);

    }
    public function login(){
        echo json_encode(['message' => 'Logging in a user']);
    }
}
?>