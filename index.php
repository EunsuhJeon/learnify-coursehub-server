<?php
require_once __DIR__ . '/../src/config/webconfig.php';
require_once __DIR__ . '/../src/helpers/response.php';
require_once __DIR__ . '/../src/controllers/AuthController.php';

session_start();

$request = $_SERVER['REQUEST_URI'];
$basePath = '/projects/learnify-coursehub-server/public';

if (strpos($request, $basePath) === 0) {
    $request = substr($request, strlen($basePath)) ?: '/';
}

$requestPath = parse_url($request, PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];

if ($requestPath === '/register' && $method === 'POST') {
    $authController = new AuthController();
    $authController->register();
} elseif ($requestPath === '/login' && $method === 'POST') {
    $authController = new AuthController();
    $authController->login();
} elseif ($requestPath === '/' && $method === 'GET') {
    successResponse([
        'project' => 'Learnify API'
    ], 'API is running.');
} else {
    errorResponse('Route not found: ' . $requestPath, 404);
}