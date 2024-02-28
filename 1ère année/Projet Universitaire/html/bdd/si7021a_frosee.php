<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=si7021a', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('SELECT * FROM frosee ORDER BY ID DESC LIMIT 0, 1'); 
	while ($donnees = $reponse->fetch()){echo "<a href='../graphe/si7021a/frosee.php'>[GRAPHE]</a>",'<i>',$donnees['Time'],'</i>'," - Point de rosée : ", $donnees['valeur']," °F" , '<br/>' ;}
	$reponse->closeCursor()
?>