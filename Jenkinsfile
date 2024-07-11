pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'soumaya_Docker'
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git credentialsId: "${GITHUB_CREDENTIALS_ID}", url: 'https://github.com/Soumayabderahmen/IRONBYTE_PROJECT.git'
                }
            }
        }

        stage('Build Angular') {
            steps {
                dir('ironbyte') {
                    bat 'npm install'
                    bat 'npm run build --prod'
                }
            }
        }

        stage('Docker Build and Push Angular') {
            steps {
                dir('ironbyte') {
                    script {
                        docker.build("${DOCKERHUB_NAMESPACE}/angular-app-iron").push()
                    }
                }
            }
        }

        stage('Build Spring Boot') {
            steps {
                dir('ironbyteintern') {
                    bat './mvnw clean package'
                }
            }
        }

        stage('Docker Build and Push Spring Boot') {
            steps {
                dir('ironbyteintern') {
                    script {
                        docker.build("${DOCKERHUB_NAMESPACE}/springboot-app").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    bat 'kubectl apply -f ironbyteintern/backend-deployment.yaml'
                    bat 'kubectl apply -f ironbyteintern/mysql-configMap.yaml'
                    bat 'kubectl apply -f ironbyteintern/mysql-secrets.yaml'
                    bat 'kubectl apply -f ironbyteintern/db-deployment.yaml'
                    bat 'kubectl apply -f ironbyte/frontend-deployment.yaml'
                }
            }
        }
    }
}
