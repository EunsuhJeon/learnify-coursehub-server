<?php

require_once __DIR__ . '/response.php';

function ensureSessionStarted()
{
    if (session_status() !== PHP_SESSION_ACTIVE) {
        session_start();
    }
}

function isLoggedIn()
{
    ensureSessionStarted();
    return isset($_SESSION['user_id']);
}

function currentUserId()
{
    ensureSessionStarted();
    return $_SESSION['user_id'] ?? null;
}

function currentUserRole()
{
    ensureSessionStarted();
    return $_SESSION['role'] ?? null;
}

function isAdmin()
{
    return currentUserRole() === 'admin';
}

function requireAuth()
{
    ensureSessionStarted();

    if (!isset($_SESSION['user_id'])) {
        errorResponse('Unauthorized. Please log in first.', 401);
    }
}

function requireAdmin()
{
    requireAuth();

    if (($_SESSION['role'] ?? '') !== 'admin') {
        errorResponse('Forbidden. Admin access only.', 403);
    }
}