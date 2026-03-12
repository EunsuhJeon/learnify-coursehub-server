<?php
function logError($message, $context = [])
{
    $logDir = __DIR__ . '/../storage/logs';
    if (!is_dir($logDir)) {
        mkdir($logDir, 0755, true);
    }
    $file = $logDir . '/app.log';
    $timestamp = date('Y-m-d H:i:s');
    $contextStr = !empty($context) ? ' ' . json_encode($context) : '';
    $line = "[$timestamp] $message$contextStr" . PHP_EOL;
    file_put_contents($file, $line, FILE_APPEND | LOCK_EX);
}