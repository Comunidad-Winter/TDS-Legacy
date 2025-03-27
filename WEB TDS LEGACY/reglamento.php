<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>AO Legacy - Reglamento Oficial del servidor</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
    <!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/reglamento.css' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body id="seccion_reglamento" onload="init();">
    <div id='bg_top'>
        <div id='pagina'>
            <div id='header'>
                <div id="animation_container" style="background:none; width:700px; height:197px"> <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;"> </div>
                </div>
                <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'> <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1><a href="#indice">Reglamento oficial</a></h1>
            </div>
            <div id='main'>
                <div id='contenido'>
                    <div class='caja_margen'>
                        <div class='caja'>
                            <div class='caja_shadow_t'>
                                <div class='caja_shadow_b'>
                                    <div class='caja_l'>
                                        <div class='caja_r'>
                                            <div class='caja_t'>
                                                <div class='caja_b'>
                                                    <div class='contenido_reglamento'>
                                                        <h1><a name="indice">Legacy</a></h1>
                                                        <h2>Reglamento oficial del servidor</h2>
                                                        <div class="menu_reglamento">
                                                            <h3>&Iacute;ndice</h3>
                                                            <ul class="ul_links">
                                                                <li><a href="#r1">1 Acerca del Reglamento de AOI</a></li>
                                                                <li class="subli"><a href="#r1.1">1.1 Validez del reglamento</a></li>
                                                                <li class="subli"><a href="#r1.2">1.2 Reglas y sus Actualizaciones</a></li>
                                                                <li><a href="#r2">2 Reglamento del usuario</a></li>
                                                                <li class="subli"><a href="#r2.1">2.1 Creac&oacute;n de personajes</a></li>
                                                                <li class="subli"><a href="#r2.2">2.2 Reglamentaci&oacute;n de los usuarios</a></li>
                                                                <li class="subli"><a href="#r2.3">2.3 Explotaci&oacute;n de bugs y uso de programas externos no autorizados</a></li>
                                                                <li class="subli"><a href="#r2.4">2.4 Actos sancionables</a></li>
                                                                <li class="subli"><a href="#r2.5">2.5 Acusaciones infundadas hacia un miembro del Staff</a></li>
                                                                <li class="subli"><a href="#r2.6">2.6 Comportamiento inadecuado en las redes oficiales</a></li>
                                                                <li class="subli"><a href="#r2.7">2.7 Sanciones especiales</a></li>
                                                                <li class="subli"><a href="#r2.8">2.8 Interferencias con el trabajo del Staff</a></li>
                                                                <li class="subli"><a href="#r2.9">2.9 Respeto entre usuarios</a></li>
                                                                <li class="subli"><a href="#r2.10">2.10 Doble Cliente</a></li>
                                                                <li class="subli"><a href="#r2.11.4">2.11.4 Sistema de Soporte</a></li>
                                                                <li class="subli"><a href="#r2.12">2.12 Expulsiones y Sanciones</a></li>
                                                                <li class="subli"><a href="#r2.12.4">2.12.4 Tolerancia Cero</a></li>
                                                                <li><a href="#r3">3 Reglamentaci&oacute;n de GMs y miembros del Staff</a></li>
                                                                <li class="subli"><a href="#r3.1">3.1 Admisi&oacute;n y permanencia</a></li>
                                                                <li class="subli"><a href="#r3.2">3.2 Manual de procedimientos</a></li>
                                                                <li class="subli"><a href="#r3.3.2">3.3.2 Identidad Reservada</a></li>
                                                                <li><a href="#r4">4 Aclaraciones Importantes</a></li>
                                                                <li><a href="#r5">5 Venta de personajes y comercio entre mismos</a></li>
                                                            </ul>
                                                        </div>
                                                        <ul class="ul_reglamento">
                                                            <li class="titulo">
                                                                <h3><span class="numero">1</span> <a name="r1">Acerca del Reglamento.</a></h3>
                                                            </li>
                                                            <li><span class="numero">1.1</span> <a name="r1.1">Validez del reglamento.</a></li>
                                                            <li class="subli"><span class="numero">1.1.1</span> Este reglamento posee validez desde su publicaci&oacute;n y hasta nuevo aviso, revocando cualquier reglamento anterior.-</li>
                                                            <li class="subli"><span class="numero">1.1.2</span> Por el solo hecho de conectarse a Legacy o descargarse nuestro software, el usuario acepta el deber de dar cumplimiento a las cl&aacute;usulas contenidas en el presente.-
                                                            </li>
                                                            <li><span class="numero">1.2</span> <a name="r1.2">Reglas y sus Actualizaciones.</a></li>
                                                            <li class="subli"><span class="numero">1.2.1</span> El staff de Legacy se reserva el derecho de suprimir, agregar o modificar cl&aacute;usulas del presente reglamento, seg&uacute;n lo crea conveniente, sin necesidad de previo aviso.-</li>
                                                            <li class="subli"><span class="numero">1.2.2</span> El desconocimiento de las reglas aqu&iacute; contenidas o de sus actualizaciones, no podr&aacute; ser invocado, de ning&uacute;n modo, como justificaci&oacute;n frente a un incumplimiento de las mismas.-</li>
                                                            <li class="subli"><span class="numero">1.2.3</span><strong id="docs-internal-guid-1f823e79-6b8b-5305-9067-416c33176e54"> Cuando el reglamento sea actualizado, esto ser&aacute; anunciado en la secci&oacute;n de Noticias de la p&aacute;gina web y en nuestras redes oficiales.</strong> Bastar&aacute;n las simples palabras &quot;Reglamento Actualizado&quot;. Es obligaci&oacute;n del usuario chequear la p&aacute;gina web antes de entrar al juego para confirmar la existencia de modificaciones al presente.
                                                            </li>
                                                        </ul>
                                                        <ul class="ul_reglamento">
                                                            <li class="titulo">
                                                                <h3><span class="numero">2</span> <a name="r2">Reglamentaci&oacute;n de los usuarios.</a></h3>
                                                            </li>
                                                            <li><span class="numero">2.1</span> <a name="r2.1">Creaci&oacute;n de personajes.-</a></li>
                                                            <li class="subli"><span class="numero">2.1.1</span> Los nombres para los personajes del juego pueden surgir de la imaginaci&oacute;n del usuario o bien ser tomados de la historia o la mitolog&iacute;a, pero siempre manteniendo la ambientaci&oacute;n medieval del Juego. <strong>No se permitir&aacute;n nicks que contengan:</strong>
                                                                <ul>
                                                                    <li> Profesiones o actividades sean o no parte del juego. Tampoco elementos que utilicen para una determinada actividad</li>
                                                                    <li>No se podr&aacute; hacer alusi&oacute;n alguna a la "clase" del Personaje o status</li>
                                                                    <li>No se permitir&aacute; alusiones a ning&uacute;n tipo de droga. Tampoco estar&aacute;n permitidos nombres que contengan alusiones raciales de tono discriminatorio, o que hagan referencia a estados f&iacute;sicos o mentales.</li>
                                                                    <li>Tambi&eacute;n ser&aacute;n prohibidos los nombres de los cuales se pueda inferir que hacen clara referencia a alg&uacute;n producto, marca, modelo, empresa o cualquier famoso.</li>
                                                                    <li>Estar&aacute;n prohibidos, adem&aacute;s, los nombres que por su similitud a los de los miembros del Staff pueden prestar a confusiones, o que puedan ser entendidos como una burla hacia los mismos.</li>
                                                                    <li>No se permitir&aacute;n personajes/nicks creados para insultar u hostigar usuarios</li>
                                                                    <li>Estar&aacute;n prohibidos los nicks con decoraciones ajenas al ambiente medieval</li>
                                                                    <li>Tampoco estar&aacute;n permitidos los nombres que hagan alusi&oacute;n a procedencia de alg&uacute;n lugar, provincia, pa&iacute;s o region.</li>
                                                                </ul>
                                                                No se permitir&aacute; ning&uacute;n nick que no sea considerado acorde con la &eacute;poca medieval. En caso de tener un nick invalido el Staff podr&aacute; obligar al usuario a cambiar el nick o banearlo dependiendo el caso.
                                                            </li>
                                                            <li class="sublii"><span class="numero">2.1.2</span> Estas mismas reglas rigen tambi&eacute;n para los nombres que se les asignen a los CLANES.</li>
                                                            <li><span class="numero">2.2</span> <a name="r2.2"> Identificadores Personales.-</a></li>
                                                            <li class="subli"><span class="numero">2.2.1</span> Ser&aacute;n considerados<strong id="docs-internal-guid-1f823e79-6b8e-4e4a-fdab-1385ba8373e8"> &quot;identificadores Personales&quot; </strong>los datos que acrediten a un usuario como due&ntilde;o de un personaje. Los mismos tienen car&aacute;cter de inalterables, no pudiendo ser modificados, salvo en circunstancias excepcionales, y por intermedio del Equipo Oficial de Legacy.-</li>
                                                            <li class="subli"><span class="numero">2.2.2</span> El uso de un <strong id="docs-internal-guid-1f823e79-6b8e-6ac9-3905-93cd2f71c187"> identificador Personal falso o inv&aacute;lido</strong>, provoca que el usuario no tenga forma de probar la propiedad del personaje.</li>
                                                            <li class="subli"><span class="numero">2.2.3</span> Estos identificadores son la &uacute;nica herramienta mediante la cual el usuario puede solicitar cualquier tr&aacute;mite o pedido referente a un personaje; por lo tanto, cualquier hecho o factor que imposibilite al usuario para utilizar su identificador, le quitar&aacute; toda posibilidad de llevar a cabo los mismos.</li>
                                                            <li><span class="numero">2.3</span> <a name="r2.3"><strong id="docs-internal-guid-1f823e79-6b8e-d670-baac-c0981e89fb73">Explotaci&oacute;n de bugs y uso de programas externos y/o hardware no autorizados.-</strong></a></li>
                                                            <li class="subli"><span class="numero">2.3.1</span> Queda terminantemente prohibida la explotaci&oacute;n de cualquier tipo de bug o utilizaci&oacute;n de software y/o hardware externo no autorizado que alteren el normal funcionamiento del juego. Es tambi&eacute;n prohibido el uso de m&aacute;s de un teclado y/o mouse por computadora, as&iacute; como tambi&eacute;n la participaci&oacute;n de m&aacute;s de una persona por computadora.</li>
                                                            <li class="sublii"> Se podr&aacute;n aplicar 3 tipos de penas:</li>
                                                            <li class="subliii"><span class="numero">a)</span>Baneo Permanente</li>
                                                            <li class="subliii"><span class="numero">b)</span>Baneo Temporal</li>
                                                            <li class="subliii"><span class="numero">c)</span> Tolerancia 0</li>
                                                            <li class="sublii"><span class="numero">2.3.1.2</span>Los GMs deber&aacute;n aplicar las penas de acuerdo a lo establecido por el "Sistema de penas" vigente. Los Directivos (Team Manager), por su cargo, poseen la facultad de aplicar sanciones especiales, seg&uacute;n su criterio.-</li>
                                                            <li class="subli"><span class="numero">2.3.2</span> Quienes oculten informaci&oacute;n referente a cualquiera de estos puntos ser&aacute;n considerados c&oacute;mplices y se les podr&aacute; aplicar una pena.</li>
                                                            <li><span class="numero">2.4</span> <a name="r2.4">Actos sancionables:</a></li>
                                                            <li class="subli"><span class="numero">2.4.1</span><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3"> Bloqueos a la libre circulaci&oacute;n.</strong></li>
                                                            <li class="subli"><span class="numero">2.4.1.1</span> Est&aacute; terminantemente prohibido bloquear la libre circulaci&oacute;n de otro usuario por cualquier sector p&uacute;blico del juego con personajes y/o criaturas.
                                                            </li>
                                                            <li class="subli"><span class="numero">2.4.1.2</span> Estar&aacute; prohibido el acomodar las criaturas existentes de modo tal que &eacute;stas bloqueen una salida, paso o entrada, o bien ataquen de modo inmediato a quien entra a un mapa. Estas actitudes se penar&aacute;n en el modo que lo determine el "Sistema de penas" vigente.</li>
                                                            <li class="subli"><span class="numero">2.5</span> <a name="r2.5"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3"> Acusaciones infundadas hacia un miembro del Staff.</strong></a></li>
                                                            <li class="subli"><span class="numero">2.5.1</span> Toda acusaci&oacute;n hacia un miembro del Staff debe ser tratada por Soporte. Aquel usuario que realice p&uacute;blicamente acusaciones hacia un miembro del Staff ser&aacute; pasible de graves sanciones.</li>
                                                            <li class="subli"><span class="numero">2.6</span> <a name="r2.6"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3"> Comportamiento inadecuado en las redes oficiales.</strong> </a></li>
                                                            <li class="sublii"><span class="numero">2.6.1</span> Aquel usuario que a trav&eacute;s de cualquiera de las redes sociales oficiales de AOI falte el respeto a la comunidad, realice acusaciones infundadas y reincida en conductas agresivas, ser&aacute; pasible de graves sanciones por parte del Staff.</li>
                                                            <li class="subli"><span class="numero">2.7</span> <a name="r2.7">Los Directivos del Staff del servidor AOI, a su criterio, podr&aacute;n aplicar sanciones especiales, a los usuarios que, tanto en el juego como en la vida en la comunidad, demuestren un comportamiento y una actitud injustificadamente hostil para con el juego, sus autoridades o su comunidad; como as&iacute; tambi&eacute;n aquellos usuarios que -sin llegar a violar expresamente este reglamento- a trav&eacute;s de sus actos y sus dichos, tanto dentro como fuera del juego, perjudiquen el normal desenvolvimiento de los jugadores, atenten contra la armon&iacute;a de la comunidad, o menoscaben el desarrollo del juego y agravien a su Staff.</li>
                                                            <li class="subli"><span class="numero">2.8</span> <a name="r2.8"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3">Interferencias con el trabajo del Staff.</strong></a></li>
                                                            <li class="sublii"><span class="numero">2.8.1</span>Mientras los GMs y Consejeros se encuentren dentro del juego realizando sus tareas, los usuarios no podr&aacute;n interferir, de ning&uacute;n modo, el libre desarrollo de las mismas.</li>
                                                            <li class="sublii"><span class="numero">2.8.2</span> La utilizaci&oacute;n incorrecta de los comandos que los personajes tienen para tomar contacto con los GMS y/o Consejeros (como ser el /GM y el /DENUNCIAR) que provoque una molestia para el desempeño de los mismos, tambi&eacute;n ser&aacute; sancionada.</li>
                                                            <li class="subli"><span class="numero">2.9</span> <a name="r2.9"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3"> Respeto entre usuarios.</strong></a>
                                                            </li>
                                                            <li class="sublii"><span class="numero">2.9.1</span> Est&aacute; prohibida la utilizaci&oacute;n de insultos y otros t&eacute;rminos insultantes o agresivos entre los usuarios, como as&iacute; tambi&eacute;n las faltas de respeto y las actitudes discriminatorias.
                                                                Ver> Lista de insultos penables (ACTUALIZADA)</li>
                                                            <li class="subli"><span class="numero">2.10</span> <a name="r2.10"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3">Doble Cliente.</strong></a>
                                                            </li>
                                                            <li class="sublii"><span class="numero">2.10.1</span> Al usuario que fuera detectado utilizando dos o m&aacute;s clientes a la vez desde una misma PC o diferentes PCs, es decir una misma y sola persona con dos o m&aacute;s personajes conectados al mismo tiempo, se le aplicar&aacute; la pena de baneo temporal o permanente seg&uacute;n las circunstancias del caso y lo previsto en el "Sistema de penas" vigente.</li>
                                                            <li class="subli"><span class="numero">2.11</span> <a name="r2.11"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3"> Discrepancias con decisiones del Staff del servidor AOI.</strong></a></li>
                                                            <li class="sublii"><span class="numero">2.11.1</span> Frente a una discrepancia con el actuar del Staff, los usuarios tendr&aacute;n derecho a presentar su opini&oacute;n o descargo.</a>
                                                            </li>
                                                            <li class="subli"><span class="numero">2.11.2</span> <a name="r2.11.2">Los descargos de los usuarios deben referirse espec&iacute;ficamente a la pena que se les aplic&oacute;. Los descargos que se refieran a otros usuarios y a la aplicaci&oacute;n o no aplicaci&oacute;n de penas, a &eacute;stos, como argumento para evitar la propia sanci&oacute;n, son inv&aacute;lidos. El usuario DEBE REFERIRSE A SUS PROPIOS ACTOS CON SU PROPIO PERSONAJE, no a los de terceros.</a></li>
                                                            <li class="sublii"><span class="numero">2.11.3</span> En caso de hacerse menci&oacute;n a una falta al procedimiento por parte de un GM o miembro del Staff, la misma debe estar correctamente acreditada y detallada indicando la hora y fecha del hecho; el usuario tambi&eacute;n debe especificar las reglas quebrantadas por parte del GM o miembro del Staff.
                                                            </li>
                                                            <li class="subli"><span class="numero">2.11.4</span> <a name="r2.11.4">Los canales de contacto con el Staff de GMs que conlleven la manipulaci&oacute;n de datos sensibles son &uacute;nicamente el sistema de de soporte. Cualquier otro contacto por foros, mensajer&iacute;a privada, chat, etc.- no tendr&aacute; car&aacute;cter oficial. Los DSGMs podr&aacute;n establecer cualquier otro canal seg&uacute;n lo crean necesario.</a></li>
                                                            <li class="sublii"><span class="numero">2.11.5</span> Cualquier queja o descargo deber&aacute; realizarse teniendo en cuenta que el Staff se reserva, de modo absoluto, los derechos de admisi&oacute;n y permanencia, raz&oacute;n por lo cual el usuario no tendr&aacute; derecho a plantear ninguna exigencia.
                                                            </li>
                                                            <li class="sublii"><span class="numero">2.12</span><a name="r2.12"><strong id="docs-internal-guid-1f823e79-6bb8-fbd1-ea90-1c52132bb86b"> Expulsiones y Sanciones.</strong>.-</li>
                                                            <li class="subli"><span class="numero">2.12.1</span> Los GMs pueden bloquear a usuarios seg&uacute;n les sea necesario para conducir investigaciones, resolver conflictos o aplicar penas.</a></li>
                                                            <li class="sublii"><span class="numero">2.12.2</span> El Staff no est&aacute; obligado a sancionar sistem&aacute;ticamente y de manera inmediata a todos los usuarios que cometen una falta, si no que lo har&aacute;n de acuerdo a su tiempo, su convencimiento y disponibilidad para verificar los hechos y aplicar la sanci&oacute;n, pudiendo, adem&aacute;s, valorar en cada caso concreto las circunstancias especiales que contenga. Por ello podr&aacute; ocurrir que un personaje sea sancionado por un hecho que cometi&oacute; tiempo atr&aacute;s, sin que tenga por ello derecho a queja.
                                                            </li>
                                                            <li class="sublii"><span class="numero">2.12.3</span>El Staff de GMs no aceptar&aacute; capturas de im&aacute;genes o videos personales como pruebas &uacute;tiles para aplicar sanciones, sino simplemente como herramientas de denuncia tendientes a reforzar la vigilancia sobre el denunciado.
                                                            </li>
                                                            <li class="subli"><span class="numero">2.12.4</span> <a name="r2.12.4"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3">"Tolerancia Cero"</strong>: Las consecuencias de la aplicaci&oacute;n de esta pena sobre un usuario son las siguientes:
                                                                    <ul>
                                                                        <li> Baneo definitivo de todos personajes que se puedan determinar que son de su propiedad.</li>
                                                                        <li>Inhabilitaci&oacute;n de la Ip del infractor para ingresar al juego.</li>
                                                                        <li> En lo sucesivo se banear&aacute; cualquier personaje que, creado con posterioridad a la sanci&oacute;n, se pueda determinar que es del usuario en cuesti&oacute;n.</li>
                                                                        <li>Se sancionar&aacute; al personaje que se encuentre siendo usado por el usuario, sin importar a qui&eacute;n pertenezca el mismo.</li>
                                                                    </ul>
                                                                </a></li>
                                                            <li class="sublii"><span class="numero">2.12.5</span> El alcance de la aplicaci&oacute;n de esta pena puede ser morigerada por los DSGMs, seg&uacute;n las circunstancias del caso.</li>
                                                        </ul>
                                                        <ul class="ul_reglamento">
                                                            <li class="titulo">
                                                                <h3><span class="numero">3</span> <a name="r3">Reglamentaci&oacute;n de GMs y miembros del Staff.</a></h3>
                                                            </li>
                                                            <li><span class="numero">3.1</span> <a name="r3.1"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3">Admisi&oacute;n y permanencia.</strong></a></li>
                                                            <li class="subli"><span class="numero">3.1.1</span> Los DSGMs (Directores Staff de GMs) decidir&aacute;n, seg&uacute;n su criterio, la admisi&oacute;n y permanencia de los GMs y Consejeros.</li>
                                                            <li class="subli"><span class="numero">3.1.2</span> Ning&uacute;n miembro del Staff, GM o Consejero, tiene derecho a reclamar por su permanencia en el Staff, ni a pedir pruebas o razones por las cuales se determin&oacute; su exclusi&oacute;n.</li>
                                                            <li class="subli"><span class="numero">3.2</span> <a name="r3.2"><strong id="docs-internal-guid-1f823e79-6b95-be41-a166-32b931efcfd3">Manual de procedimientos.</strong></a></li>
                                                            <li class="sublii"><span class="numero">3.2.1</span> La forma en que los GMs y Consejeros act&uacute;en ser&aacute; determinada por un reglamento, llamado "Manual de Procedimientos", en el cual se determinar&aacute;n qu&eacute; procedimientos deber&aacute;n seguirse frente a determinados sucesos o hechos. Contendr&aacute;, tambi&eacute;n, aclaraciones a este reglamento, por lo cual debe considerarse parte integrante del mismo, y ser respetado como tal.</li>
                                                            <li class="sublii"><span class="numero">3.3.1</span> Los GMs y Consejeros se comprometen a mantener en confidencialidad la informaci&oacute;n a la que accedieron en virtud de su puesto, y que por su naturaleza no debe ser divulgada p&uacute;blicamente.</li>
                                                            <li class="subli"><span class="numero">3.3.2</span> <a name="r3.3.2">Tanto los GMs como los Consejeros podr&aacute;n mantener su identidad en secreto, siendo responsabilidad de &eacute;stos, que la misma se mantenga de ese modo.</a></li>
                                                            <li class="sublii"><span class="numero">3.3.1</span> Los GMs, Consejeros y Rolemasters deben ser los primeros en respetar las reglas de convivencia; deben utilizar un lenguaje acorde a las situaciones y en ning&uacute;n momento podr&aacute;n insultar, ni utilizar lenguaje vulgar.-</li>
                                                            <li class="subli"><span class="numero">3.4.1</span> Los GMs y Consejeros deber&aacute;n informar toda falta a cualquier procedimiento o al reglamento por parte de un compañero, o ser&aacute; considerado encubrimiento. Pero de ninguna manera deber&aacute;n marcar esa falta por cuenta propia, la misma simplemente deber&aacute; ser reportada a los DSGMS.</li>
                                                        </ul>
                                                        <ul class="ul_reglamento">
                                                            <li class="titulo">
                                                                <h3><span class="numero">4</span> <a name="r4">Aclaraciones Importantes.</a></h3>
                                                            </li>
                                                            <li><span class="numero">4.1</span> El Staff del Servidor AOI, se reserva el derecho de admisi&oacute;n y permanencia de los usuarios en la comunidad.</li>
                                                            <li><span class="numero">4.2</span> El Staff del Servidor AOI, no es responsable de las actitudes o accionares de los usuarios, sino que cada usuario es responsable de sus propias acciones y actitudes.</li>
                                                            <li> <span class="numero">4.3</span>El Staff del Servidor AOI, no se hace responsable por cualquier daño ocasionado por nuestro software, el mismo es instalado en todo caso bajo propio riesgo del usuario.</li>
                                                            <li><span class="numero">4.4</span> Los GMs, Consejeros y personal del Staff, no son empleados nuestros ni se encuentran en posici&oacute;n remunerativa, y por ende el Staff del Servidor AOI no es responsable por su accionar.</li>
                                                            <li><span class="numero">4.5</span> El Staff del Servidor AOI, no est&aacute; obligado a responder por fallas en el servicio, ca&iacute;das del mismo o interrupciones sin previo aviso, as&iacute; como cualquier mal funcionamiento en el extremo del lado del servidor o del cliente.</li>
                                                            <li><span class="numero">4.6</span> El Staff del Servidor AOI, no est&aacute; obligado a responder por la violaci&oacute;n del reglamento por parte de terceros o personas que cooperen con el Staf de manera externa, como es el ejemplo del grupo de GMs.</li>
                                                            <li> <span class="numero">4.7</span> El Staff del Servidor AOI, deja constancia de que si los encargados del juego lo entienden pertinente, a los efectos de proteger el juego, de la utilizaci&oacute;n de programas externos por parte de los usuarios, se podr&aacute; hacer uso de los medios necesarios para conocer los programas que &eacute;stos ejecuten simult&aacute;neamente con el juego.</li>
                                                            <li><span class="numero">4.8</span> Todos los servicios prestados por el servidor de Argentum Online, AOI, son totalmente gratuitos, por lo tanto el usuario no tiene derecho a crear demandas, exigencias o reclamos. Estas demandas y reclamos s&oacute;lo ser&aacute;n atendidos de acuerdo a la buena voluntad, disponibilidad y posibilidades de nuestra empresa. En caso de no estar de acuerdo con el funcionamiento del servicio, las actitudes de otros usuarios, as&iacute; como la de nuestros personales, sus decisiones tomadas, medidas aplicadas, el funcionamiento de los servicios, administraci&oacute;n y direcci&oacute;n de los mismos, como tambi&eacute;n respecto de la administraci&oacute;n y direcci&oacute;n de nuestro personal y la manera de actuar de las personas que colaboran en este proyecto, el usuario s&oacute;lo deber&aacute; abandonar nuestro servicio y borrar el software instalado en su PC, sin posibilidad a ninguna otra acci&oacute;n, o reclamo, a causa del desacuerdo.</li>
                                                            <li><span class="numero">4.9</span> El cuidado de los personajes, se hace mediante encriptaci&oacute;n de claves, y mediante un sistema de recuperar contraseña y borrado de personajes utilizando el e-mail QUE EL USUARIO ELIGE.</li>
                                                            <li class="subli"><span class="numero">4.9.1</span> El Staff no tiene ninguna relaci&oacute;n / obligaci&oacute;n / responsabilidad, con respecto a problemas de seguridad que pueda tener el usuario. La seguridad de la PC del usuario corresponder&aacute; a los dueños de la misma, as&iacute; como la de la cuenta de e-mail corresponder&aacute; a los dueños de la mencionada cuenta y los proveedores de la misma.</li>
                                                            <li class="subli"><span class="numero">4.9.2</span> En caso de robo de e-mail, el usuario deber&aacute; tratar el problema con la empresa proveedora del mismo. El Staff del Servidor AOI tiene relaci&oacute;n en absoluto con dichas empresas, y por lo tanto no tiene raz&oacute;n por la cual tomar acci&oacute;n alguna al respecto.</li>
                                                            <li class="subli"><span class="numero">4.9.3</span> El cuidado de la seguridad del personaje, corre por cuenta exclusiva de su dueño, por lo que el Staff del Servidor AOI, no se hace cargo de los daños ocasionados ya sea por robo de e-mail o robo del personaje.</li>
                                                        </ul>
                                                        <ul class="ul_reglamento">
                                                            <li class="titulo">
                                                                <h3><span class="numero">5</span> <a name="r5">Venta de personajes y comercio entre mismos.</a></h3>
                                                            </li>
                                                            <li class="subli"><span class="numero">5.1</span> Ning&uacute;n miembro del staff podr&aacute; avalar la realizaci&oacute;n de la operaci&oacute;n de venta o comercio entre usuarios. Estando absolutamente prohibido solicitar esto al Staff.</li>
                                                            <li class="subli"><span class="numero">5.2</span> El &uacute;nico medio reconocido para el intercambio / compra / venta de personajes del juego es el denominado <strong id="docs-internal-guid-1f823e79-6bbe-c344-9961-2ee0a1b46cad"> MercadoAO.</strong></li>
                                                            <li class="subli"><span class="numero">5.2.1</span> Queda terminantemente prohibida la publicacion/difusion/promocion de cualquier transaccion por dinero real (ya sea venta de personajes, oro, o cualquier otro elemento) por parte de usuarios.</li>
                                                            <li class="subli"><span class="numero">5.3</span> La venta o cambio de personajes por fuera del sistema de MercadoAO quedan a total responsabilidad de las personas involucradas. No pudiendo bajo ning&uacute;n concepto formular reclamos al Staff en caso de ser engañados o estafados.</li>
                                                            <li class="subli"><span class="numero">5.4</span> A s&iacute; mismo el cambio de mail de un personaje mediante el sistema presente en ésta página web queda bajo la total responsabilidad del dueño del personaje. Sin lugar a reclamos o quejas por daños o p&eacute;rdidas ocasionadas por dicho acto.</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>