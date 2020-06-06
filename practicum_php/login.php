<?php
include("conexion_PDO.php");

$json = file_get_contents('php://input');
$datos = json_decode($json);

$resultadosVacios = array();

if (isset($datos)) {
    $e = $datos->email;
    $p = $datos->password;

	$conexionPDO = conexionPDO();
	$conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
	
    //$query = "SELECT * FROM users WHERE username = ? AND password = ?; ";
    $consulta = "SELECT COUNT(*) FROM users WHERE username LIKE ? AND password LIKE ?;";

    $sentencia = $conexionPDO->prepare($consulta);
    $sentencia->execute([$e, sha1($p)]);

    $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
    $a1 = $cons["COUNT(*)"];
    $sentencia = null;

    if ($a1 >= 1) {
		$query = "SELECT * FROM users, alumnos WHERE username LIKE email AND 
            username LIKE ? AND password LIKE ?";

	    $sentencia = $conexionPDO->prepare($query);
	    $sentencia->execute([$e, sha1($p)]);

	    $row = $sentencia->fetch(PDO::FETCH_ASSOC);
	    
	    if($e==$row["username"]){
	        echo json_encode($row);
	    }else{
	    	$sentencia = null;
	    	$query = "SELECT * FROM users, maestros WHERE username LIKE email AND 
                username LIKE ? AND password LIKE ?";

		    $sentencia = $conexionPDO->prepare($query);
		    $sentencia->execute([$e, sha1($p)]);

		    $row = $sentencia->fetch(PDO::FETCH_ASSOC);
		    
		    if($e==$row["username"]){
		        echo json_encode($row);
		    }else{
		        $sentencia = null;
		    	$query = "SELECT * FROM users WHERE username LIKE ? AND password LIKE ?;";

		    	$sentencia = $conexionPDO->prepare($query);
			    $sentencia->execute([$e, sha1($p)]);

				$row = $sentencia->fetch(PDO::FETCH_ASSOC);
				$row["primerAp"] = "";
				$row["SegundoAp"] = "";
			    echo json_encode($row);
		    }
		    $sentencia = null;
		}

		$date = make_date();
		$query = "UPDATE users SET last_login=? WHERE username = ? LIMIT 1";

		$sentencia = $conexionPDO->prepare($query);
		$sentencia->execute([$date, $e]);
		
		$sentencia = null;
	
    }else{ 
		$resultadosVacios["mensaje"] = "Usuario no encontrado"; 
    	echo json_encode($resultadosVacios);
    }
    
} else {
    $resultadosVacios["mensaje"] = "Datos no recividos"; 
    	echo json_encode($resultadosVacios);
}


function make_date(){
	return strftime("%Y-%m-%d %H:%M:%S", time());
}