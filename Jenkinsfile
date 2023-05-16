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
        withCredentials([usernamePassword(credentialsId: 'admin-nexus', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USER')]) {
          echo ${NEXUS_PASSWORD}
          echo ${NEXUS_USER}
            // some block
          docker login -u ${NEXUS_USER} -p ${NEXUS_PASSWORD} localhost:6002
          docker build -t basa/infra/devel8-alpine:latest .
          docker push basa/infra/devel8-alpine:latest
        }
        
          
        
      }
    }

  }
}