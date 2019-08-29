### Features

-  Create EC2 instance.
Note: Before executing the script, make susre that you have defined AWS Credentials and other required variables in config.properties available at the current location

Create EC2 instance on AWS.
-------------

**Files:** 
```
    config.properties:  This file contains aws_access_key_id_value and aws_secret_access_key_value which need to be defined 
    create-ec2-instance.py:  This script will read values defined in config.properties and create an ec2 instance on the respective AWS Account

```
***Define the following in config.properties*** 

```
	aws_access_key_id_value='ACCESS-KEY-OF-THE-AWS-ACCOUNT'
	aws_secret_access_key_value='SECRETE-KEY-OF-THE-AWS-ACCOUNT'
        region_name_value='us-west-2'
 	ImageId_value = 'ami-08692d171e3cf02d6'
        MinCount_value = 1
        MaxCount_value = 1
        InstanceType_value = 't2.micro'
        KeyName_value = 'key-pair-name'

```

**Python Command to the run the script:**
`python create-ec2-instance.py`

**Dependency Module:**
`boto3`

