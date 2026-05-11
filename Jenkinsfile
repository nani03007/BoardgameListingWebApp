pipeline {

    agent any

    tools {
        jdk 'jdk17'
        maven 'maven2'
    }

    stages {

        stage('Git Clone') {
            steps {
                git credentialsId: 'git-cred',
                url: 'YOUR_GITHUB_REPO'
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
                    credentialsId: 'docker-cred'
                ) {
                    sh 'docker push javaexpress/demo'
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
