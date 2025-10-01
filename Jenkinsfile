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

                    // run new container
                    sh 'docker run -d -p 5000:5000 --name app-ci-test e2e-devops:latest'

                    // wait and retry curl
                    retry(3) {
                       sh '''
                            sleep 5
                            docker exec app-ci-test curl -f http://localhost:5000
                        '''
                       // sh 'sleep 5 && curl -f http://localhost:5000'
                    }

                    // always show logs for debugging
                    sh 'docker logs app-ci-test || true'
                    // show logs for flask debugging
                    sh 'docker logs app-ci-test'

                    // Verify endpoint works
                    sh 'curl -f http://host.docker.internal:5000'

                   // sh 'curl -f http://localhost:5000'

                    // Clean up
                    sh 'docker stop app-ci-test'
                    sh 'docker rm app-ci-test'
                }
            }
        }
    }
}
