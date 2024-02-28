<html>
    <head>
        <meta charset="utf-8">
        <!-- importer le fichier de style -->
        <link rel="stylesheet" href="style/home.css" media="screen" type="text/css" />
    </head>
    <body>
		<h1> ACCUEIL </h1>
        <h3>
			<?php
				if($_SESSION['username'] !== ""){
					$user = $_SESSION['username'];
					echo "$user, choisissez ou vous souhaitez accéder";}
			?>
        </h3>
        <div>
			<a href='ah.php'>[---]</a> Valeur des différents capteurs<br>
			<a href='phpmyadmin' target="_blank">[---]</a> PHPMYADMIN (login & user 'iut' ou 'root')<br>
			<a href="http://<?php echo $_SERVER['HTTP_HOST']; ?>:1880" target="_blank">[---]</a> NODE RED<br>
			<a href='principale.php?deconnexion=true'><span>[---]</span></a> SE DECONNECTER<br>            
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
        </div>
        
    </body>
</html>
