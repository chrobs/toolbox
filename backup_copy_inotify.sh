#!/bin/bash

# backup file if modified
#
# toolbox@tempo-tm.de
# created: 2013-08-09
# version: 0.1
#
# script uses inotify-tools and zenity file chooser


fullpath=`zenity --file-selection --title="Zu überwachende Datei"`
filename=$(basename "$fullpath")
extension="${filename##*.}"
filename="${filename%.*}"

dir=`zenity --file-selection --directory --title="Zielverzeichnis, in das die Kopien gespeichert werden"`

while inotifywait -e modify "$fullpath"; do
  datetime=`date +%Y-%m-%d_%H:%M:%S`
  target="$filename-$datetime.$extension"
  cp $fullpath $dir/$target
done
