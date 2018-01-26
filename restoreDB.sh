#!/bin/bash

CURR_DIR=$(pwd)

if [ -z $1 ]; then
	echo "Need both db name to restore"
	exit 1
fi

BACKUP_DB=$1
cd /Library/PostgreSQL/9.6/bin

./pg_restore -j 5 --host localhost --port 5432 --create --dbname template1 --username postgres --password --verbose /Users/arperez/backups/$BACKUP_DB

cd $CURR_DIR
