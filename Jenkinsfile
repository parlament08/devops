pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'flask-app:latest'
    REMOTE_HOST = '34.69.234.250'         // Укажи IP своей VM
    REMOTE_USER = 'devops'                // Укажи своего SSH-пользователя
  }

  stages {
    stage('Build Docker Image') {
      steps {
        dir('app') {
          sh 'docker build -t $DOCKER_IMAGE .'
        }
      }
    }

    stage('Deploy via SSH') {
      steps {
        sshagent(credentials: ['vm-ssh-key']) { // 'vm-ssh-key' — ID SSH-ключа в Jenkins Credentials
          sh """
            docker save $DOCKER_IMAGE | bzip2 | ssh ${REMOTE_USER}@${REMOTE_HOST} 'bunzip2 | docker load'
            ssh ${REMOTE_USER}@${REMOTE_HOST} 'docker stop flask-app || true && docker rm flask-app || true'
            ssh ${REMOTE_USER}@${REMOTE_HOST} 'docker run -d -p 5000:5000 --name flask-app $DOCKER_IMAGE'
          """
        }
      }
    }
  }
}
