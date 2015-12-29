#!/bin/bash
BOWER='./bower_components/'
DEPS[1]='picnic/releases/picnic.css'
CONCAT=''

mkdir -p ./dist

for each in "${DEPS[@]}"
do
	cp $BOWER$each ./dist/
done
