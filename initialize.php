<?php
$dev_data = array('id'=>'-1','firstname'=>'Developer','lastname'=>'','username'=>'dev_oretnom','password'=>'5da283a2d990e8d8512cf967df5bc0d0','last_login'=>'','date_updated'=>'','date_added'=>'');

if(!defined('base_url')) {
    $env_url = getenv('BASE_URL');
    if(!empty($env_url)){
        define('base_url', rtrim($env_url, '/') . '/');
    } else if (isset($_SERVER['HTTP_HOST'])) {
        $proto = 'http';
        if ((isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') ||
            (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') ||
            (isset($_SERVER['SERVER_PORT']) && (int)$_SERVER['SERVER_PORT'] === 443)) {
            $proto = 'https';
        }
        define('base_url', $proto . '://' . $_SERVER['HTTP_HOST'] . '/');
    } else {
        define('base_url', 'http://localhost/');
    }
}

if(!defined('base_app')) define('base_app', str_replace('\\','/',__DIR__).'/' );
if(!defined('dev_data')) define('dev_data',$dev_data);
if(!defined('DB_SERVER')) define('DB_SERVER', getenv('DB_SERVER') ?: "localhost");
if(!defined('DB_USERNAME')) define('DB_USERNAME', getenv('DB_USERNAME') ?: "root");
if(!defined('DB_PASSWORD')) define('DB_PASSWORD', getenv('DB_PASSWORD') !== false ? getenv('DB_PASSWORD') : "");
if(!defined('DB_NAME')) define('DB_NAME', getenv('DB_NAME') ?: "sms_db");
if(!defined('DB_PORT')) define('DB_PORT', getenv('DB_PORT') ? (int)getenv('DB_PORT') : 3306);
?>
