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
                script {
                    echo "Cloning the repository"
                    git credentialsId: "${GITHUB_CREDENTIALS_ID}", url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main'
                }
            }
        }
        stage('Set Docker Context') {
            steps {
                script {
                    echo "Setting Docker context to ${env.DOCKER_CONTEXT}"
                    bat "docker context use ${env.DOCKER_CONTEXT}"
                }
            }
        }
        stage('Build Angular') {
            steps {
                script {
                    echo "Building Angular application"
                    dir('ironbyte') {
                        bat 'npm install'
                        bat 'npm run build --prod'
                    }
                }
            }
        }
        stage('Docker Build and Push Angular') {
            steps {
                script {
                    echo "Building and pushing Angular Docker image"
                    dir('ironbyte') {
                        def angularImage = docker.build("${env.DOCKERHUB_NAMESPACE}/angular-app-iron:5")
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            angularImage.push()
                        }
                    }
                }
            }
        }
        stage('Build Spring Boot') {
            steps {
                script {
                    echo "Building Spring Boot application"
                    dir('ironbyteintern') {
                        bat 'mvn clean package'
                    }
                }
            }
        }
        stage('Docker Build and Push Spring Boot') {
            steps {
                script {
                    echo "Building and pushing Spring Boot Docker image"
                    dir('ironbyteintern') {
                        def springBootImage = docker.build("${env.DOCKERHUB_NAMESPACE}/spring-boot-app-iron:5")
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            springBootImage.push()
                        }
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "Deploying to Kubernetes"
                    bat 'kubectl apply -f ironbyteintern/backend-deployment.yaml'
                    bat 'kubectl apply -f ironbyteintern/mysql-configMap.yaml'
                    bat 'kubectl apply -f ironbyteintern/mysql-secrets.yaml'
                    bat 'kubectl apply -f ironbyteintern/db-deployment.yaml'
                    bat 'kubectl apply -f ironbyte/frontend-deployment.yaml'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
