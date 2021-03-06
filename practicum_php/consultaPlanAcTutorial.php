<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT d.estado AS estado, a.nombre AS nombre, a.primerAp, a.SegundoAp AS segundoAp, d.id 
            AS id, d.fortaleza AS fortaleza, d.debilidad 
            AS debilidad, d.aspecto AS aspecto, d.estrategia AS estrategia, d.matricula AS matricula, u.image
            FROM diagnosticos d, alumnos a, users u
            WHERE d.matricula = a.matricula AND d.claveD = ? AND u.username = a.matricula 
            ORDER BY d.id ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
            if($row["estado"] == 0){
                $row["estadoFinal"] =false;
            }else{
                $row["estadoFinal"] =true;
            }
             
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
