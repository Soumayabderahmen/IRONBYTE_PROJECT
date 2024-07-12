pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'soumayaabderahmen'
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya'
        SPRING_BOOT_IMAGE = "${DOCKERHUB_NAMESPACE}/springboot-app"
        ANGULAR_IMAGE = "${DOCKER_CREDENTIALS_ID}/angular-app-iron"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    git branch: 'main', credentialsId: "${GITHUB_CREDENTIALS_ID}", url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git'
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
                        def angularImage = docker.build("${ANGULAR_IMAGE}:${env.BUILD_NUMBER}")
                        docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                            angularImage.push()
                            angularImage.push("latest")
                        }
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
                        def springBootImage = docker.build("${SPRING_BOOT_IMAGE}:${env.BUILD_NUMBER}")
                        docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                            springBootImage.push()
                            springBootImage.push("latest")
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
