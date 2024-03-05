# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install REDIS
RUN apt install -y redis-server
RUN apt install -y redis-tools

# Clean lists to reduce size of container
RUN rm -rf /var/lib/apt/lists/*

# Create PID directory
RUN mkdir -p /run/redis
RUN chmod 755 /run/redis

# Change current configuration, saving a .bak just in case
RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
RUN sed -i 's/bind 127.0.0.1/#bind 127.0.0.1/' /etc/redis/redis.conf

# Port to listen
EXPOSE 6379

# Launch redis when container starts
ENTRYPOINT ["redis-server", "--protected-mode no"]
