<?php
include("conexion_PDO.php");

$conexionPDO = conexionPDO();
$conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
#$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

$consultaLicenciatura = "SELECT COUNT(*) FROM licenciatura;";
$consultaAlumno       = "SELECT COUNT(*) FROM alumnos;";
$consultaMaestros     = "SELECT COUNT(*) FROM maestros;";
$consultaUser         = "SELECT COUNT(*) FROM users;";
$consultaPlanEstudios = "SELECT COUNT(*) FROM planestudios;";
$consultaTutores      = "SELECT COUNT(*) FROM tutores;";

$resultadoConsulta = array();

$sentencia = $conexionPDO->prepare($consultaLicenciatura);
$sentencia->execute([]);

$cons1 = $sentencia->fetch(PDO::FETCH_ASSOC);
$lic = $cons1["COUNT(*)"];

$resultadoConsulta["licenciatura"] = $lic;
$sentencia = null;

$sentencia = $conexionPDO->prepare($consultaAlumno);
$sentencia->execute([]);

$cons2 = $sentencia->fetch(PDO::FETCH_ASSOC);
$alum = $cons2["COUNT(*)"];

$resultadoConsulta["alumno"] = $alum;
$sentencia = null;

$sentencia = $conexionPDO->prepare($consultaMaestros);
$sentencia->execute([]);

$cons3 = $sentencia->fetch(PDO::FETCH_ASSOC);
$maest = $cons3["COUNT(*)"];

$resultadoConsulta["maestro"] = $maest;
$sentencia = null;

$sentencia = $conexionPDO->prepare($consultaUser);
$sentencia->execute([]);

$cons4 = $sentencia->fetch(PDO::FETCH_ASSOC);
$use = $cons4["COUNT(*)"];

$resultadoConsulta["users"] = $use;
$sentencia = null;

$sentencia = $conexionPDO->prepare($consultaPlanEstudios);
$sentencia->execute([]);

$cons5 = $sentencia->fetch(PDO::FETCH_ASSOC);
$plan = $cons5["COUNT(*)"];

$resultadoConsulta["planEstudios"] = $plan;
$sentencia = null;

$sentencia = $conexionPDO->prepare($consultaTutores);
$sentencia->execute([]);

$cons6 = $sentencia->fetch(PDO::FETCH_ASSOC);
$tutor = $cons6["COUNT(*)"];

$resultadoConsulta["tutores"] = $tutor;
$sentencia = null;

echo json_encode($resultadoConsulta);

?>