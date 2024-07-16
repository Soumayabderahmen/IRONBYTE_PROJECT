pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'soumayaabderahmen' // Replace with your Docker credentials ID
        DOCKER_CONTEXT = 'desktop-linux' // Set your Docker context
        DOCKERHUB_NAMESPACE = 'soumayaabderahmen'
        GITHUB_CREDENTIALS_ID = 'Soumaya' // Replace with your GitHub credentials ID
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:Soumayabderahmen/IRONBYTE_PROJECT.git', branch: 'main'
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
                        def dockerImage = "${DOCKERHUB_NAMESPACE}/angular-app-iron:5"
                        bat "docker --context ${DOCKER_CONTEXT} build -t ${dockerImage} ."
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            bat "docker --context ${DOCKER_CONTEXT} push ${dockerImage}"
                        }
                    }
                }
            }
        }
        
        stage('Build Spring Boot') {
            steps {
                dir('ironbyteintern') {
                    bat './mvnw clean package -DskipTests'
                }
            }
        }
        
        stage('Docker Build and Push Spring Boot') {
            steps {
                dir('ironbyteintern') {
                    script {
                        def springDockerImage = "${DOCKERHUB_NAMESPACE}/spring-app-iron:5"
                        bat "docker --context ${DOCKER_CONTEXT} build -t ${springDockerImage} ."
                        docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                            bat "docker --context ${DOCKER_CONTEXT} push ${springDockerImage}"
                        }
                    }
                }
            }
        }
    }
}
