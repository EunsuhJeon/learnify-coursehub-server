<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);

require_once __DIR__ . '/src/helpers/response.php';
require_once __DIR__ . '/src/controller/AuthController.php';
require_once __DIR__ . '/src/controller/CourseController.php';
require_once __DIR__ . '/src/controller/ReviewController.php';
require_once __DIR__ . '/src/controller/CartController.php';
require_once __DIR__ . '/src/controller/UserCoursesController.php';

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
} elseif ($requestPath === '/logout' && $method === 'POST') {
    $authController = new AuthController();
    $authController->logout();
} elseif ($requestPath === '/me' && $method === 'GET') {
    $authController = new AuthController();
    $authController->me();
} elseif ($requestPath === '/cart' && $method === 'GET') {
    $cartController = new CartController();
    $cartController->index();
} elseif ($requestPath === '/cart' && $method === 'POST') {
    $cartController = new CartController();
    $cartController->store();
} elseif (preg_match('#^/cart/(\d+)$#', $requestPath, $matches) && $method === 'DELETE') {
    $cartController = new CartController();
    $cartController->destroy($matches[1]);
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
} elseif ($requestPath === '/me/courses' && $method === 'GET') {
    $controller = new UserCoursesController();
    $controller->index();
} elseif ($requestPath === '/enrollments' && $method === 'POST') {
    $controller = new UserCoursesController();
    $controller->store();
} elseif (preg_match('#^/courses/(\d+)/reviews$#', $requestPath, $m) && $method === 'GET') {
    $controller = new ReviewController();
    $controller->index($m[1]);
} elseif (preg_match('#^/courses/(\d+)/reviews$#', $requestPath, $m) && $method === 'POST') {
    $controller = new ReviewController();
    $controller->store($m[1]);
} elseif (preg_match('#^/courses/(\d+)/reviews/(\d+)$#', $requestPath, $m) && $method === 'DELETE') {
    $controller = new ReviewController();
    $controller->destroy($m[1], $m[2]);
} elseif (preg_match('#^/courses/(\d+)/reviews/(\d+)$#', $requestPath, $m) && $method === 'PATCH') {
    $controller = new ReviewController();
    $controller->update($m[1], $m[2]);
} else {
    errorResponse('Route not found: ' . $requestPath, 404);
}