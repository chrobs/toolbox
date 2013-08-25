#!/bin/bash

# simple webserver with python
#
# toolbox@tempo-tm.de
# created: 2013-08-25
# version: 0.1
#
# tested with python 2.7.4 standard lib

path=`zenity --file-selection --directory --title="Verzeichnis das freigegeben werden soll"`
IP=`ifconfig | sed -n '2 p' | awk '{print $2}' | awk '{split($0,a,":"); print a[2]}'`

echo "+-----------------------------"
echo "| simple webserver            "
echo "+-----------------------------"
echo "|                             "
echo "| start server on port 8080   "
echo "| access via http://$IP:8080 "
echo "+-----------------------------"
echo ""
echo ""

cd "$path" && python -m SimpleHTTPServer 8080
