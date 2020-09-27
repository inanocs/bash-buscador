#!/bin/bash
$user=$(whoami)
while true
do
clear
echo "		||||||||||||||||||||||||||||||"
echo "		||||||Creado por inanocs||||||"
echo "		||||||||||||||||||||||||||||||"
echo

	echo "-----------Bienvenido al buscador----------"
	echo ""
	echo "	1: Buscar ficheros"
	echo "	2: Buscar directorios"
	echo "	3: Salir"
	echo""
	read -p "Introduzca la opción deseada: " op

	case $op in

	1)
	if [ $UID -eq 0 ]
	then
		echo "Introduzca la ruta para buscar el fichero"
		read ruta
		echo "Introduzca el nombre del fichero"
		read fichero
		echo "Buscando fichero..."
		sleep 1
		if [ ! -d $ruta ]
		then
			echo "La ruta es incorrecta o el directorio no existe"
		elif [ $(find $ruta -type f -name "$fichero*" 2>/dev/null | wc -l) -gt 0 ]
		then
			echo "El fichero existe"
			read -p "¿Desea visualizar los ficheros con ese nombre? si/no: " x
			case $x in
			[Ss]i|[Ss])
			echo "Mostrando..."
			sleep 1
			for i in $(find $ruta -type f -name "$fichero*" 2>/dev/null)
			do
				echo "------> $i"
				sleep 1
			done
			echo ""
			read -p "Desea guardar la informacion en un fichero en la carpeta $HOME/listado.txt?: " p
			case $p in
			[Ss]i|[Ss])
			find $ruta -type f -name "$fichero*">> $HOME/listado.txt
			sleep 1
			echo "Información guardada"
			sleep 1
			;;
			*)
			read -p "De acuerdo, ¿Desea ejecutar alguna consulta mas?: " p2
			case $p2 in
			[Ss]i|[Ss])
			echo "De acuerdo, volviendo al menu de inicio..."
			sleep 2
			;;
			*)
			echo "De acuerdo, hasta luego $(whoami)!"
			exit 0
			esac
			esac
			;;
			*)
			echo "De acuerdo."
			sleep 1
			esac
		else
			echo "El fichero no existe"
			sleep 1
			read -p "¿Desea volver a iniciar el menu? (si/no): " k
			case $k in
			[Ss]i|[Ss])
			sleep 1
			;;
			*)
			echo "De acuerdo, hasta luego $(whoami)!"
			exit 0
			esac
		fi
	else
		ruta=$HOME
		echo "Introduzca el nombre del fichero"
		read fichero
		echo "Buscando fichero..."
		sleep 1
		if [ ! -d $ruta ]
		then
			echo "La ruta es incorrecta o el directorio no existe"
		elif [ $(find $ruta -type f -name "$fichero*" | wc -l) -gt 0 ]
		then
			echo "El fichero existe"
			read -p "¿Desea visualizar los ficheros con ese nombre? si/no: " x
			case $x in
			[Ss]i|[Ss])
			echo "Mostrando..."
			sleep 1
			for i in $(find $ruta -type f -name "$fichero*")
			do
				echo "------> $i"

			done
			sleep 1
			echo ""
			read -p "Desea guardar la informacion en un fichero en la carpeta $HOME/listado.txt? (si/no): " p
			case $p in
			[Ss]i|[Ss])
			find $ruta -type f -name "$fichero*">> $HOME/listado.txt
			sleep 1
			echo "Información guardada"
			sleep 1
			;;
			*)
			read -p "De acuerdo, ¿Desea ejecutar alguna consulta mas? (si/no): " p2
			case $p2 in
			[Ss]i|[Ss])
			echo "De acuerdo, volviendo al menu de inicio..."
			sleep 2
			;;
			*)
			echo "De acuerdo, hasta luego $(whoami)!"
			exit 0
			esac
			esac
			;;
			*)
			echo "De acuerdo."
			sleep 1
			esac
		else
                     	echo "El fichero no existe"
                        sleep 1
                        read -p "¿Desea volver a iniciar el menu? (si/no): " k
                        case $k in
                        [Ss]i|[Ss])
                        sleep 1
                        ;;
                        *)
                        echo "De acuerdo, hasta luego $(whoami)!"
                        exit 0
                        esac

		fi
	fi
	echo
	;;
	2)
	read -p "Introduce la ruta sobre la cual quiere empezar a buscar: " op
	
	if [ -d $op ]
	then
		read -p "Introduce el nombre del directorio que desea buscar: " p
		sleep 1
		echo "Buscando..."
		sleep 1
		
		if [ $(find $op -type d 2>/dev/null | grep -wi "$p" |wc -l) -gt 0 ]
		then
			echo "Hemos encontrado coincidencias..."
			sleep 1
			read -p "¿Desea visualizarlas? [si/no]: " l
		
			case $l in
			[Ss]i|[Ss])
			echo "Mostrando coincidencias..."
			sleep 1
			for i in $(find $op -type d 2>/dev/null | grep -wi "$p")
			do
				echo "------> $i"

			done
			read -p "¿Desea guardar ese directorio en el fichero $HOME/tmp/directorios.txt?: " k
			case $k in
			[Ss]i|[Ss])
			if [ -f "$HOME/tmp/directorios.txt" ]
			then
				echo "Añadiendo nuevos directorios al fichero..."
				sleep 2
				echo "--------------------">>$HOME/tmp/directorios.txt
                                echo "">>$HOME/tmp/directorios.txt
				echo "----Directorios buscados en $(date +'%A,%d de %B de %Y, hora: %H:%M')----">>$HOME/tmp/directorios.txt
				find $op -type d 2>/dev/null | grep -wi "$p">>$HOME/tmp/directorios.txt
				sleep 1
				echo "Directorios añadidos al fichero..."
				sleep 2
				echo "Volviendo al menu principal"
				sleep 1

			elif [ ! -d "$HOME/tmp" ]
			then
				echo "$HOME/tmp no existe. Tranquilo, nosotros te lo creamos ;)"
				sleep 2
				mkdir $HOME/tmp
				echo "Directorio creado..."
				sleep 2
				echo "Creando archivo directorios.txt"
				sleep 2
				touch $HOME/tmp/directorios.txt
				echo "Archivo creado"
				sleep 1
				echo "Incluyendo la busqueda en el fichero..."
				echo "----Directorios buscados en $(date +'%A,%d de %B de %Y, hora: %H:%M')----">>$HOME/tmp/directorios.txt
                                find $op -type d 2>/dev/null | grep -wi "$p">>$HOME/tmp/directorios.txt
				echo "Directorios añadidos al fichero..."
                                sleep 2
                                echo "Volviendo al menu principal"
                                sleep 1

			else
				echo "$HOME/tmp/directorios no existe. Tranquilo, nosotros te lo creamos ;)"
				sleep 2
                                touch $HOME/tmp/directorios.txt
                                echo "Archivo creado"
                                sleep 1
                                echo "Incluyendo la busqueda en el fichero..."
                                echo "----Directorios buscados en $(date +'%A,%d de %B de %Y, hora: %H:%M')----">>$HOME/tmp/directorios.txt
                                find $op -type d 2>/dev/null | grep -wi "$p">>$HOME/tmp/directorios.txt
                                echo "Directorios añadidos al fichero..."
                                sleep 2
                                echo "Volviendo al menu principal"
                                sleep 2

			fi
			;;
			*)
			echo "De acuerdo. Volviendo al menu principal..."
			sleep 2
			esac
			;;
			*)
			echo "De acuerdo. Volviendo al menu principal..."
			sleep 2
			esac
		fi
	else
		echo "El directorio base no existe..."
		sleep 1
		echo "Volviendo al menu"
		sleep 1
	fi
	;;
	3)
	echo "Hasta luego $(whoami)"
	exit 0
	;;
	*)
	echo "Opcion no contemplada"
	sleep 1
	esac

done

