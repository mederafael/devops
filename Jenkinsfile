pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building..'
      }
    }

    stage('Test') {
      steps {
        echo 'Testing..'
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploying....'
        withCredentials([usernameColonPassword(credentialsId: 'admin-nexus', variable: 'ADMIN-NEXUS')]) {
          docker login localhost:6002
          docker build -t basa/infra/devel8-alpine:latest .
          docker push basa/infra/devel8-alpine:latest
        }
      }
    }

  }
}