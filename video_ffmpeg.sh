#!/bin/bash

VERSION="0.3";
VERSIONSTEXT="07.04.2017";

#Anzahl der Parameter auslesen
#bei einem Parameter:
#bei zwei Parametern:
#bei mehr als zwei Parametern

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
# sudo ln -s /home/thomas/scripts/video_ffmpeg.sh /usr/sbin
#
#######################

#23-05-16
#neben dem Umrechnen erfolgt noch eine Umbenennung der info-Datei, sofern vorhanden
#in den Namen der Video-Datei mit der Endung _info.txt


# offen 24.12.16
# -1
# -2
# Als Name wird die Verzeichnisebene 1 oder 2 oberhalb verwendet


# offen 27.12.2016
# -info: Dateiname aus der info-Datei holen, sofern vorhanden
# -checkinfo oder -cinfo mit dem Parameter t oder s: zeigt den Titel/die Staffel an


#schalter: -s nummer
#nummer beinhaltet die Anzahl in Minuten, die gewartet wird, bis die eigentliche Berechnung startet

#offen 04.03.2017
# -r: Berechnung rekursiv
# -rcheck: Terminalausgabe, welche/wieviele Dateien geändert werdenl
# -wa: whatsapp Mitteilung: dahinter entweder individueller Text oder log.datei
#
# Anlage der temporären log-Datei: video_ffmpeg.log; zum Abschluss Anzeige mit cat und anschliessendes Löschen
# Werte in der Datei werden noch aufgeschrieben
# -h oder --help

#offen: Zeit/Dauer der Umrechnung

#DATUM=`date`;
DATUM=`date "+%Y%m%d-%H%M%S"`
#echo $datum
LOG_DATEI="log-"$DATUM".txt";
TMP_DATEI="tmp-ffmpeg.txt";

LOG="n";
RCHECK="n";
WA="n";
ZEITFAKTOR="0.4";

########################
# Variablen auslesen
########################

for i in $@
do
	if [ $i = "-log" ]
		then
			LOG="j";
	fi
	
	if [ $i = "-rcheck" ]
		then
			RCHECK="j";
	fi
	
	if [ $i = "-wa" ]
		then
			WA="j";
	fi
done

#echo $LOG;
#echo $RCHECK;
#echo $WA;

function hilfe_text()
{
			echo "---------------------";
			echo "hier kommt die Hife";
			echo "---------------------";
			echo "";
			echo $0 "Version:" $VERSION "vom" $VERSIONSTEXT;
			echo "Aufruf mit dem Schalter -install";
			echo " Legt als Superuser einen Link in /usr/bin an";
			echo " -> sudo ln -s /home/thomas/scripts/video_ffmpeg.sh /usr/sbin";
			echo " -> die Datei selbst muss ausführbar, d.h. das Flag x besitzen";	
			echo "";
			echo "Aufruf mit dem Schalter -remove";
			echo " Macht die mit -i durchgeführte Operation rückgängig (=Entfernung des Links)";
			echo " -> sudo rm /usr/sbin/video_ffmpeg.sh";
			echo "";
			echo "Aufruf mit dem Schalter -s";
			echo "";
			echo "Aufruf mit dem Schalter -r | -rcheck | -wa | -log";
			echo "";
			echo "Aufruf mit dem Schalter -1 | -2";
			echo "";

			echo "Aufruf mit einem Parameter, wobei dieser nur der Dateiname ohne Endung ist.";
			echo "Das Script erkennt anhand der Datei-Endung den Typ der Datei und";
			echo "je nach Endung wird eine Aktion ausgeführt";
			echo "Mögliche Endungen:";
			echo "-.flv";
			echo "-.wmv";
			echo "-.avi";
			echo "-.txt";
			echo "";
			echo "Beispiele:";
			echo "video_ffmpeg test";
			echo "->sofern es die Datei test.avi oder test.flv oder test.wmv gibt, wird diese nach test.mp4 gewandelt.";
			echo "";
			echo "->sofern es die Datei test.txt gibt, werden die in der Datei genannten mp4-Dateien zusammengefuegt";
			echo "  und in die Datei test.mp4 geschrieben".;
			echo "  Vorher erfolgt eine Ueberpruefung, ob die Datei test.mp4 bereits existiert.";
			echo "";
			echo ""; 
			echo "";
		
}


