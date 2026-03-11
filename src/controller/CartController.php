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

    // Query to get the items in the cart and total price
    public function index(){
        requireAuth();

        $userId = (int) currentUserId();

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

}