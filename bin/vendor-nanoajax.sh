#!/bin/bash
BOWER='./bower_components/'
DEPS[1]='nanoajax/nanoajax.min.js'
CONCAT=''

mkdir -p ./dist

for each in "${DEPS[@]}"
do
	cp $BOWER$each ./dist/
done
