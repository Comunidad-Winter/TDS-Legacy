<?php


#error_reporting(E_ALL);
ob_start();
if (!isset($_SESSION)) session_start();

#23SUkezelo

#session_set_cookie_params(['samesite' => 'Strict']);
date_default_timezone_set('America/Argentina/Buenos_Aires');

 

$host=$_SERVER['HTTP_HOST'];#'tdslegacy.com.ar';
$protocol = stripos($_SERVER['SERVER_PROTOCOL'],'https') === true ? 'https://' : 'http://';

if (!empty($_SERVER['HTTP_CLIENT_IP'])) {$ip = $_SERVER['HTTP_CLIENT_IP'];} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];} else {$ip = $_SERVER['REMOTE_ADDR'];}
 

if (!defined('APP_NAME'))           define('APP_NAME' ,'AO Legacy');
if (!defined('APP_ORGANIZATION'))   define('APP_ORGANIZATION' ,'AO Legacy');
if (!defined('APP_OWNER'))          define('APP_OWNER' ,'Matias');
if (!defined('APP_DESCRIPTION'))    define('APP_DESCRIPTION' ,'Argentum Online, conocido también como AO, es un videojuego de rol multijugador masivo en línea libre disponible para los sistemas operativos Microsoft Windows y publicado en el año 1999 en Internet de manera independiente.');

if (!defined('CONN_KEY')) define('CONN_KEY', "[M-t8X%Ai{5b2C'(rB&e");

if (!defined('DB_DATABASE'))        define('DB_DATABASE', 'db_tdslegacy');
if (!defined('DB_HOST'))            define('DB_HOST','localhost');
if (!defined('DB_USERNAME'))        define('DB_USERNAME','root');
if (!defined('DB_PASSWORD'))        define('DB_PASSWORD' ,'');
if (!defined('DB_PORT'))            define('DB_PORT' ,'');

if (!defined('RESOURCES'))          define('RESOURCES' ,'http://'.$host . '/');

if (!defined('SMTP_HOST'))define('SMTP_HOST', 'HOST');
if (!defined('SMTP_PORT'))define('SMTP_PORT', 465);
if (!defined('SMTP_USERNAME'))define('SMTP_USERNAME', 'EMAIL');
if (!defined('SMTP_ENCRYPTION'))define('SMTP_ENCRYPTION', 'ssl');
if (!defined('SMTP_FROM'))define('SMTP_FROM', 'EMAIL');
if (!defined('SMTP_FROM_NAME'))define('SMTP_FROM_NAME', 'EMAIL');
if (!defined('ADMIN_EMAIL'))define('ADMIN_EMAIL', 'matias.98@hotmail.com');
if (!defined('SMTP_PASSWORD'))define('SMTP_PASSWORD', 'PASSWORD');


if (!defined('ENV_MAILS'))define('ENV_MAILS', true);

// Global Variables
if (!defined('MAX_LOGIN_ATTEMPTS_PER_HOUR'))define('MAX_LOGIN_ATTEMPTS_PER_HOUR', 5);
if (!defined('MAX_EMAIL_VERIFICATION_REQUESTS_PER_DAY'))define('MAX_EMAIL_VERIFICATION_REQUESTS_PER_DAY', 3);
if (!defined('MAX_PASSWORD_RESET_REQUESTS_PER_DAY'))define('MAX_PASSWORD_RESET_REQUESTS_PER_DAY', 3);
if (!defined('PASSWORD_RESET_REQUEST_EXPIRY_TIME'))define('PASSWORD_RESET_REQUEST_EXPIRY_TIME', 60*60);
if (!defined('CSRF_TOKEN_SECRET'))define('CSRF_TOKEN_SECRET', 'http://aoLegacy.com');
if (!defined('VALIDATE_EMAIL_ENDPOINT'))define('VALIDATE_EMAIL_ENDPOINT', $protocol.$host.'/cpremium.php?a=validar-email&');
if (!defined('RESET_PASSWORD_ENDPOINT'))define('RESET_PASSWORD_ENDPOINT', $protocol.$host.'/cpremium.php?a=resetpass-pj&');
if (!defined('RESET_ACC_PASSWORD_ENDPOINT'))define('RESET_ACC_PASSWORD_ENDPOINT', 'http://aoLegacy.com/cpremium.php?a=resetpass-acc&');
if (!defined('TDS_URL'))define('TDS_URL', $protocol.$host);
if (!defined('ADMIN_EMAIL')) define('ADMIN_EMAIL', 'matias.98@hotmail.com');
 

// MERCADOPAGO
if (!defined('PUBLIC_KEY'))define('PUBLIC_KEY', 'TEST-c04bbbe1-a043-4392-9599-1e1dfa70c71a');
if (!defined('ACCESS_TOKEN'))define('ACCESS_TOKEN', 'TEST-7468408886474646-100614-66f651b119685bb5a8e887e21b664001-187987319');

if (!defined('ENV_DEBUG'))define('ENV_DEBUG', true);
if (!defined('ENV_REQUIRE_SERVER_ON'))define('ENV_REQUIRE_SERVER_ON', true);

// CONEXION CON EL SERVIDOR
if (!defined('ENV_IP'))define('ENV_IP', '45.231.215.28');
#if (!defined('ENV_PORT'))define('ENV_PORT', 7778);
if (!defined('ENV_PORT'))define('ENV_PORT', 7778);

if (!ENV_DEBUG) {
    error_reporting(0);
}
