def gv

pipeline {
    agent any
    tools {
        maven 'mvn' #check mvn is there or not in tools og Jenkisn UI
    }

    stages {
        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }

        stage("Build Jar") {
            steps {
                script {
                    gv.buildJar()
                }
            }
        }

        stage("Build Image") {
            steps {
                script {
                    gv.buildImage()
                }
            }
        }

        stage("Deploying App") {
            steps {
                script {
                    gv.deployApp()
                }
            }
        }
    }
}
