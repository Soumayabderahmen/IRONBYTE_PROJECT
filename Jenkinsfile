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
      tools {
        maven 'Maven 3.9.8' // Ensure Maven is configured in Jenkins global tool configuration
        nodejs 'NodeJS 20.11.1' // Ensure NodeJS is configured in Jenkins global tool configuration
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main'
            }
        }

        stage('Build Angular') {
            steps {
                script {
                    dir('IronByte') {
                        bat 'npm install'
                        bat 'npm run build --prod'
                    }
                }
            }
        }

        stage('Build Spring Boot') {
            steps {
                script {
                    dir('IronByteIntern') {
                        bat 'mvn clean package'
                    }
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    docker.build("intern-angular", "IronByte/.")
                    docker.build("soumayaabderahmen/springboot-app", "IronByteIntern/.")
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        docker.image('intern-angular').push()
                        docker.image('soumayaabderahmen/springboot-app').push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                bat 'docker-compose -f docker-compose.yml up -d'
            }
        }
    }
}
