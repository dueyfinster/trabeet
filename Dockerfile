FROM dueyfinster/trabeet:base

# Copy Binaries
COPY bin/* /usr/bin/

# Add required config files
COPY config/beets /root/.config/beets
COPY config/transmission /root/.config/transmission-daemon
COPY config/transmission-rss /root/.config/transmission-rss
COPY config/filebot /root/.filebot
COPY config/webhook /opt/webhook/
COPY config/nginx /etc/nginx

# Run start script (on build)
CMD ["start"]
