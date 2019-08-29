### Features

-  List AWS EC2 Instance.
Note: Before executing the script, make susre that you have defined AWS Credentials in config.properties available at the current location

List AWS EC2 Instances from all the regions.
-------------

**Files:** 
```
    config.properties:  This file contains aws_access_key_id_value and aws_secret_access_key_value which need to be defined 
    list-ec2-instances.py:  This script will read values defined in config.properties and list all the ec2 instances available in the respective AWS Account
```
***Define the following in config.properties*** 

```
	aws_access_key_id_value='ACCESS-KEY-OF-THE-AWS-ACCOUNT'
	aws_secret_access_key_value='SECRETE-KEY-OF-THE-AWS-ACCOUNT'

```

**Python Command to the run the script:**
`python list-ec2-instances.py`

**Dependency Module:**
`boto3`