function umrechnen() {
	GEFUNDENE_DATEIEN=$(find -name '*.m2v');
	
	if [ ! -n "$GEFUNDENE_DATEIEN" ]
	then
		LOG_TEXT="'Es wurden keine umzurechnenden Dateien gefunden.'";
		log_schreiben $LOG_TEXT;
		echo $LOG_TEXT;
		exit;
	fi
	
	for i in $GEFUNDENE_DATEIEN
	do
		# echo "gefundene Datei:" $i
		# Beispiel fuer i=/samba/archiv/vdr/test/hallo.mp4
		# Beispiel fur PFAD=/samba/archiv/vdr/test (ohne / am Ende)
		PFAD=$(echo $i | rev | cut -d/ -f2- | rev);

		MP2_VORHANDEN=$(echo $i | rev | cut -c4- | rev)"mp2";
		MP4_VORHANDEN=$PFAD"/*.mp4";
		
		# Dateiname ist der Verzeichnisname
		MP4_NEU=$PFAD"/"$(echo $PFAD | rev | cut -d/ -f1 | rev)".mp4";
		# wenn der Verzeichnispfad mit 201 beginnt, dann soll der Dateiname
		# wenn der Verzeichnispfad mit .rec endet, dann soll der Dateiname
		# der Verzeichnisname eine Ebene höher sein
		# der Dateiname eine Ebene hoeher muss dann noch im String
		#	in Kleinbuchstaben
		#	ohne Leerzeichen
		# geaendert werden
		
		VERGLEICH=$(echo $MP4_NEU | rev | cut -c1-7 | rev);
		if [ $VERGLEICH = "rec.mp4" ]
		then
			MP4_NEU=$PFAD"/"$(echo $PFAD | rev | cut -d/ -f2 | rev)".mp4";
			echo "Geänderter Dateiname: $MP4_NEU";
		fi

		if [ -f $MP2_VORHANDEN ]
		then
			# hier gibt es noch einen Fehler, wenn mehr als eine *.mp4-Datei im Verzeichnis vorhanden sind
			if [ ! -f $MP4_VORHANDEN ]
			then
				#TEXT muss ein String ohne Leerzeichen sein
				TEXT="Umrechnung:"$MP2_VORHANDEN"_+_"$i"->"$MP4_NEU;
				echo -e "\033[0;31m Umrechnung: \033[0m"$MP4_NEU;
				if [ $RCHECK = "n" ]
				then
					echo -e "\033[0;31m Umrechnung: \033[0m"$MP4_NEU;
					wa_versenden "Starte_Umrechnung:";
					# wa_versenden "Starte_Umrechnung:"$MP4_NEU;
					log_schreiben $TEXT;
					#ffmpeg -i 00001.mp2 -i 00001.m2v -acodec libvo_aacenc -vcodec libx264 $1.mp4
					ffmpeg -i $MP2_VORHANDEN -i $i -acodec libvo_aacenc -vcodec libx264 $MP4_NEU;
					log_schreiben "Umrechnung_beendet";
				fi
			fi
		fi
	done		
	wa_versenden "Umrechnung_beendet.";	
}


