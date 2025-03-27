<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/DB/env.php';

$clasesStrToByte = array(
    "MAGO" => 1,
    "CLERIGO" => 2,
    "GUERRERO" => 3,
    "ASESINO" => 4,
    "LADRON" => 5,
    "DRUIDA" => 6,
    "BARDO" => 7,
    "PALADIN" => 8,
    "CAZADOR" => 9,
    "PESCADOR" => 10,
    "HERRERO" => 11,
    "LEÑADOR" => 12,
    "MINERO" => 13,
    "CARPINTERO" => 14,
    "PIRATA" => 15
);

$clasesByteToStr = array(
    1 => "MAGO",
    2 => "CLERIGO",
    3 => "GUERRERO",
    4 => "ASESINO",
    5 => "LADRON",
    6 => "DRUIDA",
    7 => "BARDO",
    8 => "PALADIN",
    9 => "CAZADOR",
    10 => "PESCADOR",
    11 => "HERRERO",
    12 => "LEÑADOR",
    13 => "MINERO",
    14 => "CARPINTERO",
    15 => "PIRATA"
);

if (!empty($_SERVER['HTTP_CLIENT_IP'])) {$ip = $_SERVER['HTTP_CLIENT_IP'];} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];} else {$ip = $_SERVER['REMOTE_ADDR'];}

function clean_variable($var) { 
    
    if ($var === null) {
        
        return null;
    }
    $pattern = '/[^a-zA-Z0-9_@\/!><#$%^.\+\-&*?;()`:.\}{\]\[ ]/';
    $newvar = preg_replace($pattern, '', $var);
    return $newvar;
};

function clean_array($array) {
    array_walk_recursive($array, function(&$value) {
        $value = clean_variable($value);
    });
    return $array;
}


$_REQUEST = clean_array($_REQUEST);
$_POST = clean_array($_POST);
$_GET = clean_array($_GET);
$_COOKIE = clean_array($_COOKIE);

if (isset($_SESSION)) {
    $_SESSION = clean_array($_SESSION);
}

function my_stream_get_contents ($handle, $timeout_seconds = 0.5)
{
    $ret = "";
    // feof ALSO BLOCKS:
    // while(!feof($handle)){$ret.=stream_get_contents($handle,1);}
    while (true) {
        $starttime = microtime(true);
        $new = stream_get_contents($handle, 1);
        $endtime = microtime(true);
        if (is_string($new) && strlen($new) >= 1) {
            $ret .= $new;
        }
        $time_used = $endtime - $starttime;
        // var_dump('time_used:',$time_used);
        if (($time_used >= $timeout_seconds) || ! is_string($new) ||
                 (is_string($new) && strlen($new) < 1)) {
            break;
        }
    }
    return $ret;
}
function server_on(){
    $C = connect();
    $res = sqlSelect($C, 'SELECT sv_on FROM world');    
    if($res && $res->num_rows === 1) {
        $row = $res->fetch_assoc();
        if ($row['sv_on'] === 1)
            return true;
        else
            return false;        
    }
    return false;
}
function get_tdspesos(){
    $conn = connect();
    $res = sqlSelect($conn, 'SELECT tdspesos FROM cuentas WHERE id=? LIMIT 1', 'i', $_SESSION['id']);
    if($res && $res->num_rows === 1) {
        $accData = $res->fetch_assoc();
        $res->free_result();
        return intval($accData['tdspesos']);
    }
    return 0;
}
function server_getdata($send, &$data){

    $C = connect();
    $sv_on=0;

    $res = sqlSelect($C, 'SELECT sv_on FROM world');    
    if($res && $res->num_rows === 1) {
        $row = $res->fetch_assoc();
        $sv_on = ($row['sv_on'] === 1) ? 1 : 0 ;
        $res->free_result();        
    }
    
    $errno = "";
    $errstr = "";

    if ($sv_on === 0) {
        if (ENV_REQUIRE_SERVER_ON) {
            exit("El servidor no se encuentra disponible.");
        }
    }else {
        $fp = fsockopen(ENV_IP, ENV_PORT, $errno, $errstr, 2);
        if (!$fp) {         
            if (ENV_DEBUG) {
                echo "Error de conexión: $errstr ($errno)";
            }
            if (ENV_REQUIRE_SERVER_ON) {
                #$C->query("UPDATE world SET sv_on=0");   
                exit("El servidor no se encuentra disponible. (Err: $errno)"); //$errstr
            }       
        }
        
        if (!is_resource($fp)) {
            return false;
        }
        
        fwrite($fp, $send);

        $data = fread($fp, 1);

        if ($data === '|') {
            while (($char = fread($fp, 128)) !== false && $char !== '|') {
                $data .= $char;

                if (feof($fp)) {
                    break;
                }
            }
            
            if (strlen($data) >= 2 && $data[0] === '|' && $data[strlen($data) - 1] === '|') {
                $data = substr($data, 0, -1);
            }
        } else {
            while (($char = fread($fp, 1)) !== false) {
                $data .= $char;

                if (feof($fp)) {
                    break;
                }
            }
        }
        //fclose($fp);
        //$C->close();
        return true;
    }
}

