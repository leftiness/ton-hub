#!/bin/bash
NODE='./node_modules/'
DEPS[1]='nanoajax/nanoajax.min.js'
CONCAT=''

mkdir -p ./dist

for each in "${DEPS[@]}"
do
	cp $NODE$each ./dist/
done
