#!/bin/bash
pm2 kill
killall node
taskkill -IM node.exe -F
