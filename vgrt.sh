#!/bin/bash


echo "Vagrant.configure('"'2'"') do |config|" > Vagrantfile

echo -n "Quina versió del box genèric de Debian vols descarregar?(Debian9/Debian10/Debian11) --> "
read versiobox
echo  "config.vm.box = '"$versiobox"' " >> Vagrantfile

echo -n "Quin és el nom de la maquina virtual? "
read nommaquina
echo "config.vm.hostname = '"$nommaquina"' " >> Vagrantfile

echo -n "Quin es el nom del sistema? "
read nomsistema
echo  "config.vm.provider '"$nomsistema"' do |v|"  >> Vagrantfile

echo  "vb.name = "'"Script7ersama"'" " >> Vagrantfile

echo -n "Quina memòria vols assignar? "
read memoriaasignada
echo    "vb.memory = '"$memoriaasignada"' " >> Vagrantfile

echo -n "Quin serà el número de CPUs? "
read numerocpu
echo    "vb.cpus = '"$numerocpu"' "  >> Vagrantfile

echo    "vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']"  >> Vagrantfile     
echo    "end"  >> Vagrantfile

echo -n "Quin port redirecciona al port número 80? "
read redireccio80
echo -n "config.vm.network "'"forwarded_port"'", guest: 80, host: $redireccio80"  >> Vagrantfile

echo -n "Quin port redirecciona al port número 443? "
read redireccio443
echo  "config.vm.network "'"forwarded_port"'", guest: 443, host: $redireccio443" >> Vagrantfile

echo -n "Quin port redirecciona al port número 3306? "
read redireccio3306
echo  "config.vm.network "'"forwarded_port"'", guest: 3306, host: $redireccio3306"  >> Vagrantfile

echo -n "Quin port redirecciona al port número 22? "
read redireccio22
echo  "config.vm.network "'"forwarded_port"'", guest: 22, host: $redireccio22"  >> Vagrantfile
  
echo    "config.vm.provision '"shell"', inline: <<-SHELL"  >> Vagrantfile
echo    "sudo apt-get update -y"  >> Vagrantfile
echo    "sudo apt-get upgrade -y" >> Vagrantfile
echo    "sudo apt-get install -y net-tools" >> Vagrantfile
echo    "sudo apt-get install -y openssh" >> Vagrantfile
echo    "sudo apt-get install -y apache2 apache2-doc" >> Vagrantfile

echo -n "Vols instalar els paquets extra? (s/n)"
read opc
if  [[  $opc  ==  "s" ]]
then
    echo    "sudo apt-get install -y openssh-sftp-server" >> Vagrantfile
    echo    "sudo apt-get install -y mariadb-server" >> Vagrantfile
    echo    "sudo apt-get install -y mariadb-client" >> Vagrantfile    
fi

echo  "SHELL" >> Vagrantfile
echo "end"  >> Vagrantfile

exit 0
