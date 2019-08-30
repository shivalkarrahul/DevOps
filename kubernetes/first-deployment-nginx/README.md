### Features
  
-  Create a First Deployment on Kubernetes.
Note: Before executing the yaml, make sure you have Kubernetes cluster setup with you.

Create a First Nginx Deployment on Kubernetes..
-------------

**Files:**
```
    first-nginx-deployment.yaml:  This .yaml file contains deployment defination.

```

**kubectl Commands:**

>Get Nodes in the cluster

    shell $ kubectl get nodes

>List your deployments
    
    shell $ kubectl get deployments

>List the pods

    shell $ kubectl get pods

> Create a Deployment:

    shell $ kubectl apply -f first-nginx-deployment.yaml

> Get the deployments

    shell $ kubectl get deployments
    
> See the running pods

    shell $ kubectl get pods
    
    
> Describe the deployment

    shell $ kubectl describe deployments nginx-deployment
    
    
> Describe the pods

    shell $ kubectl describe pod <pod_name>

    
> Get an IP of one of the pods

    shell $ kubectl describe pod <pod_name> | grep IP
    
        
> Hit the IP:Port

    shell $ curl <IP> 80
    
    
        
> Delete your Pod if you don’t need it any more

    shell $ kubectl get pods
    shell $ kubectl delete pod <pod_name>
    shell $ kubectl get pods
    * Observe that even after deleting a pod, a new pod got created. This is because we had specified replica: 2 in the deployment and deployment always takes care of it. Deployment recreated a pod to meet the replica count replica: 2. To bring this deployment down we have to delete the deployment.
    
> Delete the deployment
    
    shell $ kubectl get deployments
    shell $ kubectl delete deployments nginx-deployment
    shell $ kubectl get deployments
    shell $ kubectl get pods
    shell $ kubectl get pods
