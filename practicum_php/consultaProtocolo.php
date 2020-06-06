<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT i.id AS id, m.nombre AS modalidad, i.matricula AS matricula, i.nombre 
            AS Proyecto, i.tematica AS Tematica, i.estado AS estado, a.nombre AS nombre
            FROM modalidad m, inducion i, alumnos a
            WHERE a.matricula = i.matricula AND i.modalidad = m.id AND i.claveD = ?
            ORDER BY m.id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
            if($row["estado"] == "Inactivar"){
                $row["estadoFinal"] =false;
            }else{
                $row["estadoFinal"] =true;
            }
             
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
?>