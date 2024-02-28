<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<meta http-equiv="Refresh" content="2">
		<title>VALEURS</title>
		<link rel="stylesheet" href="style/capteur.css"/>

	</head>
	
	<body>
		<h1> VALEURS </h1>

            
        
	    <a href='../principale.php'>[---]</a> ACCUEIL<br>
		<a href='../truncate.php'>[---]</a> VIDER TOUTES LES TABLES<br>
		<a href='principale.php?deconnexion=true' ><span>[---]</span></a> SE DECONNECTER<br>               
            <?php
                session_start();
                if(isset($_GET['deconnexion']))
                { 
                   if($_GET['deconnexion']==true)
                   {  
                      session_unset();
                      header("location:index.php");
                   }
                }
            ?>
		<div>
			<h2>CAPTEUR DE TEMPERATURE ET D'HUMIDITE n°1 - SI7021 ARDUINO</h2>
			<h3>
	<?php
	include 'bdd/si7021a_ctemp.php';
	include 'bdd/si7021a_ftemp.php';
	include 'bdd/si7021a_crosee.php';
	include 'bdd/si7021a_frosee.php';
	include 'bdd/si7021a_hum.php';
	?></h3>

</div>
		<div>
			<h2>CAPTEUR DE TEMPERATURE ET D'HUMIDITE n°2 - SI7021 RASPBERRY PI</h2>
			<h3>
			<?php
	include 'bdd/si7021pi_ctemp.php';
	include 'bdd/si7021pi_ftemp.php';
	include 'bdd/si7021pi_crosee.php';
	include 'bdd/si7021pi_frosee.php';
	include 'bdd/si7021pi_hum.php';
			?></h3>
</div>
<div>
			
			<h2>CAPTEUR DE COURANT - SCT013</h2>
			<h3>
	<?php
	include 'bdd/sct013_tension.php';
	?>	</h3>

</div>
	</body>
</html>

