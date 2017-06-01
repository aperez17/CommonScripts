#!/bin/bash
# USAGE ~/scripts/review {message}

if [ -z "$1" ]; then
  echo "Please include argument the directory"
  exit 1
fi

CURR_DIR=$(pwd)
DIR=$1
cd $DIR

for f in *.bed; do
  wc -l $f
done

cd $CURR_DIR
