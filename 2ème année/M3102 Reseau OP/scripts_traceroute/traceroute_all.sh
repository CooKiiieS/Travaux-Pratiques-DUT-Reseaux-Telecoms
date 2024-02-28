#!/bin/bash

# Ecriture de digraph A { dans les fichiers .dot

echo "digraph A {" > icmp.dot

echo "digraph A {" > udp.dot

echo "digraph A {" > tcp.dot

for i in $*
do

# Definition des variables avec la commande traceroute

icmp=`sudo traceroute -nI $i | sed "1d" | grep '*' -v | sed "s/ //" | cut -d" " -f2,3 | sed "s/ //"`

udp=`sudo traceroute -nU $i | sed "1d" | grep '*' -v | sed "s/ //" | cut -d" " -f2,3 | sed "s/ //"`

tcp=`sudo traceroute -nT $i | sed "1d" | grep '*' -v | sed "s/ //" | cut -d" " -f2,3 | sed "s/ //"`

# Création de 3 tableaux

declare -a tab_icmp=()

declare -a tab_udp=()

declare -a tab_tcp=()

inc_icmp=0

inc_udp=0

inc_tcp=0

# Chaque IP récupérée est inséré dans le tableau puis le tableau s'incrémente

for ip_icmp in $icmp
do
icmp_tab[$inc_icmp]=$ip_icmp
((inc_icmp+=1))
done

for ip_udp in $udp
do
udp_tab[$inc_udp]=$ip_udp
((inc_udp+=1))
done

for ip_tcp in $tcp
do
tcp_tab[$inc_tcp]=$ip_tcp
((inc_tcp+=1))
done

# Le résultat affiché s'affiche avec moins deux valeurs

((inc_icmp-=2))

((inc_udp-=2))

((inc_tcp-=2))

# Ecriture de l'adresse IP du Routeur + IP du routeur +1 dans le fichier .dot

for x_icmp in `seq 0 $inc_icmp`
do
echo "\""${icmp_tab[x_icmp]}"\" -> \""${icmp_tab[x_icmp+1]}"\" [label=\"$i\"]" >> icmp.dot
done

for x_udp in `seq 0 $inc_udp`
do
echo "\""${udp_tab[x_udp]}"\" -> \""${udp_tab[x_udp+1]}"\" [label=\"$i\"]" >> udp.dot
done

for x_tcp in `seq 0 $inc_tcp`
do
echo "\""${tcp_tab[x_tcp]}"\" -> \""${tcp_tab[x_tcp+1]}"\" [label=\"$i\"]" >> tcp.dot
done

# Faire deux sauts de ligne à la fin de la commande

echo -e "\n\n" >> icmp.dot

echo -e "\n\n" >> udp.dot

echo -e "\n\n" >> tcp.dot

done

# Ecriture de } à la fin de chaque fichiers .dot

echo "}" >> icmp.dot

echo "}" >> udp.dot

echo "}" >> tcp.dot

# Commandes pour créer une image jpg correspondant au résultat des commandes et afficher les images

dot -Tjpg icmp.dot -o resultat_icmp.jpg

dot -Tjpg udp.dot -o resultat_udp.jpg

dot -Tjpg tcp.dot -o resultat_tcp.jpg

eog resultat_icmp.jpg

eog resultat_udp.jpg

eog resultat_tcp.jpg
