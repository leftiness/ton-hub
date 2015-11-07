#!/bin/bash
onchange "./src/server/**/*.coffee" -- npm-run-all bundle:server restart:dev &
