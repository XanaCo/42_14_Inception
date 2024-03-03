#!/bin/bash

sleep 20

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


#WILS:
# #!/bin/sh

# #Creation user
# adduser ${FTP_USER} --disabled-password --gecos ""
# echo "${FTP_USER}:${FTP_PASS}" | /usr/sbin/chpasswd
# chown -R ${FTP_USER}:${FTP_USER} /var/www/html/
# echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist

# # Mofification config file
# sed -i -r "s/listen=NO/listen=YES/1"                                /etc/vsftpd.conf
# sed -i -r "s/listen_ipv6=YES/#listen_ipv6=YES/1"                    /etc/vsftpd.conf
# sed -i -r "s/connect_from_port_20=YES/connect_from_port_20=NO/1"    /etc/vsftpd.conf
# sed -i -r "s/#write_enable=YES/write_enable=YES/1"                  /etc/vsftpd.conf
# #sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1"        /etc/vsftpd.conf
# sed -i -r "s/ssl_enable=NO/ssl_enable=YES/1"                        /etc/vsftpd.conf

# echo "listen_port=21"                       | tee -a /etc/vsftpd.conf
# echo "listen_address=0.0.0.0"               | tee -a /etc/vsftpd.conf

# echo "pasv_enable=YES"                      | tee -a /etc/vsftpd.conf
# echo "pasv_min_port=15110"                  | tee -a /etc/vsftpd.conf
# echo "pasv_max_port=15111"                  | tee -a /etc/vsftpd.conf

# echo "allow_writeable_chroot=YES"           | tee -a /etc/vsftpd.conf
# echo "local_root=/var/www/html/"            | tee -a /etc/vsftpd.conf

# echo "userlist_enable=YES"                  | tee -a /etc/vsftpd.conf
# echo "userlist_file=/etc/vsftpd.userlist"   | tee -a /etc/vsftpd.conf
# echo "userlist_deny=NO"                     | tee -a /etc/vsftpd.conf

# /usr/sbin/vsftpd /etc/vsftpd.conf