function bserver_getdata($send, &$data){

    $C = connect();
    $sv_on=0;

    $res = sqlSelect($C, 'SELECT sv_on FROM world');    
    if($res && $res->num_rows === 1) {
        $row = $res->fetch_assoc();
        $sv_on = ($row['sv_on'] === 1) ? 1 : 0 ;
        $res->free_result();        
    }
    
    $errno = "";
    $errstr = "";

    if ($sv_on === 0) {
        if (ENV_REQUIRE_SERVER_ON) {
            return false;
        }
    }else {
        $fp = fsockopen(ENV_IP, ENV_PORT, $errno, $errstr, 2);
        if (!$fp) {         
            if (ENV_DEBUG) {
                echo "Error de conexión: $errstr ($errno)";
            }
            if (ENV_REQUIRE_SERVER_ON) {
                #$C->query("UPDATE world SET sv_on=0");   
                return false;
            }       
        }
        
        if (!is_resource($fp)) {
            return false;
        }
        
        fwrite($fp, $send);

        $data = fread($fp, 1);

        if ($data === '|') {
            while (($char = fread($fp, 128)) !== false && $char !== '|') {
                $data .= $char;

                if (feof($fp)) {
                    break;
                }
            }
            
            if (strlen($data) >= 2 && $data[0] === '|' && $data[strlen($data) - 1] === '|') {
                $data = substr($data, 0, -1);
            }
        } else {
            while (($char = fread($fp, 1)) !== false) {
                $data .= $char;

                if (feof($fp)) {
                    break;
                }
            }
        }
        //fclose($fp);
        //$C->close();
        return true;
    }
}

function validsession(){
    if (!isset($_SESSION['id'])) { header("Location: cuenta-premium.php");return false;}
    
    return true;

}

function personajeExiste($nick){
 
	$conn = connect();
	$nick = $conn->real_escape_string($nick); 

    $sql = "SELECT * FROM user WHERE nick = ?";

        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            return false;
        }else{
            mysqli_stmt_bind_param($stmt, "s",$nick);
            mysqli_stmt_execute($stmt); 
        }
        
        $result = mysqli_stmt_get_result($stmt);
                            
        if(mysqli_num_rows($result) > 0){
            return true;
        }
        
        return false;
}
		

function require_logged(){
    generate_csrf_token();
	if (isset($_SESSION['verified'])) {
		if ($_SESSION['verified'] == 0)
            redirect_to_panel();#redirect_to_verification();
	}else
		redirect_to_login();
}

function require_loggedandunverified(){
    generate_csrf_token();

	if (isset($_SESSION['verified'])) {
		if ($_SESSION['verified'] == 1)
            redirect_to_panel();#redirect_to_verification();
	}else
		redirect_to_login();
}

function require_banned(){
    generate_csrf_token();
	if (isset($_SESSION['verified'])) {
		if ($_SESSION['verified'] == 0){
			redirect_to_panel();#redirect_to_verification();
			return;
		}
			if (isset($_SESSION['bannede'])) {
				if ($_SESSION['banned'] == 0)
					redirect_to_panel();
			}else
				redirect_to_panel();

	}else
		redirect_to_login();
}

function require_gm(){
    generate_csrf_token();
	if (isset($_SESSION['verified'])) {
		if ($_SESSION['verified'] == 0){
			redirect_to_panel();#redirect_to_verification();
			return;
		}
			if (isset($_SESSION['gm'])) {
				if ($_SESSION['gm'] == 0)
					redirect_to_panel();
			}else
				redirect_to_panel();

	}else
		redirect_to_login();
}

