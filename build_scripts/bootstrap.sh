#!/usr/bin/env bash

apt-get update
apt-get -y install python3-pip redis-server xvfb openssl build-essential xorg libssl-dev

# Set up virtual env
if ! [ -L /vagrant/env ]; then
  echo "setting up virtual env"
  cd /vagrant
  pip3 install virtualenv
  virtualenv env
  . env/bin/activate
  pip install -r requirements.txt
fi
