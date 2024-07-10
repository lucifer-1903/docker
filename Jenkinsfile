pipeline {
    agent any

    stages {
        stage("Git Checkout") {
            steps {
                git 'https://github.com/lucifer-1903/docker.git'
            }
        }

        stage("Docker Build") {
            steps {
                script {
                    def dockerImageTag = "$JOB_NAME:v1.$BUILD_ID"
                    sh "docker image build -t $dockerImageTag ."
                    sh "docker image tag $dockerImageTag jagan1906/$JOB_NAME:v1.$BUILD_ID"
                    sh "docker image tag $dockerImageTag jagan1906/$JOB_NAME:latest"
                }
            }
        }

        stage("Pushing Image to Dockerhub") {
            steps {
                withCredentials([string(credentialsId: 'Dockerr', variable: 'Dockerpwd')]) {
                    script {
                        def dockerImageTag = "$JOB_NAME:v1.$BUILD_ID"
                        sh "docker login -u jagan1906 -p${Dockerpwd}"
                        sh "docker image push jagan1906/$dockerImageTag"
                        sh "docker image push jagan1906/$JOB_NAME:latest"
                        sh "docker image rm $dockerImageTag jagan1906/$dockerImageTag jagan1906/$JOB_NAME:latest"
                    }
                }
            }
        }

        stage("Docker Containerization") {
            steps {
                script {
                    def Dockerrun = 'docker run -p 9000:80 -d --name Dockercontainer jagan1906/docker-groovy-webapp'
                    def Docker_remove = 'docker rm -f Dockercontainer'
                    def Docker_remove_image = 'docker rmi -f jagan1906/docker-groovy-webapp'
                    
                    sshagent(['SSH_docker']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.86.29 ${Docker_remove}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.86.29 ${Docker_remove_image}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.86.29 ${Dockerrun}"
                    }
                }
            }
        }
    }
}
