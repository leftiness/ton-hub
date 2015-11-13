#!/bin/bash
find ./dist/* ! -iname 'vendor*' ! -iname 'font*' | xargs rm -rf
