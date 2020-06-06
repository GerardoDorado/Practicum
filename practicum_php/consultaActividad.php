<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $matricula = $datos->matricula;
        
        $query=" SELECT s.actividad AS actividad, s.fecha AS fecha, a.matricula AS matricula, m.nombre AS nombre, 
            s.id AS id, s.estado As estado, m.primerAp, m.SegundoAp
            FROM actividad s, alumnos a, maestros m
            WHERE s.matricula = a.matricula AND s.matricula = ? AND s.estado = 0 AND s.claveD = m.claveD
            ORDER BY s.id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$matricula]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {           
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>