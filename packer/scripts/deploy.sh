#!/bin/bash

cd ~

# Copy application from GitHub (use https)
git clone https://github.com/Artemmkin/reddit.git

# change dir and setup dependence application
cd reddit && bundle install

# run application server in project folder
puma -d