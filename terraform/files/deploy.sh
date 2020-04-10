#!/bin/bash
set -e

source ~/.profile

git clone -b monolith https://github.com/express42/reddit 
cd reddit
bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
