#!/bin/bash

# auto-rotate images
#
# toolbox@tempo-tm.de
# created: 2015-02-15
# version: 0.1
#
# script uses zenity file chooser


string=`zenity --file-selection --multiple --title="Select Files" --file-filter=""*.jpg" "*.JPG" "*.png" "*.PNG" "*.gif" "*.GIF""`

IFS='|' read -ra files <<< "$string"



part=$[100/${#files[@]}]
count=$part
for f in "${files[@]}"; do
  convert -auto-orient "$f" "$f"
  echo $count
  count=$[$count + $part]
done | zenity --progress --percentage=0 --title="Progress"
