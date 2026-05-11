pipeline {

    agent any

    tools {
        jdk 'jdk17'
        maven 'maven2'
    }

    stages {

        stage('Git Clone') {
            steps {
               git credentialsId: 'github',
               url: 'https://github.com/nani03007/BoardgameListingWebApp.git'
            }
        }

        stage('Build') {
            steps {
                withMaven(
                    maven: 'maven2',
                    globalMavenSettingsConfig: 'global-settings'
                ) {
                    sh 'mvn clean package'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Upload Artifact To Nexus') {
            steps {
                withMaven(
                    maven: 'maven2',
                    globalMavenSettingsConfig: 'global-settings'
                ) {
                    sh 'mvn deploy'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t javaexpress/demo .'
            }
        }

stage('Docker Push') {
    steps {
      withDockerRegistry(
    credentialsId: 'Docker',
    url: 'https://index.docker.io/v1/'
) {
    sh 'docker push veera03007/k8:latest'
}
    }
}

        stage('Deploy To Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }

    }

}
