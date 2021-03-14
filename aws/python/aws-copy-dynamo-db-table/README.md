### Features

-  Make a copy of DynamoDB table.

Note: Before executing the script, make sure you have AWS access and secret keys of source and destination account with sufficient/full permissions to perform operations on DynamoDB tables

Make a copy of DynamoDB table.

This script copies defined number of items from one DynamoDB table to another. It covers the following use-cases.

1. Both the tables do not exist
2. Source Table does not exist
3. Destination Table does not exist
4. Both the table exist

-------------

**Files:** 
```
    copy-dynamodb-table.py:  This script accepts command line arguments and create a copy of DynamoDB table
```

**Python Command to the run the script:**
`python copy-dynamodb-table.py -sa <source-account-access-key-here> -ss <source-account-secret-key-here> -da <destination-account-access-key-here> -ds <destination-account-secret-key-here>
bV2A5cMfurscg -st <source-table-name-here> -dt <destination-table-name-here>`

**Dependency Module:**
`boto3`