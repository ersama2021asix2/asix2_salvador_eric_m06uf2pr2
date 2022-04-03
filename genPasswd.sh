if (( $EUID != 0 )) 
then
    echo "S'ha d'executar l'script com root"
    exit 1 
fi

aptitude search pwgen
if (( $? == 0 )) 
then
	aptitude install pwgen
fi

echo -n "Quants usuaris vols crear? (Entre 1 i 100): "
read usr

if (( $usr < 101 )) && (( $usr > 0 ))
then
	echo "Es crearan $usr usuaris"
else
	echo "El número que has introduït es erroni"
	exit 1
fi

echo -n "Introdueix el primer valor UID dels usuaris: "
read uid

echo "USUARIS CREATS AMB nousUsuaris.sh" > /root/usr$uid

for (( c=1; c<=$usr; c++ )) # START=1 END=10 INCREMENT=1
do
	nomUsuari=usr$uid
	
	contrasenya=$(pwgen 10 1)
	echo "$nomUsuari	$contrasenya" >> /root/usr$uid
	
	useradd $nomUsuari -u $uid -g users -d /home/$nomUsuari -m -s /bin/bash -p $(mkpasswd $contrasenya)
	if (( $? != 0 ))
	then
		exit 2
	fi
	uid=$(( $uid + 1 ))
	
done

echo "Script finalitzat satisfactoriament, contingut de /root/usr$uid"

cat /root/usr$uid
exit 0
