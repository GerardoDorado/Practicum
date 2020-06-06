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
        
        $consulta2 = "SELECT COUNT(*) FROM maestros WHERE claveD LIKE ?;";
       
        $sentencia = $conexionPDO->prepare($consulta2);
        $sentencia->execute([$c]);
        
        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $l1 = $cons["COUNT(*)"];
        $sentencia = null;

        if(!($l1 >= 1)){
            $sql = "INSERT INTO maestros (claveD, nombre, primerAp, SegundoAp, edad, email, activo, gradoAc) VALUES(?, ?, ?, ?, ?, ?, ?, ?);";

            $sqlPreparado = $conexionPDO->prepare($sql);
            $sqlPreparado->execute([$c, $n, $p, $s, $ed, $em, $e, $g]);
            $sqlPreparado = null;
            
            $sql = "INSERT INTO users (name, username, password, user_level, status) VALUES(?, ?, ?, 2, 1);";
            
            $sqlPreparado = $conexionPDO->prepare($sql);
            $sqlPreparado->execute([$n, $c, sha1($em)]);  
            $sqlPreparado = null;
            
            echo json_encode("¡Datos insertados correctamente!");
        }else{
            echo json_encode("¡Datos no insertados, clave repetida!");
        }

    }else{
        echo json_encode("¡Datos no insertados!");
    }    
?>