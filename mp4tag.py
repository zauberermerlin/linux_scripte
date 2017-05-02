#!/usr/bin/python
# 
# Die Uebergabe der Parameter aus der bash muss mit doppelten Anfuehrungszeichen erfolgen
# Hochkomma und Leerzeichen sind dann irrelevant
#
#######################
#
# Offizieller Pfad des Repos'
# https://github.com/zauberermerlin/linux_scripte.git
#
# fuer curl wird der raw Pfad der einzelnen Datei benötigt
#
#
#curl -L https://raw.githubusercontent.com/zauberermerlin/linux_scripte/master/mp4tag.py >mp4tag.py
#
#######################

VERSIONSDATUM="02.05.2017";
VERSION="0.1";

from mutagen.mp4 import MP4, MP4Cover
import sys
print 'Number of arguments:', len(sys.argv), 'arguments.'
# print 'Argument List:', str(sys.argv)
# 1. Parameter: Dateiname
# 2. Parameter: Titel
# 3. Artist
# 4. Album
# 5. Jahr
# 6. Nummer/Track
# 7. Genre/Studio
# 8. Kommentar
# 9. Cover-Bild
datei = MP4(sys.argv[1])
datei['\xa9nam'] = sys.argv[2]
datei['\xa9ART'] = sys.argv[3]
datei['\xa9alb'] = sys.argv[4]
datei['\xa9day'] = sys.argv[5]
#datei['trkn'] = sys.argv[6]
datei['\xa9gen'] = sys.argv[7]
datei['\xa9cmt'] = sys.argv[8]

# Cover einfuegen
with open(sys.argv[9], "rb") as f:
	datei['covr'] = [
	MP4Cover(f.read(), imageformat=MP4Cover.FORMAT_JPEG)
	]

datei.save()
