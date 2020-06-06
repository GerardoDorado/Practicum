<?php
    include("conexion_PDO.php");
    $conexionPDO = conexionPDO(); 
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);   
        
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){
        $m = $datos->matricula;
        $n = $datos->nombre;
        $pA = $datos->primerAp;
        $sA = $datos->SegundoAp;
        $fN = $datos->edad;
        $l = $datos->Licenciatura; 
        $s = $datos->Semestre;
        $e = "";
        if($datos->activo=="true"){
            $e = "Activo";
        }else{
            $e = "Inactivo";
        }
        $em = $datos->email;
        
        $consulta1 = "SELECT * FROM licenciatura WHERE nombre LIKE ?;";
       
        $sentencia = $conexionPDO->prepare($consulta1);
        $sentencia->execute([$l]);

        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $l1 = $cons['claveLic'];
        $sentencia = null;


        $consulta = "UPDATE alumnos SET nombre = ?, primerAP =  ?, SegundoAP = ?, edad = ?, email = ?, 
                    activo = ?, Semestre = ?, Licenciatura = ? WHERE matricula = ?";
        
        $sentencia = $conexionPDO->prepare($consulta);
        $sentencia->execute([$n, $pA, $sA, $fN, $em, $e, $s, $l1, $m]);

        $sentencia = null;

        echo json_encode("¡Datos modificados correctamente!");
    }else{
        echo json_encode("¡Datos no modificados!");
    }    
?>