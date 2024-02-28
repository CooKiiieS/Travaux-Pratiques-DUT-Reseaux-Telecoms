<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=si7021a', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('TRUNCATE ctemp'); 
	while ($donnees = $reponse->fetch()){echo "si7021a_ctemp OK" , '<br/>' ;}
	$reponse->closeCursor()
?>