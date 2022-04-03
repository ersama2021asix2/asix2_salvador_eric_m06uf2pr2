#!/bin/bash

echo -n "A quina carpeta vols anar? --> "
read nom_carpeta

cd $nom_carpeta

i=0

for nom_fitxer in *
do 
	if [[ -x $nom_fitxer ]] && [[ -s $nom_fitxer ]]
	then 
		gzip $nom_fitxer
		i=$[i + 1]
	fi
done
echo "S'han comprimit $i fitxers"
exit 1
