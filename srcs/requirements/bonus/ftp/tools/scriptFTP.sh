#!/bin/bash



#Creation user
adduser --disabled-password ${FTP_USER} --gecos ""

echo "${FTP_USER}:${FTP_PASS}" | /usr/sbin/chpasswd

chown -R ${FTP_USER}:${FTP_USER} /var/www/html/

echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist

usr/sbin/vsftpd /etc/vsftpd.conf &