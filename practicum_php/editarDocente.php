<?php
    include("conexion_PDO.php");
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);   
        
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){
        $c = $datos->claveD;
        $n = $datos->nombre;
        $p = $datos->primerAp;
        $s = $datos->segundoAp;
        $ed = $datos->edad;
        $e = "";
        if($datos->activo=="true"){
            $e = "Activo";
        }else{
            $e = "Inactivo";
        }
        $g = $datos->gradoAc;
        $em = $datos->email;

        $consulta = "UPDATE maestros SET nombre =  ?, primerAp = ?, SegundoAp = ?, edad = ?, email = ?, activo = ?, GradoAc = ? WHERE claveD = ?";
        
        $sentencia = $conexionPDO->prepare($consulta);
        $sentencia->execute([$n, $p, $s, $ed, $em, $e, $g, $c]);

        $sentencia = null;

        echo json_encode("¡Datos modificados correctamente!");
    }else{
        echo json_encode("¡Datos no modificados!");
    }    
?>