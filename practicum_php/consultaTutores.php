<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $query  = " SELECT t.claveD AS ClaveD,t.matricula AS Matricula,a.nombre AS Alumno,m.nombre AS Docente, m.primerAp, 
            m.SegundoAp, m.GradoAc
            FROM tutores t, maestros m, alumnos a 
            WHERE m.claveD=t.claveD AND a.matricula = t.matricula
            ORDER BY t.claveD ASC ";

    $sentencia = $conexionPDO->prepare($query);
    $sentencia->execute([]);
    
    $resultadoConsulta = array();
    
    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
        $resultadoConsulta[] = $row; 
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
    
?>