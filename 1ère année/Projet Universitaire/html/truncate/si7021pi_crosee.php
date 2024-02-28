<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=si7021pi', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('TRUNCATE crosee'); 
	while ($donnees = $reponse->fetch()){echo "si7021pi_crosee OK" , '<br/>' ;}
	$reponse->closeCursor()
?>