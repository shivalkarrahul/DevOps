### Features

- Install Gitea
- Uninstall Gitea

Pre-requisites
-------------
- Ubuntu 16.04
- Access to root user


Install Gitea on Ubuntu 16.04
-------------

**Script Name:** install-gitea.sh
**Parameters to the Script:** 0
**Usage:** ./install-gitea.sh

**Post Installation Steps**
Visit the link on Port 3000, click on Register and make the required configuration. 

```
Database Type: Select SQLite3
Path : Keep this default
Site Title: Keep this default
Repository Root Path: Keep this default
Git LFS Root Path: Keep this default
Run As Username: Keep this default
SSH Server Domain: Replace localhost with Public IP
SSH Server Port: Keep this default
Gitea HTTP Listen Port: Change this to 80
Gitea Base URL: Replace localhost with Public IP
Log Path: Keep this default

```
**Note**: Try other settings on your own to explore more about Gitea.


**New user Registration Steps**

Now restart gitea once you are done with the post installation step mentioned above.
`service gitea restart`

Visit the link on port 80
Fill in the following required details to create a new user
```
Username: 
Email Address:
Password:
Re-Type Password:
```


Uninstall Gitea from Ubuntu 16.04
-------------

**Script Name:** remove-gitea.sh
**Parameters to the Script:** 0
**Usage:** ./remove-gitea.sh

Extra files at current location
-------------
Ignore `gitea.service` and `gitea-1.9.2-linux-amd64` file. These files can be used in future if they are not available for download.
