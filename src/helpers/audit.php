<?php
require_once __DIR__ . '/../config/Database.php';

function logAudit($action, $entity, $entityId = null)
{
    $userId = isset($_SESSION['user_id']) ? (int)$_SESSION['user_id'] : null;
    $pdo = Database::getInstance()->getConnection();
    $stmt = $pdo->prepare("
        INSERT INTO audit_logs (user_id, action, entity, entity_id)
        VALUES (:user_id, :action, :entity, :entity_id)
    ");
    $stmt->execute([
        'user_id' => $userId,
        'action' => $action,
        'entity' => $entity,
        'entity_id' => $entityId
    ]);
}