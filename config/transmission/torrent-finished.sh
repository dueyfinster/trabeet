#!/bin/bash
set -x

BEET=/usr/local/bin/beet
TRANS_BIN="/usr/bin/transmission-remote"

"$TRANS_BIN" -t "$TR_TORRENT_ID" --remove

chown 1000:1000 -R "${TR_TORRENT_DIR}"

if [[ $TR_TORRENT_DIR = *"Music"* ]]; then
    echo "It's music!"
    $BEET import "${TR_TORRENT_DIR}"/"${TR_TORRENT_NAME}" && \
        plex-refresh $PLEX_MUSIC_LIB_ID
elif [[ $TR_TORRENT_DIR = *"Movie"* ]]; then
    filebot -rename -non-strict --format "{plex}" --log all --db TheMovieDB --output /video -r "${TR_TORRENT_DIR}"/"${TR_TORRENT_NAME}" && \
        plex-refresh $PLEX_MOVIES_LIB_ID
elif [[ $TR_TORRENT_DIR = *"TV"* ]]; then
    filebot -rename -non-strict --format "{plex}" --log all --db TheTVDB --output /video -r "${TR_TORRENT_DIR}"/"${TR_TORRENT_NAME}" && \
        plex-refresh $PLEX_TV_LIB_ID
fi

/usr/bin/pushover "$TR_TORRENT_NAME is complete"
