#!/bin/bash

# remove lock from pdf files such that one can modify them
#
# sebastian@bumpern.de
# created: 2012-04-28
# version: 0.2
#
# script uses zenity file chooser


PDFFILE=`zenity --file-selection --title="Select a File"`

#OUTPUTFILE=${1%".pdf"}-unlocked.pdf
#INPUTFILE=${1%".pdf"}.pdf

OUTPUTFILE=${PDFFILE%".pdf"}-unlocked.pdf
INPUTFILE=${PDFFILE%".pdf"}.pdf

#echo $PDFFILE
#echo $OUTPUTFILE
#echo $INPUTFILE

ghostscript -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sPDFPassword=password -sOutputFile="`echo $OUTPUTFILE`" -c .setpdfwrite -f "`echo $INPUTFILE`"
