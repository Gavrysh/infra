#!/bin/bash

cd ~

# Install RVM for current user
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

# run RVM script and setup dependence for work RVM & Ruby
source ~/.rvm/scripts/rvm
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
