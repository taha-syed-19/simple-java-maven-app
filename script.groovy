def buildJar() {
    echo "Building the JAR file..."
    sh 'mvn package'
}

def buildImage() {
    echo "Building the Docker Image..."
    withCredentials([usernamePassword(credentialsId: 'Docker-Auth', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
        sh 'docker build -t tahasyed19/tahasyed:1.1.1 .'
        sh "echo $PASS | docker login -u $USER --password-stdin"
        sh 'docker push tahasyed19/tahasyed:1.1.1'
    }
}

def deployApp() {
    echo "Deploying the App..."
}

return this
