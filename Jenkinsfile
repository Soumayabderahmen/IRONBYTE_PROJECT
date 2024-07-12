pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'soumayaabderahmen' // Remplacez par l'ID de vos credentials Docker
        DOCKER_CONTEXT = 'desktop-linux'
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main'
            }
        }
        stage('Set Docker Context') {
            steps {
                script {
                    sh 'docker context use ${DOCKER_CONTEXT}'
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
                        docker.build("soumayaabderahmen/angular-app-iron:latest")
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            docker.image("soumayaabderahmen/angular-app-iron:latest").push()
                        }
                    }
                }
            }
        }
        stage('Build Spring Boot') {
            steps {
                dir('ironbyteintern') {
                    bat 'mvn clean package'
                }
            }
        }
        stage('Docker Build and Push Spring Boot') {
            steps {
                dir('ironbyteintern') {
                    script {
                        docker.build("soumayaabderahmen/spring-boot-app-iron:latest")
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            docker.image("soumayaabderahmen/spring-boot-app-iron:latest").push()
                        }
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
