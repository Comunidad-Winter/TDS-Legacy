<?php

// no se está usando todavía

if (isset($_POST['AgregarMAO'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();
     
    foreach($_POST as $key => $value){

        $_POST[$key] = _cleaninjections(trim($value));
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
    
    $nick = strtoupper($_POST['nick']);
    $account_id = intval($_POST['account_id']); 
    $tipo = $_POST['tipo']; 
    $deposito = $_POST['deposito'];
    $oro = abs(intval($_POST['oro'])); 
    $requisitos = $_POST['requisitos']; 
    $contrasena = $_POST['candado']; 
    $pjs = $_POST['pjs']; 
    
    if (empty($nick) || empty($pass) || empty($email) || empty($email)) {
        exit();
    } else if (!preg_match("/[^a-zA-Z\s]+/", $nick)) {
        exit();
    } else if (strlen($pass) < 2 ) {
        exit();
    } else if (strlen($pin) < 2 ) {
        exit();
    } else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        exit();
    }else {
            
        // existe ese pj?
        $sql = "SELECT * FROM mercado WHERE pjs=?;";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) {
            exit();
        }else {
            mysqli_stmt_bind_param($stmt, "s", $nick);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);

            if ($rowpj = mysqli_fetch_assoc($result)) {
               
                //update
                $sql = 'UPDATE user set pin=?,password=?,email=?,account_id=?,nivel=?,exp=?,clase=?,raza=?,genero=?,logged=?,min_hp=?,max_hp=?,min_man=?,max_man=?,elu=?,ciudas_matados=?,crimis_matados=?,criaturas_matadas=?,privilegios=?,carceltime=?,clan=?,total_matados=?,oro=?,boveda=?,posicion=?,lastip=?,asesino=?,noble=?,burgue=?,bandido=?,plebe=?,ladron=?,retos_ganados=?,retos_perdidos=?,retos_oro_perdido=?,retos_oro_ganado=?,is_locked_in_mao=?,skillslibres=?,ups=?,ban=?,totpenas=?,puntosfotodenuncia=?,participoclanes=?,fundoclan=?,disolvioclan=?,unbandate=?,mao_index=?  WHERE nick=?;';

                $stmt = mysqli_stmt_init($conn);

                if (!mysqli_stmt_prepare($stmt, $sql)) { 
                    //echo (htmlspecialchars($stmt->error));
                    exit();
                }else{
                    mysqli_stmt_bind_param($stmt, "sssiiisssiiiiiiiiiiisiiissiiiiiiiiiiiiiiiiisssis",$pin,$pass,$email,$account_id,$nivel,$exp,$clase,$raza,$genero,$logged,$min_hp,$max_hp,$min_man,$max_man,$elu,$ciudas_matados,$crimis_matados,$criaturas_matadas,$privilegios,$carceltime,$clan,$total_matados,$oro,$boveda,$posicion,$lastip,$asesino,$noble,$burgue,$bandido,$plebe,$ladron,$retos_ganados,$retos_perdidos,$retos_oro_perdido,$retos_oro_ganado,$is_locked_in_mao,$skillslibres,$ups,$ban,$totpenas,$puntosfotodenuncia,$participoclanes,$fundoclan,$disolvioclan,$unbandate,$mao_index,$nick);
                    mysqli_stmt_execute($stmt);

                }
                exit();
            }

        $sql = "insert into user(pin, password, email,account_id,nivel,exp,clase,raza,genero,logged,min_hp,max_hp,min_man,max_man,elu,ciudas_matados,crimis_matados,criaturas_matadas,privilegios,carceltime,clan,total_matados,oro,boveda,posicion,lastip,asesino,noble,burgue,bandido,plebe,ladron,retos_ganados,retos_perdidos,retos_oro_perdido,retos_oro_ganado,is_locked_in_mao,skillslibres,ups,ban,totpenas,puntosfotodenuncia,participoclanes,fundoclan,disolvioclan,nick) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) { 
            echo (htmlspecialchars($stmt->error));
            exit();
        }else{
            mysqli_stmt_bind_param($stmt, "sssiiisssiiiiiiiiiiisiiissiiiiiiiiiiiiiiiiissis",$pin,$pass,$email,$account_id,$nivel,$exp,$clase,$raza,$genero,$logged,$min_hp,$max_hp,$min_man,$max_man,$elu,$ciudas_matados,$crimis_matados,$criaturas_matadas,$privilegios,$carceltime,$clan,$total_matados,$oro,$boveda,$posicion,$lastip,$asesino,$noble,$burgue,$bandido,$plebe,$ladron,$retos_ganados,$retos_perdidos,$retos_oro_perdido,$retos_oro_ganado,$is_locked_in_mao,$skillslibres,$ups,$ban,$totpenas,$puntosfotodenuncia,$participoclanes,$fundoclan,$disolvioclan,$mao_index,$nick);
            mysqli_stmt_execute($stmt);
        } 

        $UserIndex =$conn->insert_id;

        if (!($UserIndex) > 0 ) {
            exit();
        }
        
        // ATRIBUTOS = 5
        $sql = "insert into attribute(user_id, strength, agility, intelligence, constitution, charisma) values (?,?,?,?,?,?)";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            exit();
        }else{
            mysqli_stmt_bind_param($stmt, "iiiiii", $UserIndex ,$attrib[1],$attrib[2],$attrib[3],$attrib[4],$attrib[5]);
            mysqli_stmt_execute($stmt);                
        }
        // ATRIBUTOS = 5


        // BANCO = 40
        $current=0;
        for ($i=0; $i < 40; $i++) { 
            $sql = "insert into bank_item(user_id, number,item_id,amount) values (?,?,?,?)";
            $current++;
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                exit();
            }else{
                mysqli_stmt_bind_param($stmt, "iiii",$UserIndex, $current,$bov[$current],$bovamount[$current]);
                mysqli_stmt_execute($stmt);                
            }
        }        
        // BANCO = 40


        // INVENTORY = 30
        $current=0;
        for ($i=0; $i < 30; $i++) { 
            $sql = "insert into inventory_item(user_id, number,item_id,amount,is_equipped) values (?,?,?,?,?)";
            $current++;        
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                exit();
            }else{
                mysqli_stmt_bind_param($stmt, "iiiii",$UserIndex, $current,$inv[$current],$invamount[$current],$invequipped[$current]);
                mysqli_stmt_execute($stmt);                
            }
        }   
        // INVENTORY = 30


        // SKILLS = 21
        $current=0;
        for ($i=0; $i < 21; $i++) { 
            $sql = "insert into skillpoint(user_id,number,value) values (?,?,?)";
            $stmt = mysqli_stmt_init($conn);
            $current++;
            if (!mysqli_stmt_prepare($stmt, $sql)) {

                exit();
            }else{
                mysqli_stmt_bind_param($stmt, "iii",$UserIndex, $current,$skills[$current]);
                mysqli_stmt_execute($stmt);                
            }
        }
        // SKILLS = 21
        

        // SPELLS = 35
        $current=0;
        for ($i=0; $i < 35; $i++) { 
            $sql = "insert into spell(user_id, number,spell_id) values (?,?,?)";
            $stmt = mysqli_stmt_init($conn);
            $current++;
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                exit();
            }else{
                mysqli_stmt_bind_param($stmt, "iii",$UserIndex, $current,$spells[$current]);
                mysqli_stmt_execute($stmt);                
            }
        }
        // SPELLS


        // PENAS = 8
        $current=0;
        for ($i=0; $i < 8; $i++) { 
            $sql = "insert into punishment(user_id, number,reason) values (?,?,?)";
            $stmt = mysqli_stmt_init($conn);
            $current++;
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                exit();
            }else{
                mysqli_stmt_bind_param($stmt, "iis",$UserIndex, $current,$penas[$current]);
                mysqli_stmt_execute($stmt);                
            }
        }
        // SPELLS
        
        return $UserIndex;
        mysqli_stmt_close($stmt);
        exit();
        }
    }
}
