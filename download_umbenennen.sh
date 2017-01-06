#!/bin/bash
#
# Im Anschluss an den Download (bspw. mittels wget) Umbennen aller Dateien im aktuellen Verzeichnis
#
# Programm-Aufruf mit einem oder keinem Parameter

#######################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# für curl wird der raw Pfad der einzelnen Datei benötigt
#
# curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/download_umbenennen.sh >download_umbenennen.sh
#
#######################



VERSIONSTEXT="Version 0.1 vom 06.01.2017";
VERSION="0.1";
echo "Version:" $VERSION;

BEGINN_DATUM=$(date +%d.%m.%Y);
#echo $BEGINN_DATUM;

LAUFZEIT_BEGINN=$(date +%s);
#echo $LAUFZEIT_BEGINN;

LAUFZEIT_ENDE=$(date +%s);
#echo $LAUFZEIT_ENDE;
#das folgende Snippet ist noch mit Fehlern behaftet; die Differenz wird nicht ausgegeben, sondern als String
#echo $LAUFZEIT_BEGINN-$LAUFZEIT_ENDE;


# Aufruf-Parameter, die in jedem Script vorhanden sein sollten:
# -h oder --help: Hilfstext mit Bsp.
# -check: Verlinkung und chmod, chown Settings
# -w: nach Beendigung eine Whatsapp versenden
# -m: nach Beendigung eMail versenden
# -v oder --version: Ausgabe des Versionsstrings
# --check:: überprüfen, ob ein Update auf github vorhanden ist
# --update: neueste Version von github holen und installieren
#
# -ansible: Erstellung bzw. Anzeige des Ansible Playbooks
# -log: schreibt ins aktuelle Verzeichnis die Datei log.txt
# -test
#
#
# Anzahl der Paramter: $#
# erster Parameter: $1
# alle Argumente in einer Zeichenkette: $*
# alle Argumente in einem Array: $@
#
# for i in "${arrayName[@]}"
# do
# do whatever on $i
# done
#
#
# Länge der Parameterliste:
# len=${#array[@]}

if [ $# -gt 1 ]
then
	echo "Der Aufruf erfolgte mit:" $# "Parametern.";
	echo "Möglich sind keiner oder 1 Parameter.";
	echo "Hilfe mit:" $0 "-h oder " $0 "--help";
	echo "";
	exit;
fi	

###########################
#
# Programmstart
#
###########################

if [ $# -eq 0 ]
then
	# alle Einträge im Verzeichnis abarbeiten
	# nur Dateien sind relevant; Verzeichnisse werden verworfen
	for i in *
	do
		if [ -f $i ]
		then
			# Dateiname enthält den String mp4
			if [ -n "`echo $i | grep "mp4"`" ]
				then

	#		echo $i "ist eine Datei";
	# Bsp. für einen Dateinamen
	# Aufteilen in den Bereich vor .mp4"
	# Alles in Kleinbuchsaben
	# Sonderzeichen entfernen: [, ], Komma, Apostroph
	# +-Zeichen und Leerzeichen durch Bindestrich ersetzen
	#
	#neu=$(echo "[2ChicksSameTime]+Aaliyah+Love,+Nina+Elle+(22175+%2F+01.06.2017).mp4?mime=true" | sed s/+/-/g | tr [:upper:] [:lower:] | awk -F '.mp4' '{print $1}' | tr -d "[],()%");
	neu=$(echo $i | sed s/+/-/g | tr [:upper:] [:lower:] | awk -F '?mime' '{print $1}' | tr -d "[],()%");
	
	
	# wenn $i gleich $neu ist, dann ist nix zu tun
	if [ $i != $neu ]
		then
			echo $i "wird zu" $neu;	
	fi;
		fi;
		fi;
	done;

fi



########################
if [ $# = 1 ]
then
	echo "Hier werden jetzt mit case die ganzen Parameter abgearbeitet";
#case Variable in
#  Muster1) Kommando1 ;;
#  Muster2) Kommando2 ;;
#  Muster3) Kommando3 ;;
#esac


fi


#############################################################
#
#path-Variable anpassen
#Datei: .bashrc
#PATH=$PATH:/home/thomas/script
#(mit Doppelpunkt)
#

#############################################################
# Parameter: -update
#############################################################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# für curl wird der raw Pfad der einzelnen Datei benötigt
#
#
#curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/template.sh >template.sh
#

#############################################################
# Parameter: -checkupdate
#############################################################

