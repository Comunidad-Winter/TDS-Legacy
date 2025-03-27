<?php                   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    require_logged();

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['nick'])) {

        $nick=trim($_POST['nick']);

        $nick = $conn->real_escape_string($nick); 
        $sql = "SELECT id FROM user WHERE nick = ?";

        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo json_encode(array("error" => "Error preparing statement #1."));
            return;
        }else{
            mysqli_stmt_bind_param($stmt, "s",$nick);
            mysqli_stmt_execute($stmt); 
        }
        
        $result = mysqli_stmt_get_result($stmt);
                            
        if(mysqli_num_rows($result) == 0){
            echo json_encode(array("error" => "User not found."));
            return;
        }
    
        $rowUser = mysqli_fetch_assoc($result);

        if (strlen($nick )>30 || strlen($nick)<3) { 
            echo json_encode(array("error" => "Invalid username length."));
            return;
        }

        $sql = "SELECT DISTINCT i.number, i.amount, o.name, i.item_id
        FROM bank_item i 
        INNER JOIN objectdata o ON i.item_id = o.number 
        WHERE i.user_id = ?";

        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo json_encode(array("error" => "Error preparing statement #2."));
            return;
        }else{
            mysqli_stmt_bind_param($stmt, "i",$rowUser['id']);
            mysqli_stmt_execute($stmt); 
        }

        $result = mysqli_stmt_get_result($stmt);
                        
        if(mysqli_num_rows($result) == 0){
            echo json_encode(array("error" => "No tienes items"));
            return;
        }
    
        $items = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $items[] = $row;            
        }

        echo json_encode($items);

    }else {
        echo json_encode(array("error" => "Invalid request method or missing parameters."));
    }