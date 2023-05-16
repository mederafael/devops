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
          docker version
          echo $ADMIN-NEXUS
        }
      }
    }

  }
}