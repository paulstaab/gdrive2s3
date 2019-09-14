FROM alpine:latest

# Download ca-certs to support tls
RUN apk update \
  && apk add ca-certificates wget \
  && update-ca-certificates   

# Download rclone
RUN wget -q https://downloads.rclone.org/rclone-current-linux-amd64.zip -O /tmp/rclone.zip \
  && unzip /tmp/rclone.zip -d /tmp/ \
  && ls /tmp \
  && mv /tmp/rclone-v*-linux-amd64/rclone /usr/local/bin/ \
  && rm -r /tmp/*

# Copy runscript
COPY bin /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# Add a non-privileged user
RUN adduser -S rclone
USER rclone
WORKDIR /home/rclone

# Start the backup automatically
ENTRYPOINT ["docker-entrypoint.sh"]
CMD backup

