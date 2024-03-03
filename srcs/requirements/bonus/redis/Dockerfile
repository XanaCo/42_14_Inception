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

# Copy our configuration
COPY conf/redis.conf /etc/redis/redis.conf

# Port to listen
EXPOSE 6379

# Default when container starts (execute)
ENTRYPOINT ["redis-server", "--protected-mode no"]
