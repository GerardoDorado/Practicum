<?php
    include("conexion_PDO.php");
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);   
        
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){
        $c = $datos->claveLic;
        $n = $datos->nombre;
        $e = "";
        if($datos->activo=="true"){
            $e = "Activo";
        }else{
            $e = "Inactivo";
        }

        $consulta = "UPDATE licenciatura SET nombre =  ?, activo = ? WHERE claveLic = ?";
        
        $sentencia = $conexionPDO->prepare($consulta);
        $sentencia->execute([$n, $e, $c]);

        $sentencia = null;

        echo json_encode("¡Datos modificados correctamente!");
    }else{
        echo json_encode("¡Datos no modificados!");
    }    
?>