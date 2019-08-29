### Features

-  Create a First Pod on Kubernetes.
Note: Before executing the script, make sure you have Kubernetes cluster setup with you.

Create a First Nginx Pod on Kubernetes..
-------------

**Files:** 
```
    first-nginx-pod.yaml:  This .yaml file contains pod defination.

```

**kubectl Commands:**

>Get Nodes in the cluster

    shell $ kubectl get nodes

>Create a Pod
    
    shell $ kubectl apply -f first-nginx-pod.yaml

>Get details of the Pod 

    shell $ kubectl get pods

> Delete the Pod

    shell $ kubectl delete pod myfirstpod

> Verify if the Pod has been deleted
    
    shell $ kubectl get pods
