#!/bin/bash
set -x
exec &>/dev/stdout

test -z $1 && echo "need magnet link! $0 <magnet link>" && exit 1
test -z $2 && echo "need directory destination! $0 <magnet link> <destination>" && exit 1

DOWNLOAD_DIR=/downloads/complete/
DOWNLOAD_DIR=$DOWNLOAD_DIR/$2

HOST=localhost
PORT=9091
TRANSMISSION=/usr/bin/transmission-cli
 
SESSID=$(curl --silent --anyauth  "http://$HOST:$PORT/transmission/rpc" | sed 's/.*<code>//g;s/<\/code>.*//g')
curl --silent --anyauth --header "$SESSID" "http://$HOST:$PORT/transmission/rpc" -d "{\"method\":\"torrent-add\",\"arguments\":{\"paused\":\"false\",\"filename\":\"$1\"}}"

#"$TRANSMISSION" -w "$DOWNLOAD_DIR" "$1"
