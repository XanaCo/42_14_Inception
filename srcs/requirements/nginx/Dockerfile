# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install NGINX and OPENSSL
RUN apt install -y nginx openssl

# Assure the existence and access of the certificates folder
RUN mkdir -p /etc/ssl/private/
RUN chmod 755 /etc/ssl/private/

# Create and stock with .env variables the SSL certificate-key pair
RUN openssl req -x509 -sha256 -nodes -newkey rsa:4096 -days 30\
    -subj "/C=FR/ST=IDF/L=Paris/O=42Paris/OU=Inception/CN=ancolmen.42.fr/UID=ancolmen"\
    -keyout /etc/ssl/private/nginx_cert.key\
    -out /etc/ssl/private/nginx_cert.crt

# Copy our configuration and use it as global nginx configuration
COPY conf/nginx.conf etc/nginx/nginx.conf

# Create var/www/html repertory
RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Port to listen
EXPOSE 443

# Default command when container starts (execute nginx with options)
CMD ["nginx", "-g", "daemon off;"]