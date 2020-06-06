<?php
include("conexion_PDO.php");
$json = file_get_contents('php://input');
$datos = json_decode($json);

if (isset($datos)) {

    $m = $datos->matricula;
    $n = $datos->nombre;
    $pA = $datos->primerAp;
    $sA = $datos->SegundoAp;
    $edad = $datos->edad;
    $l = $datos->Licenciatura;
    $s = $datos->Semestre;
    $e = "";
    if ($datos->activo == "true") {
        $e = "Activo";
    } else {
        $e = "Inactivo";
    }
    $em = $datos->email;

    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);


    $consulta2 = "SELECT COUNT(*) FROM alumnos WHERE matricula LIKE ?;";

    $sentencia = $conexionPDO->prepare($consulta2);
    $sentencia->execute([$m]);

    $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
    $a1 = $cons["COUNT(*)"];
    $sentencia = null;

    if (!($a1 >= 1)) {
        $consulta2 = "SELECT * FROM licenciatura WHERE nombre LIKE '" . $l . "';";

        $sentencia = $conexionPDO->prepare($consulta2);
        $sentencia->execute([]);

        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $l1 = $cons['claveLic'];
        $sentencia = null;

        $sql = "INSERT INTO alumnos (matricula, nombre, primerAp, SegundoAp, edad, email, activo, Semestre, Licenciatura)
            VALUES('" . $m . "', '" . $n . "', '" . $pA . "', '" . $sA . "', '" . $edad . "', '" . $em . "', '" . $e . "', '" . $s . "', '" . $l1 . "');";
        $sqlPreparado = $conexionPDO->prepare($sql);
        $sqlPreparado->execute([]);
        $sqlPreparado = null;

        $sql = "INSERT INTO users (name, username, password, user_level, status) VALUES(?, ?, ?, 3, 1);";

        $sqlPreparado = $conexionPDO->prepare($sql);
        $sqlPreparado->execute([$n, $m, sha1($em)]);
        $sqlPreparado = null;
        echo json_encode("¡Datos insertados correctamente!");
    } else {
        echo json_encode("¡Datos no insertados!");
    }
} else {
    echo json_encode("¡Datos no insertados!");
}
