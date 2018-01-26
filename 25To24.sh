#!/bin/bash

CURR_DIR=$(pwd)
cd ~/tomcat/libexec/conf/Catalina/localhost
mv cloud25.xml tmfXmls/cloud25.xml
mv tmfXmls/cloud24.xml cloud24.xml
cd $CURR_DIR
