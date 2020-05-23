FROM rclone/rclone:latest

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

