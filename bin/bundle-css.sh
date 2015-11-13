#!/bin/bash
mkdir -p ./dist
touch ./dist/app.css
lessc ./src/app/app.less ./dist/app.css
