pipeline {
    agent any
    stages {
        stage('Deployment') {
            steps {
                script {
                    sh("kubectl get pods --all-namespaces")
                    sh("kubectl create namespace api")
                }
            }
        }
    }
}
