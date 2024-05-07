# WiseCow Application Deployment

This repository contains the deployment files and instructions for deploying the WiseCow application in a Kubernetes cluster using Git, Jenkins, Docker, and Kubernetes.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Deployment Steps](#deployment-steps)
- [Configuration](#configuration)

## Overview

The WiseCow application is a simple web application. It provides to upload videos, audios, images and chat. This README provides guidance on deploying the WiseCow application in a Kubernetes cluster.

## Prerequisites

Before you begin, ensure you have the following installed:

- Git
- Jenkins
- Docker
- Kubernetes cluster (e.g., Minikube, AWS EKS, GKE)

## Deployment Steps

Follow these steps to deploy the WiseCow application:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your/repository.git
   ```

2. Navigate to the cloned repository:

   ```bash
   cd repository
   ```

3. Configure Jenkins pipeline for building and pushing Docker images.
4. Modify Kubernetes deployment files (`deployment.yaml`, `service.yaml`, etc.) with your specific configurations.
5. Apply the Kubernetes deployment:

   ```bash
   kubectl apply -f deployment.yaml
   ```

6. Expose the application via a Kubernetes service:

   ```bash
   kubectl apply -f service.yaml
   ```

7. Access the application using the provided URL or external IP.

## Configuration

### Jenkins Pipeline Configuration

Configure Jenkins to automate the following tasks:

- Build Docker image from source code.
- Push Docker image to a Docker registry (e.g., Docker Hub, AWS ECR).
- Trigger Kubernetes deployment using updated image.

```
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
```

### Kubernetes Configuration

Update the Kubernetes deployment files (`deployment.yaml`, `service.yaml`, etc.) with the following configurations:

- Container image: Specify the Docker image URL for the WiseCow application.
- Environment variables: Set any required environment variables for the application.
- Resources: Define CPU and memory limits and requests for the application pods.
