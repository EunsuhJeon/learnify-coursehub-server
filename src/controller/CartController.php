<?php

require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/sanitizers.php';
require_once __DIR__ . '/../helpers/auth.php';

class CartController
{
    private $pdo;

    public function __construct()
    {
        $this->pdo = Database::getInstance()->getConnection();
    }

    public function index(){
        requireAuth();
        
        $userId = (int) currentUserId();
        
        // Query to get the items in the cart
        $itemsStmt = $this->pdo->prepare("
            SELECT 
                ci.cart_id,
                ci.course_id,
                c.title,
                c.price,
                c.level
            FROM cart_items ci
            INNER JOIN courses c ON ci.course_id = c.course_id
            WHERE ci.user_id = :user_id
            ORDER BY ci.cart_id DESC
        ");

        $itemsStmt->execute(['user_id' => $userId]);
        $items = $itemsStmt->fetchAll(PDO::FETCH_ASSOC);

        // Query to get the total price
        $summaryStmt = $this->pdo->prepare("
            SELECT 
                COUNT(*) AS item_count,
                COALESCE(SUM(c.price), 0) AS total_price
            FROM cart_items ci
            INNER JOIN courses c ON ci.course_id = c.course_id
            WHERE ci.user_id = :user_id
        ");

        $summaryStmt->execute(['user_id' => $userId]);
        $summary = $summaryStmt->fetch(PDO::FETCH_ASSOC);

        successResponse([
            'items' => $items,
            'summary' => $summary
        ], 'Cart retrieved successfully.');
    }

    public function store()
    {
        requireAuth();

        $userId = (int) currentUserId();
        $input = getJsonInput();

        $courseId = cleanInt($input['course_id'] ?? null);

        if ($courseId === null) {
            errorResponse('Valid course_id is required.', 422);
        }

        // Query to check that the course exists
        $courseStmt = $this->pdo->prepare("
            SELECT course_id, title
            FROM courses
            WHERE course_id = :course_id
            LIMIT 1
        ");

        $courseStmt->execute(['course_id' => $courseId]);
        $course = $courseStmt->fetch(PDO::FETCH_ASSOC);

        // If it does not exist, then send an error message
        if (!$course) {
            errorResponse('Course not found.', 404);
        }

        // Query to check that the course is not duplicated
        $existingStmt = $this->pdo->prepare("
            SELECT cart_id
            FROM cart_items
            WHERE user_id = :user_id AND course_id = :course_id
            LIMIT 1
        ");

        $existingStmt->execute([
            'user_id' => $userId,
            'course_id' => $courseId
        ]);

        $existingItem = $existingStmt->fetch(PDO::FETCH_ASSOC);

        // If it is duplicated, then send an error message
        if ($existingItem) {
            errorResponse('This course is already in the cart.', 409);
        }

        // Prepared Statement to add items in the cart
        $insertStmt = $this->pdo->prepare("
            INSERT INTO cart_items (user_id, course_id)
            VALUES (:user_id, :course_id)
        ");

        $insertStmt->execute([
            'user_id' => $userId,
            'course_id' => $courseId
        ]);

        successResponse([
            'cart_id' => (int) $this->pdo->lastInsertId(),
            'course_id' => $courseId
        ], 'Course added to cart successfully.', 201);
    }
}