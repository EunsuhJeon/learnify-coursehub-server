<?php
require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/auth.php';
require_once __DIR__ . '/../helpers/sanitizers.php';

    class CartController {
        private $pdo;

        public function __construct() {
            $this->pdo = Database::getInstance()->getConnection();
        }

        public function index() {
            requireAuth();
            $userId = currentUserId();

            $stmt = $this->pdo->prepare("
                SELECT ci.cart_id, c.course_id, c.title, c.price
                FROM cart_items ci
                JOIN courses c ON ci.course_id = c.course_id
                WHERE ci.user_id = :user_id
            ");
            $stmt->execute(['user_id' => $userId]);
            successResponse($stmt->fetchAll(PDO::FETCH_ASSOC), 'Cart retrieved.');
        }

        public function store() {
            requireAuth();
            $userId = currentUserId();
            $input = getJsonInput();
            $courseId = (int)($input['courseId'] ?? 0);

            if ($courseId <= 0) errorResponse('Invalid course ID.', 400);

            $stmt = $this->pdo->prepare("
                INSERT INTO cart_items (user_id, course_id) VALUES (:user_id, :course_id)
            ");
            try {
                $stmt->execute(['user_id' => $userId, 'course_id' => $courseId]);
                successResponse([], 'Added to cart.', 201);
            } catch (PDOException $e) {
                errorResponse('Item already in cart.', 409);
            }
        }

        public function destroy($cartId) {
            requireAuth();
            $userId = currentUserId();
            $cartId = (int)$cartId;

            $stmt = $this->pdo->prepare("
                DELETE FROM cart_items WHERE cart_id = :cart_id AND user_id = :user_id
            ");
            $stmt->execute(['cart_id' => $cartId, 'user_id' => $userId]);
            successResponse([], 'Removed from cart.');
        }
    }
?>