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
# fuer curl wird der raw Pfad der einzelnen Datei benoetigt
#
#
# curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/xxx.sh >xxx.sh
#
#######################

VERSIONSDATUM="27.09.2017";
VERSION="0.5";

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
# Parameter: -tupdate
# Update der vorhandenen template.slug Datei, ohne
# die vorhandenen Werte zu überschreiben
#############################################################

SLUG=$(echo $PWD | rev | cut -d/ -f1 | rev);
SLUGTXT=$SLUG".slug";
SLUGEXIF=$SLUG".exif";

SLUGMP4=$SLUG".mp4";

STAMM_BRAZ_1="http://static.brazzers.com/scenes/";
STAMM_BRAZ_2="/preview/img";

ANZAHL_ZEILEN=$(wc -l /home/thomas/scripts/template.slug | cut -c 1-2);

LOG_STATUS="n";
CHECK_STATUS="n";
WA_STATUS="n";

PROGRAMM_VERSION=$VERSION;

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
	echo "-tupdate: vorhandene template.slug Dateien werden aktualisiert";
	echo "";
	echo "-exif: kombiniert zuerst exifdatei und dann exifschreiben";
	echo "-exifdatei: Exif-Datei 'slug.exif' wird erzeugt";
	echo "-exifschreiben: Exif-Datei 'slug.exif' wird für jede *-jpg-Datei angewendet";
	echo "";
	echo "-braz: Bilder downloaden aufgrund der Einträge in der 'name.slug'-Datei";
	echo "";
	echo "-na: Bilder downloaden aufgrund der Einträge in der 'name.slug'-Datei";
	echo "";
	echo "-screenshots [dateiname]: erzeugt Screenshots aus [dateiname]";
	echo "";
	echo "-mp4tag: erzeugt aus 'name.slug'-Datei mp4-Tags in der mp4-Datei";
	echo "";
	echo "-install: Einmaliger Aufruf zur Programm-Installation.";
	echo "        " $0 "wird als User 'root' nach /usr/sbin/ kopiert und mit x-Rechten versehen.";
	echo "";
	echo "-remove: Programm wird deinstalliert. 'root'-Rechte werden dazu abgefragt.";
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

