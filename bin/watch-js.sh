#!/bin/bash
BOWER='./bower_components/'
DEPS[0]='angular/angular.js'
DEPS[1]='angular-animate/angular-animate.js'
DEPS[2]='angular-aria/angular-aria.js'
DEPS[3]='angular-cookies/angular-cookies.js'
DEPS[4]='angular-material/angular-material.js'
DEPS[5]='angular-resource/angular-resource.js'
DEPS[6]='angular-sanitize/angular-sanitize.js'
DEPS[7]='angular-ui-router/release/angular-ui-router.js'
DEPS[8]='lodash/lodash.js'
DEPS[9]='restangular/dist/restangular.js'
CONCAT=''

for each in "${DEPS[@]}"
do
	CONCAT="$CONCAT -x $BOWER$each"
done

CMD="watchify ./src/app/app.coffee -o ./dist/bundle.js -dv $CONCAT"

mkdir -p ./dist
touch ./dist/bundle.js
eval $CMD &
