#!/bin/bash
set -x
exec &>/dev/stdout

test -z $1 && echo "need video link! $0 <video link>" && exit 1
test -z $2 && echo "need directory destination! $0 <video link> <destination>" && exit 1
BEET=/usr/local/bin/beet

if [[ $2 = *"Music"* ]]; then
    echo "It's music!"
    TITLE=$(youtube-dl --extract-audio --audio-format mp3 -o '/downloads/complete/Music/%(title)s-%(id)s.%(ext)s' --print-json --no-warnings "$1" | jq -r .title)
    $BEET import /downloads/complete/Music
    plex-refresh 2
elif [[ $2 = *"Video"* ]]; then
    TITLE=$(youtube-dl -o '/media/Videos/%(title)s-%(id)s.%(ext)s' --print-json --no-warnings "$1" | jq -r .title)
    plex-refresh 7
fi

/usr/bin/pushover "$TITLE is complete"

