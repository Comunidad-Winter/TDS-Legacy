<?php

    $str="";
    $tot=0;
    $creado=false;

    $sql = 'INSERT INTO user (nick, nivel, pin, password, email, exp, clase, raza, genero, logged, min_hp, max_hp, min_man, max_man, elu, ciudas_matados, crimis_matados, criaturas_matadas, privilegios, carceltime, clan, total_matados, oro, boveda, posicion, lastip, asesino, noble, burgue, bandido, plebe, ladron, retos_ganados, retos_perdidos, retos_oro_perdido, retos_oro_ganado, is_locked_in_mao, skillslibres, ups, ban, totpenas, puntosfotodenuncia, participoclanes, fundoclan, disolvioclan, unbandate, mao_index, locked, status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

    $stmt = mysqli_stmt_init($conn);

    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo 'user:'.$stmt->error;
        exit();
    } else {            
        
        mysqli_stmt_bind_param($stmt, 'sisssssssiiiiiiiiiiisiiissiiiiiiiiiiiiiiiiisssiii', $nick, $nivel, $pin, $pass, $email, $exp, $clase, $raza, $genero, $logged, $min_hp, $max_hp, $min_man, $max_man, $elu, $ciudas_matados, $crimis_matados, $criaturas_matadas, $privilegios, $carceltime, $clan, $total_matados, $oro, $boveda, $posicion, $lastip, $asesino, $noble, $burgue, $bandido, $plebe, $ladron, $retos_ganados, $retos_perdidos, $retos_oro_perdido, $retos_oro_ganado, $is_locked_in_mao, $skillslibres, $ups, $ban, $totpenas, $puntosfotodenuncia, $participoclanes, $fundoclan, $disolvioclan, $unbandate, $mao_index, $locked,$status);
        mysqli_stmt_execute($stmt);
        if (strlen($stmt->error) > 0) echo '$stmt->error:'.$stmt->error;
        
        $UserIndex =$conn->insert_id;
        if (!($UserIndex) > 0 ) {
            echo '$UserIndex=0 '.$nick;
            exit();
        }

        $sql = "INSERT INTO attribute (user_id, strength, agility, intelligence, constitution, charisma) VALUES (?,?,?,?,?,?)";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo 'attribute:'.$stmt->error;
            exit();
        } else {
            mysqli_stmt_bind_param($stmt, "iiiiii", $UserIndex ,$attrib[1],$attrib[2],$attrib[3],$attrib[4],$attrib[5]);
            mysqli_stmt_execute($stmt);
        }

        // BANCO = 40
        $current=0;
        for ($i=0; $i < 40; $i++) {
            $sql = "INSERT INTO bank_item (user_id, number,item_id,amount) VALUES (?,?,?,?)";
            $current++;
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'bank_item:'.$stmt->error;
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "iiii", $UserIndex, $current, $bov[$current], $bovamount[$current]);
                mysqli_stmt_execute($stmt);
            }
        } 
        // BANCO = 40

        // INVENTORY = 30
        $current=0;
        for ($i=0; $i < 30; $i++) {
            $sql = "INSERT INTO inventory_item (user_id, number,item_id,amount,is_equipped) VALUES (?,?,?,?,?)";
            $current++;
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'inventory_item:'.$stmt->error;
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "iiiii", $UserIndex, $current, $inv[$current], $invamount[$current], $invequipped[$current]);
                mysqli_stmt_execute($stmt);
            }
        }
        // INVENTORY = 30

        // SKILLS = 21
        $current=0;
        for ($i=0; $i < 21; $i++) {
            $sql = "INSERT INTO skillpoint (user_id,number,value) VALUES (?,?,?)";
            $stmt = mysqli_stmt_init($conn);
            $current++;
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'skillpoint:'.$stmt->error;
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "iii", $UserIndex, $current, $skills[$current]);
                mysqli_stmt_execute($stmt);
            }
        }
        // SKILLS = 21
        
        // SPELLS = 35
        $current=0;
        for ($i=0; $i < 35; $i++) {
            $sql = "INSERT INTO spell (user_id, number,spell_id) VALUES (?,?,?)";
            $stmt = mysqli_stmt_init($conn);
            $current++;
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'spell:'.$stmt->error;
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "iii", $UserIndex, $current, $spells[$current]);
                mysqli_stmt_execute($stmt);
            }
        }
        // SPELLS

        // PENAS = 8
        $current=0;
        for ($i=0; $i < 8; $i++) {
            $sql = "INSERT INTO punishment (user_id, number,reason) VALUES (?,?,?)";
            $stmt = mysqli_stmt_init($conn);
            $current++;
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'punishment:'.$stmt->error;
                exit();
            } else {
                mysqli_stmt_bind_param($stmt, "isi", $UserIndex, $current, $penas[$current]);
                mysqli_stmt_execute($stmt);
            }
        }
        // SPELLS
        
       $creado=true;
        mysqli_stmt_close($stmt);
        exit();
    }