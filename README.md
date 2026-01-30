# 🛡️ IRONBYTE_PROJECT

**IRONBYTE_PROJECT** est un projet full-stack basé sur **Spring Boot** et **Angular**, visant à développer une **application robuste, sécurisée et évolutive**, en appliquant les bonnes pratiques d’architecture logicielle et d’automatisation **CI/CD**.

Le cœur du projet est organisé dans le dossier **IronByte/**.

---

## 🎯 Objectifs du projet
- Développer une application web full-stack moderne
- Mettre en place une architecture claire backend / frontend
- Appliquer les bonnes pratiques de développement et de sécurité
- Automatiser le cycle de vie applicatif via **CI/CD**

---

## 🛠️ Stack technique

### Backend
- **Spring Boot (Java)**  
  - API REST
  - Architecture en couches (Controller, Service, Repository)
  - Sécurité et validation des données
  - JPA / Hibernate (selon implémentation)

### Frontend
- **Angular**  
  - Architecture modulaire
  - Composants réutilisables
  - Communication avec l’API REST
  - Gestion d’état et services Angular

### Outils & bonnes pratiques
- Maven / Gradle
- Git & GitHub
- Architecture REST
- Séparation des responsabilités
- Bonnes pratiques de sécurité applicative

---

## 🔄 CI/CD (Continuous Integration & Continuous Deployment)

Le projet adopte une approche **CI/CD** afin d’automatiser les étapes clés du développement.

### Pipeline CI/CD
- Déclenchement automatique à chaque `push` ou `pull request`
- Build du backend **Spring Boot**
- Build du frontend **Angular**
- Exécution des tests automatisés
- Vérification de la qualité du code
- Préparation au déploiement

### Outils CI/CD
- **GitHub Actions** (workflows CI/CD)
- Jobs automatisés :
  - `mvn clean install`
  - `npm install && npm run build`
  - Tests unitaires backend et frontend

---

## 📁 Structure du projet
- `IronByte/backend/` : application **Spring Boot**
- `IronByte/frontend/` : application **Angular**
- `IronByte/config/` : fichiers de configuration
- `IronByte/tests/` : tests unitaires et fonctionnels
- `.github/workflows/` : pipelines CI/CD (GitHub Actions)

---

## ⚙️ Prérequis
- Java 17+
- Maven ou Gradle
- Node.js & npm
- Angular CLI
- Git

---

## 🚀 Installation & exécution

### 1️⃣ Cloner le projet
```bash
git clone https://github.com/Soumayabderahmen/IRONBYTE_PROJECT.git
cd IRONBYTE_PROJECT
