<?php
if(!defined('DB_SERVER')){
    require_once(__DIR__ . "/../initialize.php");
}
class DBConnection{

    private $host = DB_SERVER;
    private $username = DB_USERNAME;
    private $password = DB_PASSWORD;
    private $database = DB_NAME;
    private $port = DB_PORT;
    
    public $conn;
    
    public function __construct(){

        if (!isset($this->conn)) {
            mysqli_report(MYSQLI_REPORT_OFF);
            $this->conn = new mysqli($this->host, $this->username, $this->password, $this->database, (int)$this->port);
            
            if ($this->conn->connect_error) {
                echo 'Cannot connect to database server: ' . $this->conn->connect_error;
                exit;
            }
            $this->conn->set_charset("utf8mb4");
        }    
        
    }
    public function __destruct(){
        if ($this->conn instanceof mysqli) {
            $this->conn->close();
        }
    }
}
?>
