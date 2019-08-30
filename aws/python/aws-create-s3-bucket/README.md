### Features

-  Create AWS S3 Buckets.
Note: Before executing the script, make susre that you have defined AWS Credentials in config.properties available at the current location

Create AWS S3 Buckets.
-------------

**Files:** 
```
    config.properties:  This file contains aws_access_key_id_value and aws_secret_access_key_value which need to be defined 
    create-s3-blucket.py:  This script will read values defined in config.properties and create a bucket in the respective AWS Account
```
***Define the following in config.properties*** 

```

	aws_access_key_id_value='ACCESS-KEY-OF-THE-AWS-ACCOUNT'
	aws_secret_access_key_value='SECRETE-KEY-OF-THE-AWS-ACCOUNT'
	Bucket_value='S3-BUCKET-NAME'
	LocationConstraint_value='REGION-FOR-S3-BUCKET'

```

**Python Command to the run the script:**
`python create-s3-blucket.py`

**Dependency Module:**
`boto3`

