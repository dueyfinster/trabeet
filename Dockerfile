FROM ubuntu:18.04

EXPOSE 8080

# Make directories needed
RUN mkdir -p /watch

# Volumes to expose
VOLUME ["/media", "/downloads", "/watch", "/root/.config/transmission-rss"]

# Copy Binaries
COPY bin/* /usr/bin/

RUN apt-get update && apt-get install -y transmission-cli \
	transmission-common \
	transmission-daemon \
	ffmpeg \
	youtube-dl \
	curl \
	jq \
	openjdk-8-jre \
	bs1770gain \
	nginx \
	python3-pip \
	ruby-dev && \
	pip3 install beets pylast requests pyacoustid && \
	gem install transmission-rss

# Install filebot
# Template taken from: https://github.com/filebot/plugins/blob/master/docker/Dockerfile
COPY pkgs/filebot_4.7.9_amd64.deb /opt/
RUN dpkg -i /opt/filebot_4.7.9_amd64.deb \
    && rm /opt/filebot_4.7.9_amd64.deb

# Add required config files
COPY config/beets/config.yaml /root/.config/beets/config.yaml
COPY config/transmission/settings.json /root/.config/transmission-daemon/settings.json
COPY config/transmission/torrent-finished.sh /root/.config/transmission-daemon/torrent-finished.sh
COPY config/filebot/filebot.conf /root/.filebot/filebot.conf
COPY config/webhook/* /opt/webhook/
COPY config/nginx /etc/nginx

# Run start script (on build)
ONBUILD CMD ["start"]
