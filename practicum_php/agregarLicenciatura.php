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
        
        $consulta2 = "SELECT COUNT(*) FROM licenciatura WHERE claveLic LIKE ?;";
       
        $sentencia = $conexionPDO->prepare($consulta2);
        $sentencia->execute([$c]);
        
        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $l1 = $cons["COUNT(*)"];
        $sentencia = null;

        if($l1 != 1){
            $sql = "INSERT INTO licenciatura (claveLic, nombre, activo) VALUES(?, ?, ?);";

            $sqlPreparado = $conexionPDO->prepare($sql);
            $sqlPreparado->execute([$c, $n, $e]);
            
            $sqlPreparado = null;
            echo json_encode("¡Datos insertados correctamente!");
        }else{
            echo json_encode("¡Datos no insertados, clave repetida!");
        }

    }else{
        echo json_encode("¡Datos no insertados!");
    }    
?>