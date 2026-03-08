<?php
session_start();

$request = $_SERVER['REQUEST_URI'];
$basePath = '/projects/learnify-coursehub-server';
if (strpos($request, $basePath) === 0) {
    $request = substr($request, strlen($basePath)) ?: '/';
}
$method = $_SERVER['REQUEST_METHOD'];

require __DIR__.'/src/controller/AuthController.php';

if($request === '/register' && $method === 'POST'){
    $authController = new AuthController();
    $authController->register();
}
elseif($request === '/login' && $method === 'POST'){
    $authController = new AuthController();
    $authController->login();
}
elseif($method === 'GET' && $request === '/'){
    echo "Hello world";
}
else{
    echo json_encode(['error' => 'Route not found for request: '.$request]);
}

?>