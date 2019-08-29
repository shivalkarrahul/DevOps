### Features

-  List AWS S3 Buckets.
Note: Before executing the script, make susre that you have defined AWS Credentials in config.properties available at the current location

List AWS S3 Buckets.
-------------

**Files:** 
```
    config.properties:  This file contains aws_access_key_id_value and aws_secret_access_key_value which need to be defined 
    list-s3-bluckets.py:  This script will read values defined in config.properties and list all the bukckets available in the respective AWS Account
```
***Define the following in config.properties*** 

```
	aws_access_key_id_value='ACCESS-KEY-OF-THE-AWS-ACCOUNT'
	aws_secret_access_key_value='SECRETE-KEY-OF-THE-AWS-ACCOUNT'

```

**Python Command to the run the script:**
`python list-s3-bluckets.py`

**Dependency Module:**
`boto3`

