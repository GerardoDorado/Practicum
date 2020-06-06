<?php
    function conexionPDO() {
        try {
            $dsn = "mysql:host=localhost;dbname=practicum_final;charset=utf8";
            $connection = new PDO($dsn, "user", "password");
            return $connection;
        } catch (PDOException $pdeo) {
           error_log($pdeo->getMessage()); 
           echo "ERROR: ".$pdeo->getMessage();
        }
    }
?>