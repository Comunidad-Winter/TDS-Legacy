<?php

$str="";
$tot=0;

//file_put_contents( 'C:\Users\Usuario\Desktop\a' . time() . '.log', var_export( $_POST, true));
  
if (isset($_POST['AgregarPj'])) {
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
     
    foreach($_POST as $key => $value){
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
    
 $nick = strtoupper($_POST['nick']);
 $pass = $_POST['pass']; 
 $pin = $_POST['pin']; 
    $email = $_POST['email'];
    $account_id = intval($_POST['acc']);
    $nivel = intval($_POST['nivel']); 
    $exp = intval($_POST['exp']); 
    $clase = intval($_POST['clase']); 
    $raza = intval($_POST['raza']); 
    $genero = intval($_POST['genero']); 
    $logged = intval($_POST['logged']); 
    $min_hp = intval($_POST['min_hp']); 
    $max_hp = intval($_POST['max_hp']); 
    $min_man = intval($_POST['min_man']); 
    $max_man = intval($_POST['max_man']); 
    $elu = intval($_POST['elu']); 
    $ciudas_matados = intval($_POST['cium']); //ciudas_matados
    $crimis_matados = intval($_POST['crim']); //crimis_matados
    $criaturas_matadas = intval($_POST['cm']); //criaturas_matadas
    $privilegios = intval($_POST['privs']); 
    $status = intval($_POST['sss']); 
    $carceltime = intval($_POST['jail']); 
    $clan = $_POST['clan']; 
    $total_matados = intval($_POST['tm']); //total_matados
    $oro = intval($_POST['oro']); 
    $boveda = intval($_POST['bov']); 
    $posicion = $_POST['pos']; 
    $lastip = $_POST['ip']; 
    $asesino = intval($_POST['ase']); //asesino
    $noble = intval($_POST['nob']); //noble
    $burgue = intval($_POST['bur']); //burgue
    $bandido = intval($_POST['band']); //bandido
    $plebe = intval($_POST['ple']); //plebe
    $ladron = intval($_POST['lad']); //ladron
    $retos_ganados = intval($_POST['rg']);  //retos_ganados
    $retos_perdidos = intval($_POST['rp']); //retos_perdidos
    $retos_oro_perdido = intval($_POST['rop']);  //retos_oro_perdido
    $retos_oro_ganado = intval($_POST['rog']);  //retos_oro_ganado
    $is_locked_in_mao = intval($_POST['ilim']); //is_locked_in_mao
    $skillslibres = intval($_POST['skl']);  //skillslibres
    $ban = intval($_POST['ban']); 
    $ups = 0;
    $skills = array(21);
    $attrib = array(5);
    $inv = array(20);
    $invamount = array(20);
    $invequipped = array(20);
    $bov = array(40);
    $bovamount = array(40);
    $spells = array(35);
    $penas = array(8);


    for ($i=1; $i <= 21; $i++) { 
        $skills[$i]=  intval($_POST['sk'.$i]); 
    }

     for ($i=1; $i <= 5; $i++) { 
        $attrib[$i]=  intval($_POST['at'.$i]); 
    }

    for ($i=1; $i <= 20; $i++) { 
        $inv[$i]=  intval($_POST['inv'.$i]); 
        $invamount[$i]= intval($_POST['ia'.$i]); 
        $invequipped[$i]= intval($_POST['ie'.$i]); 
    }

    for ($i=1; $i <= 40; $i++) { 
        $bov[$i]=  intval($_POST['b'.$i]); 
        $bovamount[$i]= intval($_POST['ba'.$i]); 
    }

    for ($i=1; $i <= 35; $i++) { 
        $spells[$i]=  intval($_POST['s'.$i]); 
    }

    $totpenas = intval($_POST['totpenas']);     

    for ($i=1; $i <= 8; $i++) {
        $pena="";
        if (isset($_POST['p'.$i])) $pena=trim($_POST['p'.$i]);
        $penas[$i]=  trim($pena); 
    }

    $puntosfotodenuncia = intval($_POST['pft']); //puntosfotodenuncia
    $participoclanes = intval($_POST['pcl']); //participoclanes
    $fundoclan = $_POST['fcl']; //fundoclan
    $disolvioclan = $_POST['dcl']; //disolvioclan
    $unbandate = $_POST['ubd']; //disolvioclan
    $mao_index = intval($_POST['mao']); //disolvioclan
    $locked = intval($_POST['lck']);

    if (empty($nick) || empty($pass) || empty($pin) || empty($email)) {
        echo '0 '.$nick;
        exit('0');
    } else if (!preg_match('/^[\p{L}\s]+$/u', $nick)) {
        echo '1 '.$nick;
        exit('1');
    } else if (strlen($pass) < 2 ) {
        echo '2 '.$pass;
        exit('2');
    } else if (strlen($pin) < 2 ) {
        echo '3 '.$pin;
        exit('3');
    #} else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    #    echo '4 ' .$email;
    #    exit('4');
    }else {
             
  
    switch ($clase) {
    case 1:
    switch ($raza) {
    case 1: $prom =6.5;break;
    case 2: $prom =6;break;
    case 3: $prom =6;break;
    case 4: $prom =5.5;break;
    case 5: $prom =7;break;
    }break;
    case 2:
    switch ($raza) {
    case 1: $prom =8;break;
    case 2: $prom =7.5;break;
    case 3: $prom =7.5;break;
    case 4: $prom =7;break;
    case 5: $prom =8.5;break;
    }break;
    case 3:
    switch ($raza) {
    case 1: $prom =10;break;
    case 2: $prom =9.5;break;
    case 3: $prom =9.5;break;
    case 4: $prom =9;break;
    case 5: $prom =10.5;break;
    }break;
    case 4:
    switch ($raza) {
    case 1: $prom =8;break;
    case 2: $prom =7.5;break;
    case 3: $prom =7.5;break;
    case 4: $prom =7;break;
    case 5: $prom =8.5;break;
    }break;
    case 5:
    switch ($raza) {
    case 1: $prom =7;break;
    case 2: $prom =6.5;break;
    case 3: $prom =6.5;break;
    case 4: $prom =6;break;
    case 5: $prom =7.5;break;
    }break;
    case 6:
    switch ($raza) {
    case 1: $prom =8;break;
    case 2: $prom =7.5;break;
    case 3: $prom =7.5;break;
    case 4: $prom =7;break;
    case 5: $prom =8.5;break;
    }break;
    case 7:
    switch ($raza) {
    case 1: $prom =8;break;
    case 2: $prom =7.5;break;
    case 3: $prom =7.5;break;
    case 4: $prom =7;break;
    case 5: $prom =8.5;break;
    }break;
    case 8:
    switch ($raza) {
    case 1: $prom =9.5;break;
    case 2: $prom =9;break;
    case 3: $prom =9;break;
    case 4: $prom =8.5;break;
    case 5: $prom =10;break;
    }break;
    case 9:
    switch ($raza) {
    case 1: $prom =9.5;break;
    case 2: $prom =9;break;
    case 3: $prom =9;break;
    case 4: $prom =8.5;break;
    case 5: $prom =10;break;
    }break;
    case 10:
    switch ($raza) {
    case 1: $prom =6.5;break;
    case 2: $prom =6;break;
    case 3: $prom =6;break;
    case 4: $prom =5.5;break;
    case 5: $prom =7;break;
    }break;
    case 11:
    switch ($raza) {
    case 1: $prom =6.5;break;
    case 2: $prom =6;break;
    case 3: $prom =6;break;
    case 4: $prom =5.5;break;
    case 5: $prom =7;break;
    }break;
    case 12:
    switch ($raza) {
    case 1: $prom =6.5;break;
    case 2: $prom =6;break;
    case 3: $prom =6;break;
    case 4: $prom =5.5;break;
    case 5: $prom =7;break;
    }break;
    case 13:
    switch ($raza) {
    case 1: $prom =6.5;break;
    case 2: $prom =6;break;
    case 3: $prom =6;break;
    case 4: $prom =5.5;break;
    case 5: $prom =7;break;
    }break;
    case 14:
    switch ($raza) {
    case 1: $prom =6.5;break;
    case 2: $prom =6;break;
    case 3: $prom =6;break;
    case 4: $prom =5.5;break;
    case 5: $prom =7;break;
    }break;
    case 15:
    switch ($raza) {
    case 1: $prom =9.5;break;
    case 2: $prom =9;break;
    case 3: $prom =9;break;
    case 4: $prom =8.5;break;
    case 5: $prom =10;break;
    }break;
    default: $prom = 7;break;}

   switch ($raza) {case 1:$raza='HUMANO';break;case 2:$raza='ELFO';break;case 3:$raza='ELFO OSCURO';break;case 4:$raza='GNOMO';break;case 5:$raza='ENANO';break;default:$raza='HUMANO';break;}

    $ideal = intval($prom * ($nivel - 1) + 20);//floor($prom * $nivel) + 15;
    $ups = $max_hp - $ideal;  

    switch ($clase) {case 1:$clase="MAGO";break;case 2:$clase="CLERIGO";break;case 3:$clase="GUERRERO";break;case 4:$clase="ASESINO";break;case 5:$clase="LADRON";break;case 6:$clase="BARDO";break;case 7:$clase="DRUIDA";break;case 8:$clase="PALADIN";break;case 9:$clase="CAZADOR";break;case 10:$clase="PESCADOR";break;case 11:$clase="HERRERO";break;case 12:$clase="LEÑADOR";break;case 13:$clase="MINERO";break;case 14:$clase="CARPINTERO";break;case 15:$clase="PIRATA";break;default:$clase="DESCONOCIDA";break;}

    switch ($genero) {case 1:$genero="HOMBRE";break;default:$genero="MUJER";break;}

        $nick=strtoupper($nick);
        $nick=trim($nick);
             
        $sql = "SELECT id FROM user WHERE nick = ?";

        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, 's', $nick);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if (!mysqli_num_rows($result) > 0) {    
            include $_SERVER['DOCUMENT_ROOT']. '/cuentas/agregar_personaje_db.php';
            exit();
        }

        $row = mysqli_fetch_assoc($result);
        $UserIndex = $row['id'];

        $sql = 'UPDATE user SET account_id = ?, nivel = ?, pin = ?, password = ?, email = ?, `exp` = ?, clase = ?, raza = ?, genero = ?, logged = ?, min_hp = ?, max_hp = ?, min_man = ?, max_man = ?, elu = ?, ciudas_matados = ?, crimis_matados = ?, criaturas_matadas = ?, privilegios = ?, carceltime = ?, clan = ?, total_matados = ?, oro = ?, boveda = ?, posicion = ?, lastip = ?, asesino = ?, noble = ?, burgue = ?, bandido = ?, plebe = ?, ladron = ?, retos_ganados = ?, retos_perdidos = ?, retos_oro_perdido = ?, retos_oro_ganado = ?, is_locked_in_mao = ?, skillslibres = ?, ups = ?, ban = ?, totpenas = ?, puntosfotodenuncia = ?, participoclanes = ?, fundoclan = ?, disolvioclan = ?, unbandate = ?, mao_index = ?, locked = ?, status= ? WHERE nick = ?';

        $stmt = mysqli_stmt_init($conn);
        //echo 'Agregar Pj='.$nick .'|';

        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo 'user:'.$stmt->error;
            exit();
        } else {            
            
            mysqli_stmt_bind_param($stmt, "iisssssssiiiiiiiiiiisiiissiiiiiiiiiiiiiiiiisssiiis", $account_id, $nivel, $pin, $pass, $email, $exp, $clase, $raza, $genero, $logged, $min_hp, $max_hp, $min_man, $max_man, $elu, $ciudas_matados, $crimis_matados, $criaturas_matadas, $privilegios, $carceltime, $clan, $total_matados, $oro, $boveda, $posicion, $lastip, $asesino, $noble, $burgue, $bandido, $plebe, $ladron, $retos_ganados, $retos_perdidos, $retos_oro_perdido, $retos_oro_ganado, $is_locked_in_mao, $skillslibres, $ups, $ban, $totpenas, $puntosfotodenuncia, $participoclanes, $fundoclan, $disolvioclan, $unbandate, $mao_index, $locked, $status, $nick);
            mysqli_stmt_execute($stmt);
            if (strlen($stmt->error) > 0) echo 'error:'.$stmt->error;
            
            $sql = "UPDATE attribute SET strength=?, agility=?, intelligence=?, constitution=?, charisma=?
            WHERE user_id=?";
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'attribute:'.$stmt->error;
                //exit();
            } else {
                mysqli_stmt_bind_param($stmt, "iiiiii",$attrib[1],$attrib[2],$attrib[3],$attrib[4],$attrib[5],$UserIndex);
                mysqli_stmt_execute($stmt);
            }
            // BANCO = 40
            $current=0;
            for ($i=0; $i < 40; $i++) {
                $sql = "UPDATE bank_item SET item_id=?,amount=? WHERE user_id=? and number=?";
                $current++;
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo 'bank_item:'.$stmt->error;
                    //exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "iiii", $bov[$current], $bovamount[$current], $UserIndex, $current);
                    mysqli_stmt_execute($stmt);
                }
            } 
            // BANCO = 40

            // INVENTORY = 30
            $current=0;
            for ($i=0; $i < 30; $i++) {
                $sql = "UPDATE inventory_item SET item_id=?,amount=?,is_equipped=? WHERE user_id=? AND number=?";
                $current++;
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo 'inventory_item:'.$stmt->error;
                    //exit();
                } else {                    
                    mysqli_stmt_bind_param($stmt, "iiiii", $inv[$current], $invamount[$current], $invequipped[$current], $UserIndex, $current);
                    mysqli_stmt_execute($stmt);
                }
            }
            // INVENTORY = 30

            // SKILLS = 21
            $current=0;
            for ($i=0; $i < 21; $i++) {
                $sql = "UPDATE skillpoint SET value=? WHERE user_id=? AND number=?";
                $stmt = mysqli_stmt_init($conn);
                $current++;
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo 'skillpoint:'.$stmt->error;
                    //exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "iii", $skills[$current], $UserIndex, $current);
                    mysqli_stmt_execute($stmt);
                }
            }
            // SKILLS = 21
            
            // SPELLS = 35
            $current=0;
            for ($i=0; $i < 35; $i++) {
                $sql = "UPDATE spell SET spell_id=? WHERE user_id=? AND number=?";
                $stmt = mysqli_stmt_init($conn);
                $current++;
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo 'spell:'.$stmt->error;
                    //exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "iii", $spells[$current], $UserIndex, $current);
                    mysqli_stmt_execute($stmt);
                }
            }
            // SPELLS

            // PENAS = 8
            $current=0;
            for ($i=0; $i < 8; $i++) {
                $sql = "UPDATE punishment  SET reason=? WHERE user_id=? AND number=?";
                $stmt = mysqli_stmt_init($conn);
                $current++;
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo 'punishment:'.$stmt->error;
                    //exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "sii",$penas[$current], $UserIndex, $current);
                    mysqli_stmt_execute($stmt);
                }
            }
            // PENAS
            
            //echo 'PJ Updateado' .$nick;
        
            //return $UserIndex;
            mysqli_stmt_close($stmt);
        }
    }
}
