#!/bin/bash

clear
echo -n "Quants usuaris vols crear (entre 1 i 100)? "
read qt

if [[ $qt -gt 100 ]] || [[ $qt -lt 1 ]] 
then
    echo "El número que has introduït es erroni"
    exit 1
fi

echo -n "Valor inicial de l'Uid Number? (Mínim 5000) "
read vinic
vinic=$((vinic-1))

if [[ $vinic < 5000 ]] 
then
    echo "El número que has introduït es erroni"
    exit 0
fi


if [[ -e nomUsuaris.ldif ]]
then
    rm nomUsuaris.ldif
fi

NumUsr=$vinic
for (( i=1; i<=$qt; i++))
do
	vinic=$((vinic+i))
	idUsr=usr$NumUsr

	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> nousUsuaris.ldif
	echo "objectClass: top"  >> nousUsuaris.ldif
	echo "objectClass: person" >> nousUsuaris.ldif
	echo "objectClass: organizationalPerson" >> nousUsuaris.ldif
	echo "objectClass: inetOrgPerson" >> nousUsuaris.ldif
	echo "objectClass: posixAccount" >> nousUsuaris.ldif
	echo "objectClass: shadowAccount" >> nousUsuaris.ldif
	echo "cn: " $idUsr >> nousUsuaris.ldif
	echo "sn: " $idUsr >> nousUsuaris.ldif
	echo "uidNumber: " $NumUsr >> nousUsuaris.ldif
	echo "gidNumber: 101" >> nousUsuaris.ldif
	echo "homeDirectory: /home/$idUsr" >> nousUsuaris.ldif
	echo "loginShell: /bin/bash" >> nousUsuaris.ldif
	echo "objectClass: userPassword" >> ctsUsuaris.txt
	echo "" >> nousUsuaris.ldif
	((NumUsr++))

done
ldapadd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -W -f nousUsuaris.ldif

echo "S'ha creat satisfactoriament"
exit 0