# Funktion zum Schreiben eines Log-Eintrags
# Aufruf mit einem oder keinem Parameter
# Parameter enthält den Text für den Log-Eintrag
# wenn der Parameter # lautet, dann wird nur # ohne Zeitstempel geschrieben
# geschrieben wird in die Dateo log.txt im aufrufenden Verzeichnis
# jeder Eintrag beginnt mit dem Zeitstempel oder mit #
# Zeitstempel: yyyy-mm-dd hh:hh:
function log_schreiben() {

#echo "Log-Status: " $LOG;
#echo "Übergebener Text:" $1;

if [ $LOG = "j" ]
then
	ZEITSTEMPEL=$(date "+%Y-%m-%d %H:%M:%S");
	#echo "Anzahl Parameter: " $#;
	if [ $# = "0" ]
	then
		echo $ZEITSTEMPEL >>$LOG_DATEI;
	fi
	if [ $# = "1" ]
	then
		if [ $1 = "#" ]
		then
			echo "#" >>$LOG_DATEI;
		else
			echo -n $ZEITSTEMPEL >>$LOG_DATEI;
			echo " " $1  >>$LOG_DATEI;
		fi
	fi
fi
}

# Funktion zum Versenden einer Whatsapp-Nachricht
# Aufruf mit einem Parameter notwendig
# Parameter enthält den zu versendeten Text
function wa_versenden() {
if [ $WA = "j" ]
then
	wa.sh $1;
#	echo "Whatsapp wurde versendet";
fi
}


if test $# = 0
then
	hilfe_text;
	exit;
fi

case  $1 in
		-h|--help)
			hilfe_text;
			exit;;
		
		-v|--version)
			echo $0 "Version:" $VERSION "vom" $VERSIONSTEXT;
			exit;;
				
		-install)
			echo " Legt als Superuser einen Link in /usr/bin an";
			echo " -> sudo ln -s /home/thomas/workspace/ShellScripte/video_ffmpeg /usr/bin";
			sudo ln -s /home/thomas/scripts/video_ffmpeg.sh /usr/sbin;
			;;
		-remove)
			echo "Link wird entfernt";	
			echo " -> sudo rm /usr/bin/video_ffmpeg";
			sudo rm /usr/sbin/video_ffmpeg.sh;
#			echo $USER;		
			;;
	-r)
		echo "r";
		log_schreiben "#";
		log_schreiben "Anlage_Start_des_Loggings";
		# start
		umrechnen;
		exit;;

	-rcheck)
		echo "rcheck";
		LOG="n";
		WA="n";
		RCHECK="j";
		# start
		umrechnen;
		exit;;
	
	-s)
		echo "s";
		;;	
			

	*)
	# gibt es die Datei mit der Endung .flv oder nur den Uebergabe-String
			if test -f $1 || test -f $1.flv
				then
					if test -f $1
						then
							ffmpeg -i $1 -acodec libvo_aacenc -vcodec libx264 $1.mp4
						else
							ffmpeg -i $1.flv -acodec libvo_aacenc -vcodec libx264 $1.mp4
					fi

				else
					echo "Keine Flash-Datei";
			fi

			# gibt es die Datei mit der Endung .wmv oder nur den Uebergabe-String
			if test -f $1 || test -f $1.wmv
				then
					if test -f $1
						then
							ffmpeg -i $1 -acodec libvo_aacenc -vcodec libx264 $1.mp4
						else
							ffmpeg -i $1.wmv -acodec libvo_aacenc -vcodec libx264 $1.mp4
					fi

				else
					echo "Keine wmv-Datei";
			fi

			# gibt es die Datei mit der Endung .avi oder nur den Uebergabe-String
			if test -f $1 || test -f $1.avi
				then
					if test -f $1
						then
							ffmpeg -i $1 -acodec libvo_aacenc -vcodec libx264 $1.mp4
						else
							ffmpeg -i $1.avi -acodec libvo_aacenc -vcodec libx264 $1.mp4
					fi

				else
					echo "Keine avi-Datei";
			fi

			if test -f 00001.m2v
				then
				if test -f 00001.mp2
					then
					#Dateien sind vorhanden
					wa_versenden "Start_Umrechnung:_"$i".mp4";
					ffmpeg -i 00001.mp2 -i 00001.m2v -acodec libvo_aacenc -vcodec libx264 $1.mp4

				fi
			fi
			;;
		esac;


if test $# = 3
	then
	case $1 in 
	
	-s)
		#das folgende m steht für Minuten, s für Sekunden
		sleep $2.s;
		;;
	
	*)
		echo "Fehler beim Aufruf mit 3 Parametern";
		# Funktionsaufruf
#		umrechnen_funktion wert1;	
		
		;;
	
	
	esac;

	
fi


#echo $datum;
#date;


