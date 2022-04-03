#!/bin/bash
clear
case $1 in 
	-e) if (( $# != 3 )) 
		then
			echo "Numero de paràmetres incorrecte"
			echo "La opció -e necesita 3 paràmetres"
			echo "La primera opció es -e"
			echo "La segona opció es la extensió dels fichers a enviar a la paperera"
			echo "La tercera opció es el directori on es troben els fitxers a enviar a la paperera"
			exit 2
		fi
		if [[ ! -d ~/Papelera ]]
		then
			mkdir ~/Papelera
		fi
		if [[ ! -d $3 ]]
		then
			echo "La carpeta no existeix"
		else
			if (( $(ls -A $3/*.$2 2> /dev/null | wc -l) != 0 ))
		
			then
				mv $3/*.$2 ~/Papelera
				echo "Els fichers de extensió $2 a la carpeta $3 s'han enviat a la paperera"
			else
				echo "Els fichers d'extensió $2 no existeixen"
			fi
		 fi		 
		 ;;	 
	-r) if (( $# != 1 )) 
		then
			echo "Número de paràmetres incorrecte"
			echo "La opció -r no necessita més paràmetres"
			exit 1
		fi
		if [[ ! -d ~/Papelera ]]
		then
			echo "La paperera encara no existeix"
		else
			if (( $(ls -A ~/Papelera | wc -l) != 0 ))
			then
				rm ~/Papelera/* 
				echo "Paperera buida"
			else
				echo "La paperera està buida" 
			fi
		fi
		;;	
esac
exit 0




