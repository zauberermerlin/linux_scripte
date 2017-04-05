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
DATEN=$(find -name '*.slug';
for i in $DATEN
do
  echo $i;
done


