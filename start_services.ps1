# start_services.ps1

# Démarrage de Jenkins
Write-Host "Démarrage de Jenkins..."
Start-Process "cmd.exe" -ArgumentList "/c java -jar C:\Esprit\SpringProject\jenkins.war" -NoNewWindow
Write-Host "Jenkins démarré à http://localhost:8080"

# Démarrage de Minikube
Write-Host "Démarrage de Minikube..."
Start-Process "cmd.exe" -ArgumentList "/c minikube start --driver=docker --memory=3900"
Write-Host "Minikube démarré."

# Démarrage de SonarQube
Write-Host "Démarrage de SonarQube..."
$sonarPath = "C:\Esprit\SonarQube\sonarqube\sonarqube-10.6.0.92116\bin\windows-x86-64\StartSonar.bat"
Start-Process "cmd.exe" -ArgumentList "/c", $sonarPath
Write-Host "SonarQube démarré."

Write-Host "Tous les services ont été démarrés avec succès."
Pause