function check_remember_me() {

    // REFACTORIZAR THIS SHIT

    require_once '/assets/setup/db.inc.php';
    
    if (empty($_SESSION['verified']) && !empty($_COOKIE['rememberme'])) {
        
        list($selector, $validator) = explode(':', $_COOKIE['rememberme']);

        $sql = "SELECT * FROM auth_tokens WHERE auth_type='remember_me' AND selector=? AND expires_at >= NOW() LIMIT 1;";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) {

            // SQL ERROR
            return false;
        }
        else {
            
            mysqli_stmt_bind_param($stmt, "s", $selector);
            mysqli_stmt_execute($stmt);
            $results = mysqli_stmt_get_result($stmt);

            if (!($row = mysqli_fetch_assoc($results))) {

                // COOKIE VALIDATION FAILURE
                return false;
            }
            else {

                $tokenBin = hex2bin($validator);
                $tokenCheck = password_verify($tokenBin, $row['token']);

                if ($tokenCheck === false) {

                    // COOKIE VALIDATION FAILURE
                    return false;
                }
                else if ($tokenCheck === true) {

                    $email = $row['user_email'];
                    //force_login($email);
                    
                    return true;
                }
            }
        }
    }
}


function redirect_to_login() {
    header("Location: /cuenta-premium.php");
    exit();
}

function redirect_to_soporte() {
    header("Location: /cuenta-premium.php");
    exit();
}
function redirect_to_panel() {
    header("Location: /cpremium.php");
    exit();
}

function redirect_to_home() {
    header("Location: /index.php");
    exit();
}

function redirect_to_verification() {
    header("Location: /cuentas/validar.php");
    exit();
}

function connect() {
    #global $C;
    #if (isset($C) && $C instanceof mysqli && !$C->connect_error) {
    #    return $C;
    #}

	$C = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
	if($C->connect_error) {
		return false;
	}
    
    mysqli_set_charset($C, "utf8mb4");

	return $C;
}

	function sqlSelect($C, $query, $format = false, ...$vars) {
		$stmt = $C->prepare($query);
		if ($stmt) {
			if ($format) {
				$bindResult = $stmt->bind_param($format, ...$vars);
				if (!$bindResult) {
					die('Error during parameter binding: ' . $stmt->error);
				}
			}
			if ($stmt->execute()) {
				$res = $stmt->get_result();
				$stmt->close();
				return $res;
			} else {
				die('Error during execution: ' . $stmt->error);
			}
		} else {
			die('Error in SQL query preparation: ' . $C->error);
		}
	}

	function sqlInsert($C, $query, $format = false, ...$vars) {
		$stmt = $C->prepare($query);
		if($format) {
			$stmt->bind_param($format, ...$vars);
		}
		if($stmt->execute()) {
			$id = $stmt->insert_id;
			$stmt->close();
			return $id;
		}
		$stmt->close();
		return -1;
	}

	function sqlUpdate($C, $query, $format = false, ...$vars) {
		$stmt = $C->prepare($query);
		if($format) {
			$stmt->bind_param($format, ...$vars);
		}
		if($stmt->execute()) {
			$stmt->close();
			return true;
		}
		$stmt->close();
		return false;
	}

	function createToken() {
		$seed = urlSafeEncode(random_bytes(8));
		$t = time();
		$hash = urlSafeEncode(hash_hmac('sha256', session_id() . $seed . $t, CSRF_TOKEN_SECRET, true));
		return urlSafeEncode($hash . '|' . $seed . '|' . $t);
	}

	function validateToken($token) {
		$parts = explode('|', urlSafeDecode($token));
		if(count($parts) === 3) {
			$hash = hash_hmac('sha256', session_id() . $parts[1] . $parts[2], CSRF_TOKEN_SECRET, true);
			if(hash_equals($hash, urlSafeDecode($parts[0]))) {
				return true;
			}
		}
		return false;
	}

	function urlSafeEncode($m) {
		return rtrim(strtr(base64_encode($m), '+/', '-_'), '=');
	}
	function urlSafeDecode($m) {
		return base64_decode(strtr($m, '-_', '+/'));
	}

    function filter_html($m) {   
        $tags = array("p", "i");
        return preg_replace('#<(' . implode( '|', $tags) . ')(?:[^>]+)?>.*?</\1>#s', '', $m);
    }

	function sendEmail($to, $toName, $subj, $msg, $sendIP = false) {
        
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {$ip = $_SERVER['HTTP_CLIENT_IP'];} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];} else {$ip = $_SERVER['REMOTE_ADDR'];}
		
        if (ENV_MAILS == false)
            return true;
        
        $C = connect();

        #$id=sqlInsert($C,"INSERT INTO email_queue (to_email, to_name, subject, message, sendIP) values (?,?,?,?,?) ","sssss",$to,$toName,$subj,$msg,$sendIP ? 1 : 0);
        
        $id=0;

        $sql = "insert into email_queue(to_email,to_name,subject,message) values (?,?,?,?)";
        $sendIP = ($sendIP) ? 1 : 0 ;

		$msg.='<p>Saludos atte,<br /><a href="'. TDS_URL .'">Staff '.APP_NAME.'</a></p>';        
        if ($sendIP) $msg.='<p><em>Esta solicitud fue generada desde la IP: '.$ip.'</em> </p>';

        $stmt = mysqli_stmt_init($C);
        if (mysqli_stmt_prepare($stmt, $sql)){
            mysqli_stmt_bind_param($stmt, "ssss", $to,$toName,$subj,$msg);
            mysqli_stmt_execute($stmt);
            $id =$C->insert_id;
        }
        if (!$id=0) return true; # no pude insertarlo, intento manualmente?


		require_once $_SERVER['DOCUMENT_ROOT'].'/vendor/autoload.php';
		
        $transport = new Swift_SmtpTransport(SMTP_HOST, SMTP_PORT, 'ssl');
		$transport->setUsername(SMTP_USERNAME);
		$transport->setPassword(SMTP_PASSWORD);
		$mailer = new Swift_Mailer($transport);
		$message = new Swift_Message();
	
		$message->setSubject($subj);

		$msg.='<p>Saludos atte,<br /><a href="'. TDS_URL .'">Staff '.APP_NAME.'</a></p>';
      
        if ($sendIP) $msg.='<p><em>Esta solicitud fue generada desde la IP: '.$ip.'</em> </p>';
       
		$message->setBody($msg,'text/html');
		$message->setFrom(array(SMTP_USERNAME => APP_NAME));
		
		//$message->setTo($to);
		$message->setTo(array($to => $toName));
        
		try {
            #echo 'sending mail:';
			$mailer->send($message);            
			#echo '...';
            return true;
		}
		catch (\Swift_TransportException $e) {
			echo $e->getMessage();
            $_SESSION['ERRORS']['err']=$e->getMessage();            
			return false;
		}

	}
	
