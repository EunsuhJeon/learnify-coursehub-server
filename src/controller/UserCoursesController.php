<?php
    
    require_once __DIR__ . '/../config/Database.php';
    require_once __DIR__ . '/../helpers/response.php';
    require_once __DIR__ . '/../helpers/auth.php';


    class UserCoursesController {
        private $pdo;

        public function __construct() {
            $this->pdo = Database::getInstance()->getConnection();
        }

        public function index() {
            requireAuth();
            $userId = currentUserId();

            $stmt = $this->pdo->prepare("
                SELECT c.course_id AS id, c.title, c.price, e.progress, e.enrolled_at
                FROM enrollments e
                JOIN courses c ON e.course_id = c.course_id
                WHERE e.user_id = :user_id
            ");
            $stmt->execute(['user_id' => $userId]);
            $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

            successResponse($courses, 'Enrolled courses retrieved.');
        }

        public function store() {
            requireAuth();
            $userId = currentUserId();

            $input = getJsonInput();
            $courseId = (int)($input['courseId'] ?? 0);

            if ($courseId <= 0) {
                errorResponse('Invalid course ID.', 400);
            }

            $check = $this->pdo->prepare("
                SELECT enrollment_id FROM enrollments
                WHERE user_id = :user_id AND course_id = :course_id
            ");
            $check->execute(['user_id' => $userId, 'course_id' => $courseId]);

            if ($check->fetch()) {
                errorResponse('Already enrolled in this course.', 409);
            }

            $stmt = $this->pdo->prepare("
                INSERT INTO enrollments (user_id, course_id, enrolled_at)
                VALUES (:user_id, :course_id, NOW())
            ");
            $stmt->execute(['user_id' => $userId, 'course_id' => $courseId]);

            successResponse(['message' => 'Enrolled successfully.'], 'Enrolled successfully.', 201);
        }
    }

?>