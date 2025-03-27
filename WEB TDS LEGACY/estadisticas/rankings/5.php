<?php                    
            if (session_status() === PHP_SESSION_NONE) {session_start();}
            require $_SERVER['DOCUMENT_ROOT'].'/DB/env.php'; 
            require $_SERVER['DOCUMENT_ROOT'].'/DB/db.inc.php'; 
            $conn = connect();
            
            $result = $conn->query('SELECT * FROM user WHERE privilegios = 1 AND clase="DRUIDA" ORDER BY nivel DESC LIMIT 50');

            $rankingPosition=1;
            // iterar sobre cada fila del resultado
            while ($row = $result->fetch_assoc()) {
                // determinar la clase CSS a usar según el puesto en el ranking
                switch ($rankingPosition) {
                    case 1:
                        $cssClass = 'primer_puesto';
                        $medal = 'oro';
                        break;
                    case 2:
                        $cssClass = 'segundo_puesto';
                        $medal = 'plata';
                        break;
                    case 3:
                        $cssClass = 'tercer_puesto';
                        $medal = 'bronce';
                        break;
                    default:
                        $cssClass = 'puesto';
                        $medal = '';
                        break;
                }

                // mostrar los datos de la fila en el formato especificado
                echo '<div class="' . $cssClass . '"><ul>';
                if ($medal) {
                    echo '<li class="' . $medal . '"><span style="visibility:hidden;">' . $medal[0] . '</span></li>';
                } else {
                    echo '<li class="nro">' . $rankingPosition . 'º</li>';
                }
                echo '<li class="nick"><a rel="nofollow" href="mini_estadisticas.php?nick=' . $row['nick'] . '" title="Ver estadísticas de ' . $row['nick'] . '">' . $row['nick'] . '</a></li>';
                echo '<li class="lvl">' . $row['nivel'] . '</li>';
                echo '<li class="raza">' . $row['raza'] . '</li>';
                echo '<li class="clan">' . $row['clan'] . '</li>';
                echo '</ul></div>';

                // incrementar el contador para el próximo puesto en el ranking
                $rankingPosition++;
            }
         
         ?>


