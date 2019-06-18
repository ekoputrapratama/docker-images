#!/bin/sh
# remove docker config which is running terminal command on post install
# to remove all caches
if [ -f /etc/apt/apt.conf.d/docker-clean ]; then
  rm /etc/apt/apt.conf.d/docker-clean
fi
# change apt cache directory
if [ ! -f /etc/apt/apt.conf.d/docker-apt-cache ]; then
  echo "Dir{Cache \"/tmp/apt/\";};" >> /etc/apt/apt.conf.d/docker-apt-cache
  echo "APT{NeverAutoRemove {\".deb$\";}};" >> /etc/apt/apt.conf.d/docker-apt-cache
fi
