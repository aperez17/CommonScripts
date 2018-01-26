#!/bin/bash

catalina run | awk '
  /INFO/ {print "\033[94m" $0 "\033[39m" ; next}
  /ERROR/ {print "\033[91m" $0 "\033[39m" ; next}
  /WARN/ {print "\033[33m" $0 "\033[39m" ; next}
  /DEBUG/ {print "\033[35m" $0 "\033[39m" ; next}
  /SEVERE/ {print "\033[31m" $0 "\033[39m" ; next}
  1
'
