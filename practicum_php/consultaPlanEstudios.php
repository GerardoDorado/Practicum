<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $query  = " SELECT idPlanEst,ano,estado
                FROM planEstudios 
                ORDER BY idPlanEst ASC";

    $sentencia = $conexionPDO->prepare($query);
    $sentencia->execute([]);
    
    $resultadoConsulta = array();
    
    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
        $resultadoConsulta[] = $row; 
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
?>