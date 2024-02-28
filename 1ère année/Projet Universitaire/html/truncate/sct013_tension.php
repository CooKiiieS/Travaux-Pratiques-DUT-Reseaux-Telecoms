<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=sct013', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('TRUNCATE tension'); 
	while ($donnees = $reponse->fetch()){echo "sct013_tension OK" , '<br/>' ;}
	$reponse->closeCursor()
?>
