<?php
    include("conexion_PDO.php");
    
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){
        $c = $datos->id;
        
        $conexionPDO = conexionPDO();
        $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
            
        $consulta = "DELETE FROM maestros WHERE claveD = ?;";
        
        $sentencia = $conexionPDO->prepare($consulta);
        $sentencia->execute([$c]);

        $sentencia = null;

        echo json_encode("¡Datos eliminados correctamente!");
    }else{
        echo json_encode("¡Datos no eliminados!");
    }    
?>