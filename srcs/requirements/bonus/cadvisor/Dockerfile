# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install WGET
RUN apt install -y wget

# Clean lists to reduce size of container
RUN rm -rf /var/lib/apt/lists/*

# Change working directory
WORKDIR /usr/local/bin

# Donwload cAdvisor
RUN wget https://github.com/google/cadvisor/releases/download/v0.39.0/cadvisor
RUN chmod 755 cadvisor

# Launch cadvisor
ENTRYPOINT ["cadvisor"]