function _cleaninjections($test) {

    $find = array(
        "/[\r\n]/", 
        "/%0[A-B]/",
        "/%0[a-b]/",
        "/bcc\:/i",
        "/Content\-Type\:/i",
        "/Mime\-Version\:/i",
        "/cc\:/i",
        "/from\:/i",
        "/to\:/i",
        "/Content\-Transfer\-Encoding\:/i"
    );
    $ret = preg_replace($find, "", $test);
    return $ret;
}

function generate_csrf_token() {
    if (!isset($_SESSION)) session_start();
    if (empty($_SESSION['token'])) $_SESSION['token'] = bin2hex(random_bytes(32));
}

function clear_string($string) {
    $string = htmlspecialchars(trim($string));
    $string = preg_replace("/[^A-Za-z0-9\s]+/u", '', $string);
    $string = preg_replace('/\s+/', ' ', $string);
    return $string;
}

function clear_nick($nick) {
    $nick = htmlspecialchars(trim($nick));
    $nick = preg_replace("/[^a-zA-Z\s]+/", '', $nick);
    return  $nick;
}

function write_log($file, $content)
{
    $db = fopen($file . "/" . date("F_j_Y") . ".log", "a+");
    fwrite($db, "[" . $_SERVER["REMOTE_ADDR"] . "][" . date("F j, Y / H:i") . "] " . $content . "\n");
    fclose($db);
}

function check_inject($type) { 
    $badchars = array("DROP", "drop", "UPDATE", "update", "SELECT", "select", "DELETE", "delete", "WHERE", "where", "CREATE", "create", "TABLE", "table", "*", "'", '"', "$", "(", ")", "`", ";", "/", " \ ", "-1", "-2", "-3", "-4", "-5", "-6", "-7", "-8", "-9");
    foreach($type as $value) { 
    $value = clean_array($value);
    if(in_array($value, $badchars)) { 
        die("SQL Injection Detected - Make sure only to use letters and numbers!\n<br />\nIP: ".$_SERVER['REMOTE_ADDR']);
    }   else { 
            $check = preg_split("//", $value, -1, PREG_SPLIT_OFFSET_CAPTURE); 
            foreach($check as $char) { 
                if(in_array($char, $badchars)) { 
                    die("SQL Injection Detected - Make sure only to use letters and numbers!\n<br />\nIP: ".$_SERVER['REMOTE_ADDR']); 
                }
            }
        }
    }
}
function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[random_int(0, $charactersLength - 1)];
    }
    return $randomString;
}