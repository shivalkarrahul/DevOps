### Features

-  Delete specified AWS EBS Volumes.

Note: Before executing the script, make susre that you have defined AWS Credentials in config.properties available at the current location

Delete specified AWS EBS Volumes..
-------------

**Files:** 
```
    config.properties:  This file contains aws_access_key_id_value and aws_secret_access_key_value which need to be defined 
    delete-specified-ebs-volumes.py :  This script will read delete the EBS Volumes specified in the script as a list of volume_ids. Specify all those EBS Volume IDs which need to be deleted
```
***Define the following in config.properties*** 

```
	aws_access_key_id_value='ACCESS-KEY-OF-THE-AWS-ACCOUNT'
	aws_secret_access_key_value='SECRETE-KEY-OF-THE-AWS-ACCOUNT'

```

**Python Command to the run the script:**
`python delete-specified-ebs-volumes.py`

**Dependency Module:**
`boto3`

