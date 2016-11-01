!#/bin/bash
#
# Schablone fuer Scripte
# Grundgeruest zum Start eines Linux Scriptes
#

VERSION="0.1";
echo $VERSION

# Aufruf-Parameter, die in jedem Script vorhanden sein sollten:
# -h oder --help: Hilfstext mit Bsp.
# -install: kopieren und verlinken des Scripts, damit direkter Zugriff erfolgt
# -remove: den mit -install durchgeführten Vorgang rückgängig machen
# -check
#
# -ansible: Erstellung bzw. Anzeige des Ansible Playbooks
# -log
# -test
#
# Überpruefung der mitgegebenen Parameter. Ist einer der Parameter
# -h oder --help oder -install oder -remove vorhanden, dann werden alle
# anderen Parameter ignoriert
# Anzahl der Paramter: $#
# erster Parameter: $1
 
