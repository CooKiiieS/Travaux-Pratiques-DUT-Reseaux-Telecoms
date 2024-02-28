<?php
	try{$bdd = new PDO('mysql:host=localhost; dbname=sct013', 'root', 'root') ;}
	catch (Exception $e){die('Erreur : '. $e->getMessage()) ;}
	$reponse = $bdd->query('SELECT * FROM tension ORDER BY ID DESC LIMIT 0, 1'); 
	while ($donnees = $reponse->fetch()){echo "<a href='../graphe/sct013/tension.php'>[GRAPHE]</a>",'<i>',$donnees['Time'],'</i>'," - Tension : ", $donnees['valeur']," V" , '<br/>' ;}
	$reponse->closeCursor()
?>
