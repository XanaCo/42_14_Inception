# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install WGET and PHP
RUN apt install -y wget
RUN apt install -y php7.4 php-fpm php-mysql mariadb-client

# Create run/php repertory
RUN mkdir -p /run/php

# Copy our configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod 755 /etc/php/7.4/fpm/pool.d/www.conf

# Download wordpress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy our script
COPY tools/scriptWP.sh /usr/local/bin/scriptWP.sh

# Give permissions to the script
RUN chmod 755 /usr/local/bin/scriptWP.sh

# Port to listen
EXPOSE 9000

# Define the working directory
WORKDIR /var/www/html

# Default command when container starts (execute script)
CMD ["sh", "/usr/local/bin/scriptWP.sh"]