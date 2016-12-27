#!/bin/bash
#
# Schablone fuer Scripte
# Grundgeruest zum Start eines Linux Scriptes


VERSIONSTRING="Version 0.2 vom 10.12.2016";
VERSION="0.1";
echo $VERSION;

BEGINN_DATUM=$(date +%d.%m.%Y);
echo $BEGINN_DATUM;

LAUFZEIT_BEGINN=$(date +%s);
echo $LAUFZEIT_BEGINN;
sleep 2s

LAUFZEIT_ENDE=$(date +%s);
echo $LAUFZEIT_ENDE;
echo $LAUFZEIT_BEGINN - $LAUFZEIT_ENDE;


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
#
