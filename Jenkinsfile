pipeline {
    agent any
    stages {
        stage('Deployment_Backend') {
            when{
                expression{
                    GIT_BRANCH =  sh(returnStatus: true, script: """ git whatchanged|grep backend &> /dev/null  """)
                    sh(returnStdout: true, script: "echo ${GIT_BRANCH}").trim()
                    return GIT_BRANCH == 0
                }
                
            }
            steps {
                script {
                    sh "pwd"
                    withKubeConfig([credentialsId: 'kubernetesCreds', serverUrl: '${url}']){
                        sh"""
                            env
                            kubectl create namespace api > /dev/null 2>&1 || true
                            cd helm-backend
                            sudo su
                            helm upgrade '${version}' .  --install  --wait --set database.url='${database}' --set database.user='${database_user}' --set database.password='${database_password}' --set namespace.name=api --set imageCredentials.username='${DOCKER_USER}' --set imageCredentials.password='${DOCKER_PASS}' --set database.bucket_name='${bucket}' --set s3.accesskey='${accessKey}' --set s3.secretkey='${secretKey}' -n api
                        """
                    }
                }
            }
        }

stage('Deployment_Frontend') {
            when{
                expression{
                    GIT_BRANCH =  sh(returnStatus: true, script: """ git whatchanged|grep frontend &> /dev/null  """)
                    sh(returnStdout: true, script: "echo ${GIT_BRANCH}").trim()
                    return GIT_BRANCH == 0
                }
                
            }
            steps {
                script {
                    sh "pwd"
                    withKubeConfig([credentialsId: 'kubernetesCreds', serverUrl: '${url}']){
                        def BACKEND_ENDPOINT = sh(returnStdout: true, script: "kubectl get svc helm-backend-${version}-service -n api -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'")
                        sh"""
                            env
                            kubectl create namespace ui > /dev/null 2>&1 || true
                            cd helm-frontend
                            echo ${BACKEND_ENDPOINT}
                            sudo su
                            helm upgrade '${frontend_version}' . --install --set namespace.name=ui --set imageCredentials.username='${DOCKER_USER}' --set imageCredentials.password='${DOCKER_PASS}' --set replicaset.service_name=helm-backend-${version}-service --set replicaset.backend_url=${BACKEND_ENDPOINT} -n ui
                        """
                    }
                }
            }
        }

    }
}