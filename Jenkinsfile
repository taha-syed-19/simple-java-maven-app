pipeline {
    agent any
    tools {
        maven: 'MVN Check'
    }

    stages {
        stage("Build Jar") {
            steps {
                script {
                    echo "Building the JAR file..."
                    sh 'mvn package'
                }
            }
        }
        stage("Build Image") {
            steps {
                script {
                    echo "Building the Docker Image..."
                    withCredentials([usernamePassword(credentialsId: 'Docker-Auth', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t tahasyed19/tahasyed:1.1.1 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push tahasyed19/tahasyed:1.1.1'
                    }
                }
            }
        }
        stage("Deploying App") {
            steps {
                script {
                    echo "Deploying app..."
                    echo "Deployed successfully!"
                }
            }
        }
    }
}
