<?php
    include("conexion_PDO.php");
    
    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    #$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    
    $query = "SELECT matricula, alumnos.nombre AS nombreA, primerAp, SegundoAp, Semestre, edad, 
                    licenciatura.nombre AS nombreL, email, alumnos.activo, image FROM alumnos, licenciatura, users
                    WHERE alumnos.Licenciatura = licenciatura.claveLic AND username = matricula";

    $sentencia = $conexionPDO->prepare($query);
    $sentencia->execute([]);
    
    $resultadoConsulta = array();
    
    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) { 
        if($row['activo'] == "Activo"){
            $row["estado"] = true;
        }else{
            $row["estado"] = false;
        }
        $resultadoConsulta[] = $row; 
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
    
?>