pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'soumayaabderahmen' // Replace with your Docker credentials ID
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya'
        SPRING_BOOT_IMAGE = 'soumayaabderahmen/springboot-app'
        ANGULAR_IMAGE = 'soumayaabderahmen/iron-byte'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: "${GITHUB_CREDENTIALS_ID}", url: 'git@github.com:Soumayabderahmen/IRONBYTE.git'
            }
        }

        stage('Build Spring Boot') {
            steps {
                dir('IronByteIntern') {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Build Angular') {
            steps {
                dir('IronByte') {
                    sh 'npm install'
                    sh 'npm run build --prod'
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                sh 'docker-compose up -d'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f ironbyteintern/backend-deployment.yaml'
                sh 'kubectl apply -f ironbyteintern/mysql-configMap.yaml'
                sh 'kubectl apply -f ironbyteintern/mysql-secrets.yaml'
                sh 'kubectl apply -f ironbyteintern/db-deployment.yaml'
                sh 'kubectl apply -f ironbytefrontend-deployment.yaml'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}