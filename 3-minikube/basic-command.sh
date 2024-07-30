minikube start

kubectl version

# periksa status komponen
kubectl get componentstatuses

# Context
kubectl config set-context my-context --namespace=ngoprek
kubectl config use-context my-context

# Melihat objek API Kubernetes
kubectl describe