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
* Send requests via curl `curl -X POST --data "token=<MYTOKEN>" --data "uri=https://www.youtube.com/watch?v=<MYVIDEO>" --data "type=<Music|Video>" http://<my_ip>:8080/hooks/yt-dl`
