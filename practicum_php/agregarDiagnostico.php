
<?php
    include("conexion_PDO.php");

    $conexionPDO = conexionPDO();
    $conexionPDO->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexionPDO->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
  
    $json = file_get_contents('php://input');
    $datos=json_decode($json);

    if(isset($datos)){

        $i = $datos->id;
        $f = $datos->fortaleza;
        $d = $datos->debilidad;
        $as = $datos->aspecto;
        $es = $datos->estrategia;
        $m = $datos->matricula;
  
        $e = "";
        if($datos->estado=="true"){
            $e = "1";
        }else{
            $e = "0";
        }
        
        $consulta2 = "SELECT COUNT(*) FROM diagnosticos WHERE id LIKE ?;";
       
        $sentencia = $conexionPDO->prepare($consulta2);
        $sentencia->execute([$i]);
        
        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $di1 = $cons["COUNT(*)"];
        $sentencia = null;

        if(!($di1 >= 1)){

        $consulta2 = "SELECT * FROM alumnos WHERE matricula LIKE '" . $m . "';";

        $sentencia = $conexionPDO->prepare($consulta2);
        $sentencia->execute([]);

        $cons = $sentencia->fetch(PDO::FETCH_ASSOC);
        $m1 = $cons['matricula'];
        $sentencia = null;


     //  $sql = "INSERT INTO diagnosticos (id, fortaleza, debilidad, aspecto, estrategia, matricula, estado ) VALUES (?, ?, ?, ?, ?, ?, ?);";

        $sql = "INSERT INTO diagnosticos (id, fortaleza, debilidad, aspecto, estrategia, estado, matricula ) 
         VALUES ('" . $i . "', '" . $f . "', '" . $d. "', '" . $as . "', '" . $es . "', '" . $e . "', '" . $m1 . "');";
            $sqlPreparado = $conexionPDO->prepare($sql);
            $sqlPreparado->execute([]);
            $sqlPreparado = null;
    
            echo json_encode("¡Datos insertados correctamente!");
        }else{
            echo json_encode("¡Datos no insertados, clave repetida!");
        }

    }else{
        echo json_encode("¡Datos no insertados!");
    }    




     //    $sqlPreparado->execute([$i, $f, $d, $as, $es, $m, $e]);
?>

