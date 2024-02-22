# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install MARIADB
RUN apt install -y mariadb-server

# Assure the existence, access and ownership of mysqld folder
RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod 750 /var/run/mysqld

# Copy our configuration
COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/

# Copy our script
COPY tools/scriptMDB.sh .

# Give permissions to the script
RUN chmod 750 ./scriptMDB.sh

# Port to listen
EXPOSE 3306

# Default command when container starts
CMD ["sh", "scriptMDB.sh"]