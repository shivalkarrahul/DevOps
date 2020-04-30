### Features

-  Delete Ununsed EBS Volumes.

Note: Before executing the script, make susre that you have defined AWS Credentials in config.properties available at the current location

Delete Unused EBS Volumes .
-------------

**Files:** 
```
    config.properties:  This file contains aws_access_key_id_value and aws_secret_access_key_value which need to be defined 
    delete-unused-ebs-volumes.py :  This script will delete EBS Volumes which are in `state=available` and have no tags or tags other than `Name=DND`
```
***Define the following in config.properties*** 

```
	aws_access_key_id_value='ACCESS-KEY-OF-THE-AWS-ACCOUNT'
	aws_secret_access_key_value='SECRETE-KEY-OF-THE-AWS-ACCOUNT'

```

**Python Command to the run the script:**
`python delete-unused-ebs-volumes.py `

**Dependency Module:**
`boto3`

