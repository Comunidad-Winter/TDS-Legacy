<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
$conn = connect();

check_logged_out();

if (!isset($_POST['entrar'])){
    $_SESSION['ERRORS']['err'] = 'ERROR!';
    header("Location: /cuenta-premium.php");
    exit();
}
else {
    unset($_POST['entrar']);
    foreach($_POST as $key => $value){
        $_POST[$key] = _cleaninjections(trim($value));
    }


    $username = $_POST['usuario'];
    $password = $_POST['contrasena'];

    if (empty($username) || empty($password)) {
        $_SESSION['ERRORS']['err'] = 'Rellena los casilleros';
        header("Location: /cuenta-premium.php");
        exit();
    } 
    else {
 
        $sql = "SELECT * FROM cuentas WHERE username=?;";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) {

            $_SESSION['ERRORS']['err'] = 'SQL ERROR';
            header("Location: /cuenta-premium.php");
            exit();
        } 
        else {

            mysqli_stmt_bind_param($stmt, "s", $username);
            mysqli_stmt_execute($stmt);

            $result = mysqli_stmt_get_result($stmt);

            if ($row = mysqli_fetch_assoc($result)) {

                $pwdCheck = (strcmp($password,$row['password'])==0);//password_verify($password, $row['password']);

                if ($pwdCheck == false) {
                    
                    $_SESSION['ERRORS']['err'] = 'Datos incorrectos';
                    header("Location: /cuenta-premium.php");
                    exit();
                } 
                else if ($pwdCheck == true) {

                    session_start();

                        // update lastlogin only if password match huhehe
                        $sql = "UPDATE cuentas SET last_login_at=NOW() WHERE username=?;";
                        $stmt = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($stmt, $sql)) {

                            $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                            header("Location: /cuenta-premium.php");
                            exit();
                        }
                        else {

                            mysqli_stmt_bind_param($stmt, "s", $username);
                            mysqli_stmt_execute($stmt);
                        }
                    
                    session_unset();
                    
                    $_SESSION['verified'] = $row['verified'];
                    $_SESSION['password'] = $row['password'];
                    $_SESSION['pin'] = $row['pin'];
                    $_SESSION['id'] = $row['id'];
                    $_SESSION['username'] = $row['username'];
                    $_SESSION['account'] = $row['username'];
                    $_SESSION['email'] = $row['email'];
                    $_SESSION['first_name'] = $row['first_name'];
                    $_SESSION['last_name'] = $row['last_name'];
                    $_SESSION['user_level'] = $row['user_level'];
                    $_SESSION['banned'] = intval($row['banned']);
                    $_SESSION['ban_reason'] = $row['ban_reason'];
                    
                    $_SESSION['created_at'] = $row['created_at'];
                    $_SESSION['updated_at'] = $row['updated_at'];
                    $_SESSION['last_login_at'] = $row['last_login_at'];
                    $_SESSION['oro'] = intval($row['oro']);
                    $_SESSION['gm'] = intval($row['GM']) ;
                    $_SESSION['tdspesos'] = intval($row['tdspesos']) ;
                    $_SESSION['premium_at'] = $row['premium_at'] ;

                    if (isset($_POST['recordar'])){

                        if ($_POST['recordar'] ==1) {
                            $selector = bin2hex(random_bytes(8));
                            $token = random_bytes(32);

                            $sql = "DELETE FROM auth_tokens WHERE user_email=? AND auth_type='remember_me';";
                            $stmt = mysqli_stmt_init($conn);
                            if (!mysqli_stmt_prepare($stmt, $sql)) {

                                $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                                header("Location: /cuenta-premium.php");
                                exit();
                            }
                            else {

                                mysqli_stmt_bind_param($stmt, "s", $_SESSION['email']);
                                mysqli_stmt_execute($stmt);
                            }

                            setcookie(
                                'rememberme',
                                $selector.':'.bin2hex($token),
                                time() + 464000,
                                '/',
                                NULL,
                                false, // TLS-only
                                true  // http-only
                            );

                            $sql = "INSERT INTO auth_tokens (user_email, auth_type, selector, token, expires_at) 
                                    VALUES (?, 'remember_me', ?, ?, ?);";
                            $stmt = mysqli_stmt_init($conn);
                            if (!mysqli_stmt_prepare($stmt, $sql)) {

                                $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                                header("Location: /cuenta-premium.php");
                                exit();
                            }
                            else {
                                
                                $hashedToken = password_hash($token, PASSWORD_DEFAULT);
                                mysqli_stmt_bind_param($stmt, "ssss", $_SESSION['email'], $selector, $hashedToken, date('Y-m-d\TH:i:s', time() + 464000));
                                mysqli_stmt_execute($stmt);
                            }
                        }
                        
                    }

                    header("Location: /cpremium.php");
                    exit();
                } 
            } 
            else {

                $_SESSION['ERRORS']['err'] = 'Datos incorrectos';
                header("Location: /cuenta-premium.php");
                exit();
            }
        }
    }
}