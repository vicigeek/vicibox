#!/bin/bash

# Navigate to /var/tmp
cd /var/tmp || exit 1

# Clone the repository
git clone https://github.com/ccabrerar/ViciPhone.git

# Check if clone was successful
if [ ! -d "ViciPhone" ]; then
  echo "Clone failed, exiting."
  exit 1
fi

# Copy the ViciPhone directory to the target location
cp -r ViciPhone /srv/www/htdocs/agc/viciphone

# Set permissions
chmod -R 755 /srv/www/htdocs/agc/viciphone

echo "ViciPhone successfully cloned, copied, and permissions set."
