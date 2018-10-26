#!/bin/bash
set -x

BEET=/usr/bin/beet
TRANS_BIN="/usr/bin/transmission-remote"

"$TRANS_BIN" -t "$TR_TORRENT_ID" --remove

chmod 777 -R "${TR_TORRENT_DIR}"/"${TR_TORRENT_NAME}"

if [[ $TR_TORRENT_DIR = *"Music"* ]]; then
    echo "It's music!"
    $BEET import /downloads/complete/Music
    plex-refresh 2
elif [[ $TR_TORRENT_DIR = *"Movie"* ]]; then
    filebot -rename -non-strict --format "{plex}" --log all --db TheMovieDB --output /media -r "${TR_TORRENT_DIR}"/"${TR_TORRENT_NAME}"
    plex-refresh 1
elif [[ $TR_TORRENT_DIR = *"TV"* ]]; then
    filebot -rename -non-strict --format "{plex}" --log all --db TheTVDB --output /media -r "${TR_TORRENT_DIR}"/"${TR_TORRENT_NAME}"
    plex-refresh 3
fi

/usr/bin/pushover "$TR_TORRENT_NAME is complete"
