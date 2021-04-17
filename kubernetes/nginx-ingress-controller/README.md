# Nginx Ingress Controller

[How To Set Up an Nginx Ingress Controller ]

## Prerequisite: Setup a Kubernetes Cluster using Kops

```bash
kops version #Check kops vesion, tested with Version 1.18.2
helm version # Tested with Helm v3.5.3

export AWS_ACCESS_KEY_ID=AKIAQ6GAIA5XB4MK7IS7 #Export AWS Access Key
export AWS_SECRET_ACCESS_KEY=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 ##Export AWS Secret Key

export KOPS_STATE_STORE=s3://kops.devopslee.com
kops get clusters
kops create cluster --name kops.devopslee.com --state s3://kops.devopslee.com --cloud aws --master-size t2.small --master-count 1 --master-zones us-east-1a --node-size t2.small --node-count 2 --zones us-east-1a,us-east-1b,us-east-1c
kops get cluster
kops update cluster --name kops.devopslee.com
kops update cluster --name kops.devopslee.com --yes
kops validate cluster --wait 10m
kubectl get pods -A
```

## Setup Ingress Controller

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
#This will create a LoadBalancer in your aws account. Create a desired record in Route53 poiting to the LoadBalancer
```


## Check objects created by Ingress Controller

```bash
kubectl get pods
kubectl get deployment
kubectl get service
```

## Deploy a sample application

### Deployment and Service and Ingress 

```bash
kubectl apply -f 1-nginx-main-app.yaml
kubectl apply -f 2-nginx-green-app.yaml
kubectl apply -f 3-nginx-blue-app.yaml
kubectl get deployments
kubectl get pods
kubectl get service
kubectl logs nginx-ingress-ingress-nginx-controller-5c97c6b4d5-btvpl -f 
kubectl apply -f 4-ingress.yaml

```

### Ingress

```bash
kubectl logs nginx-ingress-ingress-nginx-controller-5c97c6b4d5-btvpl -f 
kubectl apply -f 4-ingress.yaml
```


## Test the application URL

[Main](http://kops.devopslee.com/)

[Green](http://kops.devopslee.com/green)

[Red](http://kops.devopslee.com/blue)


# Delete the cluster

```bash
kops delete cluster kops.devopslee.com --yes
```