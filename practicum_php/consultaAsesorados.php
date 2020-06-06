<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $json = file_get_contents('php://input');
    $datos = json_decode($json);

    if(isset($datos)){
        $claveDocente = $datos->claveD;

        $query  = " SELECT a.matricula AS matricula,a.nombre AS nombre,a.primerAp AS primerAp,a.SegundoAp 
                AS SegundoAp,a.fecha_nacimiento AS edad,a.email AS email,a.activo AS activo,a.Semestre 
                AS Semestre,l.nombre AS Licenciatura, u.image
                FROM alumnos a, licenciatura l, tutores t, users u
                WHERE a.Licenciatura = l.claveLic AND a.activo='Activo' AND t.claveD = ? 
                AND a.matricula = t.matricula AND a.matricula = u.username ORDER BY matricula ASC";

        $sentencia = $conexionPDO->prepare($query);
        $sentencia->execute([$claveDocente]);
        
        $resultadoConsulta = array();
        
        while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
            if($row["activo"] == "Activo"){
                $row["estado"] =true;
            }else{
                $row["estado"] =false;
            }
              
            $resultadoConsulta[] = $row; 
        }

        $sentencia = null;
        echo json_encode($resultadoConsulta);
    }
