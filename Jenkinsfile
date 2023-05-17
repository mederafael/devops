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
        sh "docker version"
        sh "docker images"
        sh "docker ps -a"
        sh "docker ps"
        withCredentials([usernamePassword(credentialsId: 'admin-nexus', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USER')]) {
          
          echo "${NEXUS_PASSWORD}"
          echo "${NEXUS_USER}"

          sh "docker login -u ${NEXUS_PASSWORD} -p ${NEXUS_USER} localhost:6002"
            // some block
          // docker login localhost:6002
          // docker build -t basa/infra/devel8-alpine:latest .
          // docker push basa/infra/devel8-alpine:latest
        }
        
          
        
      }
    }

  }
}
