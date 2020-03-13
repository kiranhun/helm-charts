pipeline {
    agent any
    stages {
        stage('Deployment') {
            steps {
                script {
                    sh "pwd"
                    withKubeConfig([credentialsId: 'kubernetesCreds', serverUrl: "${env.HELM_URL}"]){
                        sh("kubectl create namespace api")
                        sh("helm install '${version}' helm-backend/ --set database.url='${database}' --set database.user='${database_user}' --set database.password='${database_password}' --set namespace.name=api --set imageCredentials.username='${DOCKER_USER}' --set imageCredentials.password='${DOCKER_PASS}' --set database.bucket_name='${bucket}' --set s3.accesskey='${accessKey}' --set s3.secretkey='${secretKey}' -n api")
                    }
                }
            }
        }
    }
}