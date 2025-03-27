<?php                    
            require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
            $conn = connect();

            $clase=1;
 
            if (isset($_GET['clase'])) {
                $clase=intval($_GET['clase']);
                if ($clase > 15 || $clase <1 ) {
                    $clase=1;
                }
            }

            $clases = array();
            $clases[1] = "MAGO";
            $clases[2] = "CLERIGO";
            $clases[3] = "GUERRERO";
            $clases[4] = "ASESINO";
            $clases[5] = "LADRON";
            $clases[6] = "DRUIDA";
            $clases[7] = "BARDO";
            $clases[8] = "PALADIN";
            $clases[9] = "CAZADOR";
            $clases[10] = "PESCADOR";
            $clases[11] = "HERRERO";
            $clases[12] = "LEÑADOR";
            $clases[13] = "MINERO";
            $clases[14] = "CARPINTERO";
            $clases[15] = "PIRATA";
            
            $result = $conn->query('SELECT * FROM user WHERE privilegios = 1 AND clase="'.$clases[$clase].'" ORDER BY nivel DESC LIMIT 50');

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


