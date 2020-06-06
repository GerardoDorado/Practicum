<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT h.id AS id,  h.matricula AS matricula, h.fecha AS fecha, h.observacion 
            AS observacion, h.evaluacion AS evaluacion, h.evidencia AS evidencia, h.aspectos 
            AS aspectos, h.fortaleza AS fortaleza, h.formas AS formas, h.preguntas AS preguntas, h.reflexion 
            AS refelxion, a.nombre AS nombre, h.atencion AS atencion, a.primerAp, a.SegundoAp
            FROM habilidad h, alumnos a
            WHERE h.claveD = ? AND h.matricula = a.matricula
            ORDER BY id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
            if($row["fortaleza"]==null){
                $row["fortaleza"]="";
            }
            if($row["evidencia"]==null){
                $row["evidencia"]="";
            }
            if($row["atencion"]==null){
                $row["atencion"]="";
            }
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
