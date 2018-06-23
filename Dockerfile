FROM ubuntu:18.04

EXPOSE 9091 9000

RUN apt-get update && apt-get install -y transmission-cli \
	transmission-common \
	transmission-daemon \
	beets \
	ffmpeg \
	youtube-dl \
	curl \
	jq \
	openjdk-8-jre \
	webhook

# Install filebot
# Template taken from: https://github.com/filebot/plugins/blob/master/docker/Dockerfile
RUN placeholder="" \
    && FILEBOT_VERSION="4.7.8" \
    && FILEBOT_SHA256=c64026327cdd8b1e5e5932cef39d35e80932d527ec5c1c69b689313f7882e7b7 \
    && FILEBOT_PACKAGE=filebot_${FILEBOT_VERSION}_amd64.deb \
    && FILEBOT_BASEURL=https://downloads.sourceforge.net/project/filebot/filebot \
    && curl -L -O $FILEBOT_BASEURL/FileBot_$FILEBOT_VERSION/$FILEBOT_PACKAGE \
    && echo "$FILEBOT_SHA256 *$FILEBOT_PACKAGE" | sha256sum --check --strict \
    && dpkg -i "$FILEBOT_PACKAGE" \
    && rm "$FILEBOT_PACKAGE"
 
RUN mkdir -p /watch
COPY bin/* /usr/bin/

ONBUILD COPY config/transmission /config/transmission
ONBUILD COPY config/beet /config/beet
ONBUILD COPY config/filebot /config/filebot

ONBUILD CMD ["start"]
