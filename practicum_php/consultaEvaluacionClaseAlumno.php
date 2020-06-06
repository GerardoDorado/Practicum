<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $matricula = $datos->matricula;

        $query  = " SELECT h.id AS id,  h.matricula AS matricula, h.fecha AS fecha, h.observacion AS observacion, 
            h.evaluacion AS evaluacion, 
            h.evidencia AS evidencia, h.aspectos AS aspectos, h.fortaleza AS fortaleza, h.formas AS formas, 
            h.preguntas AS preguntas, h.reflexion AS reflexion, m.nombre AS nombre, h.atencion AS atencion,
            m.primerAp, m.SegundoAp
            FROM habilidad h, alumnos a, maestros m
            WHERE h.matricula = ? AND h.matricula = a.matricula AND m.claveD = h.claveD
            ORDER BY id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$matricula]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
            if($row["reflexion"] == null){
                $row["reflexion"]="";
            }
            if($row["aspectos"] == null){
                $row["aspectos"]="";
            }
            
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
?>