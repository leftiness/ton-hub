#!/bin/bash
NODE='./node_modules/'
DEPS[1]='picnic/releases/picnic.css'
CONCAT=''

mkdir -p ./dist

for each in "${DEPS[@]}"
do
	cp $NODE$each ./dist/
done
