pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/jasamoahf/E2E_DEVOPS.git'
            }
        }
        stage('Docker Pre-Check') {
            steps {
                sh 'docker --version'
                sh 'docker ps || true'
            }
        }

        stage('Build & Test Docker Image') {
            steps {
                sh 'docker build -t e2e-devops:${BUILD_NUMBER} .'
            }
        }

        stage('Run Container for Validation') {
            steps {
                script {
                    // Clean up old container if it exists
                    sh 'docker rm -f app-ci-test || true'

                    // Run a new container with fixed name
                    sh 'docker run -d -p 5000:5000 --name app-ci-test e2e-devops:${BUILD_NUMBER}'

                    // Wait for app to start
                    sh 'sleep 5'

                    // Verify endpoint works
                    sh 'curl -f http://localhost:5000'

                    // Clean up
                    sh 'docker stop app-ci-test'
                    sh 'docker rm app-ci-test'
                }
            }
        }
    }
}
