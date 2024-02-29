#!/bin/bash

service mariadb start

sleep 5

mariadb -u root "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

mariadb -u root "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS'"
mariadb -u root "FLUSH PRIVILEGES;"

mariadb -u root "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' INDENTIFIED BY '$MYSQL_PASS';"
mariadb -u root "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' INDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -u root "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' INDENTIFIED BY '$MYSQL_ROOT_PASS';"
mariadb -u root "FLUSH PRIVILEGES;"

mariadb-admin --user=root --password=$MYSQL_ROOT_PASS shutdown

sleep 1

exec mysqld_safe
