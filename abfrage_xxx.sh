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

AUSGABE-DATEI="abfrage_ergebnis.txt";

# alle Dateien, die auf *.slug enden finden und in Variable schreiben
DATEN=$(find -name '*.slug');
for i in $DATEN
do
  echo $i;
  # slug Laden und Auswerten
  source $i;
  if [ $FIRST = "j" ]
  then 
    echo $TITEL "-> Treffer";
  fi
done


