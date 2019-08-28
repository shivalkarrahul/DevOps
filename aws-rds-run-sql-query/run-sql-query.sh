#!/bin/bash

helpFunction()
{ 
	echo ""
	printf "\033[1;32mUsage: $0 -u rds-user -e rds-end-point -d database-name -q \"query-to-be-executed;\""
	echo ""
	echo -e "\t-u user-name of the RDS server on which a query has to be executed"
	echo -e "\t-e end-point of the RDS server on which a query has to be executed"
	echo -e "\t-d database in the RDS server on which a query has to be executed"
	echo -e "\t-q query to be executed (in double quotes and semi-colon at the end) "
	echo -e  "e.g."
	echo "Run a query"
	echo "./run-sql-query.sh -u admin -e database-1.csykuyezi6cx.eu-west-3.rds.amazonaws.com -d information_schema -q \"describe COLUMNS;\""

	echo -e "\033[0m" #reset color
	exit 1 # Exit script after printing help
}

while getopts "u:e:d:q:" opt
do
	case "$opt" in
	u ) userName="$OPTARG" ;;
	e ) endPoint="$OPTARG" ;;	
        d ) databaseName="$OPTARG" ;;
        q ) query="$OPTARG" ;;
	? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
	esac
done

echo  "******************"

# Print helpFunction in case parameters are empty
if [ -z "$userName" ] || [ -z "$endPoint" ] || [ -z "$databaseName" ] || [ -z "$query" ]
then
	printf "\033[1;31m"

	echo "Some or all of the parameters are empty";
	helpFunction
fi

# Begin script in case all parameters are correct
printf "\033[1;33m------------------------------------------------------------------Before ssh"
echo -e "\033[0m" #reset color
echo "user-name of the RDS server on which a query has to be executed			:  	$userName"
echo "end-point of the RDS server on which a query has to be executed			: 	$endPoint"
echo "database name on the RDS server on which a query has to be executed   		:       $databaseName"
echo "query which has has to be executed 						:       $query"

printf "\033[1;33mEnter the password"
read -s password

echo ""
printf "\033[1;31mConnecting to: "$userName" at "$endPoint"\033[0m\n"
echo ""
printf "\033[1;33mOutput of $query on $databaseName"
echo -e "\033[0m" #reset color
echo ""
#printf "\033[1;31mExecuting : "$query" on "$databaseName"\033[0m\n"
mysql -h "$endPoint" -u "$userName" -p$password <<EOF
	use $databaseName;
	$query
EOF
printf "\033[1;31mdisconnecting to: "$userName" at "$endPoint"\033[0m\n"
