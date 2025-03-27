<div id="menu">
	<div class="arriba">
		<ul>
			<li><a href="/index.php" id="inicio" title="Inicio Legacy">Inicio</a></li>
			<li><a href="/cuenta-premium.php" id="premium" title="Accede a tu cuenta">Cuenta</a></li>
			<li><a href="/manual.php" id="manual" title="Manual Legacy">Manual</a></li>
			<li><a href="#foro" id="toforo" title="Foro oficial Legacy">Foro</a></li>
			<li><a href="/soportes.php" id="soporte" title="Soporte Legacy">Soporte</a></li>
			<li class="ultimo"><a href="/staff.php" id="staff" title="Staff Legacy">Staff</a></li>
		</ul>
	</div>
	<div class="abajo">
		<ul>
			<li><a href="/ranking.php" id="ranking" title="Ranking Legacy">Ranking</a></li>
			<li><a href="/top50.php" id="top50" title="Top 50 Legacy">Top 50</a></li>
			<li><a href="/retos.php" id="retos" title="Retos Legacy">Retos</a></li>
			<li><a href="/reglamento.php" id="reglamento" title="Reglamento del juego">Reglas</a></li>
			<li class="ultimo jugadores_online">
				<?php    	
					require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
					$conn = connect();
				 				
					$result = $conn->query('SELECT * FROM world');
					$onlines=0;
					$online=0;
					
					if ($result->num_rows > 0) 
					  while($row = $result->fetch_assoc()) {
					  $onlines=$row['onlines'];
					  $online=$row['sv_on'];
					}
				?>
				
				<div id="online"><a href="/online.php" rel="nofollow" title="Ver estado de los servidores" style="color:#FFC000;font-family:'Trebuchet MS';font-size:10.5pt;font-weight:bold;"><?php if ($online==0) echo 'Servidor Offline'; else echo 'Jugadores Online: '.$onlines?></a></div>
			</li>
		</ul>
	</div>
</div>