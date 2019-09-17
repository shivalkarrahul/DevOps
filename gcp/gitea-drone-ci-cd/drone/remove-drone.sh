kubectl cluster-info
if [ $? -eq 1 ]
then
  echo "kubectl was unable to reach your Kubernetes cluster."
  echo "gcloud container clusters get-credentials cluster-name --zone region --project cloudcover-sandbox"
  exit 1
fi

echo "Deleting NameSpace=drone if exists"
kubectl delete namespace drone

