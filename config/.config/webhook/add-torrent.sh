#!/bin/bash
set -x
exec &>/dev/stdout

test -z $1 && echo "need magnet link! $0 <magnet link>" && exit 1
test -z $2 && echo "need directory destination! $0 <magnet link> <destination>" && exit 1

PREFIX_DIR=/downloads/complete/
TYPE_DIR=$(echo $2 | tr '[:upper:]' '[:lower:]')
DOWNLOAD_DIR=$PREFIX_DIR/$TYPE_DIR

TRANSMISSION=/usr/bin/transmission-remote

"$TRANSMISSION" -w "$DOWNLOAD_DIR" -a "$1"
