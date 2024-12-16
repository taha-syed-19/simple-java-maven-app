def gv

pipeline {
    agent any
    tools {
        maven 'MVN Check'
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
                    gv.buildApp
                }
            }
        }

        stage("Build Image") {
            steps {
                script {
                    gv.buildImage
                }
            }
        }

        stage("Deploying App") {
            steps {
                script {
                    gv.deployApp
                }
            }
        }
    }
}
