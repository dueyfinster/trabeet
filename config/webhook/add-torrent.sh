#!/bin/bash
set -x
exec &>/dev/stdout

test -z $1 && echo "need magnet link! $0 <magnet link>" && exit 1
test -z $2 && echo "need directory destination! $0 <magnet link> <destination>" && exit 1

DOWNLOAD_DIR=/downloads/complete/
DOWNLOAD_DIR=$DOWNLOAD_DIR$2

TRANSMISSION=/usr/bin/transmission-remote

"$TRANSMISSION" -w "$DOWNLOAD_DIR" -a "$1"
