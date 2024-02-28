#!/bin/bash
#Compteur pour assigner les numéro UID
compteur=1001
#Fonction  à appelé pour crée le fichier ldif
ecrireEntree() {
NOM=$(echo $1|tr ’[:upper:]’ ’[:lower:]’)
COMPTEUR=$2
PRENOM=$(echo $3|tr ’[:upper:]’ ’[:lower:]’)
#echo "$COMPTEUR"
MYUID=${PRENOM:0:3}${NOM:0:8}
#echo $MYUID
SSHA="{SSHA}"
echo  "dn: uid=${MYUID},ou=etudiants,ou=personnes,dc=iutbeziers,dc=fr"
echo  "objectClass: inetOrgPerson"
echo  "objectClass: person"
echo  "objectClass: organizationalPerson"
echo  "objectClass: posixAccount"
echo  "objectClass: shadowAccount"
echo  "objectClass: top"
echo  "cn: ${PRENOM}.${NOM}"
echo  "sn: ${PRENOM}"
echo  "givenName: ${NOM}"
echo  "uid: ${MYUID}"
echo  "uidNumber: ${COMPTEUR}"
echo  "gidNumber: ${COMPTEUR}"
echo  "homeDirectory: /home/${MYUID}"
echo  "loginShell: /bin/bash"
echo  "shadowExpire: 0"
echo  "userPassword: ${SSHA}RWK9BASh/NsGzi0k4XLRm1Xt1DoEceJvtB1h1w=="
echo -e  "mail: ${PRENOM}.${NOM}@iutbeziers.fr\n"
}

#Boucle pour lire chaque ligne du fichier
while read line
do
arg1=$(echo "$line" | sed -r 's/ /;/g'| cut -d';' -f 2) 
#Chaque nom de chaque ligne est assigné à arg1. sed remplace les espaces par des ; et cut sélectionne le champs 2. arg1=NOM
arg3=$(echo "$line" | sed -r 's/ /;/g'| cut -d';' -f 3)
#Chaque prenom de chaque ligne est assigné à arg3. sed remplace les espaces par des ; et cut sélectionne le champs 3. arg3=PRENOM
((compteur++))
#Compteur servant à attribué l'uid lors de lappel à la fonction ecrireEntree qui sincrénte à chaque fois que la boucle recommence.
ecrireEntree $arg1 $compteur $arg3 >> LAFORGE_Samuel.ldif
#appel de la fonction et renvoie dans mon fichier ldif
done < liste_tous.csv
