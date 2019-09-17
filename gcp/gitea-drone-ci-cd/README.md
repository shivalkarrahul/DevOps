Pre-requisites
-------------
- Access to GCP from command line.
- Ubuntu 16.04 Server and root access on it.
- Kubernetes Cluster on GKE
- Disk on GCE (Disk-Name=drone-server-sqlite-db, Size as per the requirement)


Installation and Integration of Gitea with Drone for CI/CD
-------------
**Installation Scripts**
*gitea/install-gitea.sh*
*drone/install-drone.sh*

**Uninstallation Scripts**
*gitea/remove-gitea.sh*
*drone/remove-drone.sh*


**Detailed Deployment Steps**
*gitea/README.md *
*gitea/README.md *


Test CI/CD
-------------
At current location, you will find a 'sample_python' directory

1. Go to Gitea Web UI
2. Create a new repo " sample_python". Do not initialize it with README
3. Now go to Drone Web UI and Syncronize the repositories. Enable this repo on Drone
4. At current location where you have cloned this repo, copy 'sample_python' from here to any other location
5. Go to copied 'sample_python' directory

Now execute the following command

```
touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin http://IP-OF-GITEA/rahul.shivalkar/sample_python.git
git push -u origin master
```

Go to Drone Web UI and See if the pipeline was executed.
