#!/bin/bash

helpFunction()
{ 
	echo ""
	printf "\033[1;32mUsage: $0 -K <internal.pem> -U <internal-user> -I <internal-ip> -a <cron-to-be-added>"
	echo ""
	echo -e "\t-K \".pem key of the server on which a cron job has to be added\""
	echo -e "\t-U UserName of the server on which a cron job has to be added"
	echo -e "\t-I IP of the server on which a cron job has to be added"
	echo -e "\t-a Name of the cron to be added (in double quotes)"
	echo "Add a new Cron Job"
	echo "e.g."
	echo "./add-cronjob.sh -K /Users/cloudcover/Documents/Rahul/access/rahuls.pem -U ubuntu -I ec2-35-180-234-158.eu-west-3.compute.amazonaws.com -a \"0 5 * * 1  testCronJob\""

	echo -e "\033[0m" #reset color
	exit 1 # Exit script after printing help
}

while getopts "I:K:U:a:" opt
do
	case "$opt" in
		K ) internalServerPemKey="$OPTARG" ;;
		U ) internalServerUser="$OPTARG" ;;	
		I ) internalServerIP="$OPTARG" ;;
		a ) addCron="$OPTARG" ;;
		? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
	esac
done

echo  "******************"
#echo $listCronJobs
# Print helpFunction in case parameters are empty
if [ -z "$internalServerIP" ] || [ -z "$internalServerPemKey" ] || [ -z "$internalServerUser" ] || [ -z "$addCron" ]
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
echo "Name of the cron to be added				:	$addCron"


printf "\033[1;31mLogging into: "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"

ssh -i "$internalServerPemKey" "$internalServerUser"@"$internalServerIP" << HERE

printf "\033[1;33m------------------------------------------------------------------After ssh"
echo -e "\033[0m" #reset color
#echo "Executing connect_prod_cron_new.sh"
#sh connect_prod_cron_new.sh
#sleep 2
echo "after ssh"
echo "IP Of the Server:" 
hostname -I
echo "Hostname of the Server:"
hostname
echo "Changing user to root"
	sudo su << EOF
	echo "User Switched To;"
	whoami
	printf "\033[1;33m------------------------------------------------------------------List of Cron Jobs Before Addition"
	echo -e "\033[0m" #reset color
	crontab -l | cat -n
	if [ -n "$addCron" ]
	then
		echo "Inside addCron"
		crontab -l >crontab.tmp
		printf '%s\n' "$addCron" >>crontab.tmp
		crontab crontab.tmp && rm -f crontab.tmp
	fi
	printf "\033[1;33m------------------------------------------------------------------Updated List of Cron Jobs"
	echo -e "\033[0m" #reset color
	crontab -l | cat -n
	printf "\033[1;31mExiting from         ---> "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"
	#echo "Existing user	---> $userName"
EOF
HERE
