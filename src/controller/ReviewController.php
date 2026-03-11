<?php
require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/sanitizers.php';
require_once __DIR__ . '/../helpers/auth.php';

class ReviewController
{
    private $pdo;

    public function __construct()
    {
        $this->pdo = Database::getInstance()->getConnection();
    }

    public function index($courseId)
    {
        $courseId = (int)$courseId;
        if($courseId <= 0){
            errorResponse('Invalid course ID', 400);
        }

        $stmt = $this->pdo->prepare("
            SELECT
                r.review_id,
                r.course_id,
                r.user_id,
                r.rating,
                r.comment,
                r.created_at,
                u.first_name,
                u.last_name,
                u.email
            FROM reviews r
            INNER JOIN users u ON r.user_id = u.user_id
            WHERE r.course_id = :course_id
            ORDER BY r.created_at DESC
            LIMIT 50
        ");

        $stmt->execute(['course_id' => $courseId]);
        $reviews = $stmt->fetchAll(PDO::FETCH_ASSOC);

        successResponse([
            'course_id' => $courseId,
            'reviews' => $reviews,
            'count' => count($reviews)
        ], 'Reviews retrieved.');
    }

    public function store($courseId)
    {
        requireAuth();
        $courseId = (int)$courseId;
        if($courseId <= 0){
            errorResponse('Invalid course ID', 400);
        }

        $input = getJsonInput();
        $ratingRaw = $input['rating'] ?? null;
        $commentRaw = $input['comment'] ?? '';
        $rating = filter_var($ratingRaw, FILTER_VALIDATE_INT);
        if($rating === false || $rating < 1 || $rating > 5){
            errorResponse('Rating must be between 1 and 5', 422);
        }

        $comment = '';
        if($commentRaw!=null && $commentRaw!==''){
            $comment = cleanString((string)$commentRaw);
        }

        if(strlen($comment) > 2000){
            errorResponse('Comment is too long (max 2000 characters)', 422);
        }

        $userId = (int)currentUserId();
        if($userId <= 0) {
            errorResponse('Unauthorized', 401);
        }

        $stmt = $this->pdo->prepare("
            INSERT INTO reviews (course_id, user_id, rating, comment)
            VALUES (:course_id, :user_id, :rating, :comment)
        ");

        $stmt->execute([
            'course_id' => $courseId,
            'user_id' => $userId,
            'rating' => $rating,
            'comment' => $comment
        ]);

        $reviewId = (int)$this->pdo->lastInsertId();

        successResponse([
            'review' => [
                'review_id' => $reviewId,
                'course_id' => $courseId,
                'user_id' => $userId,
                'rating' => $rating,
                'comment' => $comment
            ]
        ], 'Review Created.', 201);
    }
}
?>