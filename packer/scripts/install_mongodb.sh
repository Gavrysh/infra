#!/bin/bash

# Delete all open repository MongoDB
rm /etc/apt/sources.list.d/mongodb*.list

# Add keys and link to repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list'

# Update index available packets and install needed packet
apt update
apt install -y mongodb-org

# Start MongoDB, add to autostart with system, check status and version
systemctl start mongod
systemctl enable mongod
systemctl status mongod

mongod -version >> ~/output.ver
