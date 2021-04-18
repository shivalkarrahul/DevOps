# CertManager, Let’s Encrypt

[How To Setup a Cert Manager on Kubernetes]

## Pre-requisites

[Nginx Ingress Controller on the Kubernetes Cluster](https://github.com/shivalkarrahul/DevOps/tree/master/kubernetes/nginx-ingress-controller)

## Check Ingress Controller running in the Cluster

```bash
kubectl get pods
kubectl get svc
```

## Setup Cert Manager

```bash
#Tested with Helm v3.5.3
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.2.0 --set installCRDs=true
```

### Check resources created by the Cert Manager in the Cluster 

```bash
kubectl get pods -A
```

## Create a Let's Encrypt Cluster Issuer

### Create a Staging Issuer

```bash
kubectl logs cert-manager-56f5c44b5d-jn46m -n cert-manager -f
kubectl apply -f cluster-issuer/staging_issuer.yaml
```

### Check Staging Secret

```bash
kubectl get secret letsencrypt-staging-private-key -n cert-manager -o json
```

### Create a Production Issuer

```bash
kubectl logs cert-manager-56f5c44b5d-jn46m -n cert-manager -f
kubectl apply -f cluster-issuer/production_issuer.yaml
```

### Check Production Secret

```bash
kubectl get secret letsencrypt-production-private-key -n cert-manager -o json
```

## Deploy a sample application and path-based Ingress resource

### Deployment, and Service Ingress 

```bash
kubectl apply -f sample-app/1-nginx-main-app.yaml
kubectl apply -f sample-app/2-nginx-green-app.yaml
kubectl apply -f sample-app/3-nginx-blue-app.yaml
kubectl get deployments
kubectl get pods
kubectl get service
```

### Ingress with Staging Issuer 

```bash
kubectl apply -f sample-app/4-tls-ingress.yaml
kubectl get ingress
kubectl describe ingress ingress-resource-3 
```

### Check the certificate, certificate request, order and secret

```bash
kubectl get certificate -A
kubectl get certificaterequests.cert-manager.io -A
kubectl get orders.acme.cert-manager.io -A
kubectl get challenges.acme.cert-manager.io -A
kubectl get certificate  -o json | grep secretName
kubectl get secret sample-kubernetes-tls -o yaml
```

### Test the application URLs with HTTPS

[Root](https://kops.devopslee.com/)

[Green](https://kops.devopslee.com/green)

[Red](https://kops.devopslee.com/blue)

### Ingress with Production Issuer 

```bash
kubectl delete -f sample-app/4-tls-ingress.yaml
kubectl apply -f sample-app/5-tls-ingress-prod-issuer.yaml
kubectl get ingress
kubectl describe ingress ingress-resource-3 
```

### Again test the application URLs with HTTPS

[Root](https://kops.devopslee.com/)

[Green](https://kops.devopslee.com/green)

[Red](https://kops.devopslee.com/blue)
