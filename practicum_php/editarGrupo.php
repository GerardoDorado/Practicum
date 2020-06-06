<?php
    include("conexion_PDO.php");

    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){
        
        $i = $datos->id;
        $n = $datos->groupName;
        $l = $datos->groupLevel;
        $e = "";
        if($datos->estado=="true"){
            $e = "1";
        }else{
            $e = "0";
        }
        $consulta2 = "SELECT COUNT(*) FROM user_groups WHERE group_level LIKE ?;";
       
        $sentencia = $conexionPDO->prepare($consulta2);
        $sentencia->execute([$l]);
        
        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $l1 = $cons["COUNT(*)"];
        $sentencia = null;

        if($l1 != 1){
            $sql = "UPDATE user_groups SET group_name=?, group_level=?, group_status=? WHERE id = ?";

            $sqlPreparado = $conexionPDO->prepare($sql);
            $sqlPreparado->execute([$n, $l, $e, $i]);
            
            $sqlPreparado = null;
            echo json_encode("¡Datos modificados correctamente!");
        }else{
            echo json_encode("¡Datos no modificados, user_level dúplicado!");
        }
    }else{
        echo json_encode("¡Datos no modificados!");
    }    
?>