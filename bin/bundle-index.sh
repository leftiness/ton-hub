#!/bin/bash
mkdir -p ./dist
touch ./dist/index.html
jade -P ./src/app/index.jade -o ./dist/
