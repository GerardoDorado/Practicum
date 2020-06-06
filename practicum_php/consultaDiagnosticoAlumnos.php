<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $matricula = $datos->matricula;

        $query  = " SELECT d.estado AS estado, m.nombre AS nombre, d.id AS id, d.fortaleza AS fortaleza, 
                d.debilidad AS debilidad, d.aspecto AS aspecto, d.estrategia AS estrategia, d.matricula AS matricula,
                m.primerAp, m.SegundoAp
                FROM diagnosticos d, alumnos a, maestros m
                WHERE d.matricula = a.matricula AND d.matricula = ? AND m.claveD = d.claveD
                ORDER BY d.id ASC";

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