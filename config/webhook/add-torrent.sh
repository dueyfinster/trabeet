#!/bin/sh
test -z $1 && echo "need magnet link! $0 <magnet link>" && exit 1
 
# HOST=trans
# PORT=9091
TRANSMISSION=/usr/bin/transmission-cli
 
# SESSID=$(curl --silent --anyauth  "http://$HOST:$PORT/transmission/rpc" | sed 's/.*<code>//g;s/<\/code>.*//g')
# curl --silent --anyauth --header "$SESSID" "http://$HOST:$PORT/transmission/rpc" -d "{\"method\":\"torrent-add\",\"arguments\":{\"paused\":\"false\",\"filename\":\"$1\"}}"

$TRANSMISSION $1
