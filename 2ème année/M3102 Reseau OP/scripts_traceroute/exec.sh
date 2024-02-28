#!/bin/bash

#On définit les variables
#On met le fichier .dot dans un format lisible
#Tout ce qui est dans le fichier ip.rte est récupéré et coupé pour ne garder que l'IP.
#Les IP sont mises entre " les unes derrières les autres avec une flèche entre les deux pour...
#...qu'elles puissent êtres interprêtées dans le fichier .xdot
#On compile le fichier .xdot pour le transformer en fichier .pdf
#On exécute le fichier .pdf grâce à la commande atril

rm -rf carto.xdot
longueur=1
echo "digraph A {" >> carto.xdot
for ip in ip.rte
do
	echo $ip
	taille=$(wc -l $ip|cut -d " " -f 1)
	echo "Nombre d'IP dans le fichier : $taille"
	while [ $longueur -lt $taille ]
	do
		longueur1=$(($longueur + 1))
		ipa=$(cat $ip|head -n $longueur1|tail -n 1)
		ipb=$(cat $ip|head -n $longueur|tail -n 1)
		((longueur+=1))
		echo "\"$ipb\"->\"$ipa\" [label=\"$ip\"]" >> carto.xdot
	done
	longueur=1
done
echo } >> carto.xdot
dot -Tpdf carto.xdot -o carto.pdf
atril carto.pdf
