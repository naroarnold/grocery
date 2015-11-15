#!/usr/bin/env sh

# This is a shell script to start Rserve

cd ${0%/*}    # set cwd to script location
killall --quiet Rserve
R --slave --no-restore --vanilla --file="start.R" >/dev/null 2>&1
