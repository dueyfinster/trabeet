FROM dueyfinster/trabeet:base

# Copy Binaries
COPY bin/* /usr/bin/

# Add required config files
COPY config/ /root/
COPY config/nginx /etc/nginx

# Run start script (on build)
CMD ["start"]
