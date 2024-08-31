# Ajouter le dépôt Helm de Grafana
#helm repo add grafana https://grafana.github.io/helm-charts
Write-Output "Dépôt Grafana ajouté."

# Mettre à jour les dépôts Helm
#helm repo update
Write-Output "Dépôts Helm mis à jour."

# Effectuer une recherche dans le dépôt Grafana
#helm search repo grafana
Write-Output "Recherche de Grafana effectuée."

# Installer Grafana dans le namespace 'monitoring'
helm install grafana grafana/grafana --namespace monitoring
Write-Output "Grafana a été installé avec succès dans le namespace 'monitoring'."

# Exposer le service Grafana


# Récupérer le mot de passe administrateur de Grafana
# $adminPassword = kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
# Write-Output "Mot de passe administrateur de Grafana : $adminPassword"


# Vérifier les pods Grafana pour le nom exact
kubectl get pods --namespace monitoring

# Pause pour permettre à l'utilisateur de voir les pods
# Read-Host -Prompt "Appuyez sur Entrée pour continuer après avoir vérifié les pods."

# Remplacer par le nom du pod Grafana
$grafanaPodName = (kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana" -o jsonpath="{.items[0].metadata.name}")

if (-not $grafanaPodName) {
    Write-Output "Aucun pod Grafana trouvé."
    exit
}

# Afficher le nom du pod Grafana pour vérification
Write-Output "Nom du pod Grafana : $grafanaPodName"

# Réinitialiser le mot de passe administrateur du pod Grafana
try {
    kubectl exec -ti $grafanaPodName --namespace monitoring -- /bin/bash -c "grafana cli admin reset-admin-password admin"
    Write-Output "Le mot de passe administrateur de Grafana a été réinitialisé avec succès."
} catch {
    Write-Output "Erreur lors de la réinitialisation du mot de passe administrateur : $_"
}

kubectl expose service grafana -n monitoring --type=NodePort --target-port=3000 --name=grafana-server
Write-Output "Le service Grafana a été exposé avec succès."
# Ouvrir le service Grafana dans Minikube
minikube service grafana-server -n monitoring
Write-Output "Le service Grafana est maintenant ouvert dans Minikube."
# Fin du script