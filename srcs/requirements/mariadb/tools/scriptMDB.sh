#!/bin/bash

service mariadb start

sleep 5

# Create and import Wordpress database
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

# Create and give privileges to users and root
mariadb -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' INDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' INDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' INDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mariadb -u root -e "FLUSH PRIVILEGES;"

sleep 1

# service mariadb stop
mariadb-admin --user=root --password=$MYSQL_ROOT_PASSWORD shutdown

exec mysqld_safe
