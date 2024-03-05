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
RUN mkdir -p /var/www/html/
RUN mv /usr/share/adminer/* /var/www/html/

# Give permissions and ownership
RUN chmod 755 /var/www/html/adminer.php && chown www-data:www-data /var/www/html/adminer.php

# Port to listen
EXPOSE 9000

# Start adminer with port 9000
CMD ["php", "-S", "0.0.0.0:9000", "-t", "/var/www/html/"]
