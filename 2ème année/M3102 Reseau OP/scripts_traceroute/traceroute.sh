#!/bin/bash

#Le script commence par demander d'entrer une IP ou un nom de domaine.
#Ensuite on a la définition des variables comme méthodes ou ttl.
#À partir de là le script commence.
#Tout d'abord le script est basé sur le ttl. On va donc récupérer des IP tant que le ttl ne sera...
#...pas arrivé au bout.
#Le ttl s'incrémente de un à chaque IP récupérée
#On écrit la méthode utilisée pour tracer l'IP puis on fait la commande traceroute une par une.
#Les commandes traceroute des 10 premiers ttl récupérées sont testées. On les coupent pour ne...
#...garder que l'IP et on test si c"est une étoile ou une IP qui ressort de la commande.
#Si c'est une IP qui ressort on la garde et elle est envoyée dans le fichier .rte
#Ensuite pour tous les ttl supérieurs à 10 on fait la même chose mais lors de la coupure des...
#...champs on ne garde pas les mêmes que ceux des ttl inférieurs à 10 sinon les IP sont coupées.

rm ip.rte
echo "Entrez une IP ou un nom de domaine à tracer :"
read ip
methodes=("-I" "-U -p 443" "-U -p 53" "-U -p 123" "-T -p 443" "-T -p 53" "-T -p 123")
ttl=0
maxttl=30
while [ $ttl != $maxttl ]
do
	((++ttl))
	for methode in $methodes
	do
		echo "Méthode utilisée : $methode"
		commande="sudo traceroute $methode -n -f $ttl -m $ttl -N 1 -q 1 $ip"

		if [ $ttl -ge 10 ]
        	then
       			testIP=$($commande|cut -d " " -f 3|tail -n 1)
                	if [ "$testIP" != '*' ]
                	then
                		$commande|cut -d " " -f 3,4|tail -n 1  >> ip.rte
                        	break
                	fi
                	else
                		testIP=$($commande|cut -d " " -f 4|tail -n 1)
                        	if [ "$testIP" != '*' ]
                        	then
                        		$commande|cut -d " " -f 4,5|tail -n 1  >> ip.rte
                                	break
                        	fi
         fi
	done
done
