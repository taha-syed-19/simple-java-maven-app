#!/usr/bin/env groovy
@Library('jenkins-shared-library')
def gv

pipeline {
    agent any

    tools {
        maven 'My-Maven' // Use the Maven tool installed as 'My-Maven'
    }

    stages {
        stage("init") {
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage("build jars") {
            steps {
                script {
                    echo "Building jars..."
                }
                // Use Maven to build the jars
                sh "mvn clean package"
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "Building image..."
                    buildImage 'tahasyed19/tahasyed:2.0.1'// Assuming custom logic exists in buildImage()
                }
            }
        }
        stage("deploy") {
            steps {
                script {
                    echo "Deploying..."
                    gv.deployApp() // Assuming deployApp exists in the shared library
                }
            }
        }
    }
}
