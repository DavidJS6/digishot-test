node {
    def WORKSPACE = "/var/lib/jenkins/workspace/digishot-test"
    def dockerImageTag = "digishot-test${env.BUILD_NUMBER}"

    try {
         //notifyBuild('STARTED')
         stage('Clone Repo') {
            // for display purposes
            // Get some code from a GitHub repository
            git url: 'https://github.com/DavidJS6/digishot-test.git',
                //credentialsId: 'springdeploy-user',
                branch: 'master'
             
             script {
                env.ARTIFACT_ID = readMavenPom().getArtifactId()
                env.VERSION = readMavenPom().getVersion()
             }
         }
          stage('Build docker') {
              echo "ArtifactId: ${env.ARTIFACT_ID}"
              echo "Version: ${env.VERSION}"
              //sh "docker image rm ${env.ARTIFACT_ID}:${env.VERSION}"
              dockerImage = docker.build("${env.ARTIFACT_ID}:${env.VERSION}")
          }

          stage('Deploy docker') {
              echo "Docker Image Tag Name: ${dockerImageTag}"
              sh "docker stop ${env.ARTIFACT_ID} || true && docker rm ${env.ARTIFACT_ID} || true"
              /*sh "docker run --name digishot-test --restart=on-failure --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 -d -p 8282:8282 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro digishot-test:${env.BUILD_NUMBER}"*/
              sh "docker run --name ${env.ARTIFACT_ID} --restart=on-failure --detach -d -p 8282:8282 ${env.ARTIFACT_ID}:${env.VERSION}"
          }
    } catch(e) {
        //currentBuild.result = "FAILED"
        throw e
    } finally {
        //notifyBuild(currentBuild.result)
    }
}
/*
def notifyBuild(String buildStatus = 'STARTED') {

  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'
  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def now = new Date()
  // message
  def subject = "${buildStatus}, Job: ${env.JOB_NAME} FRONTEND - Deployment Sequence: [${env.BUILD_NUMBER}] "
  def summary = "${subject} - Check On: (${env.BUILD_URL}) - Time: ${now}"
  def subject_email = "Spring boot Deployment"
  def details = """<p>${buildStatus} JOB </p>
    <p>Job: ${env.JOB_NAME} - Deployment Sequence: [${env.BUILD_NUMBER}] - Time: ${now}</p>
    <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME}</a>"</p>"""


  // Email notification
    emailext (
         to: "admin@gmail.com",
         subject: subject_email,
         body: details,
         recipientProviders: [[$class: 'DevelopersRecipientProvider']]
       )
}
*/