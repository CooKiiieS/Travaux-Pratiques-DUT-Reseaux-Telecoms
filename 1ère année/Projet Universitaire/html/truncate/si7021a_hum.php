<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=si7021a', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('TRUNCATE hum'); 
	while ($donnees = $reponse->fetch()){echo "si7021a_hum OK" , '<br/>' ;}
	$reponse->closeCursor()
?>