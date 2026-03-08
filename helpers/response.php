<?php 
function jsonResponse($data = [], $status = 200)
{
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');

    echo json_encode($data);
    exit;
}

function successResponse($data = [], $message = 'Operation completed.', $status = 200)
{
    jsonResponse([
        'success' => true,
        'data' => $data,
        'message' => $message
    ], $status);
}

function errorResponse($message = 'Something went wrong.', $status = 400, $extra = [])
{
    $response = [
        'success' => false,
        'error' => $message
    ];

    if (!empty($extra)) {
        $response['details'] = $extra;
    }

    jsonResponse($response, $status);
}
?>