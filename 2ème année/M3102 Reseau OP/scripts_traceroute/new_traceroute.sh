#!/bin/bash

# Ecriture de digraph A { dans le fichier .dot

echo "digraph A {" > test.dot

for i in $*
do

# Exécution de la commande traceroute pour l'argument rentré en ligne de commande

icmp=`sudo traceroute -nI $i | sed "1d" | sed "s/ //" | cut -d" " -f2,3 | sed "s/ //"`

methodes=("-U -p80" "-U -p443" "-U -p22" "-U -p25" "-T -p80" "-T -p443" "-T -p22" "-T -p25")

for methode in $methodes
do
if [ "$icmp" == "*" ]
then
echo "test de la méthode $methodes"
`, sudo traceroute $methodes $i | sed "1d" | sed "s/ //" | cut -d" " -f2,3 | sed "s/ //"`
else
echo "Routeur inconnu"
fi
echo $methode
done

# Envoie des IP dans le fichier .dot (doit être fait sur une seule ligne)

for ip in $icmp
do
echo -n "\""$ip"\" -> " >> test.dot
echo -n "$ip "
done

done

#Commande pour enlever la dernière flèches du fichier .dot

sed -i 's/\(.*\)->/\1 /' test.dot

#Écriture de } dans le fichier .dot

echo "}" >> test.dot

# Exécution des commandes pour créer un fichier .jpg et l'afficher

#dot -Tjpg test.dot -o resultat_new_traceroute.jpg

#eog resultat_new_traceroute.jpg

#dot -Tpdf test.dot -o resultat_new_traceroute.pdf

#atril resultat_new_traceroute.pdf
