Jenkins file


pipeline {
  agent any

  stages {
    stage('Build Docker Image') {
      steps {
        script {
          docker.build("vinodkhathi/vinod-img:latest")
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'vinod_dockerhub') {
            docker.image("vinodkhathi/vinod-img:latest").push()
          }
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(
            kubeconfigId: 'kubeconfig',
            configs: 'wisecow-deployment.yaml'
          )
          kubernetesDeploy(
            kubeconfigId: 'kubeconfig',
            configs: 'wisecow-service.yaml'
          )
        }
      }
    }
  }

  post {
    always {
      echo 'Pipeline completed'
    }
  }
}
