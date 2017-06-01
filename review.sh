#!/bin/bash
# USAGE ~/scripts/review {message}

if [ -z "$1" ]; then
  echo "Please include argument for version number (i.e. ~/scripts/review .)"
  exit 1
fi

if [ "$1" == "help" ]; then
  echo "Adds files to commit on the base directory from which this command was called with the commit message specified"
  echo "If you trust the push then set environmental variable REVIEW_PUSH equal to \"YES\""
  exit 0
fi

REVIEW_PUSH="NO"
if [ "$2" == "true" ]; then
    REVIEW_PUSH="YES"
fi

message=$1
git pull
if [ $? -eq 0 ]; then
    echo "Successfully pulled"
else
    echo "FAILED TO PULL"
    exit 1
fi
git add .
if [ $? -eq 0 ]; then
    echo "Successfully added files"
else
    echo "FAILED TO ADD FILES"
    exit 1
fi
git commit -m "$message"
if [ $? -eq 0 ]; then
    echo "Successfully commmited with message $message"
else
    echo "FAILED TO COMMIT FILES"
    exit 1
fi
if [ "$REVIEW_PUSH" == "YES" ]; then
    git push
    if [ $? -eq 0 ]; then
        echo "Successfully pushed"
    else
        echo "FAILED TO PUSH"
        exit 1
    fi
fi
