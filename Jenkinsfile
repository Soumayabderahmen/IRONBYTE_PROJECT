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
    
    // tools {
    //     maven 'Maven 3.9.8' // Ensure Maven is configured in Jenkins global tool configuration
    //     nodejs 'NodeJS 20'  // Ensure NodeJS is configured in Jenkins global tool configuration
    // }
    
    // stages {
    //     stage('Checkout') {
    //         steps {
    //             script {
    //                 echo "Checking out the repository..."
    //             git url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main'
    //             }
    //         }
    //     }
        
    //     stage('Build Angular') {
    //         steps {
    //             script {
    //                 echo "Building Angular project..."
    //                 dir('IronByte') {
    //                     bat 'npm install'
    //                     bat 'npm run build --prod'
    //                 }
    //             }
    //         }
    //     }
        
    //     stage('Build Spring Boot') {
    //         steps {
    //             script {
    //                 echo "Building Spring Boot project..."
    //                 dir('IronByteIntern') {
    //                     bat 'mvn clean package'
    //                 }
    //             }
    //         }
    //     }
        
    //     stage('Build Docker Images') {
    //         steps {
    //             script {
    //                 echo "Building Docker images..."
    //                 docker.build("${DOCKERHUB_NAMESPACE}/intern-angular", "IronByte/.")
    //                 docker.build("${DOCKERHUB_NAMESPACE}/springboot-app", "IronByteIntern/.")
    //             }
    //         }
    //     }
        
    //     stage('Push Docker Images') {
    //         steps {
    //             script {
    //                 echo "Pushing Docker images..."
    //                 docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
    //                     docker.image("${DOCKERHUB_NAMESPACE}/intern-angular").push()
    //                     docker.image("${DOCKERHUB_NAMESPACE}/springboot-app").push()
    //                 }
    //             }
    //         }
    //     }
        
        stage('Deploy') {
            steps {
                echo "Deploying application using Docker Compose..."
                bat 'docker-compose -f docker-compose.yml up -d'
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
