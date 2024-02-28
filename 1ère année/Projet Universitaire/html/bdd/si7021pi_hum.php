<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=si7021pi', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('SELECT * FROM hum ORDER BY ID DESC LIMIT 0, 1'); 
	while ($donnees = $reponse->fetch()){echo "<a href='../graphe/si7021pi/hum.php'>[GRAPHE]</a>",'<i>',$donnees['Time'],'</i>'," - Humidité de la salle : ", $donnees['valeur']," %" , '<br/>' ;}
	$reponse->closeCursor()
?>