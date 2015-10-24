#!/bin/bash

# settings
USER=michele

# packages
apt-get update
apt-get upgrade -y
apt-get install -y sudo curl man
# date time
dpkg-reconfigure tzdata
# fix locale
locale-gen en_US en_US.UTF-8
dpkg-reconfigure locales

# add admin user
adduser $USER
usermod -a -G sudo $USER

# user setup
su $USER
ssh-keygen
