def frontendImage="crashtein/frontend"
def backendImage="crashtein/backend"
def dockerRegistry=""
def registryCredentials="dockerhub" 

pipeline {
    agent  { label 'agent' }
    parameters {
        string(name: 'backendDockerTag', defaultValue: '', description: 'Backend docker image tag')
        string(name: 'frontendDockerTag', defaultValue: '', description: 'Frontend docker image tag')
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
    }
}
