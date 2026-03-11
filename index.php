<?php
require_once __DIR__ . '/src/helpers/response.php';
require_once __DIR__ . '/src/controller/AuthController.php';
require_once __DIR__ . '/src/controller/CourseController.php';
require_once __DIR__ . '/src/controller/ReviewController.php';

session_start();

$request = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

$basePath = '/projects/learnify-coursehub-server';

if (strpos($request, $basePath) === 0) {
    $request = substr($request, strlen($basePath)) ?: '/';
}

$requestPath = parse_url($request, PHP_URL_PATH);

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
} elseif ($requestPath === '/courses' && $method === 'GET') {
    $controller = new CoursesController();
    $controller->index();
} elseif (preg_match('#^/courses/(\d+)$#', $requestPath, $m) && $method === 'GET') {
    $controller = new CoursesController();
    $controller->show($m[1]);
} elseif (preg_match('#^/courses/(\d+)/reviews$#', $requestPath, $m) && $method === 'GET') {
    $controller = new ReviewController();
    $controller->index($m[1]);
} elseif (preg_match('#^/courses/(\d+)/reviews$#', $requestPath, $m) && $method === 'POST') {
    $controller = new ReviewController();
    $controller->store($m[1]);
}
else {
    errorResponse('Route not found: ' . $requestPath, 404);
}