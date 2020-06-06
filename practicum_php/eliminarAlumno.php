<?php
    include("conexion_PDO.php");
    
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){
        $m = $datos->id;
        
        $conexionPDO = conexionPDO();
        $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
            
        $consulta = "DELETE FROM alumnos WHERE matricula = ?;";
        
        $sentencia = $conexionPDO->prepare($consulta);
        $sentencia->execute([$m]);

        $sentencia = null;

        echo json_encode("¡Datos eliminados correctamente!");
    }else{
        echo json_encode("¡Datos no eliminados!");
    }    
?>