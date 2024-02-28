<html>
    <head>
       <meta charset="utf-8">
       <title>PROJET R&T1 - GROUPE 17</title>
       <link rel="stylesheet" href="style/index.css" media="screen" type="text/css" />
    </head>
    <body>
        <div id="container">
            <!-- zone de connexion -->
            
            <form action="verification.php" method="POST">
                <h3>SUPERVISION D'UNE CLIM EN SALLE DE SERVEUR</h3>
                <p>AUTHENTIFICATION</p>
                <input type="text" placeholder="username (admin)" name="username" required>
                <input type="password" placeholder="password (admin)" name="password" required>
                <input type="submit" id='submit' value='SE CONNECTER AU SERVEUR WEB DU PROJET' >
                
                <?php
                if(isset($_GET['erreur'])){
                    $err = $_GET['erreur'];
                    if($err==1 || $err==2)
                        echo "<p style='color:red'>Réessayez</p>";}?>
            </form>
        </div>
        <img src='img/iut.jpg'>
    </body>
</html>
