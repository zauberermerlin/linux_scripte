#!/bin/bash

# erzeugt aus einer Vorlagendatei eine temporäre Datei mit den jpeg-TAGS
# Anschliessend werden die TAG geschrieben und die temporäre Datei gelöscht
# Name der Vorlagendatei: slug-name.txt
# Name der temporären Datei: slug-name.tmp

# Beim Aufruf übergebene Parameter:
# keiner oder mehr als 2 -> Fehler
# es muss/müssen genau entweder ein oder zwei Parameter mit gegeben werden

#


#######################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# für curl wird der raw Pfad der einzelnen Datei benötigt
#
#
#curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/video_ffmpeg >video_ffmpeg.sh
#
#######################n 


# 03.08.17
# Paramter -r für rekursiv


VERSIONSTEXT="08.03.2017";
VERSION="0.1";
# echo $VERSIONSTEXT;


BEGINN_DATUM=$(date +%d.%m.%Y);
# echo $BEGINN_DATUM;

LAUFZEIT_BEGINN=$(date +%s);
# echo $LAUFZEIT_BEGINN;

LAUFZEIT_ENDE=$(date +%s);
# echo $LAUFZEIT_ENDE;
# echo $LAUFZEIT_BEGINN - $LAUFZEIT_ENDE;


# Aufruf-Parameter, die in jedem Script vorhanden sein sollten:
# -h oder --help: Hilfstext mit Bsp.
# -install: kopieren und verlinken des Scripts, damit direkter Zugriff erfolgt
# -remove: den mit -install durchgeführten Vorgang rückgängig machen
# -check: Verlinkung und chmod, chown Settings
# -s: sleep/warten in Minuten und herunterzählen in einer Zeile wieviel Minuten noch zu warten ist
# -w: nach Beendigung eine Whatsapp versenden
# -m: nach Beendigung eMail versenden
# -v oder --version: Ausgabe des Versionsstrings
# --check:: überprüfen, ob ein Update auf github vorhanden ist
# --update: neueste Version von github holen und installieren
#
#
# -ansible: Erstellung bzw. Anzeige des Ansible Playbooks
# -log: schreibt ins aktuelle Verzeichnis die Datei log.txt
# -test
#
# Überpruefung der mitgegebenen Parameter. Ist einer der Parameter
# -h oder --help oder -install oder -remove vorhanden, dann werden alle
# anderen Parameter ignoriert
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


#############################################################
#
#path-Variable anpassen
#Datei: .bashrc
#PATH=$PATH:/home/thomas/script
#(mit Doppelpunkt)
#
#############################################################
#############################################################
# Parameter: -install
#############################################################
#
# Datei ist mit dem User 'root' nach /usr/sbin zu kopieren (verlinken geht nicht; warum??? unklar)
# anschliessend ist das r und x Flag für alle zu setzen.
# Zum Abschluss testen, ob die Datei dort auch wirklich vorhanden ist
#
# sudo cp $0 /usr/sbin 
#
#############################################################
# Parameter: -remove
#############################################################
#
# Datei als User 'root' in /usr/sbin löschen.
# Zum Abschluss das "nicht"-Vorhandensein testen
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

##########
#
# Funktion definieren
#
################

function tags_schreiben()
{
	echo "Funktionsaufruf";	
}

CHECK="n";

case $1 in
-h|--h|--help|-help)
	echo "Hilfe";
	echo $0 "Version:" $VERSION "vom" $VERSIONSTEXT;
	echo "";;

-r)
	echo "-r"
	echo "";;
	
-check)
	echo "-check"
	echo "";;


*)

if (test -f $1)
	then
		source $1;
	else
		echo "";
		echo "Fehler";
		echo "Parameter ist keine Datei!";
		echo "";
		exit;
fi	

# hier fängt das eigentliche Programm an

tags_schreiben;

#echo $TITEL;
#echo "";
#echo $BESCHREIBUNG;

esac



