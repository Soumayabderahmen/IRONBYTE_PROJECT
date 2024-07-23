pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS_ID = 'soumayaabderahmen' // Replace with your Docker credentials ID
        MYSQL_DATABASE = 'ironbyte'
        MYSQL_ROOT_PASSWORD = 'root'
        MYSQL_HOST = 'mysqldb'
        MYSQL_USER = 'root'
        MYSQL_PASSWORD = 'root'
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya' // Replace with your GitHub credentials ID
    }
    
   
    
    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Checking out the repository..."
                    git url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main', credentialsId: "${env.GITHUB_CREDENTIALS_ID}"
                }
            }
        }
        
        stage('Build') {
            steps {
                script {
                    echo "Building the application..."
                    bat 'mvn clean install -f IronByteIntern/pom.xml'
                    dir('IronByte') {
                        bat 'npm install'
                        bat 'npm run build'
                    }
                }
            }
        }
        
        stage('Build Docker Images') {
            steps {
                script {
                    echo "Building Docker images..."
                    bat "docker build -t ${env.DOCKERHUB_NAMESPACE}/ironbyteintern:latest IronByteIntern"
                    bat "docker build -t ${env.DOCKERHUB_NAMESPACE}/ironbyte:latest IronByte"
                }
            }
        }
        
        stage('Push Docker Images') {
            steps {
                script {
                    echo "Pushing Docker images to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: "${env.DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                        bat "docker push ${env.DOCKERHUB_NAMESPACE}/ironbyteintern:latest"
                        bat "docker push ${env.DOCKERHUB_NAMESPACE}/ironbyte:latest"
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Deploying application using Docker Compose..."
                bat 'docker-compose -f docker-compose.yml up --build -d'
            }
        }
        stage('Deploy to Minikube') {
            steps {
                script {
                    echo "Deploying application to Minikube..."
                    bat 'minikube start --driver=docker'
                    bat 'kubectl config use-context minikube'
                    
                    // Apply Kubernetes configurations in the jenkins namespace
                    bat 'kubectl apply -f ironbyteintern/backend-deployment.yaml -n jenkins'
                    bat 'kubectl apply -f ironbyteintern/mysql-configMap.yaml -n jenkins'
                    bat 'kubectl apply -f ironbyteintern/mysql-secrets.yaml -n jenkins'
                    bat 'kubectl apply -f ironbyteintern/db-deployment.yaml -n jenkins'
                    bat 'kubectl apply -f ironbyte/frontend-deployment.yaml -n jenkins'
                }
            }
        }
    }
    
    post {
        always {
            echo "Pipeline completed."
        }
        success {
            echo "Pipeline succeeded."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
