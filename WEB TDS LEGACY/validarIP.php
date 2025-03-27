<?php

function log_ip($ip, $file) {
    if (filter_var($ip, FILTER_VALIDATE_IP) !== false && $_SERVER['HTTP_USER_AGENT'] === 'tgT3qX') {
        $absoluteFilePath = $_SERVER['DOCUMENT_ROOT']. "/api_connect/" .$file;

        if (!file_exists($absoluteFilePath)) {
            if (!touch($absoluteFilePath)) {
                die("No se pudo crear el archivo.");
            } else {
                file_put_contents($absoluteFilePath, $ip);
            }
        } else {
            $existingContent = file_get_contents($absoluteFilePath);
            $ips = explode(',', $existingContent);
            $ips = array_map('trim', $ips);
            $ips = array_unique($ips);

            if (!in_array($ip, $ips)) {
                $ips[] = $ip;
                $newContent = implode(', ', $ips);
                file_put_contents($absoluteFilePath, $newContent);
            }
        }
    }
}

$file = 'ip.txt';

# Obtengo IP
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ip = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
    $ip = $_SERVER['REMOTE_ADDR'];
}

if (!empty($ip)) {
    log_ip($ip, $file);
}
?>