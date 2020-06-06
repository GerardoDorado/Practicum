<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT i.id AS id,i.nombre AS proyecto,i.matricula AS matricula,i.estado AS estado,
            i.evaluacion AS evaluacion, a.nombre AS nombre, a.primerAp, a.SegundoAp
            FROM inducion i, alumnos a 
            WHERE a.matricula = i.matricula AND i.claveD LIKE ?
            ORDER BY i.id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
            if($row["evaluacion"] == null){
                $row["evaluacion"]="";
            }             
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>