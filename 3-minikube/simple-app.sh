kubectl run halo-kube --image=ngoprek/halo-kube --port=80

kubectl port-forward pod/halo-kube 8080:80

# kubectl pod command

kubectl get pod
kubectl delete pod <pod_name>