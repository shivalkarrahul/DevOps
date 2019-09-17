#!/bin/bash

VER="1.9.2"
# Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea

  # Check if architecure is x86 and download Gitea
if [ -n "$(uname -a | grep x86_64)" ]; then
  sudo curl -fsSL -o "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/"$VER"/gitea-"$VER"-linux-amd64"
fi

sudo chmod +x /opt/gitea/gitea-$VER
rm -f /opt/gitea/gitea
sudo ln -sf gitea-$VER /opt/gitea/gitea
sudo ln -sf gitea-$VER /usr/local/bin/gitea

# Download and install the gitea.service for systemd
sudo curl -fsSL -o /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/branch/master/dist/etc/systemd/system/gitea.service

# Start gitea
sudo systemctl enable gitea

sudo systemctl restart gitea

echo ""
echo "###################################"
echo "# Post Installation Configuration #"
echo "###################################"

echo ""
echo ""
echo "# Visit the URL with Publicly Available IP at Port 3000 (Default Port) and click on Register"
echo ""
echo "		http://Public IP:3000/"
echo "		Do the required changes, change the port to 80"
echo "		Select SQLite3 Database"
echo "		Future changes can be made by editing the config file:"
echo "        	/opt/gitea/custom/conf/app.ini"
echo ""
echo "Once the configuraiton is done restart the Gitea service"
echo "service gitea status"
echo "Now, Gitea is available on a  new Link with Custom Port 80"

echo "Again visit the URL and click on Register to register a new user"

