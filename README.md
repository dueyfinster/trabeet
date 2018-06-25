# trabeet
Docker image for downloading for Plex using Transmission & youtube-dl, all
controlled via webhooks.

webhook (magnet uri) -> Transmission -> Beets/Filebot -> Plex Library

webhook (YouTube URL) -> youtube-dl -> Beets/Filebot -> Plex Library

# To use
Extend the docker image, add custom config/scripts and mount:

* Downloads directory at /downloads
* Plex Directory at /media (Assuming standard Plex library layout of 'Movies',
  'TV Shows', 'Videos', 'Music')
