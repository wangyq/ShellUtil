#!/bin/sh

chmod a+x rc.local
sudo cp rc.local /etc/

sudo cp rc-local.service /etc/systemd/system/
sudo systemctl enable rc-local

echo "Install rc-local service done!"

