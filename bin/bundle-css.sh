#!/bin/bash
mkdir -p ./dist
touch ./dist/app.css
lessc ./src/app/app.less ./dist/app.css
cp ./src/server/css/dialog.css ./dist/
