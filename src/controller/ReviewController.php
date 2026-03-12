<?php
require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/sanitizers.php';
require_once __DIR__ . '/../helpers/auth.php';
require_once __DIR__ . '/../helpers/audit.php';
require_once __DIR__ . '/../helpers/logger.php';

class ReviewController
{
    private $pdo;

    public function __construct()
    {
        $this->pdo = Database::getInstance()->getConnection();
    }

    public function index($courseId)
    {
        $courseId = (int) $courseId;
        if ($courseId <= 0) {
            errorResponse('Invalid course ID', 400);
        }

        try {
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
        } catch (Throwable $e) {
            logError('Review list failed', [
                'course_id' => $courseId,
                'error' => $e->getMessage()
            ]);

            errorResponse('Failed to retrieve reviews. Please try again.', 500);
        }
    }

    public function store($courseId)
    {
        requireAuth();
        $courseId = (int) $courseId;
        if ($courseId <= 0) {
            errorResponse('Invalid course ID', 400);
        }

        $input = getJsonInput();
        $ratingRaw = $input['rating'] ?? null;
        $commentRaw = $input['comment'] ?? '';
        $rating = filter_var($ratingRaw, FILTER_VALIDATE_INT);
        if ($rating === false || $rating < 1 || $rating > 5) {
            errorResponse('Rating must be between 1 and 5', 422);
        }

        $comment = '';
        if ($commentRaw != null && $commentRaw !== '') {
            $comment = cleanString((string) $commentRaw);
        }

        if (strlen($comment) > 2000) {
            errorResponse('Comment is too long (max 2000 characters)', 422);
        }

        $userId = (int) currentUserId();
        if ($userId <= 0) {
            errorResponse('Unauthorized', 401);
        }

        try {
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

            $reviewId = (int) $this->pdo->lastInsertId();

            logAudit('CREATE', 'reviews', $reviewId);

            successResponse([
                'review' => [
                    'review_id' => $reviewId,
                    'course_id' => $courseId,
                    'user_id' => $userId,
                    'rating' => $rating,
                    'comment' => $comment
                ]
            ], 'Review Created.', 201);
        } catch (Throwable $e) {
            logError('Review creation failed', [
                'course_id' => $courseId,
                'user_id' => $userId,
                'error' => $e->getMessage()
            ]);

            errorResponse('Failed to create review. Please try again.', 500);
        }
    }

    public function destroy($courseId, $reviewId)
    {
        requireAdmin(); // admin only

        $reviewId = (int) $reviewId;
        if ($reviewId <= 0) {
            errorResponse('Invalid review ID.', 400);
        }

        try {
            $stmt = $this->pdo->prepare("
                DELETE FROM reviews
                WHERE review_id = :review_id AND course_id = :course_id
            ");
            $stmt->execute(['review_id' => $reviewId, 'course_id' => (int) $courseId]);

            if ($stmt->rowCount() === 0) {
                errorResponse('Review not found.', 404);
            }

            logAudit('DELETE', 'reviews', $reviewId);
            successResponse([], 'Review deleted.');
        } catch (Throwable $e) {
            logError('Review deletion failed', [
                'course_id' => $courseId,
                'review_id' => $reviewId,
                'user_id' => currentUserId(),
                'error' => $e->getMessage()
            ]);

            errorResponse('Failed to delete review. Please try again.', 500);
        }
    }
    public function update($courseId, $reviewId)
    {
        requireAuth();

        $reviewId = (int) $reviewId;
        $courseId = (int) $courseId;
        $userId = (int) currentUserId();

        $stmt = $this->pdo->prepare("
            SELECT review_id FROM reviews
            WHERE review_id = :rid AND course_id = :cid AND user_id = :uid
        ");
        $stmt->execute(['rid' => $reviewId, 'cid' => $courseId, 'uid' => $userId]);
        $review = $stmt->fetch();

        if (!$review) {
            errorResponse('Review not found or you are not the owner.', 404);
        }

        $input = getJsonInput();
        $rating = filter_var($input['rating'] ?? null, FILTER_VALIDATE_INT);
        $commentRaw = $input['comment'] ?? '';
        $comment = ($commentRaw !== '' && $commentRaw !== null) ? cleanString((string) $commentRaw) : '';

        if ($rating === false || $rating < 1 || $rating > 5) {
            errorResponse('Rating must be between 1 and 5.', 422);
        }

        try {
            $updateStmt = $this->pdo->prepare("
                UPDATE reviews SET rating = :rating, comment = :comment
                WHERE review_id = :review_id
            ");
            $updateStmt->execute([
                'rating' => $rating,
                'comment' => $comment,
                'review_id' => $reviewId
            ]);

            logAudit('UPDATE', 'reviews', $reviewId);
            successResponse(['review_id' => $reviewId], 'Review updated.');
        } catch (Throwable $e) {
            logError('Review update failed', [
                'course_id' => $courseId,
                'review_id' => $reviewId,
                'user_id' => $userId,
                'error' => $e->getMessage()
            ]);

            errorResponse('Failed to update review. Please try again.', 500);
        }
    }
}
?>