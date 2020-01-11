#!/bin/bash
set -x

BEET=/usr/local/bin/beet
TRANS_BIN="/usr/bin/transmission-remote"
FILEBOT_CMD="filebot -rename -non-strict --format \"{plex}\" --log all --output /video"
"$TRANS_BIN" -t "$TR_TORRENT_ID" --remove

chown 1000:1000 -R "${TR_TORRENT_DIR}"

TORRENT_DIR=$(echo $TR_TORRENT_DIR | tr '[:upper:]' '[:lower:]')
TORRENT_FULL_PATH="${TR_TORRENT_DIR}/${TR_TORRENT_NAME}"

if [[ $TORRENT_DIR = *"music"* ]]; then
    echo "It's music!"
    $BEET import "${TORRENT_FULL_PATH}" && \
        plex-refresh $PLEX_MUSIC_LIB_ID
elif [[ $TORRENT_DIR = *"movie"* ]]; then
    echo "It's a movie!"
    $FILEBOT_CMD --db TheMovieDB -r "${TORRENT_FULL_PATH}" && plex-refresh $PLEX_MOVIES_LIB_ID
elif [[ $TORRENT_DIR = *"tv"* ]]; then
    echo "It's a tv show!"
    $FILEBOT_CMD --db TheTVDB -r "${TORRENT_FULL_PATH}" && plex-refresh $PLEX_TV_LIB_ID
fi

/usr/bin/pushover "$TR_TORRENT_NAME is complete"
