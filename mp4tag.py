#!/usr/bin/python
import sys
from mutagen.mp4 import MP4
# datei = MP4("practice-makes-perfect-porn.mp4")
# datei['\xa9nam'] = 'Eva Test'
# datei['\xa9day'] = '2017'
# datei['\xa9gen'] = 'Brazzers'
# datei.save()
# print(datei['\xa9nam'])
# --> Fehler datei['stik'] = str(unichr(10))
# datei['stik'] = '10'

# Cover einfügen -->ok
# with open("practice-makes-perfect-porn.jpg", "rb") as f:
#    datei["covr"] = [
#        MP4Cover(f.read(), imageformat=MP4Cover.FORMAT_JPEG)
#    ]


# datei.save()
# print(datei['trkn'])
# Wert 10 = tv show
# print(datei['stik'])
# print(datei['covr'])


print 'Number of arguments:', len(sys.argv), 'arguments.'
# print 'Argument List:', str(sys.argv)
print 'Number of arguments:', len(sys.argv), 'arguments.'
# print 'Argument List:', str(sys.argv)
if sys.argv[1] == 'hallo':
    print "Hallo"
else:
    print "Nix"
