#!/usr/bin/env bash

echo "setting up nginx (please wait...)"
rm /etc/nginx/sites-enabled/default
cp /vagrant/nginx/app.service /etc/systemd/system/
cp /vagrant/nginx/app_site /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/app_site /etc/nginx/sites-enabled/app_site

echo "setting up nginx services (please wait...)"
systemctl restart nginx
sudo systemctl start app
sudo systemctl enable app
sudo mkdir -p /var/log/uwsgi
sudo chown -R ubuntu:ubuntu /var/log/uwsgi
