pipeline {
    agent any
    environment {
        IMAGE_NAME = "gundalasudheer/flask-app"
    }
    stages {
        stage("git checkout") {
            steps{
                checkout scm
            }
        }
        stage('Get Version') {
            steps {
                script {
                    IMAGE_VERSION = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                }
            }
        }
        stage ("build") {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} . "
                }
            }

        }
        stage("Login to Docker Registry") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId : 'dockerhub_credentials',
                                                       usernameVariable: 'DOCKER_USER' , 
                                                       passwordVaraible: 'DOCKER_PASS')])
                    {
                        sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    }
                }
            }
        }
        stage("Docker Push") {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}:${IMAGE_VERSION}"
                }
            }
        }
        stage('Get Image SHA') {
           steps {
              script {
               // Get SHA of the built image
                IMAGE_SHA = sh(script: "docker inspect --format='{{index .RepoDigests 0}}' gundalasudheer/flask-app:latest", returnStdout: true).trim()
               }
            }
        }
        stage('Deploy Using Docker Compose') {
           steps {
               script {
                 // Export the SHA for Compose
                 sh """
                   export FLASK_IMAGE_SHA=$IMAGE_SHA
                   docker-compose up -d
                   """
                }
            }
        }
    }
}