pipeline {
    agent any
    stages {
        stage('Build Jar') {
            agent {
                docker {
                    image 'maven:3.6.0-jdk-8'
                    args '-v /c/Users/User/.m2:/root/.m2 -w /c/ProgramData/Jenkins/.jenkins/workspace/digishot-test@2/ -v /c/ProgramData/Jenkins/.jenkins/workspace/digishot-test@2/:/c/ProgramData/Jenkins/.jenkins/workspace/digishot-test@2/ -v /c/ProgramData/Jenkins/.jenkins/workspace/digishot-test@2@tmp/:/c/ProgramData/Jenkins/.jenkins/workspace/digishot-test@2@tmp/'
                }
            }
            steps {
                git url: 'https://github.com/DavidJS6/digishot-test.git',
                    //credentialsId: 'springdeploy-user',
                    branch: 'master'

                script {
                    env.ARTIFACT_ID = readMavenPom().getArtifactId()
                    env.VERSION = readMavenPom().getVersion()
                }

                sh 'mvn clean package -DskipTests'
                stash includes: 'target/*.jar', name: 'targetfiles'
            }
        }
        stage('Build Docker') {
            agent {
                node {
                    label 'DockerDefault'
                }
            }
            steps {
                script {
                    echo "ArtifactId: ${env.ARTIFACT_ID}"
                    echo "Version: ${env.VERSION}"
                    unstash 'targetfiles'
                    //def image = docker.build("image-name:test", ' .')
                    def dockerImage = docker.build("${env.ARTIFACT_ID}:${env.VERSION}")
                }
            }
        }
        stage('Deploy docker') {
            agent {
                node {
                    label 'DockerDefault'
                }
            }
            steps {
                sh "docker stop ${env.ARTIFACT_ID} || true && docker rm ${env.ARTIFACT_ID} || true"
                sh "docker run --name ${env.ARTIFACT_ID} --restart=on-failure --detach -d -p 9898:9898 ${env.ARTIFACT_ID}:${env.VERSION}"
            }
        }
    }
}