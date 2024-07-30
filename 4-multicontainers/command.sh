kubectl get deployment
kubectl get pods

kubectl describe pod <pod_name>
kubectl logs <pod_name>

kubectl port-forward deployment/kudemo-api-deployment 8080:8080
