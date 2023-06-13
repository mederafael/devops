pipeline {
  agent docker
  stages {
    stage('Build') {
      steps {
        echo 'Building..'
      }
    }

    stage('Test') {
      steps {
        echo 'Testing.. DOKCER'
        sh "docker version"
        sh "docker images"
        sh "docker ps -a"
        sh "docker ps"
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploying....'
        sh "docker version"
        sh "docker images"
        sh "docker ps -a"
        sh "docker ps"
        withCredentials([usernamePassword(credentialsId: 'nexus', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USER')]) {
          echo "NEXUS_USER: ${NEXUS_USER}"
          echo "NEXUS_PASSWORD: ${NEXUS_PASSWORD}"
          sh "docker login -u ${NEXUS_USER} -p ${NEXUS_PASSWORD} localhost:6002"
            // some block
          // docker login localhost:6002
          // docker build -t basa/infra/devel8-alpine:latest .
          // docker push basa/infra/devel8-alpine:latest
        }
        
          
        
      }
    }

  }
}
