#!/bin/bash

# settings
USER=michele
FTP_USER=ftpr
FTP_USER_HOME=/home/ftpr

# packages
apt-get update
apt-get upgrade -y
apt-get install -y sudo curl man ufw
# date time
echo "Europe/London" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
# fix locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US en_US.UTF-8
dpkg-reconfigure -f noninteractive locales
# firewall rules
ufw limit OpenSSH
ufw enable

# add admin user
adduser $USER
usermod -a -G sudo $USER

# ftp
apt-get install -y vsftpd
cat >/etc/vsftpd.conf <<EOL
# enable only this list of users
# the file format is one user per line
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd.userlist

# chroot for these users
chroot_local_user=YES
chroot_list_enable=YES
# (default follows)
chroot_list_file=/etc/vsftpd.chroot_list

# workaround to not enable seccomp
# enable this only if your machine does not support seccomp
seccomp_sandbox=no
EOL

cat $FTP_USER >/etc/vsftpd.userlist
cat $FTP_USER >/etc/vsftpd.chroot_list

# ftp user
useradd -d $FTP_USER_HOME $FTP_USER
mkdir $FTP_USER_HOME
chown $FTP_USER:$FTP_USER $FTP_USER_HOME
# start vsftpd
service vsftpd reload

# user setup
su $USER
ssh-keygen
