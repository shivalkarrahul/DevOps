sudo apt-get update -y

echo 'Installing Git...'
sudo apt-get install git -y

echo 'Congigure Git...'

echo "Enter the Global Username for Git";
read gitUser;
git config --global user.name "${gitUser}"

echo "Enter the Global Email for Git";
read gitMail;
git config --global user.email "${gitMail}"

echo 'Git has been configured'
git config --list
