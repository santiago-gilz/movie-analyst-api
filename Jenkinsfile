pipeline {
    environment {
        registry = "sgilz/rampup-api"
        registryCredentials = 'dockercredentials'
        gitCredentials = "githubcredentials"
        repoUrl = "https://github.com/santiago-gilz/movie-analyst-api.git"
        dockerImage = ''
        PORT="3000"
    }
    agent any
    stages {
        stage('Cloning our Git') {
            steps {
                git branch: "master", credentialsId: 	gitCredentials, url: repoUrl
            }
        }
        
        stage('Running unit tests') {
            steps {
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('Building Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("$registry:$BUILD_NUMBER", "--build-arg PORT=$PORT .")
                }
            }
        }

        stage('Deploying Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                    dockerImage.push()
                    }
                }
            }
        }

        stage('Cleaning Up') {
            steps{
                sh "docker rmi --force $registry:$BUILD_NUMBER"
            }
        }
    }
    post{
        always{
            deleteDir()
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
