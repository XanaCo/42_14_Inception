#!/bin/bash

#Create User
adduser --disabled-password ${FTP_USER} --gecos ""

#Create directory and gives permissions and ownership
mkdir -p /var/www/html
chmod 755 /var/www/html
chown -R ${FTP_USER}:${FTP_USER} /var/www/html/

#Add Password
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

#Add User to the userlist
echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist

#Start container
usr/sbin/vsftpd /etc/vsftpd.conf
