#!/bin/bash

# Delete all open repository MongoDB
sudo rm /etc/apt/sources.list.d/mongodb*.list

# Add keys and link to repo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list'

# Update index available packets and install needed packet
sudo apt update
sudo apt install -y mongodb-org

# Start MongoDB, add to autostart with system, check status and version
sudo systemctl start mongod
sudo systemctl enable mongod
systemctl status mongod

cd ~
mongod -version >> output.ver
