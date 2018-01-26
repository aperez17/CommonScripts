#!/bin/bash

CURR_DIR=$(pwd)

if [ -z $1 ]; then
	echo "Need db name for backup"
	exit 1
fi

BACKUP_DB=$1

cd /Library/PostgreSQL/9.6/bin

echo "CLEANING DIRECTORY $(/Users/arperez/backups/$BACKUP_DB)"
rm -r /Users/arperez/backups/$BACKUP_DB

echo "RUNING: ./pg_dump --file /Users/arperez/backups/$BACKUP_DB --host localhost --port 5432 --username postgres --password --verbose -Fd -j 3 --blobs $BACKUP_DB"
./pg_dump --file /Users/arperez/backups/$BACKUP_DB --host localhost --port 5432 --username postgres --password --verbose -Fd -j 3 --blobs "$BACKUP_DB"

cd $CURR_DIR
