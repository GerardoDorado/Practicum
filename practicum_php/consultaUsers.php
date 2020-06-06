<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

    $query = "SELECT u.id,u.name,u.username,u.user_level,u.status,u.last_login,g.group_name,u.image
                FROM users u LEFT JOIN user_groups g ON g.group_level=u.user_level 
                ORDER BY u.user_level ASC";

    $sentencia = $conexionPDO->prepare($query);
    $sentencia->execute([]);
    
    $resultadoConsulta = array();
    
    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
        if($row['status'] == "1"){
            $row["estado"] = true;
        }else{
            $row["estado"] = false;
        }
        $resultadoConsulta[] = $row; 
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
    
?>