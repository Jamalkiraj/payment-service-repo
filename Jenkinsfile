pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "jananipk666/trial"       // Docker image name
        DOCKER_CREDENTIALS_ID = "jananipk666"    // DockerHub credentials ID in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the Git repository
                git branch: 'main', url: 'https://github.com/Jamalkiraj/payment-service-repo'
            }
        }

        stage('Build with Maven') {
            steps {
                // Build the Java application using Maven
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to DockerHub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Run the Docker container from the pushed image
                    sh 'docker run -p 8080:8080 $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
