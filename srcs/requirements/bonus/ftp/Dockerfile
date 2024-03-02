# OS Base
FROM debian:bullseye

# Infos
LABEL author="ancolmen"
LABEL version="1.0"

# Update and Upgrade apt
RUN apt update -y && apt upgrade -y

# Install FTP
RUN apt install -y vsftpd

# Clean lists to reduce size of container
RUN rm -rf /var/lib/apt/lists/*

# Copy our configuration
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Copy our script and make it executable
COPY tools/scriptFTP.sh /usr/local/bin/scriptFTP.sh
RUN chmod 755 /usr/local/bin/scriptFTP.sh

# Create an empty repertory for FTP
RUN mkdir -p /var/run/vsftpd/empty

# Port to listen
EXPOSE 20 21 40000-50000

# Default when container starts
CMD ["sh", "/usr/local/bin/scriptFTP.sh"]