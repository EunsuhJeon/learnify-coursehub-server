<?php
function cleanString($value)
{
    if (!is_string($value)) {
        return '';
    }

    return htmlspecialchars(trim($value), ENT_QUOTES, 'UTF-8');
}

function validateEmailAddress($email)
{
    $email = trim((string)$email);
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

function cleanInt($value)
{
    $filtered = filter_var($value, FILTER_VALIDATE_INT);
    return $filtered === false ? null : $filtered;
}

function getJsonInput()
{
    $rawBody = file_get_contents('php://input');
    $decoded = json_decode($rawBody, true);

    return is_array($decoded) ? $decoded : [];
}