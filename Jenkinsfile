def frontendImage="crashtein/frontend"
def backendImage="crashtein/backend"
def dockerRegistry=""
def registryCredentials="dockerhub" 

pipeline {
    agent  { label 'agent' }
    environment {
        PIP_BREAK_SYSTEM_PACKAGES = 1
    }
    parameters {
        string(name: 'backendDockerTag', defaultValue: '', description: 'Backend docker image tag')
        string(name: 'frontendDockerTag', defaultValue: '', description: 'Frontend docker image tag')
    }
    tools {
	terraform 'Terraform'
    }
    stages {
        stage('Get code') {
            steps {
                checkout scm
            }
        }
        stage('Adjust version') {
            steps {
                script {
                    backendDockerTag = params.backendDockerTag.isEmpty() ? "latest" : params.backendDockerTag
                    frontendDockerTag = params.frontendDockerTag.isEmpty() ? "latest" : params.frontendDockerTag
                    currentBuild.description = "Backend: ${backendDockerTag}, Frontend: ${frontendDockerTag}"
                }
            }
        }
        stage('Clean running containers') {
            steps {
                sh "docker rm -f frontend backend"
            }
        }
        stage('Deploy application') {
            steps {
                script {
                    withEnv(["FRONTEND_IMAGE=$frontendImage:$frontendDockerTag","BACKEND_IMAGE=$backendImage:$backendDockerTag"]) {
                        docker.withRegistry("$dockerRegistry","$registryCredentials") {
                            sh "docker-compose up -d"
                        }
                    }
                }
            }
        }
        stage('Selenium tests') {
            steps {
                sh "pip3 install -r test/selenium/requirements.txt"
                sh "python3 -m pytest test/selenium/seleniumFrontend.py"
            }
        }
        stage('Run Ansible') {
               steps {
                   script {
                        sh "pip3 install -r requirements.txt"
                        sh "ansible-galaxy install -r requirements.yml"
                        withEnv(["FRONTEND_IMAGE=$frontendImage:$frontendDockerTag", 
                                 "BACKEND_IMAGE=$backendImage:$backendDockerTag"]) {
                            ansiblePlaybook inventory: 'inventory', playbook: 'playbook.yml'
                        }
                }
            }
        }
        stage('Run terraform') {
            steps {
                dir('Terraform') {                
                    git branch: 'main', url: 'https://github.com/crashtein/terraform'
                    withAWS(credentials:'AWS', region: 'us-east-1') {
                            sh 'terraform init -backend-config=bucket=bucket-pk01'
                            sh 'terraform apply -auto-approve -var bucket_name=bucket-pk01'
                            
                    } 
                }
            }
        }
    }
    post {
        always {
            sh "docker-compose down"
            cleanWs()
        }
    }
}
