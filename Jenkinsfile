pipeline{
  agent any
  environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        GITHUB_CREDENTIALS = credentials('90395f85-d16c-47e1-8ec4-5a9d99c8c4c1')
        version = null
        git_branch = "${params.git_branch}"
        helm_url = null
        // DOCKERHUB_CREDENTIALS_USR and DOCKERHUB_CREDENTIALS_PSW automatically available
  }
  stages{
      stage('Git clone') {
          steps{
              checkout scm
          }
      }
  }
}