- Kubernetes Cluster
- Disk (Name=drone-server-sqlite-db, Size as per the requirement)


Deployment of Drone: Manual
-------------

**Deployment Steps**
```
kubectl delete namspace drone
kubectl create -f drone-namespace.yaml
kubectl create -f drone-server-service.yaml
```
Wait till the time Loadbalancer gets the External IP, use the following command to check the status of the service.
`kubectl get service -n drone`

Once the Service gets an External IP, make the required changes in drone-configmap.yaml.
Edit `drone-configmap.yaml` to  replace SERVICE-EXTERNAL-IP with the External IP of the Service( this will be Drone Server IP ) and GITEA-EXTERNAL-IP with the External IP of Gitea.

```
kubectl create -f drone-configmap.yaml
```


```
kubectl create -f drone-server-deployment.yaml
kubectl create -f drone-agent-deployment.yaml
kubectl get all -n drone
```
The output of the above command should give you all the resources available under 'drone' namespace.
You should see all the resources in running state.

Rollback the Deployment of Drone: Manual
-------------
If you wish to rollback the deployment go through the following steps.

```
kubectl get all -n drone
kubectl delete deployment drone-agent -n drone
kubectl delete deployment drone-server -n drone
kubectl delete service drone-service -n drone
kubectl delete configmap drone-config -n drone
kubectl delete namespace drone
get all -n drone
```

Deployment of Drone: Automation
-------------

**Deployment Steps**
```
./install-drone.sh 
```

Note: When the execution is in progress read the instrctions carefully.

```
get all -n drone
```
The output of the above command should give you all the resources available under 'drone' namespace.
You should see all the resources in running state.


**Login to Drone**
-------------
Use credentials of Gitea to login into Drone which will sync up with gitea and enable the required repos on Drone for CI/CD.
You are all set to use Drone with Gitea for CI/CD.


**Uninstall Drone**
-------------
The following command will remove the 'drone' namespace
`remove-drone.sh`
