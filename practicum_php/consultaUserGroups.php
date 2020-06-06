<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

    $query = "SELECT * FROM user_groups;";

    $sentencia = $conexionPDO->prepare($query);
    $sentencia->execute([]);
    
    $resultadoConsulta = array();
    
    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
        if($row['group_status'] == "1"){
            $row["estado"] = true;
        }else{
            $row["estado"] = false;
        }
        $resultadoConsulta[] = $row; 
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
    
?>