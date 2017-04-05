#!/bin/bash
#
# Abfragen aufgrund der slug-Dateien
#

#######################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# fuer curl wird der raw Pfad der einzelnen Datei benötigt
#
#
#curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/abfrage_xxx.sh >abfrage_xxx.sh
#
#######################

# Aufruf-Parameter, die in jedem Script vorhanden sein sollten:
# -h oder --help: Hilfstext mit Bsp.
# -install: kopieren und verlinken des Scripts, damit direkter Zugriff erfolgt (ggfls. mit -check)
# 		-check: Verlinkung und chmod, chown Settings
# -remove: den mit -install durchgeführten Vorgang rückgängig machen
# -s: sleep/warten in Minuten und herunterzählen in einer Zeile wieviel Minuten noch zu warten ist
# -w: nach Beendigung eine Whatsapp versenden
# -m: nach Beendigung eMail versenden
# -v oder --version: Ausgabe des Versionsstrings
# -git: überprüfen, ob ein Update auf github vorhanden ist
# -update: neueste Version von github holen und installieren
#
#
# -ansible: Erstellung bzw. Anzeige des Ansible Playbooks
# -log: schreibt ins aktuelle Verzeichnis die Datei log.txt
# -test oder -check
#
VERSIONSDATUM="05.04.2017";
VERSION="0.1";

DATEN=$(find -name '*.slug');


#############################################################
# Funktionen definieren
# muessen vor dem Aufruf definiert werden
#############################################################

# Hilfe Funktion, zur Ausgabe des Hilfstextes
function hilfe_text()
{
	echo "Hilfe zu: abfrage_xxx.sh";
	echo "Abfragen:";
	echo " -v1 | -v2 | -v3: *.slug-Versionen";
	echo " -first: Auflistung aller Dateien mit first=j";
	echo " -actress [name]";
}

#############################################################
# Abfrage Funktionen definieren
#############################################################

function abfrage_first()
{
	DATUM=`date "+%Y%m%d-%H%M%S"`
	#echo $datum
	AUSGABE_DATEI="first-"$DATUM".txt";
	
	# alle Dateien, die auf *.slug enden finden und in Variable schreiben
	for i in $DATEN
	do
		# echo $i;
		# slug Laden und Auswerten
		source $i;
		if [ $FIRST = "j" ]
		then
			ZEIT=$(echo $RELEASE | cut -c1-10); 
			echo $FIRSTNAME";"$TITEL";"$ZEIT >>$AUSGABE_DATEI;
		fi
	done
	sort $AUSGABE_DATEI -o $AUSGABE_DATEI;
	echo "Abfrage first erstellt. Datei:" $AUSGABE_DATEI;
}

function abfrage_v1()
{
	DATUM=`date "+%Y%m%d-%H%M%S"`
	#echo $datum
	AUSGABE_DATEI="v1-"$DATUM".txt";
	
	# alle Dateien, die auf *.slug enden finden und in Variable schreiben
	for i in $DATEN
	do
		# echo $i;
		# slug Laden und Auswerten
		source $i;
		if [ $VERSION = "0.1" ]
		then
			ZEIT=$(echo $RELEASE | cut -c1-10); 
			echo $ACTRESS";"$TITEL";"$ZEIT >>$AUSGABE_DATEI;
		fi
	done
	#sort $AUSGABE_DATEI -o $AUSGABE_DATEI;
	echo "Abfrage v1 erstellt. Datei:" $AUSGABE_DATEI;
}

function abfrage_v2()
{
	DATUM=`date "+%Y%m%d-%H%M%S"`
	#echo $datum
	AUSGABE_DATEI="v2-"$DATUM".txt";
	
	# alle Dateien, die auf *.slug enden finden und in Variable schreiben
	for i in $DATEN
	do
		# echo $i;
		# slug Laden und Auswerten
		source $i;
		if [ $VERSION = "0.2" ]
		then
			ZEIT=$(echo $RELEASE | cut -c1-10); 
			echo $ACTRESS";"$TITEL";"$ZEIT >>$AUSGABE_DATEI;
		fi
	done
	#sort $AUSGABE_DATEI -o $AUSGABE_DATEI;
	echo "Abfrage v2 erstellt. Datei:" $AUSGABE_DATEI;
}

function abfrage_v3()
{
	DATUM=`date "+%Y%m%d-%H%M%S"`
	#echo $datum
	AUSGABE_DATEI="v3-"$DATUM".txt";
	
	# alle Dateien, die auf *.slug enden finden und in Variable schreiben
	for i in $DATEN
	do
		# echo $i;
		# slug Laden und Auswerten
		source $i;
		if [ $VERSION = "0.3" ]
		then
			ZEIT=$(echo $RELEASE | cut -c1-10); 
			echo $ACTRESS";"$TITEL";"$ZEIT >>$AUSGABE_DATEI;
		fi
	done
	#sort $AUSGABE_DATEI -o $AUSGABE_DATEI;
	echo "Abfrage v3 erstellt. Datei:" $AUSGABE_DATEI;
}


function abfrage_actress()
{
	DATUM=`date "+%Y%m%d-%H%M%S"`
	#echo $datum
	AUSGABE_DATEI="name-"$DATUM".txt";
	
	# alle Dateien, die auf *.slug enden finden und in Variable schreiben
	for i in $DATEN
	do
		# echo $i;
		# slug Laden und Auswerten
		source $i;
		if [ $ACTRESS = $1 ]
		then
			ZEIT=$(echo $RELEASE | cut -c1-10); 
			echo $ACTRESS";"$TITEL";"$ZEIT >>$AUSGABE_DATEI;
		fi
	done
	#sort $AUSGABE_DATEI -o $AUSGABE_DATEI;
	echo "Abfrage name erstellt. Datei:" $AUSGABE_DATEI;
}

case $1 in
	-h|--h|-help|--help)
		hilfe_text;
		exit;;

	-v|--version)
		echo $0 "Version:" $VERSION "vom" $VERSIONSDATUM;
		exit;;

	-first)
		abfrage_first;
		exit;;

	-v1)
		abfrage_v1;
		exit;;

	-v2)
		abfrage_v2;
		exit;;
		
	-v3)
		abfrage_v3;
		exit;;
		
	-actress)
		echo "Anzahl Parameter:" $#;
		if [ $# eq 2 ]
		then
			abfrage_actress $2;
			exit;
		fi
		echo "Falsche Parameter-Anzahl";
		exit;;

		*)
		echo "";
		echo "";;
esac

