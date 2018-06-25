#!/bin/bash
set -x

BEET=/usr/bin/beet
TRANS_BIN="/usr/bin/transmission-remote"

"$TRANS_BIN" -t "$TR_TORRENT_ID" --remove

if [[ $TR_TORRENT_DIR = *"Music"* ]]; then
    echo "It's music!"
    $BEET import /downloads/complete/Music
    plex-refresh 2
elif [[ $TR_TORRENT_DIR = *"Movie"* ]]; then
    filebot --output /media/Movies /downloads/complete/Movies
    plex-refresh 1
elif [[ $TR_TORRENT_DIR = *"TV"* ]]; then
    filebot --output /media/TV /downloads/complete/TV
    plex-refresh 3
fi

/usr/bin/pushover "$TR_TORRENT_NAME is complete"
