FROM ubuntu:18.04

EXPOSE 8080

ENV PLEX_HOST=plex
ENV PLEX_PORT=32400

# Make directories needed
RUN mkdir -p /watch

# Volumes to expose
VOLUME ["/music", "/video", "/downloads", "/watch"]

# Copy Binaries
COPY bin/* /usr/bin/

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

# Install filebot
# Template taken from: https://github.com/filebot/plugins/blob/master/docker/Dockerfile
COPY pkgs/filebot_4.7.9_amd64.deb /opt/
RUN dpkg -i /opt/filebot_4.7.9_amd64.deb \
    && rm /opt/filebot_4.7.9_amd64.deb

# Add required config files
COPY config/beets /root/.config/beets
COPY config/transmission /root/.config/transmission-daemon
COPY config/filebot /root/.filebot
COPY config/webhook /opt/webhook/
COPY config/nginx /etc/nginx

# Run start script (on build)
CMD ["start"]
