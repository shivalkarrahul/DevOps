echo "Removing Gitea and All its data."

echo "Stopping and removing the Gitea service."
sudo systemctl stop gitea
sudo systemctl disable gitea
sudo rm /etc/systemd/system/gitea.service

echo "Deleting Gitea configuration its data"

sudo rm /usr/local/bin/gitea
sudo rm -rf /opt/gitea
