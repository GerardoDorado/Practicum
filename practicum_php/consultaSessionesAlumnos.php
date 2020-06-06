<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $matricula = $datos->matricula;
        
        $query  = " SELECT s.nombre AS id,s.proposito AS proposito,s.matricula AS matricula, m.nombre AS nombre, 
            s.id AS IDE, s.acuerdos AS acuerdos, m.primerAp, m.SegundoAp
            FROM sesiones s, alumnos a, maestros m
            WHERE s.matricula = a.matricula AND s.matricula = ? AND m.claveD = s.claveD
            ORDER BY s.id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$matricula]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {     
            if($row["acuerdos"] ==null){
                $row["acuerdos"]="";
            }      
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>