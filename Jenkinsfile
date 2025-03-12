pipeline {
    agent {
        docker 'jenkins-liferay-with-minikube' // Specify your custom Docker image here
    }
    environment {
        MINIKUBE_DOCKER_ENV = sh(script: 'minikube docker-env', returnStdout: true).trim()
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''
                eval $MINIKUBE_DOCKER_ENV
                docker build -t liferay-custom .
                '''
            }
        }
        stage('Deploy to Minikube') {
            steps {
                sh '''
                kubectl apply -f k8s/deployment.yaml
                '''
            }
        }
    }
}
