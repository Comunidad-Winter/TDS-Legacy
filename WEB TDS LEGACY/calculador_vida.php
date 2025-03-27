<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - Calculador de promedios de vida</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor TDS Legacy, Server TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
    <!--[if lt IE 7.]>
        <script defer type='text/javascript' src='/scripts/pngfix.js'></script>
        <![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/calculador.css' rel='stylesheet' type='text/css' />
    <script type='text/javascript' src='/scripts/calcu_vida.js'></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body onload="init();">
    <div id='bg_top'>
        <div id='pagina'>
            <div id='header'>
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'>
                    <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' />
                </div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1>Calculador de vida y promedio</h1>
            </div>
            <div id='main'>
                <div id="calculador">
                    <a name="res" id="res"></a>
                    <div id="resultados" style="display:none">
                        <h3>Resultados:</h3>
                        <h4>
                            <strong id="mi_pj">-- --</strong> nivel
                            <strong id="mi_nivel">35</strong> con
                            <strong id="mi_vida">--</strong> de vida</h4>
                        <p>El promedio de vida de tu personaje es
                            <span id="prom_real" class="nro">--</span>
                        </p>
                        <p>El promedio de vida que deber&iacute;as tener es
                            <span id="prom_ideal" class="nro">--</span>
                        </p>
                        <p>Tu personaje deber&iacute;a tener
                            <span id="vida_ideal" class="nro">--</span> de vida para estar en el promedio justo.</p>
                        <p id="conclusion" class="msg"></p>
                    </div>
                    <h2>Calcul&aacute; la vida y el promedio de tu personaje</h2>
                    <div class="contenedor">
                        <form action="" name="calc" onsubmit="return false" id="calc" method="post">
                            <div class="elegiRaza">
                                <h3>Eleg&iacute; tu Raza</h3>
                                <p>
                                    <a href="#Humano" id="r1" onclick="return selectRaza('1')" class="cHumano">Humano</a>
                                </p>
                                <p>
                                    <a href="#Elfo" id="r2" onclick="return selectRaza('2');" class="cElfo">Elfo</a>
                                </p>
                                <p>
                                    <a href="#ElfoOscuro" id="r3" onclick="return selectRaza('3');" class="cEo">Elfo
                                        Oscuro</a>
                                </p>
                                <p>
                                    <a href="#Enano" id="r5" onclick="return selectRaza('5');" class="cEnano">Enano</a>
                                </p>
                                <p>
                                    <a href="#Gnomo" id="r4" onclick="return selectRaza('4');" class="cGnomo">Gnomo</a>
                                </p>
                                <input type="hidden" name="raza" id="raza" />
                            </div>
                            <div class="elegiClase">
                                <h3>Eleg&iacute; tu Clase</h3>
                                <div class="izq">
                                    <p>
                                        <label>
                                            <input name="clase" type="radio" value="4" checked="checked" /> Asesino
                                        </label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="6" /> Bardo</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="14" /> Carpintero</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="9" /> Cazador</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="2" /> Cl&eacute;rigo</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="7" /> Druida</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input name="clase" type="radio" value="3" /> Guerrero</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input name="clase" type="radio" value="11" /> Herrero</label>
                                    </p>
                                </div>
                                <div class="izq">
                                    <p>
                                        <label>
                                            <input name="clase" type="radio" value="12" /> Le&ntilde;ador</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="1" /> Mago</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="13" /> Minero</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="8" /> Palad&iacute;n</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input type="radio" name="clase" value="10" /> Pescador</label>
                                    </p>
                                    <p>
                                        <label>
                                            <input name="clase" type="radio" value="15" /> Pirata</label>
                                    </p>
                                </div>
                            </div>
                            <div class="clear">
                                <div class="submit">
                                    <p>
                                        <label for="vida" style="vertical-align:middle;">Vida</label>
                                        <input type="text" value="0" name="vida" id="vida" class="input" maxlength="3" />
                                    </p>
                                    <p>
                                        <label for="nivel">Nivel</label>
                                        <input type="text" value="0" name="nivel" id="nivel" class="input" maxlength="2" />
                                    </p>
                                    <p>
                                        <a href="#res" onclick="calcular()" class="botonCalcu">Calcular</a>
                                    </p>
                                    <div class="clear"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <script type="text/javascript">selectRaza('1');</script>
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>