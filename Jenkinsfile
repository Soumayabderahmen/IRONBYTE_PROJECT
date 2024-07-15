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
                git credentialsId: "${GITHUB_CREDENTIALS_ID}", url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main'
            }
        }
        stage('Set Docker Context') {
            steps {
                script {
                    bat 'docker context use ${DOCKER_CONTEXT}'
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
                        docker.build("${DOCKERHUB_NAMESPACE}/angular-app-iron:5")
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            docker.image("${DOCKERHUB_NAMESPACE}/angular-app-iron:5").push()
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
                        docker.build("${DOCKERHUB_NAMESPACE}/spring-boot-app-iron:5")
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            docker.image("${DOCKERHUB_NAMESPACE}/spring-boot-app-iron:5").push()
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
    post {
        always {
            cleanWs()
        }
    }
}
