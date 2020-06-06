<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT s.nombre AS id,s.proposito AS proposito,s.matricula AS matricula, a.nombre 
            AS nombre, s.id AS IDE, s.acuerdos AS acuerdos, a.primerAp, a.SegundoAp
            FROM sesiones s, alumnos a
            WHERE s.matricula = a.matricula AND s.claveD = ?
            ORDER BY s.id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
            if($row["acuerdos"]==null){
                $row["acuerdos"]="";
            } 
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>