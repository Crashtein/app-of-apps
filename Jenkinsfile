def frontendImage="crashtein/frontend"
def backendImage="crashtein/backend"
def dockerRegistry=""
def registryCredentials="dockerhub" 

pipeline {
    agent  { label 'agent' }
    stages {
        stage('Get code') {
            steps {
                checkout scm
            }
        }
    }
}
