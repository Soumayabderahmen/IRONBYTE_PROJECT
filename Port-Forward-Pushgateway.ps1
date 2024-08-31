# Récupérer le nom du pod Pushgateway
$POD_NAME = (kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=prometheus-pushgateway" -o jsonpath="{.items[0].metadata.name}")

if (-not $POD_NAME) {
    Write-Output "Aucun pod trouvé avec les labels spécifiés."
    exit 1
}

Write-Output "Nom du pod Pushgateway : $POD_NAME"

# Exposer le service Pushgateway
kubectl expose service pushgateway -n monitoring --type=NodePort --target-port=9091 --name=pushgateway-server

Write-Output "Le service Pushgateway a été exposé avec succès."

# Port forwarding à Pushgateway
Write-Output "Démarrer le port forwarding vers le pod Pushgateway..."
kubectl --namespace monitoring port-forward $POD_NAME 9091:9091