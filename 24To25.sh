#!/bin/bash

CURR_DIR=$(pwd)
cd ~/tomcat/libexec/conf/Catalina/localhost
mv cloud24.xml tmfXmls/cloud24.xml
mv tmfXmls/cloud25.xml cloud25.xml
cd $CURR_DIR
