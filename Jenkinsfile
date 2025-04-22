#!/usr/bin/env groovy
@Library('jenkins-shared-library')
def gv

pipeline {
    agent any

    tools {
        maven 'mvn' // Use the Maven tool installed as 'My-Maven'
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
                    buildJar()
                }
                // Use Maven to build the jars
                    
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "Building image..."
                    buildImage() // Assuming custom logic exists in buildImage()
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
