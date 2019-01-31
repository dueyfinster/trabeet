# trabeet
Docker image for downloading for Plex using Transmission & youtube-dl, all
controlled via webhooks.

webhook (magnet uri) -> Transmission -> Beets/Filebot -> Plex Library

webhook (YouTube URL) -> youtube-dl -> No metadata processing (video) or Beets (Music) -> Plex Library

# To use
Extend the docker image, add custom config/scripts and mount:

* Downloads directory at /downloads
* Plex Directory at /media (Assuming standard Plex library layout of 'Movies','TV Shows', 'Videos', 'Music')
* Send requests via curl `curl -X POST --data "token=<MYTOKEN>" --data "uri=https://www.youtube.com/watch?v=<MYVIDEO>" --data "type=<Movies|TV Shows|Music|Video>" http://<my_ip>:8080/hooks/yt-dl`

See sample [docker-compose](/docker-compose-sample.yml) file for reference.
