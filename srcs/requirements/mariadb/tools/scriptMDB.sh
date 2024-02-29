#!/bin/bash

service mariadb start

sleep 5

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" \
&& mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';" \
&& mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';" \
&& mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}';" \
&& mysql -e "FLUSH PRIVILEGES;" \

# echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mariadb -u root
# echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';" | mariadb -u root
# echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';" | mariadb -u root
# echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASS';" | mariadb -u root
# echo "FLUSH PRIVILEGES;" | mariadb -u root

sleep 1

mysqladmin --user=root --password=${MYSQL_ROOT_PASS} shutdown

# kill $(cat /var/run/mysqld/mysqld.pid)

exec mysqld_safe


#wil:
#!/bin/sh

# service mariadb start

# sleep 5

# mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

# mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';"

# mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}';"

# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"

# mysql -e "FLUSH PRIVILEGES;"

# sleep 1

# mysqladmin -u root -p${MYSQL_ROOT_PASS} shutdown

# exec mysqld_safe 
