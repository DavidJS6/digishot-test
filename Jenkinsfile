pipeline {
    agent any
    stages {
        stage('Build Jar') {
            agent {
                docker {
                    //image 'maven:3.6.0-jdk-8'
                    image 'maven:3.8.1-adoptopenjdk-11'
                    //args '-v /c/Users/User/.m2:/root/.m2'
                    //args '-v /home/.m2:/root/.m2'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
//                 git url: 'https://github.com/DavidJS6/digishot-test.git',
//                     //credentialsId: 'springdeploy-user',
//                     branch: 'master'

                //sh 'ls /root/.m2/repository/bo/digicert/'
                sh 'mvn -B'
                script {
                    env.ARTIFACT_ID = readMavenPom().getArtifactId()
                    env.VERSION = readMavenPom().getVersion()
                }

                sh 'mvn clean package -DskipTests'
                stash includes: 'target/*.jar', name: 'targetfiles'
            }
        }
        stage('Build Docker') {
//             agent {
//                 node {
//                     label 'DockerDefault'
//                 }
//             }
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
//             agent {
//                 node {
//                     label 'DockerDefault'
//                 }
//             }
            steps {
                sh "docker stop ${env.ARTIFACT_ID} || true && docker rm ${env.ARTIFACT_ID} || true"
                sh "docker run --name ${env.ARTIFACT_ID} --restart=on-failure --detach -d -p 9898:9898 ${env.ARTIFACT_ID}:${env.VERSION}"
            }
        }
    }
}