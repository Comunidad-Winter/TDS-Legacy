<?php

session_set_cookie_params(['samesite' => 'Strict']);
date_default_timezone_set('America/Argentina/Buenos_Aires');
session_start();

$host='aoLegacy.com';

if (!empty($_SERVER['HTTP_CLIENT_IP'])) {$ip = $_SERVER['HTTP_CLIENT_IP'];} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];} else {$ip = $_SERVER['REMOTE_ADDR'];}
 

if (!defined('APP_NAME'))           define('APP_NAME' ,'AO Legacy');
if (!defined('APP_ORGANIZATION'))   define('APP_ORGANIZATION' ,'AO Legacy');
if (!defined('APP_OWNER'))          define('APP_OWNER' ,'Cui cui');
if (!defined('APP_DESCRIPTION'))    define('APP_DESCRIPTION' ,'Argentum Online, conocido también como AO, es un videojuego de rol multijugador masivo en línea libre disponible para los sistemas operativos Microsoft Windows y publicado en el año 1999 en Internet de manera independiente.');

define('CONN_KEY', "[M-t8X%Ai{5b2C'(rB&e");
    
if (!defined('DB_DATABASE'))        define('DB_DATABASE', 'db_tdslegacy');
if (!defined('DB_HOST'))            define('DB_HOST','localhost');
if (!defined('DB_USERNAME'))        define('DB_USERNAME','root');
if (!defined('DB_PASSWORD'))        define('DB_PASSWORD' ,'');
if (!defined('DB_PORT'))            define('DB_PORT' ,'');


if (!defined('RESOURCES'))          define('RESOURCES' ,'http://'.$host . '/');



define('SMTP_HOST', 'HOST');define('SMTP_PORT', 465);define('SMTP_USERNAME', '1234@myssrl.com');define('SMTP_ENCRYPTION', 'ssl');define('SMTP_FROM', 'admin@myssrl.com');define('SMTP_FROM_NAME', 'AO Legacy');define('ADMIN_EMAIL', '1234@hotmail.com');

define('SMTP_PASSWORD', '1234');

define('ENV_MAILS', true);

// Global Variables
define('MAX_LOGIN_ATTEMPTS_PER_HOUR', 5);
define('MAX_EMAIL_VERIFICATION_REQUESTS_PER_DAY', 3);
define('MAX_PASSWORD_RESET_REQUESTS_PER_DAY', 3);
define('PASSWORD_RESET_REQUEST_EXPIRY_TIME', 60*60);
define('CSRF_TOKEN_SECRET', 'http://aoLegacy.com');
define('VALIDATE_EMAIL_ENDPOINT', 'http://aoLegacy.com/cpremium.php?a=validar-email&');
define('RESET_PASSWORD_ENDPOINT', 'http://aoLegacy.com/cpremium.php?a=resetpass-pj&');
define('RESET_ACC_PASSWORD_ENDPOINT', 'http://aoLegacy.com/cpremium.php?a=resetpass-acc&');
define('TDS_URL', 'http://aoLegacy.com');
if (!defined('ADMIN_EMAIL')) define('ADMIN_EMAIL', 'm1234@hotmail.com');
 

// MERCADOPAGO
define('PUBLIC_KEY', 'TEST-c04bbbe1-a043-4392-9599-1e1dfa70c71a');
define('ACCESS_TOKEN', 'TEST-7468408886474646-100614-66f651b119685bb5a8e887e21b664001-187987319');

define('ENV_DEBUG', false);
define('ENV_REQUIRE_SERVER_ON', true);

define('ENV_IP', '45.231.215.28');
define('ENV_PORT', 7778);

if (!ENV_DEBUG) {
    error_reporting(0);
}
