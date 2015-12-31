#!/bin/bash
IGNORE[0]='vendor*'
IGNORE[1]='font*'
IGNORE[2]='picnic*'
IGNORE[3]='dialog*'
CONCAT=''

for each in "${IGNORE[@]}"
do
	CONCAT="$CONCAT ! -iname $each"
done

CMD="find ./dist/* $CONCAT | xargs rm -rf"
eval $CMD
