helpFunction()
{ 
      echo ""
      printf "\033[1;32mUsage: $0 -K <internal.pem> -U <internal-user> -I <internal-ip> -u <user-to-be-created> -k <\"public-key-string-shared-by-the-user\">"
      echo ""
      echo -e "\t-K \".pem key of the server on which a new user has be created\""
      echo -e "\t-U UserName of the server on which a new user has be created"
      echo -e "\t-I IP of the server on which a new user has be created "
      echo -e "\t-u user to be created on the internal server"
      echo -e "\t-k \"public key string to be added shared by the user\""
      echo -e "Put Public Key in double quotes"

      echo -e  "e.g."
      echo "./provide-access.sh -U ubuntu -K /Users/Documents/Rahul/access/rahuls.pem -I 192.168.134.100  -u rahul -k  \"ssh-rsa Z1rbx6/F/ZntfkvKzX6e82ZXETBSMkFXZ2oYOOLb9QtTu4IO+W560+afjp1xLOYqWNyX+fI8N6WHKeEsZycq0iyHX5herNWxorLU3gGnwGSABCb+62yP3eaESMMV+9dJjFC9X4IyLHMR91OeDsxeLL41ABANofMROQ8yDjNcYVUxjKWyzNzuJxgnN5KngwkUOWHGbCFmHUsz1WVuWA+rhhk1CPZFywUdsDeGR/Dxd+oNKGvaKGIQuDqK1vY5GiLg0N+OvanTPbLper3/Z5A5d62fRF6+mensZGsKW543 key-name\""

      echo -e "\033[0m" #reset color
      exit 1 # Exit script after printing help
}

while getopts "I:K:U:u:k:" opt
do
   case "$opt" in
      K ) internalServerPemKey="$OPTARG" ;;
      U ) internalServerUser="$OPTARG" ;;	
      I ) internalServerIP="$OPTARG" ;;
      u ) userName="$OPTARG" ;;
      k ) keyString="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$internalServerIP" ] || [ -z "$internalServerPemKey" ] || [ -z "$internalServerUser" ] || [ -z "$userName" ] || [ -z "$keyString" ]
then
      printf "\033[1;31m"
      echo "Some or all of the parameters are empty";
      helpFunction
fi

# Begin script in case all parameters are correct
printf "\033[1;33m------------------------------------------------------------------Before ssh"
echo -e "\033[0m" #reset color
echo ".pem key of the server on which a new user has be created		:  	$internalServerPemKey"
echo "UserName of the server on which a new user has be created		: 	$internalServerUser"
echo "IP of the server on which a new user has be created			:	$internalServerIP"
echo "user to be created on the internal server				:	$userName"
echo "public key string to be added shared by the user			:	$keyString"


printf "\033[1;31mLogging into: "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"

ssh -i "$internalServerPemKey" "$internalServerUser"@"$internalServerIP" << HERE
      printf "\033[1;33m------------------------------------------------------------------After ssh"
      echo -e "\033[0m" #reset color
      echo "Creating user \"$userName\" <--- on ---> \"$internalServerIP\" <---"
      sudo useradd -m $userName

      sleep 2
      echo "Changing user to \"$userName\""
      sudo -i -u $userName bash << EOF
      echo "User Switched To;"
      whoami
      echo "creating dir: .ssh"
      mkdir -p .ssh
      echo "changing permission of dir .ssh to 700"
      chmod 700 .ssh
      echo "creating a file: .ssh/authorized_keys"
      touch .ssh/authorized_keys
      echo "changing permission of .ssh/authorized_keys to 600"
      chmod 600 .ssh/authorized_keys
      echo "appending $keyString "
      echo "to .ssh/authorized_keys"
      echo '$keyString' >> .ssh/authorized_keys


      echo "Content of .ssh/authorized_keys"
      cat .ssh/authorized_keys
      printf "\033[1;31mExiting from         ---> "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"
      #echo "Existing user	---> $userName"
EOF
HERE
