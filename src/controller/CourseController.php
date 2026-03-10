<?php
require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/sanitizers.php';

class CoursesController
{
    private $pdo;
    private const PER_PAGE = 20;

    public function __construct()
    {
        $this->pdo = Database::getInstance()->getConnection();
    }

    public function index()
    {
        $search = isset($_GET['search']) ? trim((string)$_GET['search']) : '';
        $page = max(1, (int)($_GET['page'] ?? 1));
        $offset = ($page - 1) * self::PER_PAGE;

        $sql = "
            SELECT 
                c.course_id AS id,
                c.title,
                c.description,
                c.price,
                i.name AS instructor_name,
                c.level,
                c.theme,
                c.duration
            FROM courses c
            INNER JOIN instructors i 
            ON c.instructor_id = i.instructor_id
            ";

        $params = [];

        if($search && $search !== ''){
            $sql .= " WHERE (c.title LIKE :search OR c.description LIKE :search)";
            $params['search'] = "%$search%";
        }

        $sql .= " ORDER BY c.created_at DESC LIMIT " . self::PER_PAGE . " OFFSET " . (int)$offset;
        
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        $courses = $stmt->fetchAll(PDO::FETCH_ASSOC);

        successResponse([
        'courses' => $courses,
        'page' => $page,
        'per_page' => self::PER_PAGE,
        'count' => count($courses)
        ], 'Courses retrived.');
    }

    public function show($id)
    {
        $id = (int)$id;
        if($id <= 0){
            errorResponse('Invalid course ID.', 400);
        }

        $stmt = $this->pdo->prepare("
            SELECT 
                c.course_id,
                c.title,
                c.description,
                c.instructor_id,
                c.level,
                c.price,
                c.created_at,
                c.theme,
                c.duration,
                i.name AS instructor_name,
                i.title AS instructor_title,
                i.students_count,
                i.courses_count,
                i.instructor_rating,
                i.bio AS instructor_bio
            FROM courses c
            INNER JOIN instructors i 
            ON c.instructor_id = i.instructor_id
            WHERE c.course_id = :id
        ");
        $stmt->execute(['id' => $id]);
        $course = $stmt->fetch(PDO::FETCH_ASSOC);

        if(!$course){
            errorResponse('Course not found', 404);
        }

        successResponse($course, 'Course Details Retrieved.');
    }
}
?>