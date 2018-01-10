#!/usr/bin/env bash

apt-get update

packagelist=(
    build-essential
    libssl-dev
    nginx
    openssl
    python-dev
    python3-pip
    redis-server
    xorg
    xvfb
)

apt-get -y install ${packagelist[@]}

# Set up virtual env
if ! [ -L /vagrant/env ]; then
  echo "setting up virtual env"
  cd /vagrant
  pip3 install virtualenv
  virtualenv env
  . env/bin/activate
  pip install -r requirements.txt
fi
