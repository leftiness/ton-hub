#!/bin/bash
onchange "./src/server/**/*.coffee" -- npm-run-all bundle:server stop restart &
