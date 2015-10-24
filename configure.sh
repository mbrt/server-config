#!/bin/bash

# settings
USER=michele

# packages
apt-get -y install sudo curl
# add admin user
useradd -G $USER,sudo -d /home/$USER $USER
mkdir /home/$USER
chown $USER:$USER /home/$USER
# fix locale
locale-gen en_US en_US.UTF-8
dpkg-reconfigure locales

# message
echo "-- WARNING --"
echo "Remember to set $USER password with command"
echo "passwd $USER"
