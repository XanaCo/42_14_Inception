# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install NGINX and OPENSSL
RUN apt install -y nodejs openssl

# Clean lists to reduce size of container
RUN rm -rf /var/lib/apt/lists/*

# Create certificates directory
RUN mkdir -p /etc/ssl/node

# Create and stock with .env variables the SSL certificate-key pair
RUN openssl req -x509 -sha256 -nodes -newkey rsa:4096 -days 30\
    -subj "/C=FR/ST=IDF/L=Paris/O=42Paris/OU=Inception/CN=ancolmen.42.fr/UID=ancolmen"\
    -keyout /etc/ssl/node/static_cert.key\
    -out /etc/ssl/node/static_cert.crt

# Copy files in NGINX directory
COPY conf/index.html /var/www/html/
COPY conf/styles.css /var/www/html/
COPY tools/scriptST.js /tmp/scriptST.js

# Port to listen
EXPOSE 4242

# Default command when container starts (execute nginx with options)
CMD ["node", "/tmp/scriptST.js"]