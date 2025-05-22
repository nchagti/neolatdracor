#!/bin/bash

# This script needs Morgana to be set up next to it as described in the README
# of https://github.com/daliboris/plays-encoding-framework. 

usage () {
  cat <<EOF
Usage: $0 [options] DOCX_FILE [DOCX_FILE...]

EOF
}

PEF=./plays-encoding-framework
MORGANA_DIR=./MorganaXProc-IIIse-1.6.7
MORGANA=$MORGANA_DIR/Morgana.sh

chmod +x $MORGANA

SOURCES=$@

if [[ -z $SOURCES ]]; then
  usage
  exit 1
fi

for f in $SOURCES; do
  path=$(realpath $f)
  name=$(basename $f .docx)

  echo $name $path

  $MORGANA \
    -config=$MORGANA_DIR/config.xml \
    $PEF/run/docx2dracor.xpl \
    -input:source=$path \
    -input:job-ticket=$PEF/data/translatin-ticket.xml \
    -option:data-file-path=../data/translatin-ticket.xml \
    -option:output-file-name=$name \
    -option:output-directory-path=$(pwd) \
    -option:debug-path=$(pwd)/_debug
done

exit
