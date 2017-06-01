#!/bin/bash
# USAGE ~/scripts/change_cloud_version {version}

if [ -z "$1" || -z "$2" ]; then
  echo "Please include argument for version number (i.e. ~/scripts/change_cloud_version 2.4.6 cloud24)"
  exit 1
fi

currDir=$(pwd)
cloudFile=$2
# CHANGE ME IF ANYTHING CHANGES FOR THIS FILE DIR
cloudDir=/usr/local/Cellar/tomcat@7/7.0.73/libexec/conf/Catalina/localhost
version=$1
echo "CHANGING TO VERSION $version"

#CHANGE ME IF NEW DIR
cd $cloudDir
cat "$cloudFile.xml" | sed "s/wingspan-tmf-.*.war/wingspan-tmf-$version.war/" > tmp.xml
mv tmp.xml cloud25.xml

cd $currDir
echo "$cloudFile.xml has been change to:"
cat $cloudDir/$cloudFile.xml
echo "Done."
