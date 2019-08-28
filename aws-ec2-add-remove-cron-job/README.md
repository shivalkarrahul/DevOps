### Features

- Add cronjob on the specified linux server.
- Remove cronjob from the specified linux server.

Add cronjob on to the specified linux server.
-------------

**Script Name:** add-cronjob.sh
**Parameters to the Script:** 4
**Usage:** ./add-cronjob.sh -K internal.pem -U internal-user -I internal-ip -a cron-to-be-added
***Where,*** 
```
        -K ".pem key of the server on which a cron job has to be added"
        -U UserName of the server on which a cron job has to be added
        -I IP of the server on which a cron job has to be added
        -a Name of the cron to be added (in double quotes)
```

**e.g.**
`./add-cronjob.sh -K /Users/rahul/Documents/Rahul/access/rahuls.pem -U ubuntu -I ec2-35-180-234-158.eu-west-3.compute.amazonaws.com -a "0 5 * * 1  testCronJob"`


Remove cronjob from the specified linux server.
-------------

**Script Name:** remove-cronjob.sh
**Parameters to the Script:** 4
**Usage:** ./remove-cronjob.sh -K internal.pem -U internal-user -I internal-ip -l yes
***Where,*** 
```
        -K ".pem key of the server from  which a cron job has to be removed"
        -U UserName of the server from which a cron job has to be removed
        -I IP of the server from which a cron job has to be removed
        -l List the existing Cron Jobs, provide "yes" as a parameter. Get a list first and then specify job no which needs to be removed
```

**e.g.**
`./remove-cronjob.sh -K /Users/rahul/Documents/Rahul/access/rahuls.pem -U ubuntu -I ec2-52-47-90-247.eu-west-3.compute.amazonaws.com -l yes`

