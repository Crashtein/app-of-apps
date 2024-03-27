def frontendImage="crashtein/frontend"
def backendImage="crashtein/backend"
def dockerRegistry=""
def registryCredentials="dockerhub" 

def backendDockerTag=""
def frontendDockerTag=""


pipeline {
    agent  { label 'agent' }
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
                    currentBuild.description = "Backend:${backendDockerTag}, Frontend:${frontendDockerTag}"
                }
            }
        }
    }
}
