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


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod 755 wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp


# RUN mkdir -p /var/www/html
# RUN chown -R www-data:www-data /var/www/html
# RUN chmod -R 755 /var/www/html
# RUN mkdir -p /run/php/

# Copy our configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/
# RUN chmod 755 /etc/php/7.4/fpm/pool.d/www.conf

# Copy our script
COPY tools/scriptWP.sh .

# Give permissions to the script
RUN chmod 755 ./scriptWP.sh

# Port to listen
EXPOSE 9000

# Default command when container starts
CMD ["sh", "scriptWP.sh"]