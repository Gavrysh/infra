#!/bin/bash

# Warning!!! The script works on behalf of the root

# --------------------- Part one ----------------------------------

# Install RVM for current user
cd ~
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

# run RVM script and setup dependence for work RVM & Ruby
source /usr/local/rvm/scripts/rvm
rvm requirements

# Install Ruby 2.4.1
rvm install 2.4.1

# Setup default version Ruby
rvm use 2.4.1 --default

# Install bundler
gem install bundler -V --no-ri --no-rdoc

# Check version Ruby and Bundler
ruby -v > ~/output.ver
bundler -v >> ~/output.ver

# ------------------------ Part two -------------------------------

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

mongod -version >> ~/output.ver

# ----------------------- Part three -------------------------------

# Copy application from GitHub (use https)
git clone https://github.com/Artemmkin/reddit.git

# change dir and setup dependence application
cd reddit && bundle install

# run application server in project folder
puma -d
