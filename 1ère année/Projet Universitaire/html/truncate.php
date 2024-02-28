<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>VIDER TABLES</title>
		<link rel="stylesheet" href="style/capteur.css"/>

	</head>
	<body>
		<h1>VIDER TOUTES LES TABLES </h1>
	    <a href='../ah.php'>[---]</a> RETOUR<br>
		<a href='phpmyadmin' target="_blank">[---]</a> PHPMYADMIN (login & user 'iut' ou 'root')<br>
		<a href='principale.php?deconnexion=true'><span>[---]</span></a> SE DECONNECTER<br>  
		<h3>Copier les commandes suivantes dans phpmyadmin</h3>
		           
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
		<p>
			TRUNCATE sct013.tension;<br>
			TRUNCATE si7021a.crosee;<br>
			TRUNCATE si7021a.ctemp;<br>
			TRUNCATE si7021a.frosee;<br>
			TRUNCATE si7021a.ftemp;<br>
			TRUNCATE si7021a.hum;<br>
			TRUNCATE si7021pi.crosee;<br>
			TRUNCATE si7021pi.ctemp;<br>
			TRUNCATE si7021pi.frosee;<br>
			TRUNCATE si7021pi.ftemp;<br>
			TRUNCATE si7021pi.hum;<br>
		</p>
	</body>