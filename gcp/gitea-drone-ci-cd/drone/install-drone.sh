kubectl cluster-info
if [ $? -eq 1 ]
then
  echo "kubectl was unable to reach your Kubernetes cluster."
  echo "gcloud container clusters get-credentials cluster-name --zone region --project cloudcover-sandbox"
  exit 1
fi

echo "Deleting NameSpace=drone if exists"
kubectl delete namespace drone
if [ $? -eq 1 ]
then
	echo ""
 	echo "" 
	echo "This is the first time you are deploying Drone. Before continuing, go through README.md"
        echo "You should have an existing Kubernetes cluster and persistent disks in the same zone" 
	echo "Also make the required changes in drone-configmap.yaml"
	echo
	read -p "<Press enter once you've made the changes>"
fi


echo "Create drone namespace..."
kubectl create -f drone-namespace.yaml


kubectl create -f drone-server-service.yaml
kubectl get service -n drone
if [ $? -eq 0 ]
then
  echo "We have created a frontfacing loadbalancer. We need to wait till the time it gets an external IP"
  while true; do
    echo "Waiting for 20 seconds for External IP Assignment"
#    sleep 20

    echo -ne '                        (0%)\r'
    sleep 4
    echo -ne '########                (20%)\r'
    sleep 4
    echo -ne '#############           (40%)\r'
    sleep 4
    echo -ne '#################       (60%)\r'
    sleep 4
    echo -ne '#####################   (80%)\r'
    sleep 4
    echo -ne '########################(100%)\r'
    sleep 1
    echo -ne '\n'


    
    echo "Getting Information of the drone-service"
    kubectl get service -n drone
    read -p "Do you see value assigned to EXTERNAL-IP field? (y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Let's wait for some time";;
        * ) echo "Let's wait for some tome";;
    esac
  done
  echo
  echo "Great, we will now use this IP to access Drone"
fi


echo "Before proceeding, make the required changes in drone-configmap.yaml"
read -p "<Press enter once you've made the changes>"


echo "Create drone-config configmap..."
kubectl create -f drone-configmap.yaml


echo "Create drone-server deployment"
kubectl create -f drone-server-deployment.yaml

echo "create drone-agent deployment"
kubectl create -f drone-agent-deployment.yaml

echo "Get all the resources of drone namespace"
kubectl get all -n drone



