<?php
include("conexion_PDO.php");

$conexionPDO = conexionPDO();
$conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
#$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

$json = file_get_contents('php://input');
$datos = json_decode($json);

$consulta = "SELECT * FROM maestros";
$busqueda = null;
$resultadoConsulta = array();

if (isset($datos)) {
    $busqueda = $datos->filtro;
    $consulta = "SELECT * FROM maestros WHERE nombre LIKE ? OR claveD LIKE ? OR primerAp LIKE ?;";
}
 
$sentencia = $conexionPDO->prepare($consulta, [
    PDO::ATTR_CURSOR => PDO::CURSOR_SCROLL,
]);

if ($busqueda === null) {
    $sentencia->execute();

    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
        if ($row['activo'] == "Activo") {
            $row["estado"] = true;
        } else {
            $row["estado"] = false;
        }
        $resultadoConsulta[] = $row;
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
} else {
    $parametros = ["%$busqueda%", "%$busqueda%", "%$busqueda%"];
    $sentencia->execute($parametros);

    while ($row = $sentencia->fetch(PDO::FETCH_ASSOC)) {
        if ($row['activo'] == "Activo") {
            $row["estado"] = true;
        } else {
            $row["estado"] = false;
        }
        $resultadoConsulta[] = $row;
    }

    $sentencia = null;
    echo json_encode($resultadoConsulta);
}
