### Features

-  Delete Ununsed EBS Volumes.

Delete Unused EBS Volumes .
-------------

**Files:** 
```
    delete-unused-ebs-volumes.py :  This lambda script will delete EBS Volumes which are in `state=available` and have no tags or tags other than `Name=DND`
```

Note: Create a Lamda Function on AWS using the code from this script
