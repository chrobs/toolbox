#!/bin/bash

inotifywait -m -e delete -e close_write --exclude '\*.sw??$' . |
while read dir ev file; do
  if [ "$ev" = "DELETE" ]; then
    echo "$file" >> /inotify.log
  else
    cp ./"$file" zinot/"$file"
  fi
done