#der Name der Datei muss als Parameter mit übergeben werden = $1
function datum_in_datei_schreiben()
{
#Überprüfung, ob genau ein Parameter übergeben wurde
if [ $#=1 ]
	then
		echo "##############################" >>$1;
		echo -n "# " >>$1;
		date >>$1;
		echo "##############################" >>$1;
		echo "" >>$1;
	else
		echo "Fehler beim Aufruf der Funktion datum_in_datei_schreiben.";
		echo "Zuviele oder zu wenige Parameter.";
		echo "Genau ein Parameter ist notwendig: der Dateiname.";
		echo "";
		exit;
fi
}

#Daten für exiftool schreiben
function exiftool_daten_in_datei_schreiben()
{
if [ $#=1 ]
	then
		echo -n "-title=" >>$1;
		echo $TITEL >>$1;
			echo -n "-label=" >>$1;
			echo $TITEL >>$1;
			echo -n "-xpauthor=" >>$1;
			echo $STUDIO >>$1;
			echo -n "-keywords=" >>$1;
			echo -n $ACTRESS >>$1;
			echo -n "; " >>$1;
			echo $ACTOR >>$1;
			echo -n "-personinimage=" >>$1;
			echo $ACTRESS >>$1;
			echo "" >>$1;
				
			echo -n "-xpcomment=" >>$1;
			echo $BESCHREIBUNG >>$1;
			echo -n "-Caption-Abstract=" >>$1;
			echo $BESCHREIBUNG >>$1;
			echo -n "-Description=" >>$1;
			echo $BESCHREIBUNG >>$1;
			echo -n "-imagedescription=" >>$1;
			echo $BESCHREIBUNG >>$1;
			echo "" >>$1;

#-DateTimeOriginal=2015:11:10 00:00
		echo -n "-DateTimeOriginal=" >>$1;
		echo $RELEASE >>$1;
		echo "" >>$1;
	else
		echo "Fehler beim Aufruf der Funktion exiftool_daten_in_datei_schreiben.";
		echo "Zuviele oder zu wenige Parameter.";
		echo "Genau ein Parameter ist notwendig: der Dateiname.";
		echo "";
		exit;
fi

}


#Bilder von NaughtyAmerica.com downloaden
function na()
{
	#Beispiel für einen Wert aus template.slug
	#http://images4.naughtycdn.com/datana/upload/source/2cst/carmelladylanjerryrem/carmelladylanjerryremvert_scene_huge.jpg
		
	STAMM_NA=$(echo $1 | cut -d/ -f9);
	BILD1=$(echo $STAMM_NA | cut -d_ -f1);

	#je nach übergebenem Parameter sind die letzten 3 oder letzten 4 Zeichen zu entfernen
	#zu unterscheiden am Ende mit: entweder *huge.jpg oder img?.jpg
		
	ANZAHL=$(echo ${#STAMM_NA});
	KRITERIUM=$(echo ${STAMM_NA:$((ANZAHL-8)):8});
		
	[ "$1" = "save" ]
		
	if [ "$KRITERIUM" != "huge.jpg" ]
	then
		BILD=$(echo ${BILD1::-3});
	else
		BILD=$(echo ${BILD1::-4});
	fi
		
	PFAD=$(echo $1 | cut -d/ -f1-8);
	BIG="vert_scene_huge.jpg";
	PIC="hor_big_img";

	wget $PFAD"/"$BILD$BIG;
	mv $BILD$BIG 05-$SLUG.jpg;

	for((i=1;i<5;i++));
	do
		wget $PFAD"/"$BILD$PIC$i".jpg";
		mv $BILD$PIC$i".jpg" "0"$i-$SLUG.jpg;
	done;
}


function exifdatei_funktion()
{
	if [ -f $SLUGEXIF ]
	then
		echo "Exif-Datei existiert bereits.";
		echo "Nix gemacht.";
		echo "";
		#exit;
	else
		if [ -f $SLUGTXT ]
		then
		echo "Lade slug-Datei";
		source $SLUGTXT;
			touch $SLUGEXIF;
		datum_in_datei_schreiben $SLUGEXIF;
		
		echo "# exiftool -overwrite_original -@ slug.exif bilder.jpg" >>$SLUGEXIF;
		echo "" >>$SLUGEXIF;
		
		exiftool_daten_in_datei_schreiben $SLUGEXIF;
		
		echo "Exif-Datei erzeugt.";
		echo "";
		#exit;
		else
			echo "slug-Datei existiert nicht.";
			echo "Nix gemacht.";
			echo "";
			#exit;
		fi
	fi
}


function exifschreiben_funktion()
{
	if [ -f $SLUGEXIF ]
	then
		for i in *.jpg
			do
				exiftool -overwrite_original -@ $SLUGEXIF $i;
				echo "Exifdaten in" $i "geschrieben.";
		done;
	else
		echo "Keine slug-Datei vorhanden.";
		echo "Nix gemacht.";
		echo "";
		#exit;
	fi	
}

function screenshots_funktion()
{
	#For JPEG output use -q:v to control output quality. Full range is a linear
	#scale of 1-31 where a lower value results in a higher quality.
	#2-5 is a good range to try.
	# exiftool our-new-maid-part-one.mp4 | grep 'Track Duration'
	# Track Duration                  : 0:41:30
	# echo "zu wandelnde Datei:" $1;
	DATEINAME_OHNE_ENDUNG=$(echo $1 | cut -d. -f1);
	# echo $DATEINAME_OHNE_ENDUNG;
	#führende Null (genau eine) muss noch mittels SED entfernt werden
	DAUER_STD=$(exiftool $1 | grep 'Track Duration' | rev | cut -d: -f3 | rev | sed 's/^0//');
	DAUER_MIN=$(exiftool $1 | grep 'Track Duration' | rev | cut -d: -f2 | rev | sed 's/^0//');
	#echo "Stunden:" $DAUER_STD;
	#echo "Minuten:" $DAUER_MIN;

	#Umrechnung in Sekunden
	let ZEIT=DAUER_MIN*60+DAUER_STD*60*60;
	#echo $ZEIT;

	let ZAEHLER;
	for((i=0;i<=ZEIT;i=i+30))
	do
		let ZAEHLER++;
	#	echo $ZAEHLER"-"$i;
		ffmpeg -ss $i -i $1 -vframes 1 -q:v 2 $ZAEHLER"-"$DATEINAME_OHNE_ENDUNG".jpg";
	done

	#Dateien umbenennen
	#die Grenze liegt bei 9999
}

function mp4tag_funktion()
{
	# Aufruf des python-Scripts 'mp4tag.py' mit 9 (neun) Parametern
	# mp4-Tags werden in die mp4-Datei geschrieben
	echo "mp4tag";
	if [ ! -f $SLUGTXT ]
		then
			echo "Slug-Datei:" $SLUGTXT "ist nicht vorhanden";
			exit;
	fi
	echo "Los gehts";
	source $SLUGTXT;
	#source my-stepmoms-obsessed-with-me.slug ; ./xxx.py my-stepmoms-obsessed-with-me.mp4 "$TITEL" "$ACTRESS"';'"$ACTOR" "$ALBUM" "2017" "1" "$STUDIO" "$BESCHREIBUNG" "05-my-stepmoms-obsessed-with-me.jpg"
	
	if [ ! -f /home/thomas/scripts/mp4tag.py ]
		then
			echo "Datei: /home/thomas/scripts/mp4tag.py nicht vorhanden.";
			echo "Programm beendet";
			exit;
	fi

# 1. Parameter: Dateiname
# 2. Parameter: Titel
# 3. Artist
# 4. Album
# 5. Jahr
# 6. Nummer/Track
# 7. Genre/Studio
# 8. Kommentar
# 9. Cover-Bild
	#Wenn actor nicht gefüllt/leer, dann nur actress
	#ansonsten mit; (Semikolon) actress + actor

	ARTIST=$(echo $ACTRESS | sed s/\;/,\ /g);
	
	if [ "$ACTOR" != "" ]
	then
		echo "Variable Actor ist gefüllt";
		#ARTIST=$(echo $ACTRESS | sed s/\;/,\ /g)", "$ACTOR;
		
		ACTOR=$(echo $ACTOR | sed s/\;/,\ /g);
		ARTIST=$(echo $ACTRESS | sed s/\;/,\ /g)", "$ACTOR;
	fi

	echo "Actress/Actor:" $ARTIST;

	JAHR=$(echo $RELEASE | cut -c1-4);
	echo "Jahr:" $JAHR;
	
	BILD=$TITELBILD"-"$SLUG".jpg";
	if [ "$TITELBILD" == "" ]
	then
		BILD="dummy";
	fi
	
	echo "Bild:" $BILD;
	
	/home/thomas/scripts/mp4tag.py "$SLUGMP4" "$TITEL" "$ARTIST" "$ALBUM" "$JAHR" track "$STUDIO" "$BESCHREIBUNG" "$BILD";

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
# Parameter: -tag_schreiben (ggfls. in Verbindung mit -r und/oder -check)
# Parameter: -tag_datei (ggfls. in Verbindung mit -r und/oder -check)
# Parameter: -info
# Parameter: -check (ggfls. in Verbindung mit -r oder -update)
# Parameter: -log: log_jjjjmmtt-hhmm.txt-Datei im aktuellen Verzeichnis erzeugen
# Parameter: -v oder --version
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


case $1 in
	-h|--h|-help|--help)
		hilfe_text;
		echo "";
		exit;;
		
		
	-v|--version)
		echo "";
		echo "Programm:" $0;
		echo "Version:" $VERSION "vom:" $VERSIONSDATUM;
		echo "";
		exit;;


	-t|--template)
		# Ablauf
		# (1) Name des Stammverzeichnisses holen
		# (2) Überprüfen, ob es im aktuellen Verzeichnis die Datei stammverzeichnis.txt gibt
		# (3) Überprüfen, ob es im Verzeichnis /home/thomas/scripts/ die Datei template_xxx.txt gibt
		# (4) Leere Datei stammverzeichnis.txt im aktuellen Verzeichnis erstellen
		# (5) Kopf aus template.slug in Datei übertragen
		# (6) Zeitstempel in Datei einfügen
		# (7) Datenfeld SLUG erzeugen und befüllen
		# (8) Datenfelder aus template.slug übertragen

#		SLUG=$(echo $PWD | rev | cut -d/ -f1 | rev);
#		SLUGTXT=$SLUG".txt";

		if [ -f $SLUGTXT ]
		then
			echo "Slug-Datei:" $SLUGTXT "ist bereits vorhanden";
			echo "";
		else
			if [ -f /home/thomas/scripts/template.slug ]
			then
				echo "Template wird kopiert/erstellt.";
				# erstelle leere Datei
				touch $SLUGTXT;
				# Funktion zum Datum schreiben
				datum_in_datei_schreiben $SLUGTXT;
				
				# hier werden die ersten 15 Zeilen (=alles Kommentare) aus der template.slug angefuegt
				head -n 15 /home/thomas/scripts/template.slug >>$SLUGTXT;
				# Tag SLUG wird erstellt
				echo 'SLUG="'$SLUG'";' >>$SLUGTXT; 
				# Tag Pfad wird erstellt
				PFAD=$(pwd);
				echo 'PFAD="'$PFAD'";' >>$SLUGTXT; 

				tail -n $((ANZAHL_ZEILEN-15)) /home/thomas/scripts/template.slug >>$SLUGTXT;

				echo "Fertig.";
				echo "";
			else
				echo "Es existiert keine original Slug-Datei im Verzeichnis /home/thomas/scripts";
				echo "mit dem Namen template.slug.";
				echo "";
			fi
		fi
		exit;;

	-tupdate)
		echo "Parameter: -tupdate";
		exit;;

	-braz)
		if [ -f $SLUGTXT ]
		then
			echo "Lade slug-Datei";
			source $SLUGTXT;

				for((i=1;i<10;i++)) do
					QUELLE=$STAMM_BRAZ_1$BRAZNR$STAMM_BRAZ_2"/0"$i".jpg";
					wget $QUELLE
					mv "0"$i".jpg" "0"$i"-"$SLUG".jpg";
				done
			
				for((i=0;i<6;i++)) do
					QUELLE=$STAMM_BRAZ_1$BRAZNR$STAMM_BRAZ_2"/1"$i".jpg";
					wget $QUELLE
					mv "1"$i".jpg" "1"$i"-"$SLUG".jpg";
				done
		fi
		exit;;


	-na)
		if [ -f $SLUGTXT ]
		then
			echo "Lade slug-Datei";
			source $SLUGTXT;

			na $NA;
		fi
		exit;;

	-exif)
		echo "Führt zuerst exifdatei und dann exifschreiben aus";
		exifdatei_funktion;
		echo "";
		exifschreiben_funktion;
		exit;;

	-exifdatei)
			exifdatei_funktion;
		exit;;

	-exifschreiben)
			exifschreiben_funktion;
		exit;;
		
	-screenshots)
		screenshots_funktion $2;
		exit;;
	
	-mp4tag)
		mp4tag_funktion;
		exit;;
	
		
	-install)
		echo "Installiere: " $0 " nach /usr/sbin als User root";
		sudo cp /home/thomas/scripts/xxx.sh /usr/sbin/;
		sudo chmod a+rx /usr/sbin/xxx.sh;
		echo;
		# alternativ: verlinken
		exit;;
	
	-remove)
	echo "Entferne " $0 " aus dem Verzeichnis /usr/sbin";
	echo "dazu sind root - Rechte erforderlich";
	sudo rm $0;
	echo;
	exit;;

	*)
		echo "Da ist wohl ein Fehler passiert :(";
		echo "";;
esac
