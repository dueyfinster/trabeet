FROM ubuntu:18.04

EXPOSE 9091 9000

RUN mkdir -p /watch

RUN apt-get update && apt-get install -y transmission-cli \
	transmission-common \
	transmission-daemon \
	ffmpeg \
	youtube-dl \
	curl \
	jq \
	openjdk-8-jre \
	webhook \
	mp3gain \
	nginx && \
	pip install beets

# Install filebot
# Template taken from: https://github.com/filebot/plugins/blob/master/docker/Dockerfile
RUN placeholder="" \
    && FILEBOT_VERSION="4.7.9" \
    && FILEBOT_SHA256=892723dcec8fe5385ec6665db9960e7c1a88e459a60525c02afb7f1195a50523 \
    && FILEBOT_PACKAGE=filebot_${FILEBOT_VERSION}_amd64.deb \
    && FILEBOT_BASEURL=https://downloads.sourceforge.net/project/filebot/filebot \
    && curl -L -O $FILEBOT_BASEURL/FileBot_$FILEBOT_VERSION/$FILEBOT_PACKAGE \
    && echo "$FILEBOT_SHA256 *$FILEBOT_PACKAGE" | sha256sum --check --strict \
    && dpkg -i "$FILEBOT_PACKAGE" \
    && rm "$FILEBOT_PACKAGE"
 
ONBUILD COPY start /usr/bin/
ONBUILD COPY config/beet /config/beet
ONBUILD COPY config/filebot /config/filebot
ONBUILD COPY config/transmission /config/transmission
ONBUILD COPY config/nginx /etc/nginx
ONBUILD COPY config/webhook /config/webhook

ONBUILD CMD ["start"]
