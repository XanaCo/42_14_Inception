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

RUN mkdir -p /run/php
# Copy our configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN chmod 755 /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html


# Copy our script
COPY tools/scriptWP.sh /usr/local/bin/scriptWP.sh

# Give permissions to the script
RUN chmod 755  /usr/local/bin/scriptWP.sh

# Port to listen
EXPOSE 9000

WORKDIR /var/www/html

# Default command when container starts
CMD ["sh", "/usr/local/bin/scriptWP.sh"]