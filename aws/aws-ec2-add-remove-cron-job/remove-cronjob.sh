#!/bin/bash

helpFunction()
{ 
	echo ""
	printf "\033[1;32mUsage: $0 -K <internal.pem> -U <internal-user> -I <internal-ip> -l <yes/no>"
	echo ""
	echo -e "\t-K \".pem key of the server on which a cron job has to be removed\""
	echo -e "\t-U UserName of the server on which a cron job has to be removed"
	echo -e "\t-I IP of the server on which a cron job has to be removed"
	echo -e "\t-l List the existing Cron Jobs, provide \"yes\" as a parameter. Get a list first and then specify job no which needs to be removed"
	echo -e  "e.g."
	echo "Remove a new Cron Job"
	echo "./remove-cronjob.sh -K /Users/cloudcover/Documents/Rahul/access/rahuls.pem -U ubuntu -I ec2-52-47-90-247.eu-west-3.compute.amazonaws.com -l yes"
	echo -e "\033[0m" #reset color
	exit 1 # Exit script after printing help
}

while getopts "I:K:U:l:" opt
do
	case "$opt" in
	K ) internalServerPemKey="$OPTARG" ;;
	U ) internalServerUser="$OPTARG" ;;	
	I ) internalServerIP="$OPTARG" ;;
	l ) showListOfJobs="$OPTARG" ;;
	? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
	esac
done

echo  "******************"
echo $listCronJobs

# Print helpFunction in case parameters are empty
if [ -z "$internalServerIP" ] || [ -z "$internalServerPemKey" ] || [ -z "$internalServerUser" ] || [ -z "$showListOfJobs" ]
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

if [ $showListOfJobs == "yes" ]
then

	printf "\033[1;31mLogging into: "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"
	ssh -i "$internalServerPemKey" "$internalServerUser"@"$internalServerIP" << HERE
		printf "\033[1;33m------------------------------------------------------------------After ssh"
		echo -e "\033[0m" #reset color
		echo "after ssh"
		hostname -I
		hostname
		echo "Changing user to root"
		sudo su << EOF
			echo "User Switched To;"
			whoami
			printf "\033[1;33m------------------------------------------------------------------List of Cron Jobs Before Deletion"
			echo -e "\033[0m" #reset color
			crontab -l | cat -n
			printf "\033[1;31mExiting from         ---> "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"
EOF
HERE
fi


echo "Enter Cron Job Line Number to be removed"
read lineNumber
printf "\033[1;31mLogging into: "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"
ssh -i "$internalServerPemKey" "$internalServerUser"@"$internalServerIP" << HERE
	printf "\033[1;33m------------------------------------------------------------------After ssh"
	echo -e "\033[0m" #reset color
	echo "after ssh"
	hostname -I
	hostname
	#sleep 2
	echo "Changing user to root"
	sudo su << EOF
		echo "User Switched To;"
		whoami
		printf "\033[1;33m------------------------------------------------------------------List of Cron Jobs Before Deletion"
		echo -e "\033[0m" #reset color
		crontab -l | cat -n
		crontab -l | sed -e "$lineNumber"d >crontab.tmp
		crontab crontab.tmp && rm -f crontab.tmp
		printf "\033[1;33m------------------------------------------------------------------Updated List of Cron Jobs"
		echo -e "\033[0m" #reset color
		crontab -l | cat -n
		printf "\033[1;31mExiting from         ---> "$internalServerPemKey" "$internalServerUser"@"$internalServerIP"\033[0m\n"
EOF
HERE
