FROM ubuntu:18.04

EXPOSE 8080

ENV PLEX_HOST=plex
ENV PLEX_PORT=32400

# Make directories needed
RUN mkdir -p /watch

# Volumes to expose
VOLUME ["/music", "/video", "/downloads", "/watch"]

RUN apt-get update && apt-get install -y transmission-cli \
	transmission-common \
	transmission-daemon \
	ffmpeg \
	curl \
	jq \
	openjdk-8-jre \
	bs1770gain \
	nginx \
	python3-pip \
	ruby-dev && \
	pip3 install youtube-dl beets pylast requests pyacoustid && \
	gem install transmission-rss
# TODO: add webhook ubuntu package when it supports templates	

# Install filebot
# Template taken from: https://github.com/filebot/plugins/blob/master/docker/Dockerfile
COPY pkgs/filebot_4.7.9_amd64p.deb /opt/
RUN dpkg -i /opt/filebot_4.7.9_amd64p.deb \
    && rm /opt/filebot_4.7.9_amd64p.deb
    
    
