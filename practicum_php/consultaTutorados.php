<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT t.matricula AS matricula, a.nombre AS nombre, a.primerAp AS primerAp,
            a.SegundoAp AS segundoAp, a.Semestre AS semestre, a.SegundoAp AS segundoAp, a.email AS email 
            FROM tutores t, maestros m, alumnos a 
            WHERE m.claveD=t.claveD AND a.matricula = t.matricula AND t.claveD = ?
            ORDER BY t.claveD ASC ";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>