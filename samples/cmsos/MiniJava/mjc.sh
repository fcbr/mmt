#!/bin/sh

if [ -z $JAVA ]; then
    echo 'Please set your $JAVA environment variable.'
    exit
fi

$JAVA -jar mjc.jar $@
