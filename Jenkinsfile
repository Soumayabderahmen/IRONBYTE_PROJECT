pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'soumayaabderahmen'
        MYSQL_DATABASE = 'ironbyte'
        MYSQL_ROOT_PASSWORD = 'root'
        MYSQL_HOST = 'mysqldb'
        MYSQL_USER = 'root'
        MYSQL_PASSWORD = 'root'
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya'
        SONARQUBE_URL = 'http://localhost:9000'
        SONARQUBE_TOKEN = credentials('sonarqube-token') // Utiliser l'ID du token ajouté dans Jenkins
        SONARQUBE_TOKEN_ANGULAR = credentials('sonarqube-angular-token')
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
         stage('Run Unit Tests') {
            steps {
                script {
                    echo "Running JUnit tests..."
                    dir('IronByteIntern') {
                        bat 'mvn test'
                    }
                }
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml' // Emplacement des rapports JUnit
                }
            }
        }
       stage('SonarQube Analysis for Spring Boot') {
    steps {
        script {
            withSonarQubeEnv('SonarQube-SpringBoot') {
                dir('IronByteIntern') {
                    withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONARQUBE_TOKEN')]) {
                            bat "mvn sonar:sonar -Dsonar.projectKey=IRONBYTE_PROJECT -Dsonar.projectName=IRONBYTE_PROJECT -Dsonar.host.url=http://localhost:9000 -Dsonar.token=sqp_bbd7623f4c2c599d6bf30bc432b7bb7142cfdee4"
                    }
                }
            }
        }
    }
}
 stage('SonarQube Analysis for Angular') {
    steps {
        script {
            withSonarQubeEnv('SonarQube-Angular') { 
                dir('IronByte') {
                    bat """
                        ng test --watch=false --code-coverage
                        sonar-scanner.bat ^
                            -Dsonar.projectKey=IRONBYTE_ANGULAR_PROJECT ^
                            -Dsonar.sources=src ^
                            -Dsonar.tests=src ^
                            -Dsonar.test.inclusions=src/**/*.spec.ts ^
                            -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info ^
                            -Dsonar.host.url=${env.SONARQUBE_URL} ^
                            -Dsonar.token=${env.SONARQUBE_TOKEN_ANGULAR}
                    """
                }
            }
        }
    }
}


        stage('Build Docker Images') {
            steps {
                script {
                    echo "Building Docker images..."
                    bat "docker build -t ${env.DOCKERHUB_NAMESPACE}/springboot-app:latest ./IronByteIntern"
                    bat "docker build -t ${env.DOCKERHUB_NAMESPACE}/ironbytepipeline-angular:latest ./IronByte"
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application using Docker Compose..."
                bat 'docker-compose -f docker-compose.yml up --build -d'
            }
        }

        stage('Push Docker Images') {
            steps {
                script {
                    echo "Pushing Docker images to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: "${env.DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                        bat "docker push ${env.DOCKERHUB_NAMESPACE}/springboot-app:latest"
                        bat "docker push ${env.DOCKERHUB_NAMESPACE}/ironbytepipeline-angular:latest"
                    }
                }
            }
        }

        stage('Deploy to K8s') {
            steps {
                script {
                    echo "Deploying application to Minikube..."
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