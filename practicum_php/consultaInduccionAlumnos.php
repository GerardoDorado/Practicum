<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $matricula = $datos->matricula;

        $query  = "SELECT i.id AS id, i.nombre AS nombre, i.tematica AS tematica, i.evaluacion AS evaluacion, 
            m.nombre AS modalidad
            FROM modalidad m, inducion i
            WHERE matricula = ? AND estado = 'Activo' AND i.modalidad = m.id
            ORDER BY id ASC";
         
        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$matricula]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
            if($row["evaluacion"]==null){
                $row["evaluacion"]="";
            }
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>