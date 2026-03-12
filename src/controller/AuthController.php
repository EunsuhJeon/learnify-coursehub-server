<?php
require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/sanitizers.php';
require_once __DIR__ . '/../helpers/auth.php';
require_once __DIR__ . '/../helpers/audit.php';

class AuthController
{
    private $pdo;

    public function __construct()
    {
        $this->pdo = Database::getInstance()->getConnection();
    }

    public function register()
    {
        $input = getJsonInput();

        $firstName = cleanString($input['first_name'] ?? '');
        $lastName = cleanString($input['last_name'] ?? '');
        $email = validateEmailAddress($input['email'] ?? '');
        $password = $input['password'] ?? '';

        if ($firstName === '' || $lastName === '' || !$email || $password === '') {
            errorResponse('Validation failed. Missing or invalid fields.', 422);
        }

        if (strlen($password) < 8) {
            errorResponse('Password must be at least 8 characters long.', 422);
        }

        if (strlen($password) > 72) {
            errorResponse('Password must be less than 72 characters long.', 422);
        }

        $checkStmt = $this->pdo->prepare("SELECT user_id FROM users WHERE email = :email LIMIT 1");
        $checkStmt->execute(['email' => $email]);
        $existingUser = $checkStmt->fetch(PDO::FETCH_ASSOC);

        if ($existingUser) {
            errorResponse('Email already exists.', 409);
        }

        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        $insertStmt = $this->pdo->prepare("
            INSERT INTO users (first_name, last_name, email, password_hash, role)
            VALUES (:first_name, :last_name, :email, :password_hash, :role)
        ");

        $insertStmt->execute([
            'first_name' => $firstName,
            'last_name' => $lastName,
            'email' => $email,
            'password_hash' => $hashedPassword,
            'role' => 'student'
        ]);

        ensureSessionStarted();
        // to prevent session hijacking
        session_regenerate_id(true);
        $newUserId = (int) $this->pdo->lastInsertId();

        $_SESSION['user_id'] = $newUserId;
        $_SESSION['role'] = 'student';

        logAudit('CREATE', 'users', $newUserId);

        successResponse([
            'token' => session_id(),
            'user' => [
                'user_id' => $newUserId,
                'first_name' => $firstName,
                'last_name' => $lastName,
                'email' => $email,
                'role' => 'student'
            ]
        ], 'User registered successfully.', 201);

    }

    public function login()
    {
        $input = getJsonInput();

        $email = validateEmailAddress($input['email'] ?? '');
        $password = $input['password'] ?? '';

        if (!$email || $password === '') {
            errorResponse('Invalid email or password.', 422);
        }

        $stmt = $this->pdo->prepare("
            SELECT user_id, first_name, last_name, email, password_hash, role
            FROM users
            WHERE email = :email
            LIMIT 1
        ");

        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user || !password_verify($password, $user['password_hash'])) {
            errorResponse('Invalid email or password.', 401);
        }

        ensureSessionStarted();
        $_SESSION['user_id'] = (int) $user['user_id'];
        $_SESSION['role'] = $user['role'];

        successResponse([
            'token' => session_id(),
            'user' => [
                'user_id' => (int) $user['user_id'],
                'first_name' => $user['first_name'],
                'last_name' => $user['last_name'],
                'email' => $user['email'],
                'role' => $user['role']
            ]
        ], 'Login successful.');
    }

    // Method to logout correctly
    // "/logout"
    public function logout()
    {
        ensureSessionStarted();

        $_SESSION = [];

        // Delete session cookies in the browser (or Postman)
        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();

            setcookie(
                session_name(),
                '',
                time() - 42000,
                $params['path'],
                $params['domain'],
                $params['secure'],
                $params['httponly']
            );
        }

        session_destroy();

        successResponse([], 'Logout successful.');
    }

    // To reassure who is authenticated
    // "/me"
    public function me()
    {
        // Helper to check if the session already exists
        requireAuth();

        // Get data for that user
        $userId = (int) currentUserId();
        $stmt = $this->pdo->prepare("
            SELECT user_id, first_name, last_name, email, role
            FROM users
            WHERE user_id = :user_id
            LIMIT 1
        ");

        $stmt->execute(['user_id' => $userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            errorResponse('User not found.', 404);
        }

        successResponse([
            'user' => $user
        ], 'Authenticated user retrieved successfully.');
    }
}
