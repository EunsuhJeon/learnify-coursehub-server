<?php
require_once __DIR__ . '/../config/Database.php';
require_once __DIR__ . '/../helpers/response.php';
require_once __DIR__ . '/../helpers/sanitizers.php';
require_once __DIR__ . '/../helpers/auth.php';

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
        $newUserId = (int)$this->pdo->lastInsertId();

        $_SESSION['user_id'] = $newUserId;
        $_SESSION['role'] = 'student';

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
        $_SESSION['user_id'] = (int)$user['user_id'];
        $_SESSION['role'] = $user['role'];

        successResponse([
            'token' => session_id(),
            'user' => [
                'user_id' => (int)$user['user_id'],
                'first_name' => $user['first_name'],
                'last_name' => $user['last_name'],
                'email' => $user['email'],
                'role' => $user['role']
            ]
        ], 'Login successful.');
    }
}