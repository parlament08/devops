pipeline {
  agent any


  environment {
    DOCKER_IMAGE = 'flask-app:latest'
    REMOTE_HOST = '35.192.111.248'
    REMOTE_USER = 'devops'
  }

  stages {
    stage('Build Docker Image') {
      steps {
        dir('app') {
          sh '''
            docker buildx create --use || true
            docker buildx build --platform linux/amd64 -t $DOCKER_IMAGE --load .
           '''
        }
      }
    }

    stage('Deploy via SSH') {
      steps {
        sshagent(credentials: ['vm-ssh-key']) { // 'vm-ssh-key' — ID SSH-key in Jenkins Credentials
          sh """
            docker save $DOCKER_IMAGE | bzip2 | ssh ${REMOTE_USER}@${REMOTE_HOST} 'bunzip2 | docker load'
            ssh ${REMOTE_USER}@${REMOTE_HOST} 'docker stop flask-app || true && docker rm flask-app || true'
            ssh ${REMOTE_USER}@${REMOTE_HOST} 'docker run -d -p 5050:5050 --name flask-app $DOCKER_IMAGE'
          """
        }
      }
    }
  }
}
