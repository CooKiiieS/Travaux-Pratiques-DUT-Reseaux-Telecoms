#!/bin/bash

# Ecriture de digraph A { dans le fichier .dot

echo "digraph A {" > liens.dot

for i in $*
do

# Exécution de la commande traceroute pour l'argument rentré en ligne de commande

icmp=`sudo traceroute -nI $i | sed "1d" | grep '*' -v | sed "s/ //" | cut -d" " -f2,3 | sed "s/ //"`

# Création d'un tableau

declare -a tab_icmp=()
inc_icmp=0

# Chaque IP est envoyé dans chaque case du tableau

for ip_icmp in $icmp
do
icmp_tab[$inc_icmp]=$ip_icmp
((inc_icmp+=1))
done

# On ne prend pas les deux dernières valeurs

((inc_icmp-=2))

# Envoie des IP dans le fichier .dot

for x_icmp in `seq 0 $inc_icmp`
do
echo "\""${icmp_tab[x_icmp]}"\" -> \""${icmp_tab[x_icmp+1]}"\" [label=\"$i\"]" >> liens.dot
done

echo -e "\n\n" >> liens.dot

done

echo "}" >> liens.dot

# Exécution des commandes pour créer un fichier .jpg et l'afficher

dot -Tjpg liens.dot -o resultat_traceroute_icmp.jpg

eog resultat_traceroute_icmp.jpg
