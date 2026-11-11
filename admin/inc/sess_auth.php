<?php 
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
$link = (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') ||
        (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on') ? "https://" : "http://";
$link .= ($_SERVER['HTTP_HOST'] ?? 'localhost') . ($_SERVER['REQUEST_URI'] ?? '/');

if(!isset($_SESSION['userdata']) && strpos($link, 'login.php') === false){
	redirect('admin/login.php');
    exit;
}
if(isset($_SESSION['userdata']) && strpos($link, 'login.php') !== false){
	redirect('admin/index.php');
    exit;
}
$module = array('','admin','faculty','student');
if(isset($_SESSION['userdata']) && (strpos($link, 'index.php') !== false || strpos($link, 'admin/') !== false) && ($_SESSION['userdata']['login_type'] ?? null) != 1){
	echo "<script>alert('Access Denied!');location.replace('".base_url.($module[$_SESSION['userdata']['login_type']] ?? 'admin')."');</script>";
    exit;
}
