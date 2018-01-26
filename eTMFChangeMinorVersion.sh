#!/bin/bash
set -e
CURR_DIR=$(pwd)

if [ -z $1 ] || [ -z $2 ] || [ -z $3 ]; then
	echo "Need a current and new tmfVersion for backup and a platform version"
	exit 1
fi

CURRENT_VERSION=$1
NEW_VERSION=$2
PLATFORM_VERSION=$3

CURR_MAJOR=$(echo $CURRENT_VERSION | cut -d. -f1)
CURR_MINOR=$(echo $CURRENT_VERSION | cut -d. -f2)
CURR_BUILD=$(echo $CURRENT_VERSION | cut -d. -f3)

NEW_MAJOR=$(echo $NEW_VERSION | cut -d. -f1)
NEW_MINOR=$(echo $NEW_VERSION | cut -d. -f2)
NEW_BUILD=$(echo $NEW_VERSION | cut -d. -f3)

CURR_MAJ_MIN=$CURR_MAJOR$CURR_MINOR
NEW_MAJ_MIN=$NEW_MAJOR$NEW_MINOR

TMF_DIR="/Users/arperez/wingspan/CloudTmf"
PLATFORM_DIR="/Users/arperez/wingspan/platform"
TOMCAT_DIR="/Users/arperez/tomcat/libexec/conf/Catalina/localhost"

cd $PLATFORM_DIR
echo "CHECKING OUT PLATFORM VERSION $PLATFORM_VERSION"
git checkout platform/$PLATFORM_VERSION/dev
git pull

cd $TMF_DIR
echo "CHECKING OUT TMF VERSION $NEW_VERSION"
git checkout tmf/$NEW_VERSION/dev
git pull

cd $TOMCAT_DIR
echo "MOVING XML FILE: cloud$CURR_MAJ_MIN.xml and replacing with cloud$NEW_MAJ_MIN.xml"
mv cloud$CURR_MAJ_MIN.xml tmfXmls
mv tmfXmls/cloud$NEW_MAJ_MIN.xml .

cd $TMF_DIR/wspt_tmf_local/config/local
echo "REPLACING LOCAL CONFIG IN config"
mv *.* $CURR_MAJ_MIN
cp $NEW_MAJ_MIN/* .

cd $TMF_DIR
echo "REBUILDING PROJECT"
rebuild_project() {
  sbt -mem 2000 dbSetup wspt_tmf/webappPrepare
  echo "PROJECT REBUILT"
  exit 0
}
rebuild_project &

echo "RUNNING NPM INSTALL"
cd $TMF_DIR/tmf2_web
rm -rf node_modules
npm install

cd $CURR_DIR
echo "PROCESS DONE AWAITING CHILD PROCESS"
