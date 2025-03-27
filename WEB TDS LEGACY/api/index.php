
<?php
    
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $uri = explode( '/', $uri );
   
     var_dump ($uri);

    if ($uri[1] !== 'request') {
        header("HTTP/1.1 404 Not Found");
        exit();
    }
    $requestType = null;
    if (isset($uri[2])) {
        $requestType = $uri[2];
    }
     
echo 'aa';
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $dbConnection = connect();

    $requestMethod = $_SERVER["REQUEST_METHOD"];

    if ($requestMethod == "GET") {
        switch ($requestType) {
            case 'ranking':
                echo("Success");
                break;
            
            default:
                echo("Bad gathering");
                break;
        }
        
    }else {
        echo 'nada';
    }
    