# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install ADMINER
RUN apt install -y adminer

# Clean lists to reduce size of container
RUN rm -rf /var/lib/apt/lists/*

# Create an empty repertory for Adminer and move it into it
RUN mkdir -p /var/www/adminer/
RUN mv /usr/share/adminer/* /var/www/adminer

# Port to listen
EXPOSE 8080

# Default when container starts
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer/"]

