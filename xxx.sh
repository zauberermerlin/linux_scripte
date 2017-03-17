#!/bin/bash
#
# Programm, dass alles rund um xxx erledigt.
#
#
#

#######################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# fuer curl wird der raw Pfad der einzelnen Datei benötigt
#
#
#curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/xxx.sh >xxx.sh
#
#######################

VERSIONSDATUM="08.03.2017";
VERSION="0.1";

BEGINN_DATUM=$(date +%d.%m.%Y);
#echo $BEGINN_DATUM;

LAUFZEIT_BEGINN=$(date +%s);
#echo $LAUFZEIT_BEGINN;

LAUFZEIT_ENDE=$(date +%s);
#echo $LAUFZEIT_ENDE;
#echo $LAUFZEIT_BEGINN - $LAUFZEIT_ENDE;

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
# Datei als User 'root' in /usr/sbin loeschen.
# Zum Abschluss das "nicht"-Vorhandensein testen
#

#############################################################
# Parameter: -update
#############################################################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# fuer curl wird der raw Pfad der einzelnen Datei benötigt
#
#
#curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/template.sh >template.sh
#

#############################################################
# Parameter: -checkupdate
#############################################################

#############################################################
# Funktionen definieren
# muessen vor dem Aufruf definiert werden
#############################################################

#
# Hilfe Funktion, zur Ausgabe des Hilfstextes
#

function hilfe_text()
{
echo "";
echo "Hilfe fuer:" $0 "Version:" $VERSION "vom:" $VERSIONSDATUM
echo "";
echo "-t | --template: Template-Datei wird erzeugt";
echo "";
echo "-exifdatei: Exif-Datei 'slug.exif' wird erzeugt";
echo "";
echo "-exifschreiben: Exif-Datei 'slug.exif' wird für jede *-jpg-Datei angewendet";
echo "";

echo "-brazdown: Bilder downloaden aufgrund der Einträge in der 'slug.txt' Datei";
echo "";
}

#
# Ueberprüft ob und welche Dateien vorhanden sind
# exiftool
# 
# slug.mp4-Datei
# slug.txt-Datei
# slug.exif-Datei
# slug.jpg-Dateien
# slug_thumbs.jpg-Dateien
#

function programme_dateien_check()
{
# Überprüfen, ob eine *.txt Datei vorhanden ist (=slug-Datei)
echo "check";
}



#############################################################
# Auswertung der Parameter
#############################################################

# Ueberpruefung der mitgegebenen Parameter. Ist einer der Parameter
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
# Laenge der Parameterliste:
# len=${#array[@]}


#08.03.17
# Parameter: -t oder --template_erzeugen (ggfls. in Verbindung mit -r und/oder -check)
# Parameter: -tag_schreiben (ggfls. in Verbindung mit -r und/oder -check)
# Parameter: -tag_datei (ggfls. in Verbindung mit -r und/oder -check)
# Parameter: -info
# Parameter: -check (ggfls. in Verbindung mit -r oder -update)
# Parameter: -log: log_jjjjmmtt-hhmm.txt-Datei im aktuellen Verzeichnis erzeugen
# Parameter: -v oder --version
# Parameter: -brazdown
# -ansible: Erstellung bzw. Anzeige des Ansible Playbooks
# -install: kopieren und verlinken des Scripts, damit direkter Zugriff erfolgt (ggfls. mit -check)
# -remove: den mit -install durchgefuehrten Vorgang rueckgaengig machen
# -wa: nach Beendigung eine Whatsapp versenden
# -m: nach Beendigung eMail versenden
# -git: Ueberpruefen, ob ein Update auf github vorhanden ist
# -update: neueste Version von github holen und installieren
#
#
# -ansible: Erstellung bzw. Anzeige des Ansible Playbooks
# -log: schreibt ins aktuelle Verzeichnis die Datei log.txt
#



LOG_STATUS="n";
CHECK_STATUS="n";
WA_STATUS="n";

case $1 in
	-h|--h|-help|--help)
		hilfe_text;
		echo "";
		exit;;
	-v|--version)
		echo "";
		echo "Programm:" $0;
		echo "Version:" $VERSION "vom:" $VERSIONSDATUM
		echo "";
		exit;;

	-brazdown)
		echo "";
		
		source $2;
		
	stamm1="http://static.brazzers.com/scenes/";
	stamm2="/preview/img";

	#echo $stamm1;
	#echo $stamm2;

	for((i=1;i<10;i++)) do
	    		    quelle=$stamm1$BRAZNR$stamm2"/0"$i".jpg";
	    		    wget $quelle
	    mv "0"$i".jpg" "0"$i"-"$SLUG".jpg";
#	    mv "0"$i"-"$SLUG".jpg" "./"$SLUG
	    echo $quelle;
	done

	for((i=0;i<6;i++)) do
		    quelle=$stamm1$BRAZNR$stamm2"/1"$i".jpg";
		    wget $quelle
	    mv "1"$i".jpg" "1"$i"-"$2".jpg";
#	    mv "1"$i"-"$2".jpg" "./"$2
	    echo $quelle;
	done		
		exit;;

	-t|--template)
		# Ablauf
		# (1) Name des Stammverzeichnisses holen
		# (2) Überprüfen, ob es im aktuellen Verzeichnis die Datei stammverzeichnis.txt gibt
		# (3) Überprüfen, ob es im Verzeichnis /home/thomas/scripts/ die Datei template_xxx.txt gibt
		# (4) kopieren von template_xxx.txt ins aktuelle Verzeichnis und umbenennen in stammverzeichnis.txt
		#

		SLUG=$(echo $PWD | rev | cut -d/ -f1 | rev);
		SLUGTXT=$SLUG".txt";

		if [ -f $SLUGTXT ]
		then
			echo "Slug-Datei:" $SLUGTXT "ist bereits vorhanden";
			echo "";
		else
			if [ -f /home/thomas/scripts/slug-template.txt ]
			then
				echo "Template wird kopiert/erstellt.";
				cp /home/thomas/scripts/slug-template.txt ./$SLUGTXT;
				echo "####" >>$SLUGTXT;
				date >>$SLUGTXT;
				echo 'SLUG="'$SLUG'";' >>$SLUGTXT; 
				echo "####" >>$SLUGTXT;
				echo "Fertig.";
				echo "";
			else
				echo "Es existiert keine original Slug-Datei im Verzeichnis /home/thomas/scripts";
				echo "mit dem Namen slug-template.txt.";
				echo "";
			fi
		fi
						
		exit;;

	-exifdatei)
		echo "";
		echo "";;


	-exifschreiben)
		echo "";
		echo "";;

	*)
		echo "";
		echo "";;
esac
