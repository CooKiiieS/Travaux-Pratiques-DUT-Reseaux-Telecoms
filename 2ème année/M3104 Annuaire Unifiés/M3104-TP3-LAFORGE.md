##Entrées du projet et cahier des charges
1) Je lance une VM et je fais un *apt update*
J’installe mon annuaire avec *apt-get install* (mot de passe admin = test) :

```
apt-get install slapd ldap-utils
```

J’édite le fichier ldap.conf pour ajouter le domaine iutbeziers.fr dans mon annuaire :

```
LDAP Defaults

See ldap.conf(5) for details
This file should be world readable but not world writable.

BASE dc=iutbeziers,dc=fr
URI  ldap://localhost/

SIZELIMIT 12 
TIMELIMIT 15 
DEREF never

TLS certificates (needed for GnuTLS)
TLS_CACERT /etc/ssl/certs/ca-certificates.crt
```

Je redémarre le service :

```
root@debian:/etc/ldap# service slapd restart
```

Je vérifie ensuite avec la commande slapcat que mon domaine est bien présent :

```
dn: cn=admin,dc=iutbeziers,dc=fr
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: LDAP administrator
userPassword:: e1NTSEF9R2k2TWMzajAwWFhTMEVjZkVzdFgrVWNSaXRxUkw3Rmw=
structuralObjectClass: organizationalRole
entryUUID: e4085032-964d-1039-856a-d910ee91b317
creatorsName: cn=admin,dc=iutbeziers,dc=fr
createTimestamp: 20191108083122Z
entryCSN: 20191108083122.990562Z#000000#000#000000
modifiersName: cn=admin,dc=iutbeziers,dc=fr
modifyTimestamp: 20191108083122Z
```

Pour l’avoir il a fallut que je fasse un dpkg-reconfigure slapd et que je configure moi-même le domaine

2) Une fois mon annuaire installé je configure mon fichier arbre.ldif de la façon suivante :

```
dn: ou=groups,dc=iutbeziers,dc=fr
objectClass: top
objectClass: organizationalunit
ou: groups
description: Branche Groupes

dn: ou=personnes,dc=iutbeziers,dc=fr
objectClass: top
objectClass: organizationalunit
ou: personnes
description: Groupes de personnes

dn: ou=etudiants,ou=personnes,dc=iutbeziers,dc=fr
objectClass: top
objectClass: organizationalunit
ou: etudiants
description: Groupes d'etudiant

dn: ou=TD,ou=groups,dc=iutbeziers,dc=fr
objectClass: top
objectClass: organizationalunit
ou: TD
description: Groupes de TDs

dn: ou=TDA,ou=TD,ou=groups,dc=iutbeziers,dc=fr
objectClass: top
objectClass: organizationalunit
ou: TDA
description: Groupe de TD A

dn: ou=TDB,ou=TD,ou=groups,dc=iutbeziers,dc=fr
objectClass: top
objectClass: organizationalunit
ou: TDB
description: Groupe de TD B
```

Maintenant j’importe ce fichier dans mon annuaire avec la commande suivante :

```
root@214-3:/etc/ldap# ldapadd -x -D cn=admin,dc=iutbeziers,dc=fr -W -f arbre.ldif
```

3) Après l’avoir importé je crée un script qui va convertir le fichier .csv de moodle en fichier .ldif de la bonne forme :

```
!/bin/bash
Compteur pour assigner les numéro UID
compteur=1001
Fonction  à appelé pour crée le fichier ldif
ecrireEntree() {
NOM=$(echo $1|tr ’[:upper:]’ ’[:lower:]’)
COMPTEUR=$2
PRENOM=$(echo $3|tr ’[:upper:]’ ’[:lower:]’)
echo "$COMPTEUR"
MYUID=${PRENOM:0:3}${NOM:0:8}
echo $MYUID
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

Boucle pour lire chaque ligne du fichier
while read line
do
arg1=$(echo "$line" | sed -r 's/ /;/g'| cut -d';' -f 2) 
Chaque nom de chaque ligne est assigné à arg1. sed remplace les espaces par de$
arg3=$(echo "$line" | sed -r 's/ /;/g'| cut -d';' -f 3)
Chaque prenom de chaque ligne est assigné à arg3. sed remplace les espaces par$
((compteur++))
Compteur servant à attribué l'uid lors de lappel à la fonction ecrireEntree qu$
ecrireEntree $arg1 $compteur $arg3 >> LAFORGE_Samuel.ldif
appel de la fonction et renvoie dans mon fichier ldif
done < liste_tous.csv
```

Maintenant quand j’exécute le script il me crée un fichier .ldif avec la liste de tous les étudiants :

```
dn: uid=aouandhume,ou=etudiants,ou=personnes,dc=iutbeziers,dc=fr
objectClass: inetOrgPerson
objectClass: person
objectClass: organizationalPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: top
cn: aouita.andhume
sn: aouita
givenName: andhume
uid: aouandhume
uidNumber: 1002
gidNumber: 1002
homeDirectory: /home/aouandhume
loginShell: /bin/bash
shadowExpire: 0
userPassword: {SSHA}RWK9BASh/NsGzi0k4XLRm1Xt1DoEceJvtB1h1w==
mail: aouita.andhume@iutbeziers.fr
...
```

Pour finir j'envoie mon fichier dans mon annuaire avec la commande suivante :

```
root@214-3:/etc/ldap# ldapadd -x -D cn=admin,dc=iutbeziers,dc=fr -W -f LAFORGE_Samuel.ldif
```

Pour vérifier que mes fichiers sont bien envoyés dans mon annuaire je fais la commande suivante :

```
root@214-3:/etc/ldap# ldapsearch -x -LLL -H ldap:/// -b dc=iutbeziers,dc=fr > ldapout1.log
```

Maintenant dans mon fichier ldapout.log j’ai tous les noms des étudiants.

4) Je télécharge sur moodle les 3 fichiers .ldif et je fais ensuite les commandes suivantes :

```
root@214-3:/etc/ldap# sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f memberof_load_configure.ldif
```

```
root@214-3:/etc/ldap# sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f 1refint.ldif
```

```
root@214-3:/etc/ldap# sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f 2refint.ldif
ldapmodify: modify operation type is missing at line 2, entry "olcOverlay={1}refint,olcDatabase={1}hdb,cn=config"
```

Maintenant si je fais un ldapsearch des memberof je dois les visualiser