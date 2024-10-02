# Ajouter le dépôt Helm
helm repo update
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Installer Prometheus dans le namespace monitoring
helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace

# Attendre que les pods soient en cours d'exécution
Write-Output "Attendre que les pods Prometheus soient en cours d'exécution..."
kubectl rollout status deployment/prometheus-server --namespace monitoring

# Récupérer le nom du pod Prometheus
$POD_NAME = (kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")

if (-not $POD_NAME) {
    Write-Output "Aucun pod trouvé avec les labels spécifiés."
    exit 1
}

Write-Output "Nom du pod Prometheus : $POD_NAME"

# Exposer le service Prometheus
kubectl expose service prometheus-server -n monitoring --type=NodePort --target-port=9090 --name=prom-server

Write-Output "Le service Prometheus a été exposé avec succès."

# Port forwarding à Prometheus
Write-Output "Démarrer le port forwarding vers le pod Prometheus..."
kubectl --namespace monitoring port-forward $POD_NAME 9090:9090