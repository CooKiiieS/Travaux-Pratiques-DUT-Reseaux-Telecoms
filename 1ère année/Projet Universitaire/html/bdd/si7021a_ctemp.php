<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=si7021a', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('SELECT * FROM ctemp ORDER BY ID DESC LIMIT 0, 1'); 
	while ($donnees = $reponse->fetch()){echo "<a href='../graphe/si7021a/ctemp.php'>[GRAPHE]</a>",'<i>',$donnees['Time'],'</i>'," - Température de la salle : ", $donnees['valeur']," °C" ,  '<br/>' ;}
	$reponse->closeCursor()
?>