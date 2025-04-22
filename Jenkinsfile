def gv

pipeline {
    agent any
    tools {
        maven 'mvn' 
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
