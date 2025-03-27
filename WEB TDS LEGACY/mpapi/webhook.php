<?php

    $xSignature = $_SERVER['HTTP_X_SIGNATURE'];
    $xRequestId = $_SERVER['HTTP_X_REQUEST_ID'];
    $queryParams = $_GET;

    $dataID = isset($queryParams['data.id']) ? $queryParams['data.id'] : '';
    $parts = explode(',', $xSignature);

    $ts = null;
    $hash = null;

    foreach ($parts as $part) {
        $keyValue = explode('=', $part, 2);
        if (count($keyValue) == 2) {
            $key = trim($keyValue[0]);
            $value = trim($keyValue[1]);
            if ($key === "ts") {
                $ts = $value;
            } elseif ($key === "v1") {
                $hash = $value;
            }
        }
    }

    $secret = "c2e19f536e89e4db7900fe719240b83db07ba612ebc63a86e9cc183e0f230b24";

    $manifest = "id:$dataID;request-id:$xRequestId;ts:$ts;";

    $sha = hash_hmac('sha256', $manifest, $secret);
    if ($sha !== $hash) {
        echo "HMAC verification failed";
        die();
    }

    


