#!/bin/bash
# USAGE ~/scripts/change_cloud_version {version}

dbSetup=0
if [ -z "$1" ]; then
  dbSetup="NO"
else
  dbSetup=$1
fi

currDir=$(pwd)
catalina stop
cd ~/wingspan/platform
sbt clean compile
cd ~/wingspan/CloudTmf
if [ $dbSetup == "YES" ]; then
 sbt clean compile client war
else
 sbt clean compile dbSetup client war
fi
catalina start
echo "All Done :)"
