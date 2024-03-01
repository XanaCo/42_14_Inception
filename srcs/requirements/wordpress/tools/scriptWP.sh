#!/bin/bash

if [ -f "/var/www/html/wp-config.php" ];
then
    echo "Wordpress already set\n"
else
# Download main package
    wp core download --allow-root

    sleep 10
# Configuration of the database parameters
    wp core config --dbname=$MYSQL_DATABASE\
                    --dbhost="mariadb:3306"\
                    --dbuser=$MYSQL_USER\
                    --dbpass=$MYSQL_PASS\
                    --allow-root

# Installation of wordpress with given parameters
    wp core install --url=$WP_URL\
                    --title=$WP_TITLE\
                    --admin_user=$WP_ADMIN\
                    --admin_password=$WP_ADMIN_PASS\
                    --admin_email=$WP_ADMIN_EMAIL\
                    --allow-root

# Creation of an additional user
    wp user create $WP_USER $WP_USER_EMAIL --role=author\
                    --user_pass=$WP_USER_PASS\
                    --allow-root

# ADD BONUS HERE

fi
# List installed plugins
wp plugin list --allow-root

# Start PHP_FPM
exec /usr/sbin/php-fpm7.4 -F;