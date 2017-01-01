#!/bin/bash
#
# Bilder download von brazers.com
#
# Parameter
# (1) http ohne bild und ohne Schraegstrich
#   bsp.:
#     original: http://static.brazzers.com/scenes/10298/preview/img/01.jpg
#     -> http://static.brazzers.com/scenes/10298/preview/img
#
#     -> stamm_1: http://static.brazzers.com/scenes/
#     -> stamm_2: /preview/img
#
# (2) slug name

#echo $# = Anzahl der Parameter
#echo $0 = dateiname
#echo $1 = Parameter (1)
#echo $2 = Parameter (2)

if (($#==2))
then
	mkdir $2

	stamm1="http://static.brazzers.com/scenes/";
	stamm2="/preview/img";

	#echo $stamm1;
	#echo $stamm2;

	for((i=1;i<10;i++)) do
	    quelle=$stamm1$1$stamm2"/0"$i".jpg";
	    wget $quelle
	    mv "0"$i".jpg" "0"$i"-"$2".jpg";
	    mv "0"$i"-"$2".jpg" "./"$2
	    echo $quelle;
	done

for((i=0;i<6;i++)) do
	    quelle=$stamm1$1$stamm2"/1"$i".jpg";
	    wget $quelle
    mv "1"$i".jpg" "1"$i"-"$2".jpg";
    mv "1"$i"-"$2".jpg" "./"$2
    echo $quelle;
done
fi

if (($#==1))
then

case "$1" in
   -install)
	echo "Installiere: " $0 " nach /usr/sbin als User root";
	sudo cp $0 /usr/sbin;
# Überprüfung, ob erfolgreich
	echo;;

   -remove)
	echo "Entferne " $0 " aus dem Verzeichnis /usr/sbin";
	echo "dazu sind root - Rechte erforderlich";
	sudo rm /usr/sbin/$0;
#Überprüfung, ob erfolgreich
	echo;;

   -h|--help)
	echo "Hilfe";;
   *)
	echo "unbekannter Parameter";;
esac
fi

if (($#==0|$#>2))
then
	echo "Falsche Anzahl der Parameter.";
	echo "Notwendig sind 2; angegeben wurden: " $#;
fi
