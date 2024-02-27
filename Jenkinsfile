pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven3"
    }
    
    stages {
        stage('chekout') {
            steps {
                git branch: 'main', url: 'https://github.com/mukeshsonam/myfoodies.git'
            }
        }
        
        stage('build') {
            steps {
                sh "mvn clean verify"
            }
        }
        
        stage('docker_build') {
            steps {
             sh "docker build -t mukesh92/foodies:${BUILD_NUMBER} ."
             sh "echo your docker file build successfully"
            }
        }  
        
        stage('docker_push') {
            steps {
              withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/'){
              sh "docker push mukesh92/foodies:${BUILD_NUMBER}"
              }
           }
        }
        
        stage('Deployk8s'){
            steps{
            withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8stoken', namespace: 'jenkins', restrictKubeConfigAccess: false, serverUrl: 'https://172.31.40.170:6443') {
            sh "kubectl apply -f foodies.yml"
            sh 'kubectl set image deployments/foodies foodies=mukesh92/foodies:${BUILD_NUMBER}'
              }
            }
        }
    }
}
